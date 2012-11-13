# DevexMigration
## POST [HPKeystoneExtensionBaseURI]/action/NOT DOCUMENTED
*Privilege Level: System Administrator*  
 
*Constraints:*  

1. TBD

Description TO BE PROVIDED

**Request Data**  

**URL Parameters**

TBD

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|password|xs:string|true|
|secretKey|xs:string|false|
|tenantId|xs:string|false|
|accountId|xs:string|true|
|contactId|xs:string|false|
|billingId|xs:string|false|
|emailAddress|xs:string|true|
|username|xs:string|true|
|firstName|xs:string|true|
|lastName|xs:string|true|
|salt|xs:string|true|
|swiftEndpoint|xs:string|false|
|nova1Endpoint|xs:string|false|
|nova2Endpoint|xs:string|false|
|swiftHash|xs:string|false|
|swiftAccessKeyId|xs:string|false|
|novaAccessKeyId|xs:string|false|
|dryrun|xs:string|false|

JSON

TBD

**Success Response**

**Status Code**

TBD

**Response Data**

-  UMS_USER holds the accountId for the user created in the UMS. _(CreateUmsUserAndDomain)_
-  UMS_DOMAIN holds the domainId for the domain created in the UMS. _(CreateUmsUserAndDomain)_
-  KMS_TENANT holds the ID for the tenant created in KMS. _(CreateKmsDomain)_
-  KMS_USER holds the ID for the UserAccount created in the KMS. _(CreateKmsUser)_

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
|:----------------|:----------------|:----------------|
|CreateUmsUserAndDomain|Create a new UMS User and Domain. The User will be configured as the Administrator for the new Domain.|false|
|MigrateUmsUser|No description available.|false|
|CreateKmsDomain|Create a new KMS Tenant corresponding to a UMS Domain.|false|
|CreateKmsUser|Create a new KMS User Account corresponding to a UMS User.|false|
|ImportKmsUserKeys|No description available.|false|
|MigrateSalesforceAccount|No description available.|false|
|MigrateZuoraDomainAndContact|No description available.|false|
|MigrateProvisionedServices|No description available.|false|
|EnableMigratedDomain|No description available.|false|

**Notes**
