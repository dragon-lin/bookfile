#!/bin/sh

echo "IntermediaCA1生成证书";
echo "1.生成example.com的msp";
echo "1）登记example.com";
cd /opt/gopath/src/github.com/hyperledger/fabric-ca/bin/ca-server
fabric-ca-client enroll -M ./crypto-config/ordererOrganizations/example.com/msp -u http://admin1:adminpw1@localhost:7055 --home ./fabric-ca-client
echo "2）添加联盟成员"
fabric-ca-client affiliation list -M ./crypto-config/ordererOrganizations/example.com/msp -u http://admin1:adminpw1@localhost:7055 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org1 -M ./crypto-config/ordererOrganizations/example.com/msp -u http://admin1:adminpw1@localhost:7055 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org2 -M ./crypto-config/ordererOrganizations/example.com/msp -u http://admin1:adminpw1@localhost:7055 --home ./fabric-ca-client
fabric-ca-client affiliation add com -M ./crypto-config/ordererOrganizations/example.com/msp -u http://admin1:adminpw1@localhost:7055 --home ./fabric-ca-client
fabric-ca-client affiliation add com.example -M ./crypto-config/ordererOrganizations/example.com/msp -u http://admin1:adminpw1@localhost:7055 --home ./fabric-ca-client
echo "2.生成Admin@example.com的msp"
echo "1）注册Admin@example.com"
fabric-ca-client register --id.name Admin@example.com --id.type client --id.affiliation "com.example" --id.attrs '"hf.Registrar.Roles=client,orderer,peer,user","hf.Registrar.DelegateRoles=client,orderer,peer,user",hf.Registrar.Attributes=*,hf.GenCRL=true,hf.Revoker=true,hf.AffiliationMgr=true,hf.IntermediateCA=true,role=admin:ecert' --id.secret=123456 --csr.cn=example.com --csr.hosts=['example.com'] -M ./crypto-config/ordererOrganizations/example.com/msp -u http://admin1:adminpw1@localhost:7055 --home ./fabric-ca-client
echo "2）登记Admin@example.com"
fabric-ca-client enroll -u http://Admin@example.com:123456@localhost:7055 --csr.cn=example.com --csr.hosts=['example.com'] -M ./crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp --home ./fabric-ca-client
echo "3）生成msp"
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/admincerts
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/msp/admincerts
echo "3.生成orderer0.example.com的msp"
echo "1）注册orderer0.example.com"
fabric-ca-client register --id.name orderer0.example.com --id.type orderer --id.affiliation "com.example" --id.attrs '"role=orderer",ecert=true' --id.secret=123456 --csr.cn=orderer0.example.com --csr.hosts=['orderer0.example.com'] -M ./crypto-config/ordererOrganizations/example.com/msp -u http://admin1:adminpw1@localhost:7055 --home ./fabric-ca-client
echo "2）登记orderer0.example.com"
fabric-ca-client enroll -u http://orderer0.example.com:123456@localhost:7055 --csr.cn=orderer0.example.com --csr.hosts=['orderer0.example.com'] -M ./crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp --home ./fabric-ca-client
echo "3）生成msp"
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/admincerts
echo "4.生成orderer1.example.com的msp"
echo "1）注册orderer1.example.com"
fabric-ca-client register --id.name orderer1.example.com --id.type orderer --id.affiliation "com.example" --id.attrs '"role=orderer",ecert=true' --id.secret=123456 --csr.cn=orderer1.example.com --csr.hosts=['orderer1.example.com'] -M ./crypto-config/ordererOrganizations/example.com/msp -u http://admin1:adminpw1@localhost:7055 --home ./fabric-ca-client
echo "2）登记orderer1.example.com"
fabric-ca-client enroll -u http://orderer1.example.com:123456@localhost:7055 --csr.cn=orderer1.example.com --csr.hosts=['orderer1.example.com']  -M ./crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/msp --home ./fabric-ca-client
echo "3）生成msp"
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/msp/admincerts
echo "5.生成orderer2.example.com的msp"
echo "1）注册orderer2.example.com"
fabric-ca-client register --id.name orderer2.example.com --id.type orderer --id.affiliation "com.example" --id.attrs '"role=orderer",ecert=true' --id.secret=123456 --csr.cn=orderer2.example.com --csr.hosts=['orderer2.example.com'] -M ./crypto-config/ordererOrganizations/example.com/msp -u http://admin1:adminpw1@localhost:7055 --home ./fabric-ca-client
echo "2）登记orderer2.example.com"
fabric-ca-client enroll -u http://orderer2.example.com:123456@localhost:7055 --csr.cn=orderer2.example.com --csr.hosts=['orderer2.example.com']  -M ./crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp --home ./fabric-ca-client
echo "3）生成msp"
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/admincerts

