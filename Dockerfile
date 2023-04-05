FROM stackql/stackql:latest AS stackql
FROM jupyter/base-notebook:latest AS jupyter
WORKDIR /jupyter
USER root
RUN apt-get update && \
    apt-get upgrade -y
# copy magic extensions
RUN mkdir -p /jupyter/ext
COPY ./extensions/* /jupyter/ext
RUN chmod 644 /jupyter/ext/*.py && \
    chown jovyan:users /jupyter/ext/*.py
# setup python environment
ENV PYTHON_PACKAGES="\
    matplotlib \
    pandas \
    psycopg2-binary \
    pystackql \
" 
RUN pip install --upgrade pip \
    && pip install --no-cache-dir $PYTHON_PACKAGES
# copy stackql binary from stackql container
COPY --from=stackql /srv/stackql/stackql /srv/stackql/stackql
COPY scripts/ /scripts/
RUN chmod +x /scripts/start-stackql.sh
RUN chmod +x /scripts/start-jupyter.sh