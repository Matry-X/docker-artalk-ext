FROM artalk/artalk-go:latest

RUN apk update && \
    apk add git uuidgen wget && \
    apk cache clean

WORKDIR /data

RUN wget -q https://github.com/lionsoul2014/ip2region/raw/master/data/ip2region.xdb && \
    git clone https://github.com/kirklin/go-swd && \
    mv ./go-swd/pkg/dictionary/default ./dict && \
    rm -rf ./go-swd

WORKDIR /

RUN wget -q https://github.com/nezhahq/agent/releases/download/v1.2.0/nezha-agent_linux_amd64.zip && \
    unzip nezha-agent_linux_amd64.zip && rm nezha-agent_linux_amd64.zip && mv nezha-agent agent

COPY artalk.yml /data
COPY config.yml /data
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh agent

EXPOSE 3000

CMD []
ENTRYPOINT [ "./entrypoint.sh" ]