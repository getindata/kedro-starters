# Kedro starters by GetInData

In [GetInData](https://getindata.com/) we deploy Kedro-based projects to different environments 
(on-premise and cloud). This repository hosts the starters with a few deployment recipes, including
the ones that use [our plugins](https://github.com/search?q=topic%3Akedro-plugin+org%3Agetindata+fork%3Atrue&type=repositories).

## Available starters

* [pyspark-iris-running-on-gke](getindata_kedro_starters/pyspark-iris-running-on-gke/README.md) uses Google Kubernetes Engine to run Spark-powered kedro pipeline in a distributed manner.

## Starters development

1. Clone the repository and switch to `develop`
1. Run `poetry install`
1. Run `source $(poetry env info --path)/bin/activate`
Note: when you use `conda`, you need the extra step of `conda decativate` to avoid conflict between the `conda` and `venv`
3. Install kedro `pip install kedro==0.18.3`
4. Run `kedro new -s <name-of-the-starter>`
