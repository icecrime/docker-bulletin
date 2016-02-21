FROM icecrime/vossibility-bulletin
MAINTAINER Arnaud Porterie <icecrime@docker.com>

ENV ELASTICSEARCH="localhost:9200"
ADD ./weekly/generate /etc/periodic/weekly/generate

ENTRYPOINT ["crond"]
