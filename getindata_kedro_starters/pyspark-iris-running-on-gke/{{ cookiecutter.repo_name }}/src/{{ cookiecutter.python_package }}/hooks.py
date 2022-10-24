import os
import socket

from kedro.framework.hooks import hook_impl
from pyspark import SparkConf
from pyspark.sql import SparkSession


class SparkHooks:
    @hook_impl
    def after_context_created(self, context) -> None:
        """Initialises a SparkSession using the config
        defined in project's conf folder.
        """

        # Load the spark configuration in spark.yaml using the config loader
        parameters = context.config_loader.get("spark*", "spark*/**")
        spark_conf = SparkConf().setAll(parameters.items())

        # Set the spark@k8s dynamic parameters
        if context.env == 'spark-on-k8s':
            spark_conf.set('spark.kubernetes.container.image', os.getenv('CONTAINER_IMAGE', 'apache/spark:v{{ cookiecutter.spark_version }}'))
            spark_conf.set("spark.driver.host", socket.gethostbyname(socket.gethostname()))
            spark_conf.set('spark.kubernetes.driver.pod.name', socket.gethostname())

        # Initialise the spark session
        spark_session_conf = (
            SparkSession.builder.appName(context._package_name)
            .enableHiveSupport()
            .config(conf=spark_conf)
        )
        _spark_session = spark_session_conf.getOrCreate()
        _spark_session.sparkContext.setLogLevel("WARN")
