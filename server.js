// server.js — ReadySetLaunch Backend Entry Point

import 'dotenv/config';
import express from 'express';
import cors from 'cors';

// Route modules
import authRoutes       from './modules/auth/authRoutes.js';
import projectRoutes    from './modules/projects/projectRoutes.js';
import checklistRoutes  from './modules/checklist/checklistRoutes.js';
import simulationRoutes from './modules/simulation/simulationRoutes.js';
import historyRoutes    from './modules/history/historyRoutes.js';
import dashboardRoutes  from './modules/dashboard/dashboardRoutes.js';

const app  = express();
const PORT = process.env.PORT || 5000;

// ── Middleware ────────────────────────────────────────────────────────────
app.use(cors({
  origin:      process.env.FRONTEND_URL || 'http://localhost:3000',
  credentials: true
}));
app.use(express.json());

// ── Routes ────────────────────────────────────────────────────────────────
app.use('/api/auth',        authRoutes);
app.use('/api/projects',    projectRoutes);
app.use('/api/checklist',   checklistRoutes);
app.use('/api/simulation',  simulationRoutes);
app.use('/api/history',     historyRoutes);
app.use('/api/dashboard',   dashboardRoutes);

// ── Health check ──────────────────────────────────────────────────────────
app.get('/api/health', (_req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// ── 404 fallback ─────────────────────────────────────────────────────────
app.use((_req, res) => {
  res.status(404).json({ error: 'Route not found.' });
});

// ── Start ─────────────────────────────────────────────────────────────────
app.listen(PORT, () => {
  console.log(`\n🚀 ReadySetLaunch API running on http://localhost:${PORT}`);
  console.log(`   Health check → http://localhost:${PORT}/api/health\n`);
});
