import { Router } from 'express';
import { db } from '../db.js';
import { businessClients, businessProfessionals, clientProfiles, m3uPlaylists, authorizedDevices } from '../drizzle/schema.js';
import { eq, count, and } from 'drizzle-orm';

const router = Router();

// POST: Crear cliente para un profesional con validación estricta del límite del plan
router.post('/', async (req, res) => {
  try {
    const { professionalId, username, passwordHash, maxDevices } = req.body;
    if (!professionalId || !username || !passwordHash) {
      return res.status(400).json({ success: false, message: 'Faltan datos requeridos' });
    }

    // 1. Obtener la capacidad contratada del profesional
    const [prof] = await db
      .select()
      .from(businessProfessionals)
      .where(eq(businessProfessionals.professionalId, professionalId));

    if (!prof) {
      return res.status(404).json({ success: false, message: 'Profesional no encontrado' });
    }

    // 2. Contar usuarios actuales del profesional
    const [currentClientsCount] = await db
      .select({ value: count() })
      .from(businessClients)
      .where(eq(businessClients.professionalId, professionalId));

    const totalCurrent = Number(currentClientsCount.value);
    const userLimit = prof.userLimit || 250; // Por defecto Business 250

    // 3. Validar si supera el límite del plan
    if (totalCurrent >= userLimit) {
      return res.status(403).json({ 
        success: false, 
        message: `Límite de usuarios alcanzado para tu plan actual (${userLimit} usuarios máximo). Actualiza tu plan para añadir más clientes.` 
      });
    }

    // 4. Crear el cliente
    const [client] = await db
      .insert(businessClients)
      .values({
        professionalId,
        username,
        passwordHash,
        maxDevices: maxDevices || 5,
        status: 'active'
      })
      .returning();

    res.status(201).json({ success: true, client });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al crear cliente' });
  }
});

// GET: Obtener la ficha individual completa de un cliente
router.get('/:clientId/details', async (req, res) => {
  try {
    const { clientId } = req.params;

    const [client] = await db
      .select()
      .from(businessClients)
      .where(eq(businessClients.id, Number(clientId)));

    if (!client) {
      return res.status(404).json({ success: false, message: 'Cliente no encontrado' });
    }

    const profiles = await db
      .select()
      .from(clientProfiles)
      .where(eq(clientProfiles.clientId, Number(clientId)));

    const playlists = await db
      .select()
      .from(m3uPlaylists)
      .where(eq(m3uPlaylists.clientId, Number(clientId)));

    const devices = await db
      .select()
      .from(authorizedDevices)
      .where(eq(authorizedDevices.clientId, Number(clientId)));

    res.json({
      success: true,
      clientCard: {
        ...client,
        profiles,
        playlists,
        devices
      }
    });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al obtener la ficha del cliente' });
  }
});

// PATCH: Modificar estado del cliente (suspender / activar / renovar)
router.patch('/:clientId/status', async (req, res) => {
  try {
    const { clientId } = req.params;
    const { status } = req.body;

    if (!['active', 'suspended', 'expired'].includes(status)) {
      return res.status(400).json({ success: false, message: 'Estado inválido' });
    }

    await db
      .update(businessClients)
      .set({ status })
      .where(eq(businessClients.id, Number(clientId)));

    res.json({ success: true, message: `Cuenta actualizada a estado: ${status}. Datos y listas conservados.` });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al actualizar el estado' });
  }
});

// POST: Registrar / Autorizar un nuevo dispositivo (Máximo 5)
router.post('/:clientId/devices', async (req, res) => {
  try {
    const { clientId } = req.params;
    const { deviceId, deviceName } = req.body;

    if (!deviceId) {
      return res.status(400).json({ success: false, message: 'ID de dispositivo requerido' });
    }

    const [existingCount] = await db
      .select({ value: count() })
      .from(authorizedDevices)
      .where(eq(authorizedDevices.clientId, Number(clientId)));

    if (Number(existingCount.value) >= 5) {
      return res.status(400).json({ success: false, message: 'Límite máximo de 5 dispositivos alcanzado' });
    }

    const [existingDevice] = await db
      .select()
      .from(authorizedDevices)
      .where(and(eq(authorizedDevices.clientId, Number(clientId)), eq(authorizedDevices.deviceId, deviceId)));

    if (existingDevice) {
      const [updated] = await db
        .update(authorizedDevices)
        .set({ lastActive: new Date(), deviceName: deviceName || existingDevice.deviceName })
        .where(eq(authorizedDevices.id, existingDevice.id))
        .returning();
      return res.json({ success: true, device: updated });
    }

    const [device] = await db
      .insert(authorizedDevices)
      .values({
        clientId: Number(clientId),
        deviceId,
        deviceName: deviceName || 'Dispositivo Compatible'
      })
      .returning();

    res.status(201).json({ success: true, device });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al autorizar el dispositivo' });
  }
});

// DELETE: Desvincular / Bloquear un dispositivo
router.delete('/:clientId/devices/:deviceId', async (req, res) => {
  try {
    const { clientId, deviceId } = req.params;

    await db
      .delete(authorizedDevices)
      .where(and(eq(authorizedDevices.clientId, Number(clientId)), eq(authorizedDevices.deviceId, deviceId)));

    res.json({ success: true, message: 'Dispositivo desvinculado correctamente' });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al desvincular el dispositivo' });
  }
});

export default router;
