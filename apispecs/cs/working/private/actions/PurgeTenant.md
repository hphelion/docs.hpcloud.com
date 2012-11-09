# PurgeTenant

## Description ##

Delete the specified Tenant from the UMS. Cancel all activated services and all Zuora subscriptions for the tenant.

## PrivilegeLevel ##

**System Admin, Domain Admin**

## Examples ##

	http://host:port/v2.0/HP-IDM/v1.0/action/purgetenant

## Action Parameters ##

| Parameter Name	| Parameter Type	| Is Required	|
| ---------------	| ------------------	| -------------	|
| tenantId 	| xs:string 	| **true** 	|
| tenantName 	| xs:string 	| **true** 	|

**One or the other**

## Action Steps ##
| Step Name 	| Step Description 	| Is Retryable 	|
| ---------- 	| ----------------- 	| ------------ 	|
| FindUmsTenant 	| Find the specified tenant 	| false 	|
| PurgeZuoraTenantAccount 	| Cancel all subscriptions in Zuora that are owned by this tenant. Do not remove tenant account. 	| false 	|
| PurgeServicesForTenant 	| Attempt to purge (physically remove) all the services for the tenant by de-provisioning the tenant's services first. *Note:* Rollback is not supported. 	| false 	|
| PurgeUmsTenant 	| Delete the tenant from the UMS. 	| false 	|

## Constraints ##

1. tenantId or tenantName must be valid.

## JobTicket Results ##

1. The tenantId for the purged Tenant.
