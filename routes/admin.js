import { Router } from 'express';
import { db } from '../db.js';
import { businessProfessionals, businessClients, systemIncidents } from '../drizzle/schema.js';
import { eq, count, sum } from 'drizzle-orm';

const router = Router();

// GET: Consultar todos los profesionales de la plataforma y estadísticas generales
router.get('/professionals', async (req, res) => {
  try {
    const professionals = await db.select().from(businessProfessionals);

    // Calcular estadísticas generales de la plataforma
    const totalProfessionals = professionals.length;
    const activeProfessionals = professionals.filter(p => p.status === 'active').length;
    const suspendedProfessionals = professionals.filter(p => p.status === 'suspended').length;

    const allClients = await db.select().from(businessClients);
    const totalPlatformClients = allClients.length;

    res.json({
      success: true,
      globalStats: {
        totalProfessionals,
        activeProfessionals,
        suspendedProfessionals,
        totalPlatformClients
      },
      professionals
    });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al obtener la lista de profesionales' });
  }
});

// POST: Crear un nuevo profesional Business y asignar plan/límites
router.post('/professionals', async (req, res) => {
  try {
    const { professionalId, name, email, passwordHash, plan, userLimit } = req.body;
    
    if (!professionalId || !name || !email || !passwordHash) {
      return res.status(400).json({ success: false, message: 'Faltan datos requeridos del profesional' });
    }

    // Definir límites por defecto según el plan si no se especifican
    let limit = userLimit || 250;
    let price = 20;
    if (plan === 'Business 500') { limit = 500; price = 40; }
    if (plan === 'Business 1000') { limit = 1000; price = 70; }

    const [newProf] = await db
      .insert(businessProfessionals)
      .values({
        professionalId,
        name,
        email,
        passwordHash,
        plan: plan || 'Business 250',
        priceMonthly: price,
        userLimit: limit,
        status: 'active'
      })
      .returning();

    res.status(201).json({ success: true, professional: newProf });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al crear el profesional Business' });
  }
});

// PATCH: Activar, suspender o modificar plan/límites de un profesional
router.patch('/professionals/:professionalId', async (req, res) => {
  try {
    const { professionalId } = req.params;
    const { status, plan, userLimit } = req.body;

    const updateData = {};
    if (status) updateData.status = status;
    if (plan) updateData.plan = plan;
    if (userLimit) updateData.userLimit = userLimit;

    const [updated] = await db
      .update(businessProfessionals)
      .set(updateData)
      .where(eq(businessProfessionals.professionalId, professionalId))
      .returning();

    if (!updated) {
      return res.status(404).json({ success: false, message: 'Profesional no encontrado' });
    }

    res.json({ success: true, message: 'Profesional actualizado correctamente', professional: updated });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al actualizar el profesional' });
  }
});

// GET: Revisar incidencias técnicas globales de la plataforma
router.get('/incidents', async (req, res) => {
  try {
    const incidents = await db.select().from(systemIncidents);
    res.json({ success: true, incidents });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al obtener las incidencias' });
  }
});

export default router;
