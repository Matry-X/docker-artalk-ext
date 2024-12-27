FROM freshrss/freshrss:latest

RUN apt-get update && \
    apt-get install -yq ca-certificates iproute2 sed supervisor unzip wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /app && \
    wget -q https://github.com/nezhahq/agent/releases/download/v1.4.0/nezha-agent_linux_amd64.zip && \
    unzip nezha-agent_linux_amd64.zip && rm nezha-agent_linux_amd64.zip && mv nezha-agent /app/agent && \
    wget -q https://github.com/fatedier/frp/releases/download/v0.61.1/frp_0.61.1_linux_amd64.tar.gz && \
    tar -xzf frp_0.61.1_linux_amd64.tar.gz && \
    rm frp_0.61.1_linux_amd64.tar.gz && \
    mv frp_0.61.1_linux_amd64/frpc /app/frpc && \
    rm -rf frp_0.61.1_linux_amd64 && \
    wget -q https://github.com/stalwartlabs/mail-server/releases/download/v0.10.7/stalwart-mail-x86_64-unknown-linux-gnu.tar.gz && \
    tar -xzf stalwart-mail-x86_64-unknown-linux-gnu.tar.gz && \
    rm stalwart-mail-x86_64-unknown-linux-gnu.tar.gz && \
    mv stalwart-mail /app/stalwart-mail && \
    chmod +x /app/agent /app/frpc /app/stalwart-mail

COPY config.agent.yml /app
COPY damon.conf /etc/supervisor/conf.d/damon.conf
COPY frpc.toml /app

RUN sed -e "s#-secret-key-32-#$CLIENT_SECRET#" \
        -e "s#-server-host-#$CLIENT_HOST#" \
        -e "s#-uuid-#$UUID#" \
        -i /app/config.agent.yml && \
    sed -e "s#-server-addr-#$SERVER_ARRD#" \
        -e "s#-server-port-#$SERVER_PORT#" \
        -e "s#-user-id-#$USER_ID#" \
        -e "s#-user-token-#$USER_TOKEN#" \
        -e "s#-smtp-port-ssl-#$SMTP_PORT_SSL#" \
        -e "s#-smtp-port-tls-#$SMTP_PORT_TLS#" \
        -e "s#-imap-port-#$IMAP_PORT#" \
        -i /app/frpc.toml && \
    /app/agent service -c /app/config.agent.yml install && \
    /app/stalwart-mail --init /app/data && \


EXPOSE 80 8080 465 587 993

CMD /agent service -c /config.agent.yml start && \
    supervisord -c /etc/supervisor/supervisord.conf && \
    ([ -z "$CRON_MIN" ] || cron) && \
	. /etc/apache2/envvars && \
	exec apache2 -D FOREGROUND $([ -n "$OIDC_ENABLED" ] && [ "$OIDC_ENABLED" -ne 0 ] && echo '-D OIDC_ENABLED')
