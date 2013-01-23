# PurgeUser

## Description ##

Completely remove the specified User from the system. Deallocate any services assigned to this user, and inactivate accounts in third party systems, such as Zuora and Salesforce.

## PrivilegeLevel ##

N/A

## Examples ##

	http://host:port/v2.0/HP-IDM/v1.0/action/purgeuser

## Action Parameters ##

| Parameter Name	| Parameter Type	| Is Required	|
| -----------	| ------------------	| -------------	|
| accountId 	| xs:string 	| **true** 	|
| dryrun 	| xs:string 	| false 	|

## Action Steps ##
| Step Name 	| Step Description 	| Is Retryable 	|
| -- 	| -- 	| -- 	|
| DeleteKmsUser 	| 	| false 	|
| DeleteUmsUser 	| 	| false 	|

## Constraints ##

N/A

## JobTicket Results ##

N/A