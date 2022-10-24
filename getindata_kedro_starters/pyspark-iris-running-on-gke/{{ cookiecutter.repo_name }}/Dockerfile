ARG BASE_IMAGE=python:3.9-slim
FROM $BASE_IMAGE

# install project requirements
COPY src/requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt && rm -f /tmp/requirements.txt

# (Required) install utilities required by Spark
RUN apt update && apt install -y tini openjdk-11-jre-headless curl

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV SPARK_HOME /usr/local/lib/python3.9/site-packages/pyspark

# add kedro user
ARG KEDRO_UID=999
ARG KEDRO_GID=999

RUN groupadd -f -g ${KEDRO_GID} kedro_group && \
    useradd -d /home/kedro -s /bin/bash -g ${KEDRO_GID} -u ${KEDRO_UID} kedro

# install Spark entrypoint
RUN curl https://raw.githubusercontent.com/apache/spark/v{{ cookiecutter.spark_version }}/resource-managers/kubernetes/docker/src/main/dockerfiles/spark/entrypoint.sh > /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

# copy the whole project except what is in .dockerignore
WORKDIR /home/kedro
USER kedro
COPY --chown=kedro:kedro_group . .

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
