import os
from pathlib import Path
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import joblib

print("Iniciando pipeline de predicción...")

# 1. Cargar credenciales y conectar a la Base de Datos
BASE_DIR = Path(__file__).resolve().parent.parent
ENV_PATH = BASE_DIR / ".env"
MODELS_DIR = BASE_DIR / "Models"

load_dotenv(dotenv_path=ENV_PATH)
DB_USER = os.getenv('DB_USER')
DB_PASS = os.getenv('DB_PASS')
DB_HOST = os.getenv('DB_HOST')
DB_PORT = os.getenv('DB_PORT')
DB_NAME = os.getenv('DB_NAME')

engine = create_engine(f'postgresql+psycopg2://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}')

# 2. Extraer los datos de clientes nuevos (Joined)
# Recordamos usar minúsculas para el nombre de la vista en PostgreSQL
query = "SELECT * FROM vw_joindata"
df_new = pd.read_sql_query(query, engine)

print(f"Datos extraídos: {df_new.shape[0]} clientes nuevos a evaluar.")

# Guardar los IDs para asociarlos a la predicción final
clientes_ids = df_new['Customer ID']

# 3. Cargar el modelo y la estructura de columnas esperada
MODEL_PATH = MODELS_DIR / "random_forest_churn.pkl"
COLUMNS_PATH = MODELS_DIR / "model_columns.pkl"

rf_model = joblib.load(MODEL_PATH)
expected_columns = joblib.load(COLUMNS_PATH)

# 4. Preprocesamiento de los datos nuevos
# Identificamos las columnas a eliminar, usando errors='ignore' por si alguna (como Churn Score) ya no viene en los nuevos
columnas_a_eliminar = [
    'Customer ID', 'Customer Status', 'Churn Label', 
    'Churn Score', 'Churn Category', 'Churn Reason',
    'Satisfaction Score'
]
X_new_raw = df_new.drop(columns=[col for col in columnas_a_eliminar if col in df_new.columns], errors='ignore')

# Aplicar One-Hot Encoding
X_new = pd.get_dummies(X_new_raw, drop_first=True)

# *** EL PASO CRÍTICO DE PRODUCCIÓN ***
# Alinear las columnas del dataset nuevo con las que el modelo aprendió durante el entrenamiento
X_new = X_new.reindex(columns=expected_columns, fill_value=0)

# 5. Generar Predicciones
# Extraemos la probabilidad de la clase 1 (Probabilidad de que SÍ abandone)
probabilidad_churn = rf_model.predict_proba(X_new)[:, 1]
# Opcional: También sacamos la clasificación dura (0 o 1)
prediccion_clase = rf_model.predict(X_new)

# 6. Ensamblar la tabla final para la base de datos
df_predicciones = pd.DataFrame({
    'Customer ID': clientes_ids,
    'Churn_Risk_Probability': probabilidad_churn,
    'Churn_Prediction_Flag': prediccion_clase
})

# 7. Cargar los resultados directamente a PostgreSQL
# if_exists='replace' recrea la tabla en cada ejecución. En un flujo diario real podrías usar 'append' con lógica de upsert.
df_predicciones.to_sql('fact_churn_predictions', engine, if_exists='replace', index=False)

print("¡Éxito! Las predicciones han sido calculadas y almacenadas en la tabla 'fact_churn_predictions' de PostgreSQL.")