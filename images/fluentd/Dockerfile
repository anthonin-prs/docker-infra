# fluentd/Dockerfile

FROM fluent/fluentd:v1.17.0-debian-amd64-1.0
USER root
RUN gem update && gem install fluent-plugin-elasticsearch --no-document --version 5.4.3
USER fluent