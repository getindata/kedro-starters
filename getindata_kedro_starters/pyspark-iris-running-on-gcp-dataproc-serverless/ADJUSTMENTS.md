# How to adjust the official `pyspark-iris` starter?

1. Add `spark_version` to the `cookiecutter.json` (with some default value), `prompts.yml` and `src/requirements.txt`
1. Add `gcloud_project` and `gcloud_region` to cookiecutter+prompts (they do templating in README.md)
1. Add `tini` to the image (installed via `apt`).
1. Copy the `conf/dataproc-serverless` - this one uses `file:///home/kedro` prefix to the raw data in the catalog (as default fsUri is `gs`).
1. Adjust the Dockerfile - set kedro uid and git to 1099 (Dataproc needs it)
1. Get rid of all the `@pyspark` and `@pandas` entries in `conf/base/catalog.yml`, as we're going to pass all the artifacts in-memory. Also, adjust the `pipeline.py` by stipping these suffixes.
1. Modify `node.py` by adding `.toPandas()` for all the data returned by `split_data`. Next nodes expect Pandas dataframes, so we need inline conversion here (as an alternative to `@pandas/@pyspark` in the catalog).
1. Modify `pip install` command in Dockerfile, adding `--no-cache` flag (so the images will be smaller). Also, drop the spark jars to make the image even smaller (no need to keep them as Dataproc adds own)
