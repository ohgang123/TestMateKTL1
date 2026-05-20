# Render Deploy

This project is ready to deploy as a Render Web Service with the included
`render.yaml`.

## Deploy with Blueprint

1. Push this folder to GitHub/GitLab/Bitbucket.
2. In Render, choose **New > Blueprint**.
3. Select the repository.
4. Render will read `render.yaml` and create the web service.

The service uses:

- Runtime: Python
- Build command: `pip install -r requirements.txt`
- Start command: `bash ./start.sh`
- Health check: `/api/dashboard`
- SQLite path: `backend/data/ktl.db` by default

## Deploy Manually

If you create a Web Service manually, use these settings:

- Runtime: `Python`
- Build Command: `pip install -r requirements.txt`
- Start Command: `bash ./start.sh`
- Environment Variables:
  - `PYTHON_VERSION=3.11.9`

Attach a persistent disk mounted at `/var/data` only if you want submitted
applications to survive redeploys. If you do, add `KTL_DB_PATH=/var/data/ktl.db`.

## Notes

- Render provides the `PORT` environment variable. `start.sh` binds Uvicorn to
  `0.0.0.0:$PORT`.
- The trained model files in `backend/artifacts/` must be committed. If the
  model file is missing, startup stops with a clear error unless training data
  is provided via `KTL_DATA_CSV`.
