ARG BASE_IMAGE=python:3.9-slim
FROM $BASE_IMAGE

# install project requirements and delete Spark jars (Dataproc provides their own)
COPY src/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache -r /tmp/requirements.txt && rm /tmp/requirements.txt && \
    rm -rf /usr/local/lib/python3.9/site-packages/pyspark/jars/

# (Required) install utilities required by Dataproc
RUN apt update && apt install -y procps tini && apt-get clean && rm -rf /var/lib/apt/lists/*

# add kedro user
ARG KEDRO_UID=1099
ARG KEDRO_GID=1099

RUN groupadd -f -g ${KEDRO_GID} kedro_group && \
    useradd -d /home/kedro -s /bin/bash -g ${KEDRO_GID} -u ${KEDRO_UID} kedro

# copy the whole project except what is in .dockerignore
WORKDIR /home/kedro
USER kedro
COPY --chown=kedro:kedro_group . .

# overwrite default Dataproc's python
ENV PYSPARK_PYTHON /usr/local/bin/python