echo "IntermediaCAtls1生成证书"
echo "1.生成example.com的msp"
echo "1）登记example.com"
cd /opt/gopath/src/github.com/hyperledger/fabric-ca/bin/ca-server
fabric-ca-client enroll -M ./crypto-config/ordererOrganizations/example.com/tlstmp -u http://admin1:adminpw1@localhost:8055 --home ./fabric-ca-client
echo "2）添加联盟成员"
fabric-ca-client affiliation list -M ./crypto-config/ordererOrganizations/example.com/tlstmp -u http://admin1:adminpw1@localhost:8055 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org1 -M ./crypto-config/ordererOrganizations/example.com/tlstmp -u http://admin1:adminpw1@localhost:8055 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org2 -M ./crypto-config/ordererOrganizations/example.com/tlstmp -u http://admin1:adminpw1@localhost:8055 --home ./fabric-ca-client
fabric-ca-client affiliation add com -M ./crypto-config/ordererOrganizations/example.com/tlstmp -u http://admin1:adminpw1@localhost:8055 --home ./fabric-ca-client
fabric-ca-client affiliation add com.example -M ./crypto-config/ordererOrganizations/example.com/tlstmp -u http://admin1:adminpw1@localhost:8055 --home ./fabric-ca-client
echo "2.生成Admin@example.com的tls"
echo "1）注册Admin@example.com"
fabric-ca-client register --id.name Admin@example.com --id.type client --id.affiliation "com.example" --id.attrs '"hf.Registrar.Roles=client,orderer,peer,user","hf.Registrar.DelegateRoles=client,orderer,peer,user",hf.Registrar.Attributes=*,hf.GenCRL=true,hf.Revoker=true,hf.AffiliationMgr=true,hf.IntermediateCA=true,role=admin:ecert' --id.secret=123456 --csr.cn=example.com --csr.hosts=['example.com'] -M ./crypto-config/ordererOrganizations/example.com/tlstmp -u http://admin1:adminpw1@localhost:8055 --home ./fabric-ca-client
echo "2）登记Admin@example.com"
fabric-ca-client enroll -d --enrollment.profile tls -u http://Admin@example.com:123456@localhost:8055  --csr.cn=example.com --csr.hosts=['example.com'] -M ./crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tlstmp --home ./fabric-ca-client
echo "3）生成tls"
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tls
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./intermediacatls1/ca-chain.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tls/ca.crt
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tlstmp/signcerts/cert.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tls/client.crt
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tlstmp/keystore
keystore=`ls -l $path | tail -n 1 | awk '{print $9}'`
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tlstmp/keystore/$keystore ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tls/client.key
cp -r ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tlstmp/tlscacerts ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/msp
cp -r ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tlstmp/tlsintermediatecerts ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/msp
# rm -rf ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/tlstmp
echo "3.生成orderer0.example.com的tls"
echo "1）注册orderer0.example.com"
fabric-ca-client register --id.name orderer0.example.com --id.type orderer --id.affiliation "com.example" --id.attrs '"role=orderer",ecert=true' --id.secret=123456 --csr.cn=orderer0.example.com --csr.hosts=['orderer0.example.com'] -M ./crypto-config/ordererOrganizations/example.com/tlstmp -u http://admin1:adminpw1@localhost:8055 --home ./fabric-ca-client
echo "2）登记orderer0.example.com"
fabric-ca-client enroll -d --enrollment.profile tls -u http://orderer0.example.com:123456@localhost:8055 --csr.cn=orderer0.example.com --csr.hosts=['orderer0.example.com'] -M ./crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tlstmp --home ./fabric-ca-client
echo "3）生成tls"
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tls
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./intermediacatls1/ca-chain.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tls/ca.crt
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tlstmp/signcerts/cert.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tls/server.crt
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tlstmp/keystore
keystore=`ls -l $path | tail -n 1 | awk '{print $9}'`
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tlstmp/keystore/$keystore ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tls/server.key
cp -r ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tlstmp/tlscacerts ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp
cp -r ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tlstmp/tlsintermediatecerts  ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/msp
# rm -rf ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer0.example.com/tlstmp
echo "4.生成orderer1.example.com的tls"
echo "1）注册orderer1.example.com"
fabric-ca-client register --id.name orderer1.example.com --id.type orderer --id.affiliation "com.example" --id.attrs '"role=orderer",ecert=true' --id.secret=123456 --csr.cn=orderer1.example.com --csr.hosts=['orderer1.example.com'] -M ./crypto-config/ordererOrganizations/example.com/tlstmp -u http://admin1:adminpw1@localhost:8055 --home ./fabric-ca-client
echo "2）登记orderer1.example.com"
fabric-ca-client enroll -d --enrollment.profile tls -u http://orderer1.example.com:123456@localhost:8055 --csr.cn=orderer1.example.com --csr.hosts=['orderer1.example.com'] -M ./crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tlstmp --home ./fabric-ca-client
echo "3）生成tls"
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tls
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./intermediacatls1/ca-chain.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/ca.crt
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tlstmp/signcerts/cert.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/server.crt
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tlstmp/keystore
keystore=`ls -l $path | tail -n 1 | awk '{print $9}'`
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tlstmp/keystore/$keystore ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tls/server.key
cp -r ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tlstmp/tlscacerts ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/msp
cp -r ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tlstmp/tlsintermediatecerts  ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/msp
# rm -rf ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer1.example.com/tlstmp
echo "5.生成orderer2.example.com的tls"
echo "1）注册orderer2.example.com"
fabric-ca-client register --id.name orderer2.example.com --id.type orderer --id.affiliation "com.example" --id.attrs '"role=orderer",ecert=true' --id.secret=123456 --csr.cn=orderer2.example.com --csr.hosts=['orderer2.example.com'] -M ./crypto-config/ordererOrganizations/example.com/tlstmp -u http://admin1:adminpw1@localhost:8055 --home ./fabric-ca-client
echo "2）登记orderer2.example.com"
fabric-ca-client enroll -d --enrollment.profile tls -u http://orderer2.example.com:123456@localhost:8055 --csr.cn=orderer2.example.com --csr.hosts=['orderer2.example.com']  -M ./crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tlstmp --home ./fabric-ca-client
echo "3）生成tls"
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./intermediacatls1/ca-chain.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/ca.crt
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tlstmp/signcerts/cert.pem ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.crt
path=./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tlstmp/keystore
keystore=`ls -l $path | tail -n 1 | awk '{print $9}'`
cp ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tlstmp/keystore/$keystore ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.key
cp -r ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tlstmp/tlscacerts ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp
cp -r ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tlstmp/tlsintermediatecerts  ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp
# rm -rf ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tlstmp
# rm -rf ./fabric-ca-client/crypto-config/ordererOrganizations/example.com/tlstmp

