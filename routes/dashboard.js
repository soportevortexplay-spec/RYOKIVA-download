import { Router } from 'express';
import { db } from '../db.js';
import { businessProfessionals, businessClients, authorizedDevices, businessNotifications } from '../drizzle/schema.js';
import { eq, count } from 'drizzle-orm';

const router = Router();

// GET: Obtener el resumen general de la Pantalla Principal
router.get('/:professionalId/summary', async (req, res) => {
  try {
    const { professionalId } = req.params;

    const [prof] = await db
      .select()
      .from(businessProfessionals)
      .where(eq(businessProfessionals.professionalId, professionalId));

    if (!prof) {
      return res.status(404).json({ success: false, message: 'Profesional no encontrado' });
    }

    const clients = await db
      .select()
      .from(businessClients)
      .where(eq(businessClients.professionalId, professionalId));

    const totalClients = clients.length;
    const activeClients = clients.filter(c => c.status === 'active').length;
    const suspendedClients = clients.filter(c => c.status === 'suspended').length;
    const userLimit = prof.userLimit || 250;
    const availableSlots = Math.max(0, userLimit - totalClients);

    const notifications = await db
      .select()
      .from(businessNotifications)
      .where(eq(businessNotifications.professionalId, professionalId));

    res.json({
      success: true,
      dashboard: {
        totalClients,
        activeClients,
        suspendedClients,
        capacityContracted: userLimit,
        availableSlots,
        plan: prof.plan,
        status: prof.status,
        notifications
      }
    });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al obtener el resumen del panel' });
  }
});

// GET: Estadísticas detalladas de control del negocio
router.get('/:professionalId/statistics', async (req, res) => {
  try {
    const { professionalId } = req.params;

    const [prof] = await db
      .select()
      .from(businessProfessionals)
      .where(eq(businessProfessionals.professionalId, professionalId));

    if (!prof) {
      return res.status(404).json({ success: false, message: 'Profesional no encontrado' });
    }

    const clients = await db
      .select()
      .from(businessClients)
      .where(eq(businessClients.professionalId, professionalId));

    const totalClients = clients.length;
    const activeClients = clients.filter(c => c.status === 'active').length;
    const inactiveClients = clients.filter(c => c.status === 'suspended' || c.status === 'expired').length;
    const expiredClients = clients.filter(c => c.status === 'expired').length;

    // Nuevas altas en los últimos 30 días
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    const newSignups = clients.filter(c => new Date(c.createdAt) >= thirtyDaysAgo).length;

    // Contar dispositivos registrados de todos los clientes del profesional
    let totalDevices = 0;
    for (const client of clients) {
      const devices = await db
        .select()
        .from(authorizedDevices)
        .where(eq(authorizedDevices.clientId, client.id));
      totalDevices += devices.length;
    }

    const userLimit = prof.userLimit || 250;
    const availableSlots = Math.max(0, userLimit - totalClients);

    res.json({
      success: true,
      statistics: {
        totalClients,
        activeClients,
        inactiveClients,
        newSignups,
        expiredClients,
        totalRegisteredDevices: totalDevices,
        capacityContracted: userLimit,
        capacityUsed: totalClients,
        availableSlots,
        subscriptionStatus: prof.status,
        plan: prof.plan
      }
    });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al obtener las estadísticas' });
  }
});

export default router;
