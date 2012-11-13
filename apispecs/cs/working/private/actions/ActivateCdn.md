# ActivateCdn
## POST [HPKeystoneExtensionBaseURI]/action/activatecdn
*Privilege Level: System Administrators, Domain Administrators*  
*Constraints:* 
 
1.  A service endpoint can be subscribed to only once by the same tenant. _(FindUmsTenant)_  
2.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_  
3.  ```serviceName``` and ```regionCode``` parameters must be valid and must resolve a unique ```EndpointTemplate``` _(CreateEndpointRef)_  
4.  serviceName must resolve to a RegisteredService object _(AssociateRoles)_  
5.  ```serviceName``` and ```regionCode``` parameters must be valid and must resolve a unique ```EndpointTemplate``` _(CreateProvisioningInfo)_  


Activate the specified (existing) Swift Tenant to CDN service.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|serviceName|xs:string|true|
|domainId|xs:string|false|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/activatecdn HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512

{ "JobTicket" :
  { "actionParams" : {
      "serviceName":"cdn",
      "regionCode":"az1:east:us",
      "tenantName":"Tenant1"
    }
  }
}
```
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

JSON

TBD  

XML

TBD  

Curl Example

TBD

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|FindUmsTenant|Retrieve an existing Tenant from the UMS based on the Name of the Tenant.|false|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning. Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action. The ```ITLSessionContext``` associated with the incoming request thread is used for authorization checks.|false|
|CreateZuoraSubscription| |false|
|CreateEndpointRef|Create an ```EndpointRef``` that links an endpoint via an ```EndpointTemplate``` to a Tenant. The ```EndpointRef``` that links the tenant to the endpoint. This linkage, if it does not already exist, is setup in CS DB. | false |
| AssociateRoles | Assign service activation roles to a specified user and/or to a specified group | false |
| CreateProvisioningInfo | Create or update an existing ```ProvisioningInfo``` record to track a tenant's provisioned service.  The ```ProvisioningInfo``` that tracks the provisioning status of this tenant with the provisioned endpoint (via ```serviceName``` and ```regionCode```) is setup.  The status of this ```ProvisioningInfo``` set to ```ENABLED``` and also the ```serviceAccountId``` field is set to the accountId (for now this is the tenantId) of the tenant.  If the ```ProvisioningInfo``` exists, then it will be reused and only the status will be marked ```ENABLED```.  In the future this behavior may change since the current behavior retains the ```ProvisioningInfo``` record of a 'Deprovisioned' tenant since provisioning history has not been implemented yet. | false |

**Notes**

1.  The ```tenantName``` must resolve to an existing tenant and must be provisioned to at least one ```Object Storage``` service.
2.  The ```domainId``` is neither required nor used.
3.  As part of activation the ```Domain Administrators``` group for the domain of the Tenant is added to the role ```cdn-admin``` for this tenant.