echo "IntermediaCA2生成证书"
echo "1.生成org1.example.com的msp"
echo "1）登记org1.example.com"
fabric-ca-client enroll --csr.cn=org1.example.com --csr.hosts=['org1.example.com'] -M ./crypto-config/peerOrganizations/org1.example.com/msp -u http://admin2:adminpw2@localhost:7056 --home ./fabric-ca-client
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/msp/config.yaml
echo "NodeOUs:"&>$path
echo "    Enable: true"&>>$path
echo "    ClientOUIdentifier:"&>>$path
echo "      Certificate: intermediatecerts/localhost-7056.pem"&>>$path
echo "      OrganizationalUnitIdentifier: client"&>>$path
echo "    PeerOUIdentifier:"&>>$path
echo "      Certificate: intermediatecerts/localhost-7056.pem"&>>$path
echo "      OrganizationalUnitIdentifier: peer"&>>$path
echo "2）添加联盟成员"
fabric-ca-client affiliation list -M ./crypto-config/peerOrganizations/org1.example.com/msp -u http://admin2:adminpw2@localhost:7056 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org1 -M ./crypto-config/peerOrganizations/org1.example.com/msp -u http://admin2:adminpw2@localhost:7056 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org2 -M ./crypto-config/peerOrganizations/org1.example.com/msp -u http://admin2:adminpw2@localhost:7056 --home ./fabric-ca-client
fabric-ca-client affiliation add com -M ./crypto-config/peerOrganizations/org1.example.com/msp -u http://admin2:adminpw2@localhost:7056 --home ./fabric-ca-client
fabric-ca-client affiliation add com.example -M ./crypto-config/peerOrganizations/org1.example.com/msp -u http://admin2:adminpw2@localhost:7056 --home ./fabric-ca-client
fabric-ca-client affiliation add com.example.org1 -M ./crypto-config/peerOrganizations/org1.example.com/msp -u http://admin2:adminpw2@localhost:7056 --home ./fabric-ca-client
echo "2.生成Admin@example.com的msp"
echo "1）注册Admin@example.com"
fabric-ca-client register --id.name Admin@org1.example.com --id.type client --id.affiliation "com.example.org1" --id.attrs '"hf.Registrar.Roles=client,orderer,peer,user","hf.Registrar.DelegateRoles=client,orderer,peer,user",hf.Registrar.Attributes=*,hf.GenCRL=true,hf.Revoker=true,hf.AffiliationMgr=true,hf.IntermediateCA=true,role=admin:ecert' --id.secret=123456 --csr.cn=org1.example.com --csr.hosts=['org1.example.com'] -M ./crypto-config/peerOrganizations/org1.example.com/msp -u http://admin2:adminpw2@localhost:7056 --home ./fabric-ca-client
echo "2）登记Admin@example.com"
fabric-ca-client enroll -u http://Admin@org1.example.com:123456@localhost:7056 --csr.cn=org1.example.com --csr.hosts=['org1.example.com']  -M ./crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp --home ./fabric-ca-client
echo "3）生成msp"
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/admincerts
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/msp/admincerts
echo "3.生成peer0.org1.example.com的msp"
echo "1）注册peer0.org1.example.com"
fabric-ca-client register --id.name peer0.org1.example.com --id.type peer --id.affiliation "com.example.org1" --id.attrs '"role=peer",ecert=true' --id.secret=123456 --csr.cn=peer0.org1.example.com --csr.hosts=['peer0.org1.example.com'] -M ./crypto-config/peerOrganizations/org1.example.com/msp -u http://admin2:adminpw2@localhost:7056 --home ./fabric-ca-client
echo "2）登记peer0.org1.example.com"
fabric-ca-client enroll -u http://peer0.org1.example.com:123456@localhost:7056 --csr.cn=peer0.org1.example.com --csr.hosts=['peer0.org1.example.com']  -M ./crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp --home ./fabric-ca-client
echo "3）生成msp"
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/admincerts
echo "4.生成peer1.org1.example.com的msp"
echo "1）注册peer1.org1.example.com"
fabric-ca-client register --id.name peer1.org1.example.com --id.type peer --id.affiliation "com.example.org1" --id.attrs '"role=peer",ecert=true' --id.secret=123456 --csr.cn=peer1.org1.example.com --csr.hosts=['peer1.org1.example.com'] -M ./crypto-config/peerOrganizations/org1.example.com/msp -u http://admin2:adminpw2@localhost:7056 --home ./fabric-ca-client
echo "2）登记peer1.org1.example.com"
fabric-ca-client enroll -u http://peer1.org1.example.com:123456@localhost:7056 --csr.cn=peer1.org1.example.com --csr.hosts=['peer1.org1.example.com']  -M ./crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp --home ./fabric-ca-client
echo "3）生成msp"
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp/admincerts

