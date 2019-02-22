-- 配置表
drop table if exists fabric_config;
create table fabric_config(
   row_id int(10)  unsigned NOT NULL AUTO_INCREMENT,
   league_id int(10), -- 联盟ID
   org_name varchar(50), -- 组织名称
   user_name varchar(50), -- 用户名称
   cryptoconfig_path varchar(255), -- 证书配置路径
   channelartifacts_path varchar(255), -- 通道配置路径
   org_mspid varchar(30), -- 组织msp_id
   org_domain varchar(50), -- 组织域名
   orderer_domain varchar(50), -- orderer域名
   channel_name varchar(50), -- 通道名称
   chaincode_name varchar(50), -- 智能合约名称
   chaincode_source varchar(50), -- 智能合约源码
   chaincode_path varchar(255), -- 智能合约路径
   chaincode_policy varchar(255), -- 智能合约策略
   chaincode_version varchar(30), -- 智能合约版本
   proposal_waittime int(10), -- 提案等待时间
   invoke_waittime int(10), -- 交易等待时间
   is_tls tinyint DEFAULT 0, -- 是否开启TLS
   is_catls tinyint DEFAULT 0, -- 是否开启CA TLS
   is_delete tinyint DEFAULT 0, -- 是否删除
   PRIMARY KEY (row_id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8;
create unique index fabric_config_row_id on fabric_config(row_id);

-- orderer配置表
drop table if exists fabric_orderer;
create table fabric_orderer(
   row_id int(10)  unsigned NOT NULL AUTO_INCREMENT,
   orderer_name varchar(50), -- 排序名称
   orderer_location varchar(255), -- 排序地址
   config_id int(10), -- 配置ID
   is_delete tinyint DEFAULT 0, -- 是否删除
   PRIMARY KEY (row_id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8;
create unique index fabric_orderer_row_id on fabric_orderer(row_id);

-- peer配置表
drop table if exists fabric_peer;
create table fabric_peer(
   row_id int(10)  unsigned NOT NULL AUTO_INCREMENT,
   peer_name varchar(50), -- 节点名称
   peer_eventhubname varchar(50), -- 节点事件名称
   peer_location varchar(255), -- 节点地址
   peer_eventhublocation varchar(255), -- 节点事件地址
   is_eventlistener tinyint DEFAULT 0, -- 是否监听
   config_id int(10),
   is_delete tinyint DEFAULT 0, -- 是否删除
   PRIMARY KEY (row_id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8;
create unique index fabric_peer_row_id on fabric_peer(row_id);

-- 用户表
drop table if exists fabric_user;
create table fabric_user(
   row_id int(10) unsigned NOT NULL AUTO_INCREMENT,
   name varchar(50), -- 名称
   account varchar(50), -- 帐户
   password varchar(32), -- 密码
   is_delete tinyint DEFAULT 0, -- 是否删除
   PRIMARY KEY (row_id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8;
create unique index fabric_user_row_id on fabric_user(row_id);

-- 添加数据
insert into fabric_user(name, account, password, is_delete) values
                       ("管理员", "admin", "e10adc3949ba59abbe56e057f20f883e", 0);

insert into fabric_config(league_id, org_name, user_name, cryptoconfig_path, channelartifacts_path, org_mspid, org_domain, orderer_domain, channel_name, chaincode_name, chaincode_source, chaincode_path, chaincode_policy, chaincode_version, proposal_waittime, invoke_waittime, is_tls, is_catls, is_delete) values
                         ("1", "Org1", "Admin", 'crypto-config', 'channel-artifacts', 'Org1MSP', 'org1.example.com', 'example.com', 'mychannel', 'mycc' , '/opt/gopath', 'github.com/hyperledger/fabric/kafkapeer/chaincode/go/example02', 'chaincodeendorsementpolicy.yaml', '1.0', '90000', '120', 1, 0, 0);
select @@IDENTITY AS row_id;
set @row_id = @@IDENTITY;
insert into fabric_orderer(orderer_name, orderer_location, config_id, is_delete) values
                          ("orderer0.example.com", "grpc://192.168.235.3:7050", @row_id, 0),
						  ("orderer1.example.com", "grpc://192.168.235.4:7050", @row_id, 0),
						  ("orderer2.example.com", "grpc://192.168.235.5:7050", @row_id, 0);
insert into fabric_peer(peer_name, peer_eventhubname, peer_location, peer_eventhublocation, is_eventlistener, config_id, is_delete) values
                       ("peer0.org1.example.com", "peer0.org1.example.com", "grpc://192.168.235.7:7051", "grpc://192.168.235.7:7053", 1, @row_id, 0);