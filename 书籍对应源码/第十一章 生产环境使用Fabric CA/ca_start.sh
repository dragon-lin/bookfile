#!/bin/sh

echo "RootCA启动";
cd $GOPATH/src/github.com/hyperledger/fabric-ca/bin
mkdir ca-server
cp -f docker-rootca.yaml ./ca-server
cp -f docker-intermediaca1.yaml ./ca-server
cp -f docker-intermediaca2.yaml ./ca-server
cp -f docker-intermediaca3.yaml ./ca-server
cp -f docker-intermediacatls1.yaml ./ca-server
cp -f docker-intermediacatls2.yaml ./ca-server
cp -f docker-intermediacatls3.yaml ./ca-server

cd ca-server
fabric-ca-server init -b admin:adminpw --home ./rootca
fabric_ver="1.4.0"
sed -i "s/^version:.*$/version: $fabric_ver/g" ./rootca/fabric-ca-server-config.yaml
docker-compose -f docker-rootca.yaml up -d

echo "IntermediaCA1启动";
fabric-ca-server init -b admin1:adminpw1 -u http://admin:adminpw@localhost:7054 --home ./intermediaca1
fabric_ver="1.4.0"
fabric_port="7055"
sed -i "s/^version:.*$/version: $fabric_ver/g" ./intermediaca1/fabric-ca-server-config.yaml
sed -i "s/^port:.*$/port: $fabric_port/g" ./intermediaca1/fabric-ca-server-config.yaml
docker-compose -f docker-intermediaca1.yaml up -d

echo "IntermediaCAtls1启动";
fabric-ca-server init -b admin1:adminpw1 -u http://admin:adminpw@localhost:7054 --home ./intermediacatls1
fabric_ver="1.4.0"
fabric_port="8055"
sed -i "s/^version:.*$/version: $fabric_ver/g" ./intermediacatls1/fabric-ca-server-config.yaml
sed -i "s/^port:.*$/port: $fabric_port/g" ./intermediacatls1/fabric-ca-server-config.yaml
docker-compose -f docker-intermediacatls1.yaml up -d

echo "IntermediaCA2启动";
fabric-ca-server init -b admin2:adminpw2 -u http://admin:adminpw@localhost:7054 --home ./intermediaca2
fabric_ver="1.4.0"
fabric_port="7056"
sed -i "s/^version:.*$/version: $fabric_ver/g" ./intermediaca2/fabric-ca-server-config.yaml
sed -i "s/^port:.*$/port: $fabric_port/g" ./intermediaca2/fabric-ca-server-config.yaml
docker-compose -f docker-intermediaca2.yaml up -d

echo "IntermediaCAtls2启动";
fabric-ca-server init -b admin2:adminpw2 -u http://admin:adminpw@localhost:7054 --home ./intermediacatls2
fabric_ver="1.4.0"
fabric_port="8056"
sed -i "s/^version:.*$/version: $fabric_ver/g" ./intermediacatls2/fabric-ca-server-config.yaml
sed -i "s/^port:.*$/port: $fabric_port/g" ./intermediacatls2/fabric-ca-server-config.yaml
docker-compose -f docker-intermediacatls2.yaml up -d

echo "IntermediaCA3启动";
fabric-ca-server init -b admin3:adminpw3 -u http://admin:adminpw@localhost:7054 --home ./intermediaca3
fabric_ver="1.4.0"
fabric_port="7057"
sed -i "s/^version:.*$/version: $fabric_ver/g" ./intermediaca3/fabric-ca-server-config.yaml
sed -i "s/^port:.*$/port: $fabric_port/g" ./intermediaca3/fabric-ca-server-config.yaml
docker-compose -f docker-intermediaca3.yaml up -d

echo "IntermediaCAtls3启动";
fabric-ca-server init -b admin3:adminpw3 -u http://admin:adminpw@localhost:7054 --home ./intermediacatls3
fabric_ver="1.4.0"
fabric_port="8057"
sed -i "s/^version:.*$/version: $fabric_ver/g" ./intermediacatls3/fabric-ca-server-config.yaml
sed -i "s/^port:.*$/port: $fabric_port/g" ./intermediacatls3/fabric-ca-server-config.yaml
docker-compose -f docker-intermediacatls3.yaml up -d