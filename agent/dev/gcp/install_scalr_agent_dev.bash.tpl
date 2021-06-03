#!/bin/bash

# install dependencies

yum install -y curl container-selinux


# downloaad and install the scalr-agent package

curl "${package_url}" -o scalr-agent.rpm
rpm -i scalr-agent.rpm


# configure and start the agent

scalr-agent configure --token=${scalr_token} --url=${scalr_url} --agent-name=${scalr_agent_name}
systemctl daemon-reload
systemctl start scalr-agent
