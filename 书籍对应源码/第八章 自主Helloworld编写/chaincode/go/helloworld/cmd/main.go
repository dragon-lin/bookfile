/*
 * 
 * 文件名称 : main.go 
 * 创建者 : linwf
 * 创建日期: 2018/08/23 
 * 文件描述: 主入口函数
 * 历史记录: 无 
 */

package main

import (
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	"github.com/hyperledger/fabric/helloworld/chaincode/go/helloworld"
)

func main() {
	err := shim.Start(new(helloworld.SimpleChaincode))
	if err != nil {
		fmt.Printf("Error starting Simple chaincode: %s", err)
	}
}
