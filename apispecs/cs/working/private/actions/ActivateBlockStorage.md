# Activate Block Storage
## POST [HPKeystoneExtensionBaseURI]/action/activateblockstorage
*Privilege Level: System Administrators, Domain Administrators*  
*Constraints:*  
1. A service endpoint can be subscribed to only once by the same tenant. (FindUmsTenant)  
2. serviceName parameter must be valid (AuthorizeProvisioningAction)  
3. serviceName and regionCode parameters must be valid and must resolve a unique EndpointTemplate (CreateEndpointRef)  
4. serviceName must resolve to a RegisteredService object (AssociateRoles)  
5. serviceName and regionCode parameters must be valid and must resolve a unique EndpointTemplate (CreateProvisioningInfo)  

Activate specified (existing) Tenant to Block Storage service.

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
POST http://host:port/v2.0/HP-IDM/v1.0/action/activateblockstorage HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive
Content-Length: 512
{ "JobTicket" :
    { "actionParams" : {
        "serviceName":"block-storage",
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
```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X POST -H 'User-Agent: Jakarta Commons-HttpClient/3.1' -H 'Content-Type: application/json' --cert <cert-path> --cacert <ca-cert-path> --data '{"JobTicket": {"actionParams":{"status": "SUSPENDED_3", "domainId": "92636548281306"}}}' -H 'X-Auth-Token: <auth-token>' [HPKeystoneExtensionBaseURI]/action/UpdateDomain?timeOut=20000  
```
**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|FindUmsTenant|Retrieve an existing Tenant from the UMS based on the Name of the Tenant|false|
|AuthorizeProvisioningAction|Perform authorisation checks prior to provisioning.  Essentially validate that the user attempting to provision the tenant is actually authorised to perform this action.  The *ITLSessionContext* associated with the incoming request thread is used for authorisation checks.|false|
|CreateZuoraSubscription|&nbsp;|false|
|CreateEndpointRef|Create an *EndpointRef* that links an endpoint via an *EndpointTemplate* to a Tenant.  The *EndpointRef* that links the tenant to the endpoint. This linkage, if it does not already exist, is setup in CS DB.|false|
|AssociateRoles|Assign service activation roles to a specified user and/or to a specified group|false|
|CreateProvisioningInfo|Create or update an existing *ProvisioningInfo* record to track a tenant's provisioned service.  The *ProvisioningInfo* that tracks the provisioning status of this tenant with the provisioned endpoint (via *serviceName* and regionCode) is setup.  The status of this *ProvisioningInfo* set to ENABLED and also the serviceAccountId field is set to the accountId (for now this is the tenantId) of the tenant.  If the ProvisioningInfo exists, then it will be reused and only the status will be marked ENABLED.  In the future this behaviour may change since the currentbehaviour retains the ProvisioningInfo record of a 'Deprovisioned' tenant since provisioning history has not been implemented yet.|false|




