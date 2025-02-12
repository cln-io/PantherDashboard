#!/bin/bash
systemctl stop nginx
systemctl disable nginx
apt-get -y remove nginx

rm -rf /var/dashboard
rm -rf /etc/monitor-scripts

systemctl disable auto-maintain.timer
systemctl disable auto-update.timer
systemctl disable bt-check.timer
systemctl disable bt-service-check.timer
systemctl disable clear-blockchain-check.timer
systemctl disable cpu-check.timer
systemctl disable external-ip-check.timer
systemctl disable fastsync-check.timer
systemctl disable helium-status-check.timer
systemctl disable infoheight-check.timer
systemctl disable local-ip-check.timer
systemctl disable miner-check.timer
systemctl disable miner-service-check.timer
systemctl disable miner-version-check.timer
systemctl disable password-check.timer
systemctl disable peer-list-check.timer
systemctl disable pf-check.timer
systemctl disable pf-service-check.timer
systemctl disable pubkeys-check.timer
systemctl disable reboot-check.timer
systemctl disable temp-check.timer
systemctl disable update-check.timer
systemctl disable update-dashboard-check.timer
systemctl disable update-miner-check.timer
systemctl disable wifi-check.timer
systemctl disable wifi-config-check.timer
systemctl disable wifi-service-check.timer

rm -rf /etc/systemd/system/auto-maintain.timer
rm -rf /etc/systemd/system/auto-maintain.service
rm -rf /etc/systemd/system/auto-update.timer
rm -rf /etc/systemd/system/auto-update.service
rm -rf /etc/systemd/system/bt-check.timer
rm -rf /etc/systemd/system/bt-check.service
rm -rf /etc/systemd/system/bt-service-check.service
rm -rf /etc/systemd/system/bt-service-check.timer
rm -rf /etc/systemd/system/clear-blockchain-check.timer
rm -rf /etc/systemd/system/clear-blockchain-check.service
rm -rf /etc/systemd/system/cpu-check.timer
rm -rf /etc/systemd/system/cpu-check.service
rm -rf /etc/systemd/system/external-ip-check.service
rm -rf /etc/systemd/system/external-ip-check.timer
rm -rf /etc/systemd/system/fastsync-check.service
rm -rf /etc/systemd/system/fastsync-check.timer
rm -rf /etc/systemd/system/helium-status-check.service
rm -rf /etc/systemd/system/helium-status-check.timer
rm -rf /etc/systemd/system/infoheight-check.service
rm -rf /etc/systemd/system/infoheight-check.timer
rm -rf /etc/systemd/system/local-ip-check.service
rm -rf /etc/systemd/system/local-ip-check.timer
rm -rf /etc/systemd/system/miner-check.service
rm -rf /etc/systemd/system/miner-check.timer
rm -rf /etc/systemd/system/miner-service-check.service
rm -rf /etc/systemd/system/miner-service-check.timer
rm -rf /etc/systemd/system/miner-version-check.timer
rm -rf /etc/systemd/system/miner-version-check.service
rm -rf /etc/systemd/system/password-check.service
rm -rf /etc/systemd/system/password-check.timer
rm -rf /etc/systemd/system/peer-list-check.service
rm -rf /etc/systemd/system/peer-list-check.timer
rm -rf /etc/systemd/system/pf-check.service
rm -rf /etc/systemd/system/pf-check.timer
rm -rf /etc/systemd/system/pf-service-check.service
rm -rf /etc/systemd/system/pf-service-check.timer
rm -rf /etc/systemd/system/pubkeys-check.service
rm -rf /etc/systemd/system/pubkeys-check.timer
rm -rf /etc/systemd/system/reboot-check.service
rm -rf /etc/systemd/system/reboot-check.timer
rm -rf /etc/systemd/system/temp-check.service
rm -rf /etc/systemd/system/temp-check.timer
rm -rf /etc/systemd/system/update-check.service
rm -rf /etc/systemd/system/update-check.timer
rm -rf /etc/systemd/system/update-dashboard-check.timer
rm -rf /etc/systemd/system/update-dashboard-check.service
rm -rf /etc/systemd/system/update-miner-check.timer
rm -rf /etc/systemd/system/update-miner-check.service
rm -rf /etc/systemd/system/wifi-check.service
rm -rf /etc/systemd/system/wifi-check.timer
rm -rf /etc/systemd/system/wifi-config-check.service
rm -rf /etc/systemd/system/wifi-config-check.timer
rm -rf /etc/systemd/system/wifi-service-check.service
rm -rf /etc/systemd/system/wifi-service-check.timer

rm -f /etc/ssl/private/nginx-selfsigned.key
rm -f /etc/ssl/certs/nginx-selfsigned.crt
rm -f /etc/ssl/certs/dhparam.pem

systemctl daemon-reload
