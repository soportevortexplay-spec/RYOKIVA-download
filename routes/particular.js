import { Router } from 'express';
import { db } from '../db.js';
import { particularUsers, particularProfiles, particularPlaylists } from '../drizzle/schema.js';
import { eq, count } from 'drizzle-orm';

const router = Router();

// POST: Registro de usuario Particular por email
router.post('/register', async (req, res) => {
  try {
    const { email, passwordHash } = req.body;
    if (!email || !passwordHash) {
      return res.status(400).json({ success: false, message: 'Correo y contraseña requeridos' });
    }

    const [user] = await db
      .insert(particularUsers)
      .values({ email, passwordHash })
      .returning();

    res.status(201).json({ success: true, user });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al registrar usuario particular' });
  }
});

// POST: Crear perfil particular (Límite 5)
router.post('/:userId/profiles', async (req, res) => {
  try {
    const { userId } = req.params;
    const { profileName } = req.body;

    const [existing] = await db
      .select({ value: count() })
      .from(particularProfiles)
      .where(eq(particularProfiles.particularUserId, Number(userId)));

    if (Number(existing.value) >= 5) {
      return res.status(400).json({ success: false, message: 'Límite máximo de 5 perfiles particulares alcanzado' });
    }

    const [profile] = await db
      .insert(particularProfiles)
      .values({ particularUserId: Number(userId), profileName })
      .returning();

    res.status(201).json({ success: true, profile });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al crear perfil particular' });
  }
});

// POST: Añadir lista de reproducción particular
router.post('/:userId/playlists', async (req, res) => {
  try {
    const { userId } = req.params;
    const { playlistUrl } = req.body;

    const [playlist] = await db
      .insert(particularPlaylists)
      .values({ particularUserId: Number(userId), playlistUrl })
      .returning();

    res.status(201).json({ success: true, playlist });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error al añadir lista particular' });
  }
});

export default router;
