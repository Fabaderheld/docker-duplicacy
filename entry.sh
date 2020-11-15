#!/bin/sh
/duplicacy/duplicacy_web &
sleep 5
tail -f /root/.duplicacy-web/logs/duplicacy_web.log