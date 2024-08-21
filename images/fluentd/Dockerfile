# fluentd/Dockerfile

FROM fluent/fluentd:v1.17.0-debian-amd64-1.0
USER root
RUN gem update && gem install fluent-plugin-elasticsearch
RUN gem install faraday-httpclient
RUN gem install excon
USER fluent