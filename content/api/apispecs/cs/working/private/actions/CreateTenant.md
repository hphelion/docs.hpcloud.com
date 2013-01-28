# Create Tenant
## POST [HPKeystoneExtensionBaseURI]/action/createtenant
*Privilege Level: System Admin, Domain Admin*  
 
This Action is used to create a new Tenant for an existing Domain in Control Services. Once successfully created in CS, a new Account is created in Zuora which is linked to the Tenant. Later, when the tenant activates services, the corresponding Zuora Account will subscribe to products in order to support customer billing.

This action can also be used to set the soldTo address of tenant (CS and Zuora) account.

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
|addressLine1|xs:string|false|
|addressLine2|xs:string|false|
|city|xs:string|false|
|state|xs:string|false|
|country|xs:string|false|
|zip|xs:string|false|

## Constraints ##
1. Tenant Name must be unique.
1. If Zuora cannot be accessed than this Action Step will be retried at a future time.
1. By default address is not a mandatory parameter but if provided it should have all the components (e.g. addressLine1, city, state, country and zip) only addressLine2 is an optional argument.
1. If no address is provided in parameter this action will use the domain's soldTo address to map to tenant's soldTo address.
1. BillTo address of tenant (CS and Zuora) account should always mapped to the billTo address of domain account.

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
