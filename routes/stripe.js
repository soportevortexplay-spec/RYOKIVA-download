import { Router } from 'express';
import { db } from '../db.js';
import { businessProfessionals, businessNotifications } from '../drizzle/schema.js';
import { eq } from 'drizzle-orm';

const router = Router();

// POST: Webhook de Stripe para automatizar activaciones y gestionar fallos de pago
router.post('/webhook', async (req, res) => {
  const event = req.body;

  try {
    switch (event.type) {
      case 'checkout.session.completed':
      case 'invoice.payment_succeeded': {
        const sessionOrInvoice = event.data.object;
        const customerId = sessionOrInvoice.customer;

        // Determinar el plan según el importe o metadata (ejemplo genérico basado en planes)
        // Buscamos al profesional por su stripeCustomerId
        const [prof] = await db
          .select()
          .from(businessProfessionals)
          .where(eq(businessProfessionals.stripeCustomerId, customerId));

        if (prof) {
          // Activar suscripción y asegurar estado activo
          await db
            .update(businessProfessionals)
            .set({ status: 'active' })
            .where(eq(businessProfessionals.id, prof.id));

          // Registrar notificación de éxito
          await db.insert(businessNotifications).values({
            professionalId: prof.professionalId,
            title: 'Suscripción Renovada',
            message: 'Tu pago se ha procesado correctamente y la capacidad de tu plan está activa.'
          });
        }
        break;
      }

      case 'invoice.payment_failed': {
        const invoice = event.data.object;
        const customerId = invoice.customer;

        const [prof] = await db
          .select()
          .from(businessProfessionals)
          .where(eq(businessProfessionals.stripeCustomerId, customerId));

        if (prof) {
          // Suspender profesional por fallo de pago (SIN eliminar cuentas ni listas de clientes)
          await db
            .update(businessProfessionals)
            .set({ status: 'suspended' })
            .where(eq(businessProfessionals.id, prof.id));

          // Registrar notificación de aviso importante
          await db.insert(businessNotifications).values({
            professionalId: prof.professionalId,
            title: 'Pago Fallido / Suspendido',
            message: 'Hubo un problema con tu último pago. Actualiza tu método de pago para reactivar el servicio. Tus datos y clientes están seguros y conservados.'
          });
        }
        break;
      }

      default:
        console.log(`Evento de Stripe no manejado: ${event.type}`);
    }

    res.json({ received: true });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error procesando webhook de Stripe' });
  }
});

export default router;
