# ReadySetLaunch 🚀

> From **Idea → Launch Confidence**

A sleek, dark-themed frontend app that helps founders and makers assess their product launch readiness through interactive checklists, simulations, and roadmaps.

---

## ✨ Features

- **Practice Mode** — Interactive launch readiness checklist with per-section progress tracking
- **Marketing Mode** — Platform selector and product workspace with a live readiness meter
- **Launch Simulation** — AI-style launch outcome simulator with adoption predictions and risk levels
- **Launch Roadmap** — Animated 3-week timeline with prioritised tasks
- **Project History** — Track and revisit previous projects

---

## 📁 Project Structure

```
ReadySetLaunch/
├── index.html              # Main entry point
├── css/
│   ├── variables.css       # Design tokens (colours, spacing, radius)
│   ├── base.css            # CSS reset & global styles
│   ├── components.css      # Reusable UI components (nav, buttons, forms…)
│   ├── pages.css           # Page-specific layouts and styles
│   └── responsive.css      # Media queries & mobile styles
├── js/
│   ├── router.js           # Client-side page router (showPage)
│   ├── checklist.js        # Checklist toggle & progress logic
│   ├── simulation.js       # Launch simulation + platform selection
│   └── readiness.js        # Live readiness gauge (product input page)
├── assets/
│   └── favicon.svg         # SVG favicon
└── README.md
```

---

## 🚀 Getting Started

No build tools required — this is a pure HTML/CSS/JS project.

### Run locally

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/ReadySetLaunch.git
cd ReadySetLaunch

# Open in browser (macOS)
open index.html

# Or serve with any static server
npx serve .
```

### Deploy to GitHub Pages

1. Push the repo to GitHub
2. Go to **Settings → Pages**
3. Set source to `main` branch, `/ (root)` folder
4. Your site will be live at `https://YOUR_USERNAME.github.io/ReadySetLaunch/`

---

## 🛠 Tech Stack

| Technology | Usage |
|---|---|
| HTML5 | Semantic markup, multi-page SPA structure |
| CSS3 | Custom properties, Grid, Flexbox, animations |
| Vanilla JS | DOM manipulation, routing, state management |
| Google Fonts | Sora + JetBrains Mono |
| Inline SVG | All icons (zero external icon dependencies) |

---

## 🎨 Design System

All design tokens live in `css/variables.css`:

| Token | Value | Usage |
|---|---|---|
| `--green` | `#2de09e` | Primary CTA, success states |
| `--blue` | `#4a90d9` | Marketing mode accent |
| `--bg-deep` | `#080c18` | Page background |
| `--bg-card` | `#0e1526` | Card backgrounds |

---

## 📄 License

MIT — free to use, modify, and distribute.
