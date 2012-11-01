# PurgeDomain

## Description ##

Completely remove the specified Domain from the system. Cascade removal to all subordinate Users, Tenants and Resources. Inactivate any associated accounts in Zuora and Salesforce.

## PrivilegeLevel ##

**System Admin**

## Examples ##

	http://host:port/v2.0/HP-IDM/v1.0/action/purgedomain

## Action Parameters ##

| Parameter Name	| Parameter Type	| Is Required	|
| -----------	| ------------------	| -------------	|
| domainId 	| xs:string 	| **true** 	|
| dryrun 	| xs:string 	| false 	|

## Action Steps ##
| Step Name 	| Step Description 	| Is Retryable 	|
| -- 	| -- 	| -- 	|
| DeactivateZuoraAccount 	| When a domain is deleted we mark the corresponding Zuora Account as inactive by setting its state to 'Canceled' - with one Ell. 	| false 	|
| PurgeServicesForDomain 	| Find all domain tenants and attempt to purge (physically remove) all the services for every tenant by deprovisioning the tenant's services first. *Note:* Rollback is not supported. 	| false 	|
| DeleteKmsDomain 	| 	| false 	|
| DeleteUmsDomain 	| 	| false 	|

## Constraints ##

N/A

## JobTicket Results ##

N/A