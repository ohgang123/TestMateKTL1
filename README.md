# KTL TestMate

FastAPI backend and static frontend for KTL test application prediction,
recommendation, statistics, and admin workflows.

## Render Deployment

This repository is prepared for Render deployment.

Use **New > Blueprint** in Render and select this repository. Render reads
`render.yaml` automatically.

Key files for deployment:

- `render.yaml`: Render service, health check, environment variables, disk
- `start.sh`: startup script that runs the FastAPI server on Render's `PORT`
- `requirements.txt`: Python dependencies
- `backend/`: API, model, SQLite logic
- `backend/artifacts/`: committed trained model and statistics files
- `frontend/`: static applicant/admin screens

## Manual Render Settings

If you create a Render Web Service manually:

- Runtime: `Python`
- Build Command: `pip install -r requirements.txt`
- Start Command: `bash ./start.sh`
- Environment Variables:
  - `PYTHON_VERSION=3.11.9`
  - `KTL_DB_PATH=/var/data/ktl.db`

Attach a persistent disk mounted at `/var/data` so SQLite data survives
redeploys.

## URLs

After deployment:

- `/`: landing page
- `/applicant/`: applicant screen
- `/admin/`: admin dashboard
- `/admin/db.html`: DB console
- `/admin/stats.html`: statistics console
- `/docs`: Swagger API docs

## Notes

- The original raw training CSV is not required for deployment because the
  trained model artifacts are already in `backend/artifacts/`.
- Runtime SQLite data is stored outside the repository with `KTL_DB_PATH`.
