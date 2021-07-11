import coremltools as ct
from sklearn.ensemble import GradientBoostingClassifier, BaggingClassifier
import pandas as pd

if __name__ == "__main__":
    # Load data
    data = pd.read_csv('heart_data.csv')

    # Train a model
    GB = GradientBoostingClassifier()
    GB.fit(
        data[['age', 'sex', 'cp', 'trestbps', 'chol', 'fbs', 'restecg', 'thalach', 'exang', 'oldpeak', 'slope', 'ca',
              'thal']],
        data['target']
    )

    BG_GB = BaggingClassifier(base_estimator=GB)
    BG_GB.fit(
        data[['age', 'sex', 'cp', 'trestbps', 'chol', 'fbs', 'restecg', 'thalach', 'exang', 'oldpeak', 'slope', 'ca',
              'thal']],
        data['target']
    )

    # Convert and save the scikit-learn model
    coreml_model = ct.converters.sklearn.convert(BG_GB)
    coreml_model.save('ML_model.mlmodel')