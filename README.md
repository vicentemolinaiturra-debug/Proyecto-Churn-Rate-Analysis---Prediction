# Telco Churn Rate Analysis & Prediction

Proyecto de análisis y predicción de abandono de clientes (*churn rate*) utilizando PostgreSQL, Python, Machine Learning y Power BI.

>## 📊 **Análisis Ejecutivo y Caso de Negocio**  
> Este repositorio documenta la arquitectura de datos y la guía de reproducción técnica. Para leer el análisis completo de resultados, la toma de decisiones basada en datos y ver el dashboard prescriptivo en acción, **[visita el caso de estudio en mi portafolio de Notion](https://app.notion.com/p/Telco-Churn-Prediction-End-to-End-Pipeline-4ed57cd27e8c83c3830c014690ce76e4?source=copy_link)**.

## 📁 Estructura del proyecto

```text
Proyecto Churn Rate Analysis & Prediction/
├── Dashboard/
│   ├── *.pbix
│   ├── *.pbip
│   ├── *.Report/
│   ├── *.SemanticModel/
│   └── Reporte_Ejecutivo.pdf
├── Data/
│   └── dataset_crudo.csv
├── Models/
│   ├── random_forest_churn.pkl
│   └── model_columns.pkl
├── Notebooks/
│   └── modeltraining.ipynb
├── QueriesSQL/
│   ├── Data_Treatment.sql
│   └── Prediction_Exporation.sql
├── Scripts/
│   └── modelproduction.py
├── dependencies.txt
├── .env
└── README.md
```

### Descripción de las carpetas y archivos

- **`Dashboard/`**: contiene el archivo de Power BI (`.pbix`), la estructura Developer (`.pbip`, `.Report`, `.SemanticModel`) y el reporte ejecutivo en PDF.
- **`Data/`**: almacena el dataset crudo original en formato CSV.
- **`Models/`**: contiene los archivos serializados del modelo de Machine Learning (`.pkl`).
- **`Notebooks/`**: contiene los archivos de exploración y entrenamiento en Jupyter Notebook (`.ipynb`).
- **`QueriesSQL/`**: contiene los scripts SQL para estructurar, limpiar y consultar la base de datos.
- **`Scripts/`**: contiene el código Python de producción (`modelproduction.py`), refactorizado con ruteo dinámico mediante `pathlib`.
- **`dependencies.txt`**: contiene las librerías necesarias de Python.

## 🚀 Guía de reproducción

Ejecuta los pasos siguientes en el orden indicado.

### 1. Creación de Base de Datos y Tratamiento (SQL)

Antes de procesar la información, debes crear una base de datos vacía en PostgreSQL utilizando tu cliente SQL de preferencia (como pgAdmin, DBeaver o la terminal). 

Una vez creada la base de datos, conéctate a ella, importa la data:

```text
Data/telco_Churn_Behavior_IBM.csv
```

y ejecuta el archivo:

```text
QueriesSQL/Data_Treatment.sql
```

Este script:

1. Explora la data cruda.
2. Realiza la limpieza inicial de los datos.
3. Estructura la información en PostgreSQL.
4. Crea las vistas necesarias para el proyecto, incluida `vw_joindata`.

### 2. Configuración del entorno y seguridad

Instala las librerías necesarias desde la raíz del proyecto:

```bash
pip install -r dependencies.txt
```

Después, crea obligatoriamente un archivo local llamado `.env` en la raíz del proyecto. Este archivo se utilizará para conectar Python y SQLAlchemy con la base de datos PostgreSQL local.

El archivo debe tener exactamente esta estructura:

```plaintext
DB_USER=****
DB_PASS=*****
DB_HOST=localhost
DB_PORT=5432
DB_NAME=******
```

Como la base de datos es local, `DB_HOST` y `DB_PORT` deben mantenerse como `localhost` y `5432`. Solo debes reemplazar los valores representados por asteriscos con tus credenciales y el nombre de tu base de datos.

> ⚠️ **Seguridad:** el archivo `.env` ya está excluido en `.gitignore`. No lo publiques ni subas tus credenciales al repositorio.

### 3. Ejecución del modelo predictivo (Python)

Ejecuta el script de producción desde la raíz del proyecto:

```bash
python Scripts/modelproduction.py
```

El script buscará dinámicamente:

- Las credenciales en el archivo `.env` ubicado en la raíz del proyecto.
- Los modelos serializados dentro de la carpeta `Models/`.

Posteriormente, procesará los clientes nuevos obtenidos desde PostgreSQL y devolverá las predicciones a la tabla:

```text
fact_churn_predictions
```

### 4. Exploración de predicciones (SQL)

Ejecuta el archivo:

```text
QueriesSQL/Prediction_Exporation.sql
```

Este script permite cruzar la vista original de clientes con las predicciones generadas. La consulta principal es:

```sql
SELECT 
		c."Customer ID",
		c."gender",
		c."contract",
		c."Monthly Charge",
		ROUND(CAST(p."Churn_Risk_Probability" * 100 AS numeric), 2) AS "Risk_Percentage",
		p."Churn_Prediction_Flag"
FROM vw_joindata c
JOIN fact_churn_predictions p 
	ON c."Customer ID" = p."Customer ID"
ORDER BY p."Churn_Risk_Probability" DESC;
```

### 5. Visualización operativa

Finalmente, abre el proyecto ubicado en la carpeta `Dashboard/` y actualiza las credenciales del origen de datos en Power BI.

Después de configurar la conexión, podrás interactuar con los resultados de las predicciones y consultar el riesgo de abandono de los clientes desde el dashboard.

