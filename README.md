# Proposal Maker

A clean React application for managing business proposals, company brandings, service items, and client-facing proposal views.

## Features

- Create proposals with custom services and pricing
- Manage multiple company profiles and branding data
- View proposals in a client-ready format
- Export proposals to Google Sheets via API
- Print or save proposals as PDF-ready documents

## Getting Started

1. Install dependencies:

```bash
npm install
```

2. Start the development server:

```bash
npm run dev
```

3. Open the app at:

```bash
http://localhost:3000
```

## Key Pages

- `/` — Home dashboard
- `/admin/proposals` — Admin proposal editor
- `/admin/companies` — Company branding manager
- `/admin/services` — Service management

## Notes

- Google Sheets export requires `GOOGLE_SHEETS_API_KEY` and `GOOGLE_SHEETS_ID` in `.env.local`
- Proposal and company data are stored locally in the browser via `localStorage`
