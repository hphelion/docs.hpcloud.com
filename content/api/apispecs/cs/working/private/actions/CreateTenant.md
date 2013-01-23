# Create Tenant
## POST [HPKeystoneExtensionBaseURI]/action/createtenant
*Privilege Level: System Admin, Domain Admin*  
 
*Constraints:*  

1.  Tenant Name must be unique.
2.  If Zuora cannot be accessed than this Action Step will be retried at a future time.

This Action is used to create a new Tenant for an existing Domain in Control Services. Once successfully created in CS, a new Account is created in Zuora which is linked to the Tenant. Later, when the tenant activates services, the corresponding Zuora Account will subscribe to products in order to support customer billing.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|tenantName|xs:string|true|
|domainId|xs:string|true|
|description|xs:string|false|
|homeRegion|xs:string|false|

JSON

TBD

**Success Response**

**Status Code**

TBD

**Response Data**

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


## Region Resolution ##
{{PRIVATE}} If homeRegion is specified in input data, then CS tenant is created in specified homeRegion. If home region is not specified in input data, then CS tenant is created in same region where tenant's domain region. Currently we are not propagating region to zuora side.

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|CreateUmsTenant|Create a new UMS Tenant object.|false|
|CreateZuoraTenantAccount|Create a Zuora Account that is a child of the Domain Account|true|

**Notes**