echo "IntermediaCAtls2生成证书"
echo "1.生成org1.example.com的tls"
echo "1）登记org1.example.com"
fabric-ca-client enroll --csr.cn=org1.example.com --csr.hosts=['org1.example.com'] -M ./crypto-config/peerOrganizations/org1.example.com/tlstmp -u http://admin2:adminpw2@localhost:8056 --home ./fabric-ca-client
echo "2）添加联盟成员"
fabric-ca-client affiliation list -M ./crypto-config/peerOrganizations/org1.example.com/tlstmp -u http://admin2:adminpw2@localhost:8056 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org1 -M ./crypto-config/peerOrganizations/org1.example.com/tlstmp -u http://admin2:adminpw2@localhost:8056 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org2 -M ./crypto-config/peerOrganizations/org1.example.com/tlstmp -u http://admin2:adminpw2@localhost:8056 --home ./fabric-ca-client
fabric-ca-client affiliation add com -M ./crypto-config/peerOrganizations/org1.example.com/tlstmp -u http://admin2:adminpw2@localhost:8056 --home ./fabric-ca-client
fabric-ca-client affiliation add com.example -M ./crypto-config/peerOrganizations/org1.example.com/tlstmp -u http://admin2:adminpw2@localhost:8056 --home ./fabric-ca-client
fabric-ca-client affiliation add com.example.org1 -M ./crypto-config/peerOrganizations/org1.example.com/tlstmp -u http://admin2:adminpw2@localhost:8056 --home ./fabric-ca-client
echo "2.生成Admin@example.com的tls"
echo "1）注册Admin@example.com"
fabric-ca-client register --id.name Admin@org1.example.com --id.type client --id.affiliation "com.example.org1" --id.attrs '"hf.Registrar.Roles=client,orderer,peer,user","hf.Registrar.DelegateRoles=client,orderer,peer,user",hf.Registrar.Attributes=*,hf.GenCRL=true,hf.Revoker=true,hf.AffiliationMgr=true,hf.IntermediateCA=true,role=admin:ecert' --id.secret=123456 --csr.cn=org1.example.com --csr.hosts=['org1.example.com'] -M ./crypto-config/peerOrganizations/org1.example.com/tlstmp -u http://admin2:adminpw2@localhost:8056 --home ./fabric-ca-client
echo "2）登记Admin@example.com"
fabric-ca-client enroll -d --enrollment.profile tls -u http://Admin@org1.example.com:123456@localhost:8056 --csr.cn=org1.example.com --csr.hosts=['org1.example.com']  -M ./crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/tlstmp --home ./fabric-ca-client
echo "3）生成tls"
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/tls
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./intermediacatls2/ca-chain.pem ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/tls/ca.crt
cp ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/tlstmp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/tls/client.crt
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/tlstmp/keystore
keystore=`ls -l $path | tail -n 1 | awk '{print $9}'`
cp ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/tlstmp/keystore/$keystore ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/tls/client.key
# rm -rf ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/tlstmp
echo "3.生成peer0.org1.example.com的tls"
echo "1）注册peer0.org1.example.com"
fabric-ca-client register --id.name peer0.org1.example.com --id.type peer --id.affiliation "com.example.org1" --id.attrs '"role=peer",ecert=true' --id.secret=123456 --csr.cn=peer0.org1.example.com --csr.hosts=['peer0.org1.example.com'] -M ./crypto-config/peerOrganizations/org1.example.com/tlstmp -u http://admin2:adminpw2@localhost:8056 --home ./fabric-ca-client
echo "2）登记peer0.org1.example.com"
fabric-ca-client enroll -d --enrollment.profile tls -u http://peer0.org1.example.com:123456@localhost:8056 --csr.cn=peer0.org1.example.com --csr.hosts=['peer0.org1.example.com']  -M ./crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tlstmp --home ./fabric-ca-client
echo "3）生成tls"
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./intermediacatls2/ca-chain.pem ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
cp ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tlstmp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tlstmp/keystore
keystore=`ls -l $path | tail -n 1 | awk '{print $9}'`
cp ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tlstmp/keystore/$keystore ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key
# rm -rf ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tlstmp
echo "4.生成peer1.org1.example.com的tls"
echo "1）注册peer1.org1.example.com"
fabric-ca-client register --id.name peer1.org1.example.com --id.type peer --id.affiliation "com.example.org1" --id.attrs '"role=peer",ecert=true' --id.secret=123456 --csr.cn=peer1.org1.example.com --csr.hosts=['peer1.org1.example.com'] -M ./crypto-config/peerOrganizations/org1.example.com/tlstmp -u http://admin2:adminpw2@localhost:8056 --home ./fabric-ca-client
echo "2）登记peer1.org1.example.com"
fabric-ca-client enroll -d --enrollment.profile tls -u http://peer1.org1.example.com:123456@localhost:8056 --csr.cn=peer1.org1.example.com --csr.hosts=['peer1.org1.example.com']  -M ./crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tlstmp --home ./fabric-ca-client
echo "3）生成tls"
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./intermediacatls2/ca-chain.pem ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt
cp ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tlstmp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.crt
path=./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tlstmp/keystore
keystore=`ls -l $path | tail -n 1 | awk '{print $9}'`
cp ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tlstmp/keystore/$keystore ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.key
# rm -rf ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tlstmp
# rm -rf ./fabric-ca-client/crypto-config/peerOrganizations/org1.example.com/tlstmp

