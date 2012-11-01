## DeactivateObjectStorage
#### POST [HPKeystoneExtensionBaseURI]/action/deactivateobjectstorage
*Privilege Level: System Administrators, Domain Administrators*  
 
*Constraints:*  

1.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
2.  ```serviceName``` and ```regionCode``` parameters must be valid and must resolve a unique ```EndpointTemplate``` _(DeleteEndpointRef)_
3.  serviceName must resolve to a RegisteredService object _(UnassociateRoles)_
4.  ```serviceName``` and ```regionCode``` parameters must be valid and must resolve a unique ```EndpointTemplate``` _(DeleteProvisioningInfo)_

Deactivate specified Tenant from OpenStack Object Storage (Swift) service.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:-|:-|:-|
|serviceName|xs:string|true|
|domainId|xs:string|false|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateobjectstorage HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512

{ "JobTicket" :
  { "actionParams" : {
      "serviceName":"object-storage",
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
|:-|:-|:-|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning.Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action.The ```ITLSessionContext``` associated with the incoming request thread is used for authorization checks.|false|
|DeleteEndpointRef|Remove an ```EndpointRef``` tthat links an endpoint via an ```EndpointTemplate``` to a Tenant.The ```EndpointRef``` that links the tenant to the endpoint is deleted if it exists from the CS DB|false|
|UnassociateRoles|Remove assigned service activation roles from a specified user and/or from a specified group|false|
|DeleteProvisioningInfo|Update an existing ```ProvisioningInfo``` record to ```DELETED``` status to mark a tenant's removal from a previously provisioned service.In the future this behavior may change since the current behavior retains the ```ProvisioningInfo``` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|


**Notes**

1.  ```tenantName``` must resolve to an existing tenant.
2.  As part of deactivation the ```Domain Administrators``` group for the domain of the Tenant is removed from the role ```admin``` for this tenant.
3.  ```domainId``` is neither required nor used.
