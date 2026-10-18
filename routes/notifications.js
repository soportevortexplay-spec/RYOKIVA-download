import { Router } from 'express';
import { db } from '../db.js';
import { businessNotifications, businessProfessionals, businessClients, systemIncidents } from '../drizzle/schema.js';
import { eq, count } from 'drizzle-orm';

const router = Router();

// GET: Obtener todas las notificaciones y avisos de un profesional
router.get('/:professionalId', async (req, res) => {
  try {
    const { professionalId } = req.params;

    // 1. Verificación automática de capacidad próxima al límite (ej. >= 90%)
    const [prof] = await db
      .select()
      .from(businessProfessionals)
      .where(eq(businessProfessionals.professionalId, professionalId));

    if (prof) {
      const [clientCount] = await db
        .select({ value: count() })
        .from(businessClients)
        .where(eq(businessClients.professionalId, professionalId));

      const total = Number(clientCount.value);
      const limit = prof.userLimit || 250;
      const percentage = (total / limit) * 100;

      if (percentage >= 90) {
        // Verificar si ya existe una notificación similar reciente para no duplicar
        const notifications = await db
          .select()
          .from(businessNotifications)
          .where(eq(businessNotifications.professionalId, professionalId));

        const exists = notifications.some(n => n.title.includes('Capacidad'));
        if (!exists) {
          await db.insert(businessNotifications).values({
            professionalId,
            title: 'Capacidad del Plan Próxima al Límite',
            message: `Estás utilizando el ${Math.round(percentage)}% de tu plan actual (${total}/${limit} usuarios). Considera actualizar tu plan.`
          });
        }
      }
    }

    // 2. Obtener todas las notificaciones del profesional
    const notifications = await db
      .select()
      .from(businessNotifications)
      .where(eq(businessNotifications.professionalId, professionalId));

    // 3. Obtener incidencias del sistema reportadas
    const incidents = await db
      .select()
      .from(systemIncidents)
      .where(eq(systemIncidents.professionalId, professionalId));

    res.json({
      success: true,
      notifications,
      incidents
    });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al obtener las notificaciones' });
  }
});

// PATCH: Marcar notificación como leída
router.patch('/:notificationId/read', async (req, res) => {
  try {
    const { notificationId } = req.params;

    await db
      .update(businessNotifications)
      .set({ read: true })
      .where(eq(businessNotifications.id, Number(notificationId)));

    res.json({ success: true, message: 'Notificación marcada como leída' });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al actualizar la notificación' });
  }
});

export default router;
