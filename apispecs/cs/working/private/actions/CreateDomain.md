# CreateDomain - SEVERELY DEPRECATED - TO BE REMOVED IN CONSER-4098
## POST [HPKeystoneExtensionBaseURI]/action/createdomain
*Privilege Level: System Admin*  
 
*Constraints:*  

1.  Domain name must be unique. _(CreateUmsDomain)_
2.  If Salesforce cannot be accessed than this Action Step will be retried at a future time. _(CreateSalesforceAccount)_

This Action is used to create a new Domain in Control Services. Once successfully created in CS, new Accounts are created in both Salesforce and Zuora which are linked to the Domain.

**Request Data**  

**URL Parameters**

TBD

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|name|xs:string|true|
|state|xs:string|false|
|addressLine1|xs:string|false|
|addressLine2|xs:string|false|
|city|xs:string|false|
|zip|xs:string|false|
|country|xs:string|false|
|phone|xs:string|false|
|company|xs:string|false|
|website|xs:string|false|
|emailAddress|xs:string|false|

JSON

TBD

**Success Response**

**Status Code**

TBD

**Response Data**

1.  The domainId for the created Domain. _(CreateUmsDomain)_
2.  KMS_TENANT holds the ID for the tenant created in KMS. _(CreateKmsDomain)_
3.  SALESFORCE_ACCOUNT will contain the Salesforce Account ID. _(CreateSalesforceAccount)_

JSON

TBD

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
|:----------------|:----------------|:----------------|
|CreateUmsDomain|Create a new UMS Domain object.|false|
|CreateKmsDomain|Create a new KMS Tenant corresponding to a UMS Domain.|false|
|CreateSalesforceAccount|Create a new Salesforce Account. No Salesforce Contact is created with the new Account.|true|
|CreateZuoraDomainAccount|Create a new Zuora account with no BillTo/SoldTo Contact.|true|


**Notes**
