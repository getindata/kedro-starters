# How to adjust the official `pyspark-iris` starter?

1. Create `infrastructure/` dir and put all the terraform code there.
1. Create `conf/spark-on-k8s` env and copy the `spark.yml` there.
1. Add `terraform` directory to `.dockerignore` (no need to pack all these providers to the image).
1. Add JRE, `tini` and `procps` to the image (can be installed via `apt`).
1. Add Spark's entrypoint to the `Dockerfile` as `ENTRYPOINT`. Spark executors run command `executor` on the image and that's the easiest way to make it work as expected.
1. Get rid of all the `@pyspark` and `@pandas` entries in `conf/base/catalog.yml`, as we're going to pass all the artifacts in-memory. Also, adjust the `pipeline.py` by stipping these suffixes.
1. Modify `node.py` by adding `.toPandas()` for all the data returned by `split_data`. Next nodes expect Pandas dataframes, so we need inline conversion here (as an alternative to `@pandas/@pyspark` in the catalog).
1. Add `spark_version` to the `cookiecutter.json` (with some default value), `prompts.yml` and `src/requirements.txt`
1. Add `gcloud_project`, `gcloud_region` and `gcloud_zone` to `cookiecutter.json` and `prompts.yml`, so they can be used within Terraform vars file and README docs.
1. Modify `pip install` command in Dockerfile, adding `--no-cache` flag (so the images will be smaller).
1. Add `JAVA_HOME` and `SPARK_HOME` entries in Dockerfile
1. Extend `hooks.py` with this snippet

        # Set the spark@k8s dynamic parameters
        if context.env == 'spark-on-k8s':
            spark_conf.set('spark.kubernetes.container.image', os.getenv('CONTAINER_IMAGE', 'apache/spark:v{{ cookiecutter.spark_version }}'))
            spark_conf.set("spark.driver.host", socket.gethostbyname(socket.gethostname()))
            spark_conf.set('spark.kubernetes.driver.pod.name', socket.gethostname())

1. Add the README.md section about running terraform, pushing the docker image and running a job.
