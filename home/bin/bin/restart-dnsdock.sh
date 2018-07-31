#!/usr/bin/fish

# After running this you need to add 127.0.0.54 to your list of DNS servers.
#
# Examples:
#
#  systemd-resolved: in /etc/systemd/resolved.conf, set DNS=127.0.0.54
#  dnsmasq: in /etc/dnsmasq.d/dnsdock.conf, set server=/docker/127.0.0.54
#  pure libc: in /etc/resolv.conf, set nameserver=127.0.0.54
#  etc...

if docker inspect dnsdock >/dev/null 2>&1
    docker rm -rf dnsdock
end

docker run -d \
        -v /var/run/docker.sock:/var/run/docker.sock \
        --restart always \
        --name dnsdock \
        -p 127.0.0.54:53:53/udp \
    aacebedo/dnsdock:latest-amd64 \
        --nameserver=(systemd-resolve --status --no-pager | grep -A 2 'DNS Servers:' | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | grep -v '^127\.')
