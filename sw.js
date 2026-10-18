const CACHE_NAME = 'ryokiva-v1';
const ASSETS = [
  '/',
  'index.html',
  'profiles.html',
  'tv.html',
  'vod.html',
  'settings.html',
  'logo.png',
  'fondo.jpg'
];

self.addEventListener('install', (e) => {
  e.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(ASSETS))
  );
});

self.addEventListener('fetch', (e) => {
  e.respondWith(
    caches.match(e.request).then((res) => res || fetch(e.request))
  );
});
