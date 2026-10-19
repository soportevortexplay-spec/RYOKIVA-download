/**
 * RYOKIVA - Conector Centralizado
 */
const API_BASE_URL = 'http://localhost:3000/api';
const RyokivaAPI = {
    getToken() { return localStorage.getItem('ryokiva_token') || ''; },
    async request(endpoint, options = {}) {
        const res = await fetch(API_BASE_URL + endpoint, { headers: { 'Content-Type': 'application/json' }, ...options });
        return res.json();
    }
};
window.RyokivaAPI = RyokivaAPI;
