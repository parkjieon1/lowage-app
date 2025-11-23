# Model server (FastAPI)

Place your `lai_v6_quantile_engine.pkl` model file under `server/model/` (create that directory). The server will load the model at startup and expose a `/predict` endpoint.

Quick local run (Windows PowerShell):

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port 8000
```

Notes for Android emulator:
- From the Android emulator, access the host machine at `http://10.0.2.2:8000/predict` (POST with JSON).
- If you use a different emulator (e.g., Genymotion), the host IP differs.

Example request body:

```json
{
  "sex": "M",
  "sit_ups": 35,
  "flexibility": 5.0,
  "jump_power": 40.0,
  "cardio_recovery": 110
}
```

Security note: Do not commit `.pkl` to source control; put it in `server/model/` and ensure `.gitignore` excludes that folder.
