import { pgTable, serial, text, timestamp, boolean, integer } from 'drizzle-orm/pg-core';

export const businessNotifications = pgTable('business_notifications', {
  id: serial('id').primaryKey(),
  professionalId: text('professional_id').notNull(),
  title: text('title').notNull(),
  message: text('message').notNull(),
  read: boolean('read').default(false).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull()
});

export const businessProfessionals = pgTable('business_professionals', {
  id: serial('id').primaryKey(),
  professionalId: text('professional_id').unique().notNull(),
  name: text('name').notNull(),
  email: text('email').unique().notNull(),
  passwordHash: text('password_hash').notNull(),
  plan: text('plan').default('Business 250').notNull(),
  priceMonthly: integer('price_monthly').default(20).notNull(),
  status: text('status').default('active').notNull(),
  userLimit: integer('user_limit').default(250).notNull(),
  stripeCustomerId: text('stripe_customer_id'),
  stripeSubscriptionId: text('stripe_subscription_id'),
  createdAt: timestamp('created_at').defaultNow().notNull()
});

export const systemIncidents = pgTable('system_incidents', {
  id: serial('id').primaryKey(),
  professionalId: text('professional_id'),
  type: text('type').notNull(),
  description: text('description').notNull(),
  resolved: boolean('resolved').default(false).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull()
});

export const businessClients = pgTable('business_clients', {
  id: serial('id').primaryKey(),
  professionalId: text('professional_id').notNull(),
  username: text('username').unique().notNull(),
  passwordHash: text('password_hash').notNull(),
  status: text('status').default('active').notNull(),
  maxDevices: integer('max_devices').default(2).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull()
});

export const clientProfiles = pgTable('client_profiles', {
  id: serial('id').primaryKey(),
  clientId: integer('client_id').notNull(),
  profileName: text('profile_name').notNull(),
  pinCode: text('pin_code'),
  parentalControl: boolean('parental_control').default(false).notNull(),
  favoritesChannels: text('favorites_channels'),
  favoritesVOD: text('favorites_vod'),
  lastChannel: text('last_channel'),
  lastMovie: text('last_movie'),
  lastEpisode: text('last_episode'),
  createdAt: timestamp('created_at').defaultNow().notNull()
});

export const m3uPlaylists = pgTable('m3u_playlists', {
  id: serial('id').primaryKey(),
  clientId: integer('client_id').notNull(),
  profileId: integer('profile_id'), // Opcional: lista específica para un perfil
  listType: text('list_type').default('primary').notNull(), // 'primary' (principal) o 'backup' (respaldo)
  type: text('type').notNull(), // 'm3u' o 'xtream'
  playlistUrl: text('playlist_url'),
  xtreamHost: text('xtream_host'),
  xtreamUser: text('xtream_user'),
  xtreamPass: text('xtream_pass'),
  createdAt: timestamp('created_at').defaultNow().notNull()
});

export const authorizedDevices = pgTable('authorized_devices', {
  id: serial('id').primaryKey(),
  clientId: integer('client_id').notNull(),
  deviceId: text('device_id').notNull(),
  deviceName: text('device_name'),
  lastActive: timestamp('last_active').defaultNow().notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull()
});

export const particularUsers = pgTable('particular_users', {
  id: serial('id').primaryKey(),
  email: text('email').unique().notNull(),
  passwordHash: text('password_hash').notNull(),
  stripeSubscriptionId: text('stripe_subscription_id'),
  status: text('status').default('active').notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull()
});

export const particularProfiles = pgTable('particular_profiles', {
  id: serial('id').primaryKey(),
  particularUserId: integer('particular_user_id').notNull(),
  profileName: text('profile_name').notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull()
});

export const particularPlaylists = pgTable('particular_playlists', {
  id: serial('id').primaryKey(),
  particularUserId: integer('particular_user_id').notNull(),
  playlistUrl: text('playlist_url').notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull()
});
