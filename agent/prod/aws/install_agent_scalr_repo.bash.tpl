#!/bin/bash


yum install -y curl
curl -s https://packagecloud.io/install/repositories/scalr/scalr/script.rpm.sh | bash
yum install -y scalr-agent

scalr-agent configure --token=${scalr_token} --url=${scalr_url} --agent-name=${scalr_agent_name}
systemctl daemon-reload
systemctl start scalr-agent
