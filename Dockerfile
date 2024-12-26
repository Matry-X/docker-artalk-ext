FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -yq ca-certificates iproute2 sed supervisor unzip wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN wget -q https://github.com/nezhahq/agent/releases/download/v1.4.0/nezha-agent_linux_amd64.zip && \
    unzip nezha-agent_linux_amd64.zip && rm nezha-agent_linux_amd64.zip && mv nezha-agent agent && \
    wget -q https://github.com/stalwartlabs/mail-server/releases/download/v0.10.7/stalwart-mail-x86_64-unknown-linux-gnu.tar.gz && \
    tar -xzf stalwart-mail-x86_64-unknown-linux-gnu.tar.gz && rm stalwart-mail-x86_64-unknown-linux-gnu.tar.gz && \
    wget -q https://github.com/fatedier/frp/releases/download/v0.61.1/frp_0.61.1_linux_amd64.tar.gz && \
    tar -xzf frp_0.61.1_linux_amd64.tar.gz && rm frp_0.61.1_linux_amd64.tar.gz && \
    mv frp_0.61.1_linux_amd64/frpc . && rm -rf frp_0.61.1_linux_amd64

COPY config.agent.yml .
COPY damon.conf .
COPY frpc.toml .
COPY entrypoint.sh .

RUN chmod +x agent entrypoint.sh frpc stalwart-mail

EXPOSE 3000

ENTRYPOINT [ "/app/entrypoint.sh" ]