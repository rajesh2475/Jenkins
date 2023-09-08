!/bin/bash
python -m venv venv
source venv/bin/activate
pip install requirements.txt
pytest --cov=<app root folder> --junitxml = <path-to-store-result>
python -m coverage xml
