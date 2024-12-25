#!/usr/bin/env bash

DATA_DIR="$(pwd)/data"
WORK_DIR="$(pwd)"

# first run
if [ ! -e ${DATA_DIR}/.install ]; then

    # replace secret key
    sed -e "s#-secret-key-32-#$CLIENT_SECRET#" \
        -e "s#-server-host-#$CLIENT_HOST#" \
        -e "s#-uuid-#$UUID#" \
        -i ${DATA_DIR}/config.agent.yml
    # install agent
    ${WORK_DIR}/agent service -c ${DATA_DIR}/config.agent.yml install

    sed -e "s#app-key#$APP_KEY#g" \
        -e "s#site-default#$SITE_DEFAULT#g" \
        -e "s#site-url#$SITE_URL#g" \
        -e "s#pg-name#$PG_NAME#g" \
        -e "s#pg-host#$PG_HOST#g" \
        -e "s#pg-port#$PG_PORT#g" \
        -e "s#pg-user#$PG_USER#g" \
        -e "s#pg-password#$PG_PASSWORD#g" \
        -e "s#admin-email#$ADMIN_EMAIL#g" \
        -e "s#admin-password#$ADMIN_PASSWORD#g" \
        -i ${DATA_DIR}/artalk.yml

    touch ${DATA_DIR}/.install
fi

# RUN agent
${WORK_DIR}/agent service -c ${DATA_DIR}/config.agent.yml start
# RUN artalk
${WORK_DIR}/artalk server -c ${DATA_DIR}/artalk.yml --host 0.0.0.0 --port 3000
