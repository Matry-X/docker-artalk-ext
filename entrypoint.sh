#!/usr/bin/env bash

UUID=${UUID:-"$(uuidgen)"}

# first run
if [ ! -e /data/.install ]; then

    sed -e "s#-secret-key-32-#$CLIENT_SECRET#" \
        -e "s#-server-host-#$CLIENT_HOST#" \
        -e "s#-uuid-#$UUID#" \
        -i /data/config.yml
    # install agent
    /agent service -c /data/config.yml install

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
        -i /data/artalk.yml

    touch /data/.install
fi

# RUN agent
/agent service -c /data/config.yml start
# RUN artalk
/usr/bin/artalk server -c /data/artalk.yml --host 0.0.0.0 --port 3000
