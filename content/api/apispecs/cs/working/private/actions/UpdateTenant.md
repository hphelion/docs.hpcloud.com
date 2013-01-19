# UpdateTenant

## Description ##

Change the name and/or description for an existing Tenant in both UMS and Zuora.

## PrivilegeLevel ##

**System Admin, Domain Admin**

## Examples ##

	http://host:port/v2.0/HP-IDM/v1.0/action/updatetenant

## Action Parameters ##

| Parameter Name	| Parameter Type	| Is Required	|
| ---------------	| ------------------	| -------------	|
| tenantId 	| xs:string 	| **true** 	|
| tenantName 	| xs:string 	| false 	|
| description 	| xs:string 	| false 	|
| status 	| xs:string 	| false	|

## Action Steps ##
| Step Name 	| Step Description 	| Is Retryable 	|
| ---------- 	| ----------------- 	| ------------ 	|
| FindUmsTenant 	| 	| 	|
| UpdateUmsTenant 	| Update the tenant's name and/or description in the UMS. 	| false 	|
| UpdateZuoraTenantAccount 	| Update the tenant's name and/or description in Zuora. 	| **true** 	|


## Constraints ##

1. tenantId must be valid.
1. tenantName must be unique.
1. If Zuora cannot be accessed than this Action Step will be retried at a future time.

## JobTicket Results ##

1. The tenantId for the created Tenant.
1. ZUORA_TENANT_ACCOUNT will contain the Zuora Account ID.
