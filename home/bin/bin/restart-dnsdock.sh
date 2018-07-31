#!/usr/bin/fish

function die
    echo "aborting"
    exit 1
end

if docker inspect dnsdock >/dev/null 2>&1
    docker rm -f dnsdock
    or die
end

docker run -d \
        -v /var/run/docker.sock:/var/run/docker.sock \
        --restart always \
        --name dnsdock \
        -p 127.0.0.54:53:53/udp \
    aacebedo/dnsdock:latest-amd64 \
        --nameserver=(systemd-resolve --status --no-pager | grep -A 2 'DNS Servers:' | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | grep -v '^127\.')
or die

if not test -d /etc/systemd/resolved.conf.d
    sudo mkdir /etc/systemd/resolved.conf.d
    or die
end

echo '
[Resolve]
DNS=127.0.0.54
' | sudo tee /etc/systemd/resolved.conf.d/dnsdock.conf >/dev/null
and sudo systemctl daemon-reload
and sudo systemctl restart systemd-resolved.service
