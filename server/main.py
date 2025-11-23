from fastapi import FastAPI
from pydantic import BaseModel
import numpy as np
import pickle
import os

app = FastAPI()

MODEL_PATH = os.path.join(os.path.dirname(__file__), 'model', 'lai_v6_quantile_engine.pkl')
model = None


class LoAgeInput(BaseModel):
    sex: str  # 'M' or 'F'
    sit_ups: int
    flexibility: float
    jump_power: float
    cardio_recovery: int


@app.on_event('startup')
def load_model():
    global model
    from fastapi import FastAPI
    from pydantic import BaseModel
    import numpy as np
    import pickle
    import os
    import traceback

    app = FastAPI()

    MODEL_PATH = os.path.join(os.path.dirname(__file__), 'model', 'lai_v6_quantile_engine.pkl')
    model = None
    loader_name = None


    class LoAgeInput(BaseModel):
        sex: str  # 'M' or 'F'
        sit_ups: int
        flexibility: float
        jump_power: float
        cardio_recovery: int


    @app.on_event('startup')
    def load_model():
        global model, loader_name
        if not os.path.exists(MODEL_PATH):
            print(f"Model not found at {MODEL_PATH}. Place your .pkl there.")
            model = None
            return

        # Try pickle first, then joblib as a fallback
        try:
            with open(MODEL_PATH, 'rb') as f:
                model = pickle.load(f)
            loader_name = 'pickle'
            print('Model loaded with pickle.')
        except Exception:
            try:
                import joblib

                model = joblib.load(MODEL_PATH)
                loader_name = 'joblib'
                print('Model loaded with joblib.')
            except Exception:
                print('Failed to load model with pickle and joblib:')
                traceback.print_exc()
                model = None


    @app.post('/predict')
    def predict(inp: LoAgeInput):
        if model is None:
            return {'error': 'model not loaded'}

        sex_value = 1 if inp.sex.upper() == 'M' else 0
        # Default: create a 2D numpy array; many sklearn models accept this.
        X = np.array([[sex_value, inp.sit_ups, inp.flexibility, inp.jump_power, inp.cardio_recovery]])

        try:
            # Try common predict interface
            pred = model.predict(X)
            lo_age = float(pred[0])
            return {'lo_age': lo_age, 'tier': f"대략 {int(lo_age)//10*10}대", 'percentile': None}
        except Exception as e1:
            # If the model is a pipeline or expects a dict-like input, try alternative
            try:
                # Some custom models accept a list/dict of records
                if hasattr(model, 'predict'):
                    pred = model.predict({
                        'sex': [inp.sex],
                        'sit_ups': [inp.sit_ups],
                        'flexibility': [inp.flexibility],
                        'jump_power': [inp.jump_power],
                        'cardio_recovery': [inp.cardio_recovery],
                    })
                    lo_age = float(pred[0])
                    return {'lo_age': lo_age, 'tier': f"대략 {int(lo_age)//10*10}대", 'percentile': None}
            except Exception:
                pass

            # If both approaches failed, return error with traceback for debugging
            tb = traceback.format_exc()
            return {'error': 'prediction failed', 'detail': str(e1), 'trace': tb}
