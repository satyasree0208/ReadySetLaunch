# ReadySetLaunch — Full Stack (Frontend + Supabase)

Complete integrated project: frontend wired to Supabase auth + backend API.

---

## ⚡ 2-Step Setup to Get Running

### Step 1 — Add your Supabase keys to `js/supabase.js`
```js
const SUPABASE_URL  = 'https://YOUR-PROJECT.supabase.co';
const SUPABASE_ANON = 'your-anon-key';
```

### Step 2 — Add your backend URL to `js/api.js`
```js
const API_BASE = 'http://localhost:5000/api';  // or your deployed URL
```

### Step 3 — Open `index.html` in a browser
That's it! No build tools, no npm install for the frontend.

---

## 🗂 File Structure

```
ReadySetLaunch-integrated/
├── index.html              ← All pages in one SPA
├── css/
│   ├── variables.css       ← Design tokens
│   ├── base.css            ← Reset & globals
│   ├── components.css      ← Nav, buttons, forms, checklist
│   ├── pages.css           ← Page-specific styles
│   ├── responsive.css      ← Mobile breakpoints
│   └── auth.css            ← Auth page overrides
├── js/
│   ├── supabase.js         ← Supabase client (PUT YOUR KEYS HERE)
│   ├── api.js              ← All backend API calls
│   ├── auth.js             ← Login, register, Google OAuth, logout
│   ├── router.js           ← Page routing with auth guard
│   ├── dashboard.js        ← Data loading: dashboard, history, checklist, simulation
│   └── app.js              ← Entry point, wires everything together
└── assets/
    └── favicon.svg
```

---

## 🔐 Auth Flow

| Action | How |
|---|---|
| Register | Email + password via Supabase |
| Login | Email + password via Supabase |
| Google login | One-click OAuth via Supabase |
| Session | Auto-restored on page load |
| Logout | Clears session, redirects to auth page |

---

## 📂 What the Analyzer Does

1. User drops any file (`.html`, `.js`, `.py`, `.zip`, `.md`, etc.)
2. File type is detected from extension
3. Scores are calculated for 4 sections: Market, Technical, Operations, UX
4. Results show: Readiness %, Adoption prediction, Weeks to launch, Suggestions
5. User can click "Create project from this" to save it to Supabase

---

## 🔌 Backend Required For

- Saving projects to database
- Persistent checklist state
- Running & storing simulations
- Project history with real data
- Dashboard stats

The analyzer and checklist **work offline** (no backend needed) for the demo/reviewer.

---

## 🚀 Deploy to GitHub Pages (frontend only)

1. Push to GitHub
2. Settings → Pages → Deploy from `main` branch
3. Add your Supabase keys in `js/supabase.js` before pushing
