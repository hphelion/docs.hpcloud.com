# UpdateTenant

## Description ##

Change the name and/or description for an existing Tenant in both UMS and Zuora. This action can also be used to update the soldTo address of tenant account (CS and Zuora).

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
| addressLine1	| xs:string	|false	|
| addressLine2	| xs:string	|false	|
| city		| xs:string	|false	|
| state		| xs:string	|false	|
| country	| xs:string	|false	|
| zip		| xs:string	|false	|

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
1. By default address is not a mandatory parameter but if provided it should have all the components (e.g. addressLine1, city, state, country and zip) only addressLine2 is an optional argument.
1. BillTo address of tenant (CS and Zuora) account should always mapped to the billTo address of domain account.

## JobTicket Results ##

1. The tenantId for the created Tenant.
1. ZUORA_TENANT_ACCOUNT will contain the Zuora Account ID.
