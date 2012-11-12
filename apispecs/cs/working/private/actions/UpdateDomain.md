# UpdateDomain

## Description ##

Update the properties of the specified Domain. Property changes are propagated to all internal (UMS, KMS) and external (Salesforce) services.

In addition to set simple property values, the UpdateDomain action can also set the status for a Domain.

| Status Value 	| Privilege Level 	| Description 	|
| -- 	| -- 	| -- 	|
| ENABLED 	| SA 	| Default state to an active account 	|
| SUSPENDED_3 	| SA 	| No user in a suspended domain can log into their account. 	|
| DELETED 	| SA 	| Soft delete. Domain data is not purged. Can be re-ENABLED only by SA. 	|

## PrivilegeLevel ##

**System Administration, Domain Administration**

## Examples ##

	POST http://host:port/v2.0/HP-IDM/v1.0/action/updatedomain HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	Content-Length: 512
	{ "JobTicket" : {
		"actionParams" : {
      		"domainId":"44386614938865",
      		"city":"Portland",
      		"state":"Oregon"
      		"zip":"97213"
    		}
		}
	}

	POST http://host:port/v2.0/HP-IDM/v1.0/action/updatedomain HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	Content-Length: 512
	{ "JobTicket" : {
		"actionParams" : {
      		"status":"SUSPENDED_3",
    		}
		}
	}

## Action Parameters ##

| Parameter Name	| Parameter Type 	| Is Required 	|
| :--	| :--	| :- 	|
| name 	| xs:string 	| false 	|
| state 	| xs:string 	| false 	|
| status 	| xs:string 	| false 	|
| domainId 	| xs:string 	| **true** 	|
| addressLine1 	| xs:string 	| false 	|
| addressLine2 	| xs:string 	| false 	|
| city 	| xs:string 	| false 	|
| zip 	| xs:string 	| false 	|
| country 	| xs:string 	| false 	|
| phone 	| xs:string 	| false 	|
| company 	| xs:string 	| false 	|
| website 	| xs:string 	| false 	|
| emailAddress 	| xs:string 	| false 	|
| homeRegion 	| xs:string 	| false 	|

## Action Steps ##

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| UpdateUmsDomain 	| 	| false 	|
| UpdateKmsDomain 	| Update the state of a KMS Tenant to match that of its corresponding UMS Domain. 	| false 	|
| UpdateSalesforceAccount 	| 	| false 	|
| UpdateZuoraAccount 	| Update the Zuora Account that corresponds to the specified UMS Domain instance. 	| true 	|

## Constraints ##

N/A

## JobTicket Results ##

1. Following execution the KMS Tenant ID will be stored in the KMS_TENANT field. _(UpdateKmsDomain)_
1. ZUORA_DOMAIN_ACCOUNT is set with the Zuora AccountID for the corresponding Domain instance. _(UpdateZuoraAccount)_