echo "IntermediaCA3生成证书"
echo "1.生成org2.example.com的msp"
echo "1）登记org2.example.com"
fabric-ca-client enroll --csr.cn=org2.example.com --csr.hosts=['org2.example.com'] -M ./crypto-config/peerOrganizations/org2.example.com/msp -u http://admin3:adminpw3@localhost:7057 --home ./fabric-ca-client
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/msp/config.yaml
echo "NodeOUs:"&>$path
echo "  Enable: true"&>>$path
echo "  ClientOUIdentifier:"&>>$path
echo "    Certificate: intermediatecerts/localhost-7057.pem"&>>$path
echo "    OrganizationalUnitIdentifier: client"&>>$path
echo "  PeerOUIdentifier:"&>>$path
echo "    Certificate: intermediatecerts/localhost-7057.pem"&>>$path
echo "    OrganizationalUnitIdentifier: peer"&>>$path
echo "2）添加联盟成员"
fabric-ca-client affiliation list -M ./crypto-config/peerOrganizations/org2.example.com/msp -u http://admin3:adminpw3@localhost:7057 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org1 -M ./crypto-config/peerOrganizations/org2.example.com/msp -u http://admin3:adminpw3@localhost:7057 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org2 -M ./crypto-config/peerOrganizations/org2.example.com/msp -u http://admin3:adminpw3@localhost:7057 --home ./fabric-ca-client
fabric-ca-client affiliation add com -M ./crypto-config/peerOrganizations/org2.example.com/msp -u http://admin3:adminpw3@localhost:7057 --home ./fabric-ca-client
fabric-ca-client affiliation add com.example -M ./crypto-config/peerOrganizations/org2.example.com/msp -u http://admin3:adminpw3@localhost:7057 --home ./fabric-ca-client
fabric-ca-client affiliation add com.example.org2 -M ./crypto-config/peerOrganizations/org2.example.com/msp -u http://admin3:adminpw3@localhost:7057 --home ./fabric-ca-client
echo "2.生成Admin@example.com的msp"
echo "1）注册Admin@example.com"
fabric-ca-client register --id.name Admin@org2.example.com --id.type client --id.affiliation "com.example.org2" --id.attrs '"hf.Registrar.Roles=client,orderer,peer,user","hf.Registrar.DelegateRoles=client,orderer,peer,user",hf.Registrar.Attributes=*,hf.GenCRL=true,hf.Revoker=true,hf.AffiliationMgr=true,hf.IntermediateCA=true,role=admin:ecert' --id.secret=123456 --csr.cn=org2.example.com --csr.hosts=['org2.example.com'] -M ./crypto-config/peerOrganizations/org2.example.com/msp -u http://admin3:adminpw3@localhost:7057 --home ./fabric-ca-client
echo "2）登记Admin@example.com"
fabric-ca-client enroll -u http://Admin@org2.example.com:123456@localhost:7057 --csr.cn=org2.example.com --csr.hosts=['org2.example.com']  -M ./crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp --home ./fabric-ca-client
echo "3）生成msp"
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/admincerts
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/msp/admincerts
echo "3.生成peer0.org2.example.com的msp"
echo "1）注册peer0.org2.example.com"
fabric-ca-client register --id.name peer0.org2.example.com --id.type peer --id.affiliation "com.example.org2" --id.attrs '"role=peer",ecert=true' --id.secret=123456 --csr.cn=peer0.org2.example.com --csr.hosts=['peer0.org2.example.com'] -M ./crypto-config/peerOrganizations/org2.example.com/msp -u http://admin3:adminpw3@localhost:7057 --home ./fabric-ca-client
echo "2）登记peer0.org2.example.com"
fabric-ca-client enroll -u http://peer0.org2.example.com:123456@localhost:7057 --csr.cn=peer0.org2.example.com --csr.hosts=['peer0.org2.example.com']  -M ./crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp --home ./fabric-ca-client
echo "3）生成msp"
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp/admincerts
echo "4.生成peer1.org2.example.com的msp"
echo "1）注册peer1.org2.example.com"
fabric-ca-client register --id.name peer1.org2.example.com --id.type peer --id.affiliation "com.example.org2" --id.attrs '"role=peer",ecert=true' --id.secret=123456 --csr.cn=peer1.org2.example.com --csr.hosts=['peer1.org2.example.com'] -M ./crypto-config/peerOrganizations/org2.example.com/msp -u http://admin3:adminpw3@localhost:7057 --home ./fabric-ca-client
echo "2）登记peer1.org2.example.com"
fabric-ca-client enroll -u http://peer1.org2.example.com:123456@localhost:7057 --csr.cn=peer1.org2.example.com --csr.hosts=['peer1.org2.example.com'] -M ./crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp --home ./fabric-ca-client
echo "3）生成msp"
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp/admincerts
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp/admincerts

