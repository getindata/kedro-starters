# Kedro starters by GetInData

In [GetInData](https://getindata.com/) we deploy Kedro-based projects to different environments 
(on-premise and cloud). This repository hosts the starters with a few deployment recipes, including
the ones that use [our plugins](https://github.com/search?q=topic%3Akedro-plugin+org%3Agetindata+fork%3Atrue&type=repositories).

## Available starters

* [pyspark-iris-running-on-gke](getindata_kedro_starters/pyspark-iris-running-on-gke/README.md) uses Google Kubernetes Engine to run Spark-powered kedro pipeline in a distributed manner.

## Starters development

1. Clone the repository and switch to `develop`.
2. Run `poetry install`
3. Check the venv location: `poetry env info`
4. Run `source VENV_PATH/bin/activate`
5. Install kedro `pip install kedro==0.18.3`
6. Run `kedro new -s <name-of-the-starter>`
