# Solr image
FROM ukhomeoffice/openjre8:latest

# Kibana version
ARG SOLR_VERSION=6.0.0
ENV SOLR_VERSION ${SOLR_VERSION}
ARG SOLR_DOWNLOAD_URL=http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/${SOLR_VERSION}/solr-${SOLR_VERSION}.tgz
ENV SOLR_DOWNLOAD_URL ${SOLR_DOWNLOAD_URL}
ENV SOLR_HOME=/usr/share/solr
ENV PATH=${PATH}:${SOLR_HOME}/bin

# Install Solr
RUN apk add --update curl bash
RUN curl -s ${SOLR_DOWNLOAD_URL} | tar zx -C /usr/share && \
    ln -s /usr/share/solr-${SOLR_VERSION} $SOLR_HOME
RUN apk del curl && \
    rm -rf /var/cache/apk/*

# Expose default port
EXPOSE 8983

# Run Kibana in node.js
ENTRYPOINT ["solr", "start", "-f"]

