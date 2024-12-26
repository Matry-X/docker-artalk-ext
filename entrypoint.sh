#!/usr/bin/env sh

DATA_DIR="$(pwd)/data"
WORK_DIR="$(pwd)"

if [ ! -s /etc/supervisor/conf.d/damon.conf ]; then
    # agent
    sed -e "s#-secret-key-32-#$CLIENT_SECRET#" \
        -e "s#-server-host-#$CLIENT_HOST#" \
        -e "s#-uuid-#$UUID#" \
        -i ${WORK_DIR}/config.agent.yml
    ${WORK_DIR}/agent service -c config.agent.yml install

    # frp
    sed -e "s#-server-addr-#$SERVER_ARRD#" \
        -e "s#-server-port-#$SERVER_PORT#" \
        -e "s#-user-id-#$USER_ID#" \
        -e "s#-user-token-#$USER_TOKEN#" \
        -e "s#-smtp-port-ssl-#$SMTP_PORT_SSL#" \
        -e "s#-smtp-port-tls-#$SMTP_PORT_TLS#" \
        -e "s#-imap-port-#$IMAP_PORT#" \
        -i ${WORK_DIR}/frpc.toml
    FRPC_CMD="${WORK_DIR}/frpc -c ${WORK_DIR}/frpc.toml"

    # mail-server
    ${WORK_DIR}/stalwart-mail --init ${DATA_DIR}
    sed -e "s#8080#3000#" -i ${DATA_DIR}/etc/config.toml
    MAILSERVER_CMD="${WORK_DIR}/stalwart-mail --config ${DATA_DIR}/etc/config.toml"

    # supervisor
    cp ${WORK_DIR}/damon.conf /etc/supervisor/conf.d/damon.conf
    sed -e "s#-frpc-cmd-#$FRPC_CMD#" \
        -e "s#-mailserver-cmd-#$MAILSERVER_CMD#" \
        -i /etc/supervisor/conf.d/damon.conf
fi

# RUN agent
${WORK_DIR}/agent service -c config.agent.yml start
# RUN supervisor
supervisord -c /etc/supervisor/supervisord.conf
