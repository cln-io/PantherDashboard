#!/bin/bash
service=$(cat /var/dashboard/services/miner-update | tr -d '\n')
version=$(cat /var/dashboard/statuses/latest_miner_version | tr -d '\n')
pantherx_ver=$(cat /var/dashboard/statuses/pantherx_ver)

if [[ "$pantherx_ver" = "X1" ]]; then
    miner_data_path="/opt/miner_data"
fi

if [[ "$pantherx_ver" = "X2" ]]; then
    miner_data_path="/opt/panther-x2/miner_data"
fi

if [[ $service == 'start' ]]; then
  echo 'running' > /var/dashboard/services/miner-update
  echo 'Stopping currently running docker...' > /var/dashboard/logs/miner-update.log
  docker stop helium-miner >> /var/dashboard/logs/miner-update.log
  currentdockerstatus=$(sudo docker ps -a -f name=helium-miner --format "{{ .Status }}")
  if [[ $currentdockerstatus =~ 'Exited' || $currentdockerstatus == '' ]]; then
    echo 'Backing up current config...' >> /var/dashboard/logs/miner-update.log
    currentconfig=$(sudo docker inspect helium-miner | grep sys.config | grep -Po '"Source": ".*\/sys.config' | sed 's/"Source": "//' | sed -n '1p')
    mkdir ${miner_data_path}/configs
    mkdir ${miner_data_path}/configs/previous_configs
    currentversion=$(docker ps -a -f name=helium-miner --format "{{ .Image }}" | grep -Po 'miner: *.+' | sed 's/miner://')
    cp "$currentconfig" "${miner_data_path}/configs/previous_configs/$currentversion.config" >> /var/dashboard/logs/miner-update.log

    echo 'Removing currently running docker...' >> /var/dashboard/logs/miner-update.log
    docker rm helium-miner
    echo 'Acquiring and starting latest docker version...' >> /var/dashboard/logs/miner-update.log
    docker image pull quay.io/team-helium/miner:$version >> /var/dashboard/logs/miner-update.log
    docker run -d --init --ulimit nofile=64000:64000 --restart always --publish 127.0.0.1:1680:1680/udp --publish 44158:44158/tcp --name helium-miner --mount type=bind,source=${miner_data_path},target=/var/data --mount type=bind,source=${miner_data_path}/log,target=/var/log/miner --device /dev/i2c-1  --privileged -v /var/run/dbus:/var/run/dbus --mount type=bind,source=/root/helium/overlay/docker.config,target=/config/sys.config quay.io/team-helium/miner:$version >> /var/dashboard/logs/miner-update.log

    currentdockerstatus=$(sudo docker ps -a -f name=helium-miner --format "{{ .Status }}")
    if [[ $currentdockerstatus =~ 'Up' ]]; then
      echo 'stopped' > /var/dashboard/services/miner-update
      echo $version > /var/dashboard/statuses/current_miner_version
      echo "DISTRIB_RELEASE=$(echo $version | sed -e 's/miner-arm64_//' | sed -e 's/_GA//')" > /etc/lsb_release
      echo 'Update complete.' >> /var/dashboard/logs/miner-update.log
    else
      echo 'stopped' > /var/dashboard/services/miner-update
      echo 'Miner docker failed to start.  Check logs to investigate.'
    fi
  else
    echo 'stopped' > /var/dashboard/services/miner-update
    echo 'Error: Could not stop docker.' >> /var/dashboard/logs/miner-update.log
  fi
fi
