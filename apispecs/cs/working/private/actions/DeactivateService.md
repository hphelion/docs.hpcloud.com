## DeactivateService
#### POST [HPKeystoneExtensionBaseURI]/action/deactivateservice
*Privilege Level: System Administrators, Domain Administrators*  
 
*Constraints:*  

1.  If a ```tenantId``` is provided, then a tenant with the specified ```tenantId``` must exist. In this case, the ```tenantName``` is ignored. _(FindUmsTenant)_
2.  A service endpoint can be subscribed to only once by the same tenant. _(FindUmsTenant)_
3.  The ```tenantId``` must be available (the UMS tenant must exist) at the time this is called. _(DeprovisionService)_
4.  Service specific errors may be returned. _(DeprovisionService)_
5.  ```Block Storage``` deactivation: Tenant being activated _must not_ have an active subscription to ```Compute``` service in the same region. _(DeprovisionService)_
6.  ```serviceName``` and ```regionCode``` parameters must be valid and must resolve a unique ```EndpointTemplate``` _(DeleteEndpointRef)_
7.  serviceName must resolve to a RegisteredService object _(UnassociateRoles)_
8.  ```serviceName``` and ```regionCode``` parameters must be valid and must resolve a unique ```EndpointTemplate``` _(DeleteProvisioningInfo)_


Deactivate specified Tenant from the specified service.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:-------------|:-------------|:----------|
|tenantId|xs:string|true|
|serviceName|xs:string|true|
|regionCode|xs:string|false|
|tenantName|xs:string|true|
|dryrun|xs:string|false|

JSON

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateservice HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512

{ "JobTicket" :
  { "actionParams" : {
      "serviceName":"Block Storage",
      "regionCode":"az1:east:us",
      "tenantName":"Tenant1"
    }
  }
}
```

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateservice HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512

{ "JobTicket" :
  { "actionParams" : {
      "serviceName":"CDN",
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

```UMS_TENANT``` holds the tenantId for the new or existing Tenant. _(FindUmsTenant)_

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:--------|:---------------|:-----------|
|FindUmsTenant|Retrieve an existing Tenant from the UMS based on the ```tenantId``` or the ```tenantName``` of the Tenant.|false|
|DeactivateZuoraSubscription|Cancel Zuora subscriptions for a service that is being deactivated.|false|
|DeprovisionService|Deprovision the tenant to specified external service.Currently, the tenant is only deprovisioned from Object Storage (Swift). Other services do not require any provisioning actions beyond the CS DB.Note: Deprovisioning rollback from Object Storage is not supported.|false|
|DeleteEndpointRef|Remove an ```EndpointRef``` tthat links an endpoint via an ```EndpointTemplate``` to a Tenant.The ```EndpointRef``` that links the tenant to the endpoint is deleted if it exists from the CS DB|false|
|UnassociateRoles|Remove assigned service activation roles from a specified user and/or from a specified group|false|
|DeleteProvisioningInfo|Update an existing ```ProvisioningInfo``` record to ```DELETED``` status to mark a tenant's removal from a previously provisioned service.In the future this behavior may change since the current behavior retains the ```ProvisioningInfo``` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|


**Notes**

1.  Either the ```tenantName``` OR ```tenantId``` is required and it must resolve to an existing tenant.
2.  As part of deactivation the *Service Roles* assigned at activation time are removed from the tenant.
3.  ```domainId``` is neither required nor used.
