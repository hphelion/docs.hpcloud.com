# ActivateCompute
## POST [HPKeystoneExtensionBaseURI]/action/activatecompute
*Privilege Level: System Administrators, Domain Administrators*
  
*Constraints:*
  
1.  A service endpoint can be subscribed to only once by the same tenant. _(CreateUmsTenant)_
2.  If a tenant with {{tenantName}} exists then the domainId of that tenant must match the {{domainId}} parameter _(CreateUmsTenant)_
3.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
4.  {{serviceName}} and {{regionCode}} parameters must be valid and must resolve a unique ```EndpointTemplate``` _(CreateEndpointRef)_
5.  serviceName must resolve to a RegisteredService object _(AssociateRoles)_
6.  {{serviceName}} and {{regionCode}} parameters must be valid and must resolve a unique ```EndpointTemplate``` _(CreateProvisioningInfo)_

Activate specified Tenant to OpenStack Compute (Nova) service.

As part of activation the ```Domain Administrators``` group for the domain of the Tenant is added to the roles ```netadmin``` and ```volume-manager``` for this tenant.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:-|:-|:-|
|serviceName|xs:string|true|
|domainId|xs:string|true|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/activatecompute HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512

{ "JobTicket" :
  { "actionParams" : {
      "serviceName":"compute",
      "regionCode":"az1:east:us",
      "domainId":"01234567890123",
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
|:-|:-|:-|
|CreateUmsTenant|Create a new or retrieve an existing Tenant from the UMS based on the Name of the Tenant.|false|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning. Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action. The ```ITLSessionContext``` associated with the incoming request thread is used for authorization checks.|false|
|CreateZuoraSubscription| |false|
|CreateZuoraSubscription| |false|
|CreateEndpointRef|Create an ```EndpointRef``` that links an endpoint via an ```EndpointTemplate``` to a Tenant. The ```EndpointRef``` that links the tenant to the endpoint. This linkage, if it does not already exist, is setup in CS DB.|false|
|AssociateRoles|Assign service activation roles to a specified user and/or to a specified group|false|
|CreateProvisioningInfo|Create or update an existing ```ProvisioningInfo``` record to track a tenant's provisioned service. The ```ProvisioningInfo``` that tracks the provisioning status of this tenant with the provisioned endpoint (via {{serviceName}} and {{regionCode}}) is setup. The status of this ```ProvisioningInfo``` set to ```ENABLED``` and also the {{serviceAccountId}} field is set to the accountId (for now this is the tenantId) of the tenant. If the ```ProvisioningInfo``` exists, then it will be reused and only the status will be marked ```ENABLED```. In the future this behavior may change since the current behavior retains the ```ProvisioningInfo``` record of a 'Deprovisioned' tenant since provisioning history has not been implemented yet.|false|

**Notes**

1.  The ```tenantName``` must be globally unique.
2.  A ```Block Storage``` service must be available in the *same region* to which this tenant will automatically be provisioned to.



