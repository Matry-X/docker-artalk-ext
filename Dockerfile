FROM debian

RUN apt-get update && \
    apt-get install -y git iproute2 sed supervisor unzip uuid-runtime wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /artalk/data

RUN wget -q https://github.com/lionsoul2014/ip2region/raw/master/data/ip2region.xdb && \
git clone https://github.com/kirklin/go-swd && \
mv ./go-swd/pkg/dictionary/default ./dict && \
rm -rf ./go-swd

WORKDIR /artalk

RUN wget -q https://github.com/nezhahq/agent/releases/download/v1.4.0/nezha-agent_linux_amd64.zip && \
    unzip nezha-agent_linux_amd64.zip && rm nezha-agent_linux_amd64.zip && mv nezha-agent agent && \
    wget -q https://github.com/ArtalkJS/Artalk/releases/download/v2.9.1/artalk_v2.9.1_linux_amd64.tar.gz && \
    tar -xzf artalk_v2.9.1_linux_amd64.tar.gz && rm artalk_v2.9.1_linux_amd64.tar.gz && \
    mv artalk_v2.9.1_linux_amd64/artalk . && rm -rf artalk_v2.9.1_linux_amd64

COPY artalk.yml /artalk/data
COPY config.agent.yml /artalk/data
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh artalk agent

EXPOSE 3000

ENTRYPOINT [ "./entrypoint.sh" ]