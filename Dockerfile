FROM ghcr.io/linkwarden/linkwarden:latest

RUN apt-get update && \
    apt-get install -y iproute2 sed unzip wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/nezhahq/agent/releases/download/v1.4.1/nezha-agent_linux_amd64.zip && \
    unzip nezha-agent_linux_amd64.zip && rm nezha-agent_linux_amd64.zip && mv nezha-agent /agent

COPY config.agent.yml /

RUN chmod +x /agent

EXPOSE 3000

CMD sed -e "s#-secret-key-32-#$CLIENT_SECRET#" -e "s#-server-host-#$CLIENT_HOST#" -e "s#-uuid-#$UUID#" -i /config.agent.yml && \
    /agent service -c /config.agent.yml install && \
    /agent service -c /config.agent.yml start && \
    yarn prisma migrate deploy && yarn start