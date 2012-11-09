## Cancel Account
#### POST [HPKeystoneExtensionBaseURI]/action/cancelaccount
*Privilege Level: System Admin*  
 
*Constraints:*  

None

Mark a Domain and all connected objects are CANCELED or TERMINATED. A canceled account can later be re-enabled, but a terminated account can never be used again.

This action will also cancel subscriptions in Zuora and update status in Salesforce.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:-------------|:-------------|:----------|
|domainId|xs:string|true|
|terminate|xs:boolean|false|
|reason|xs:string|false|

JSON

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/cancelaccount HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512

{ "JobTicket" :
  { "actionParams" : {
      "domainId":"44386614938865",
      "terminate":"true",
      "reason":"deadbeat"
    }
  }
}
```

**Success Response**

**Status Code**

{success http status code}

**Response Data**

JSON

{json response code formatted}

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:--------|:---------------|:-----------|
|UpdateUmsDomain||false|
|UpdateKmsDomain|Update the state of a KMS Tenant to match that of its corresponding UMS Domain.|false|
|UpdateServicesForDomain||false|
|UpdateSalesforceAccount||false|
|DeactivateZuoraAccount|Update the Zuora Account that corresponds to the specified UMS Domain instance.|false|

**Notes**

None
