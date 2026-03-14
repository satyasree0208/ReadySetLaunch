# ReadySetLaunch — Backend API 🚀

Built with **Node.js + Express + Supabase** (PostgreSQL + Auth)

---

## 📁 Folder Structure

```
ReadySetLaunch-backend/
├── server.js                          # Entry point
├── package.json
├── .env.example                       # Copy to .env and fill values
├── supabase-schema.sql                # Run this in Supabase SQL Editor
│
├── config/
│   └── supabase.js                    # Supabase client (anon + admin)
│
├── middleware/
│   └── authMiddleware.js              # JWT verification for protected routes
│
└── modules/
    ├── auth/
    │   ├── authRoutes.js              # POST /api/auth/register, /login, /logout
    │   └── authController.js         # Email/password + Google OAuth logic
    │
    ├── projects/
    │   ├── projectRoutes.js           # GET/POST/PUT/DELETE /api/projects
    │   └── projectController.js      # CRUD for projects
    │
    ├── checklist/
    │   ├── checklistRoutes.js         # GET/PUT /api/checklist/:projectId
    │   └── checklistController.js    # Toggle items, progress, reset
    │
    ├── simulation/
    │   ├── simulationRoutes.js        # POST /api/simulation/:projectId/run
    │   └── simulationController.js   # Scoring logic + result storage
    │
    ├── history/
    │   ├── historyRoutes.js           # GET /api/history
    │   └── historyController.js      # All projects with readiness summary
    │
    └── dashboard/
        ├── dashboardRoutes.js         # GET /api/dashboard
        └── dashboardController.js    # Aggregated stats for home screen
```

---

## ⚡ Quick Start

### Step 1 — Install dependencies
```bash
cd ReadySetLaunch-backend
npm install
```

### Step 2 — Set up Supabase
1. Go to [supabase.com](https://supabase.com) → create a new project
2. Open **SQL Editor** → paste the entire contents of `supabase-schema.sql` → click **Run**
3. Go to **Settings → API** → copy your Project URL, anon key, and service role key

### Step 3 — Enable Google OAuth in Supabase
1. Go to **Authentication → Providers → Google**
2. Toggle **Enable**
3. Create a Google OAuth app at [console.cloud.google.com](https://console.cloud.google.com):
   - Create project → APIs & Services → Credentials → OAuth 2.0 Client ID
   - Authorised redirect URI: `https://your-project-id.supabase.co/auth/v1/callback`
4. Paste **Client ID** and **Client Secret** into Supabase → Save

### Step 4 — Configure environment
```bash
cp .env.example .env
```
Fill in your `.env`:
```env
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
APP_URL=http://localhost:5000
PORT=5000
FRONTEND_URL=http://localhost:3000
```

### Step 5 — Run the server
```bash
# Development (auto-restart on changes)
npm run dev

# Production
npm start
```

Server runs at: `http://localhost:5000`

---

## 🔌 API Endpoints

### Auth — `/api/auth`
| Method | Endpoint              | Description                        | Auth Required |
|--------|-----------------------|------------------------------------|---------------|
| POST   | `/register`           | Register with email + password     | ❌            |
| POST   | `/login`              | Login with email + password        | ❌            |
| POST   | `/logout`             | Logout current session             | ✅            |
| POST   | `/reset-password`     | Send password reset email          | ❌            |
| GET    | `/google`             | Redirect to Google login           | ❌            |
| GET    | `/google/callback`    | Google OAuth callback              | ❌            |
| GET    | `/me`                 | Get current logged-in user         | ✅            |

### Projects — `/api/projects`
| Method | Endpoint   | Description               | Auth Required |
|--------|------------|---------------------------|---------------|
| GET    | `/`        | Get all user projects     | ✅            |
| GET    | `/:id`     | Get single project        | ✅            |
| POST   | `/`        | Create new project        | ✅            |
| PUT    | `/:id`     | Update project            | ✅            |
| DELETE | `/:id`     | Delete project            | ✅            |

### Checklist — `/api/checklist`
| Method | Endpoint                    | Description                   | Auth Required |
|--------|-----------------------------|-------------------------------|---------------|
| GET    | `/:projectId`               | Get checklist (auto-seeds)    | ✅            |
| GET    | `/:projectId/progress`      | Get overall + section %       | ✅            |
| PUT    | `/:projectId/:itemId`       | Toggle item done/undone       | ✅            |
| DELETE | `/:projectId/reset`         | Reset all items to undone     | ✅            |

### Simulation — `/api/simulation`
| Method | Endpoint              | Description                    | Auth Required |
|--------|-----------------------|--------------------------------|---------------|
| POST   | `/:projectId/run`     | Run a new launch simulation    | ✅            |
| GET    | `/:projectId`         | Get simulation history         | ✅            |

### History — `/api/history`
| Method | Endpoint | Description                          | Auth Required |
|--------|----------|--------------------------------------|---------------|
| GET    | `/`      | All projects with readiness summary  | ✅            |
| GET    | `/:id`   | Single project with full detail      | ✅            |

### Dashboard — `/api/dashboard`
| Method | Endpoint | Description                     | Auth Required |
|--------|----------|---------------------------------|---------------|
| GET    | `/`      | Stats: projects, avg readiness  | ✅            |

---

## 🔐 How Authentication Works

### Email / Password
```javascript
// Register
POST /api/auth/register
Body: { "email": "user@example.com", "password": "secret123", "full_name": "Satya" }

// Login → returns access_token
POST /api/auth/login
Body: { "email": "user@example.com", "password": "secret123" }

// Use token in all protected requests
Headers: { "Authorization": "Bearer <access_token>" }
```

### Google OAuth (frontend flow)
```javascript
// 1. Redirect user to:
GET /api/auth/google

// 2. User picks Google account → Supabase handles token exchange

// 3. Frontend receives session at /auth/callback
//    Extract token from URL hash or Supabase JS client session
```

---

## 🗃️ Database Tables

| Table             | Description                              |
|-------------------|------------------------------------------|
| `profiles`        | User profile (auto-created on signup)    |
| `projects`        | Each product/project created by a user   |
| `checklist_items` | 16 launch readiness tasks per project    |
| `simulations`     | Simulation results with scores           |

---

## 🚀 Deploy to Railway / Render

```bash
# Set these environment variables in your hosting dashboard:
SUPABASE_URL
SUPABASE_ANON_KEY
SUPABASE_SERVICE_ROLE_KEY
FRONTEND_URL
PORT
```

Both [Railway](https://railway.app) and [Render](https://render.com) support Node.js — just connect your GitHub repo and set the env vars.

---

## 📄 License
MIT
