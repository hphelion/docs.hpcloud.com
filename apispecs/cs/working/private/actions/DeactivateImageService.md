# DeactivateImageService
## POST [HPKeystoneExtensionBaseURI]/action/{action path}
*Privilege Level: System Administrators, Domain Administrators*  
 
*Constraints:*  

1.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
2.  ```serviceName``` and ```regionCode``` parameters must be valid and must resolve a unique ```EndpointTemplate``` _(DeleteEndpointRef)_
3.  serviceName must resolve to a RegisteredService object _(UnassociateRoles)_
4.  ```serviceName``` and ```regionCode``` parameters must be valid and must resolve a unique ```EndpointTemplate``` _(DeleteProvisioningInfo)_

Deactivate specified Tenant from OpenStack Image Service (Glance).

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type| Is Required|
|:----------------|:----------------|:----------------|
|domainId|xs:string|false|
|tenantId|xs:string|true|
|serviceName|xs:string|true|
|regionCode|xs:string|true|
|tenantName|xs:string|true|
|dryrun|xs:string|false|

JSON

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateimageservice HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512

{ "JobTicket" :
  { "actionParams" : {
      "serviceName":"image-service",
      "regionCode":"az1:east:us",
      "tenantName":"Tenant1"
    }
  }
}
```

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateimageservice HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512

{ "JobTicket" :
  { "actionParams" : {
      "serviceName":"image-service",
      "regionCode":"az1:east:us",
      "tenantId":"12345678901234"
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
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning.Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action.The ```ITLSessionContext``` associated with the incoming request thread is used for authorization checks.|false|
|DeactivateZuoraSubscription|Cancel Zuora subscriptions for a service that is being deactivated.|false|
|DeleteEndpointRef|Remove an ```EndpointRef``` tthat links an endpoint via an ```EndpointTemplate``` to a Tenant.The ```EndpointRef``` that links the tenant to the endpoint is deleted if it exists from the CS DB|false|
|UnassociateRoles|Remove assigned service activation roles from a specified user and/or from a specified group|false|
|DeleteProvisioningInfo|Update an existing ```ProvisioningInfo``` record to ```DELETED``` status to mark a tenant's removal from a previously provisioned service.In the future this behavior may change since the current behavior retains the ```ProvisioningInfo``` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|


**Notes**

1.  Either the ```tenantName``` OR ```tenantId``` is required and it must resolve to an existing tenant.
2.  As part of deactivation the *Service Roles* assigned at activation time are removed from the tenant. 
3.  ```domainId``` is neither required nor used.

