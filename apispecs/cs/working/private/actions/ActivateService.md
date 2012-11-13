# ActivateService
## POST [HPKeystoneExtensionBaseURI]/action/activateservice
*Privilege Level: 
System Administrators, Domain Administrators*  

Apart from regular authorization requirement there are added authorization check on service activation call. Following are the new constraints added:

1.  Services and its endpoint template(s) has release state associated with it, by default customer has privilege to activate a service, as long as the service and endpoint template is/are in public state.
2.  Service releaseState takes higher presidency over endpoint template releaseState. (e.g. if service is in "beta" release state and its endpoint template is in "public", customer should not allowed to activate such services)
3.  If one of the endpoint template of a service is not in "public" state, service activation on that region should not be allowed.
4.  NOC and SA has privilege to activate any service does not matters what is the release state.
5.  To allow customer to activate a non public service, there should be special grant created on behalf of customer by NOC/Support
 
*Constraints:*  

1.  If a tenantId is provided, then a tenant with the specified tenantId must exist. In this case, the tenantName is ignored and no new tenant will be created. _(FindOrCreateUmsTenant)_
2.  If a tenant with tenantName exists then the domainId of that tenant must match the domainId parameter. _(FindOrCreateUmsTenant)_
3.  A service endpoint can be subscribed to only once by the same tenant. _(FindOrCreateUmsTenant)_
4.  The tenantId must be available (the UMS tenant must exist) at the time this is called. _(ProvisionService)_
5.  Service specific errors may be returned. _(ProvisionService)_
6.  ```CDN``` activation: Tenant being activated _must_ have an active subscription to Object Storage service. _(ProvisionService)_
7.  ```Block Storage``` activation: Tenant being activated _must_ have an active subscription to Compute service in the same region. _(ProvisionService)_
8.  serviceName and regionCode parameters must be valid and must resolve a unique EndpointTemplate _(CreateEndpointRef)_
9.  serviceName must resolve to a RegisteredService object _(AssociateRoles)_
10.  serviceName and regionCode parameters must be valid and must resolve a unique EndpointTemplate _(CreateProvisioningInfo)_

Activate specified Tenant to to the specified service.

**Request Data**  

**URL Parameters**

{parameters provided within the url}

**Data Parameters**


|Parameter Name|Parameter Type|Is Required|
|:-------------|:-------------|:----------|
|domainId|xs:string|true|
|tenantId|xs:string|true|
|serviceName|xs:string|true|
|regionCode|xs:string|false|
|tenantName|xs:string|true|
|dryrun|xs:string|false|


JSON

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/activateservice HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512

{ "JobTicket" :
  { "actionParams" : {
      "serviceName":"Object Storage",
      "regionCode":"az1:east:us",
      "domainId":"01234567890123",
      "tenantName":"Tenant1"
    }
  }
}
```

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/activateservice HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512

{ "JobTicket" :
  { "actionParams" : {
      "serviceName":"Compute",
      "regionCode":"az1:east:us",
      "domainId":"01234567890123",
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
|:--------|:---------------|:-----------|
|FindOrCreateUmsTenant|Create a new or retrieve an existing Tenant from the UMS based on the tenantName of the Tenant, *OR* retrieve an existing Tenant from the UMS based on the tenantId of the Tenant.|false|
|CreateZuoraSubscription|Create Zuora subscriptions for a service that is being activated.|false|
|ProvisionService|Provision the tenant to specified external service.Currently, the tenant is only provisioned to Object Storage (Swift). Other services do not require any provisioning actions beyond the CS DB.|false|
|CreateEndpointRef|Create an EndpointRef that links an endpoint via an EndpointTemplate to a Tenant.The EndpointRef that links the tenant to the endpoint is created if it does not exist in the CS DB|false|
|AssociateRoles|Assign service activation roles to a specified user and/or to a specified group|false|
|CreateProvisioningInfo|Create or update an existing ProvisioningInfo record to track a tenant's provisioned service.The ProvisioningInfo that tracks the provisioning status of this tenant with the provisioned endpoint (via serviceName and regionCode) is setup.The status of this ProvisioningInfo set to ENABLED and also the serviceAccountId field is set to the accountId (for now this is the tenantId) of the tenant.If the ProvisioningInfo exists, then it will be reused and only the status will be marked ENABLED.In the future this behavior may change since the current behavior retains the ProvisioningInfo record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|

**Notes**

1.  The tenantName must be globally unique.
2.  EITHER tenantName OR tenantId are required.
3.  If only the tenantName is provided then, if the tenant with the specified name does not exist then a new tenant will be created.
4.  If only the tenantId is provided then the tenant with the specified tenantId must exist.
5.  If both are provided then tenantId takes precedence and the net effect is the same as if only the tenantId was provided.
6.  As part of activation certain *Service Roles* assignments are made for this tenant. 