echo "IntermediaCAtls3生成证书"
echo "1.生成org2.example.com的tls"
echo "1）登记org2.example.com"
fabric-ca-client enroll --csr.cn=org2.example.com --csr.hosts=['org2.example.com'] -M ./crypto-config/peerOrganizations/org2.example.com/tlstmp -u http://admin3:adminpw3@localhost:8057 --home ./fabric-ca-client
echo "2）添加联盟成员"
fabric-ca-client affiliation list -M ./crypto-config/peerOrganizations/org2.example.com/tlstmp -u http://admin3:adminpw3@localhost:8057 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org1 -M ./crypto-config/peerOrganizations/org2.example.com/tlstmp -u http://admin3:adminpw3@localhost:8057 --home ./fabric-ca-client
fabric-ca-client affiliation remove --force org2 -M ./crypto-config/peerOrganizations/org2.example.com/tlstmp -u http://admin3:adminpw3@localhost:8057 --home ./fabric-ca-client
fabric-ca-client affiliation add com -M ./crypto-config/peerOrganizations/org2.example.com/tlstmp -u http://admin3:adminpw3@localhost:8057 --home ./fabric-ca-client
fabric-ca-client affiliation add com.example -M ./crypto-config/peerOrganizations/org2.example.com/tlstmp -u http://admin3:adminpw3@localhost:8057 --home ./fabric-ca-client
fabric-ca-client affiliation add com.example.org2 -M ./crypto-config/peerOrganizations/org2.example.com/tlstmp -u http://admin3:adminpw3@localhost:8057 --home ./fabric-ca-client
echo "2.生成Admin@example.com的tls"
echo "1）注册Admin@example.com"
fabric-ca-client register --id.name Admin@org2.example.com --id.type client --id.affiliation "com.example.org2" --id.attrs '"hf.Registrar.Roles=client,orderer,peer,user","hf.Registrar.DelegateRoles=client,orderer,peer,user",hf.Registrar.Attributes=*,hf.GenCRL=true,hf.Revoker=true,hf.AffiliationMgr=true,hf.IntermediateCA=true,role=admin:ecert' --id.secret=123456 --csr.cn=org2.example.com --csr.hosts=['org2.example.com'] -M ./crypto-config/peerOrganizations/org2.example.com/tlstmp -u http://admin3:adminpw3@localhost:8057 --home ./fabric-ca-client
echo "2）登记Admin@example.com"
fabric-ca-client enroll -d --enrollment.profile tls -u http://Admin@org2.example.com:123456@localhost:8057 --csr.cn=org2.example.com --csr.hosts=['org2.example.com']  -M ./crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/tlstmp --home ./fabric-ca-client
echo "3）生成tls"
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/tls
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./intermediacatls3/ca-chain.pem ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/tls/ca.crt
cp ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/tlstmp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/tls/client.crt
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/tlstmp/keystore
keystore=`ls -l $path | tail -n 1 | awk '{print $9}'`
cp ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/tlstmp/keystore/$keystore ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/tls/client.key
# rm -rf ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/tlstmp
echo "3.生成peer0.org2.example.com的tls"
echo "1）注册peer0.org2.example.com"
fabric-ca-client register --id.name peer0.org2.example.com --id.type peer --id.affiliation "com.example.org2" --id.attrs '"role=peer",ecert=true' --id.secret=123456 --csr.cn=peer0.org2.example.com --csr.hosts=['peer0.org2.example.com'] -M ./crypto-config/peerOrganizations/org2.example.com/tlstmp -u http://admin3:adminpw3@localhost:8057 --home ./fabric-ca-client
echo "2）登记peer0.org2.example.com"
fabric-ca-client enroll -d --enrollment.profile tls -u http://peer0.org2.example.com:123456@localhost:8057 --csr.cn=peer0.org2.example.com --csr.hosts=['peer0.org2.example.com']  -M ./crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tlstmp --home ./fabric-ca-client
echo "3）生成tls"
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./intermediacatls3/ca-chain.pem ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
cp ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tlstmp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/server.crt
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tlstmp/keystore
keystore=`ls -l $path | tail -n 1 | awk '{print $9}'`
cp ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tlstmp/keystore/$keystore ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/server.key
# rm -rf ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tlstmp
echo "4.生成peer1.org2.example.com的tls"
echo "1）注册peer1.org2.example.com"
fabric-ca-client register --id.name peer1.org2.example.com --id.type peer --id.affiliation "com.example.org2" --id.attrs '"role=peer",ecert=true' --id.secret=123456 --csr.cn=peer1.org2.example.com --csr.hosts=['peer1.org2.example.com'] -M ./crypto-config/peerOrganizations/org2.example.com/tlstmp -u http://admin3:adminpw3@localhost:8057 --home ./fabric-ca-client
echo "2）登记peer1.org2.example.com"
fabric-ca-client enroll -d --enrollment.profile tls -u http://peer1.org2.example.com:123456@localhost:8057 --csr.cn=peer1.org2.example.com --csr.hosts=['peer1.org2.example.com'] -M ./crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tlstmp --home ./fabric-ca-client
echo "3）生成tls"
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls
if [ ! -d $path ];then
      mkdir -p $path
fi
cp ./intermediacatls3/ca-chain.pem ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
cp ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tlstmp/signcerts/cert.pem ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.crt
path=./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tlstmp/keystore
keystore=`ls -l $path | tail -n 1 | awk '{print $9}'`
cp ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tlstmp/keystore/$keystore ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.key
# rm -rf ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tlstmp
# rm -rf ./fabric-ca-client/crypto-config/peerOrganizations/org2.example.com/tlstmp
