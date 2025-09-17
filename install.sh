#!/bin/bash


mkdir /opt
mkdir /opt/magnumproxy

arch=$(uname -m)

[ -f /opt/magnumproxy/proxy ] && rm -f /opt/magnumproxy/proxy
[ -f /opt/magnumproxy/sslproxy ] && rm -f /opt/magnumproxy/sslproxy
[ -f /opt/magnumproxy/menu ] && rm -f /opt/magnumproxy/menu


if [[ $arch == "x86_64" || $arch == "amd64" || $arch == "x86_64h" ]]; then
    echo "Sistema baseado em x86_64 (64-bit Intel/AMD)"
    curl -o "/opt/magnumproxy/proxy" -f "https://raw.githubusercontent.com/UlekBR/MagnumProxy/refs/heads/main/MagnumProxy_x64"
    curl -o "/opt/magnumproxy/sslproxy" -f "https://raw.githubusercontent.com/UlekBR/MagnumProxy/refs/heads/main/MagnumProxySSL_x64"
    curl -o "/opt/magnumproxy/menu" -f "https://raw.githubusercontent.com/UlekBR/MagnumProxy/refs/heads/main/menu_x64"
elif [[ $arch == "aarch64" || $arch == "arm64" || $arch == "armv8-a" ]]; then
    echo "Sistema baseado em arm64 (64-bit ARM)"
    curl -o "/opt/magnumproxy/proxy" -f "https://raw.githubusercontent.com/UlekBR/MagnumProxy/refs/heads/main/MagnumProxy_arm64"
    curl -o "/opt/magnumproxy/sslproxy" -f "https://raw.githubusercontent.com/UlekBR/MagnumProxy/refs/heads/main/MagnumProxySSL_arm64"
    curl -o "/opt/magnumproxy/menu" -f "https://raw.githubusercontent.com/UlekBR/MagnumProxy/refs/heads/main/menu_arm64"
else
    echo "Arquitetura não reconhecida: $arch"
    return
fi

curl -o "/opt/magnumproxy/cert.pem" -f "https://raw.githubusercontent.com/UlekBR/MagnumProxy/refs/heads/main/cert.pem"
curl -o "/opt/magnumproxy/key.pem" -f "https://raw.githubusercontent.com/UlekBR/MagnumProxy/refs/heads/main/key.pem"

chmod +x /opt/magnumproxy/proxy
chmod +x /opt/magnumproxy/sslproxy
chmod +x /opt/magnumproxy/menu

ln -s /opt/magnumproxy/menu /usr/local/bin/magnumproxy
clear
echo -e "Para iniciar o menu digite: magnumproxy"
