/*
Copyright IBM Corp. All Rights Reserved.

SPDX-License-Identifier: Apache-2.0
*/

package main

import (
    "bytes"
    "encoding/json"
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

type PayChaincode struct {
}

type Pay struct {
   UserId      string `json:"user_id"` //用户id
   OrderId     string `json:"order_id"` //订单id
   PayTransID  string `json:"pay_trans_id"` //支付平台交易id
   BuyProduct  string `json:"buy_product"` //购买产品
   TransAmount string `json:"trans_amount"` //交易金额
   TransTime string `json:"trans_time"` //交易时间
}


func (t *PayChaincode) Init(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("pay Init")
	return shim.Success(nil)
}

func (t *PayChaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("pay Invoke")
	function, args := stub.GetFunctionAndParameters()
	if function == "invoke" {
		return t.invoke(stub, args)
	} else if function == "query" {
		return t.query(stub, args)
	}

	return shim.Error("Invalid invoke function name. Expecting \"invoke\" \"query\"")
}

func (t *PayChaincode) invoke(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	var userId, orderId, payTransId, buyProduct, transAmount, transTime string    //用户ID、订单ID、支付平台交易ID、购买产品、交易金额、交易时间
	var err error

	if len(args) != 6 {
		return shim.Error("参数数量错误，需要6个参数。")
	}

	userId = args[0]
	orderId = args[1]
	payTransId = args[2]
	buyProduct = args[3]
	transAmount = args[4]
	transTime = args[5]

	pay := &Pay{userId, orderId, payTransId, buyProduct, transAmount, transTime}
	payJSONBytes, err := json.Marshal(pay)
	if err != nil {
		return shim.Error(err.Error())
	}
	
	err = stub.PutState(orderId, payJSONBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

func (t *PayChaincode) query(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	var userId string // 用户Id
	var err error

	if len(args) != 1 {
		return shim.Error("参数数量错误，需要1个参数。")
	}

	userId = args[0]

    queryString := fmt.Sprintf("{\"selector\":{\"user_id\":\"%s\"}}", userId)

	queryResults, err := getQueryResultForQueryString(stub, queryString)
	if err != nil {
		return shim.Error(err.Error())
	}
	return shim.Success(queryResults)
}

// =========================================================================================
// getQueryResultForQueryString executes the passed in query string.
// Result set is built and returned as a byte array containing the JSON results.
// =========================================================================================
func getQueryResultForQueryString(stub shim.ChaincodeStubInterface, queryString string) ([]byte, error) {

	fmt.Printf("- getQueryResultForQueryString queryString:\n%s\n", queryString)

	resultsIterator, err := stub.GetQueryResult(queryString)
	if err != nil {
		return nil, err
	}
	defer resultsIterator.Close()

	buffer, err := constructQueryResponseFromIterator(resultsIterator)
	if err != nil {
		return nil, err
	}

	fmt.Printf("- getQueryResultForQueryString queryResult:\n%s\n", buffer.String())

	return buffer.Bytes(), nil
}

// ===========================================================================================
// constructQueryResponseFromIterator constructs a JSON array containing query results from
// a given result iterator
// ===========================================================================================
func constructQueryResponseFromIterator(resultsIterator shim.StateQueryIteratorInterface) (*bytes.Buffer, error) {
	// buffer is a JSON array containing QueryResults
	var buffer bytes.Buffer
	buffer.WriteString("[")

	bArrayMemberAlreadyWritten := false
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return nil, err
		}
		// Add a comma before array members, suppress it for the first array member
		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"Key\":")
		buffer.WriteString("\"")
		buffer.WriteString(queryResponse.Key)
		buffer.WriteString("\"")

		buffer.WriteString(", \"Record\":")
		// Record is a JSON object, so we write as-is
		buffer.WriteString(string(queryResponse.Value))
		buffer.WriteString("}")
		bArrayMemberAlreadyWritten = true
	}
	buffer.WriteString("]")

	return &buffer, nil
}

func main() {
	err := shim.Start(new(PayChaincode))
	if err != nil {
		fmt.Printf("Error starting Simple chaincode: %s", err)
	}
}