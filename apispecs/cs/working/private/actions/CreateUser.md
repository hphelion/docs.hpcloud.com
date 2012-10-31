# CreateUser

## Description ##

First, create a new User within the specified Domain in Control Services, and create accesskeys for the User. Next, create a new Contact for this user in Salesforce beneath the Salesforce Account of the Domain. Finally, if there is not already a Zuora Contact, then create one based on the user info.

In order to support MC IP address validation there are two additional parameters. ipCheckSucceeded store a boolean value indicating whether or not the IP address of the client is not blocked. ipAddress contains the actual address.

## PrivilegeLevel ##

**System Admin, Domain Admin**

## Examples ##

    http://host:port/v2.0/HP-IDM/v1.0/action/createuser

## Action Parameters ##

| Parameter Name	| Parameter Type 	| Is Required 	|
| :--	| :--	| :- 	|
| state	| xs:string 	| false 	|
| password 	| xs:string 	| **true**	|
| domainId	| xs:string 	| **true** 	|
| addressLine1	| xs:string 	| false 	|
| addressLine2	| xs:string 	| false 	|
| city	| xs:string 	| false 	|
| zip	| xs:string 	| false 	|
| country	| xs:string 	| false 	|
| phone	| xs:string 	| false 	|
| company	| xs:string 	| false 	|
| website	| xs:string 	| false 	|
| emailAddress	| xs:string 	| false 	|
| username 	| xs:string 	| **true**	|
| firstName	| xs:string 	| false 	|
| lastName	| xs:string 	| false 	|
| ipAddress	| xs:string 	| false 	|
| promoCode	| xs:string	| false	|
| partnerCode	| xs:string	| false	|
| riskScore	| xs:int 	| false 	|
| phoneInBillingLocation	| xs:string 	| false 	|
| ipBillingDistance	| xs:int 	| false 	|
| ipCity	| xs:string 	| false 	|
| ipRegion	| xs:string 	| false 	|
| ipCountry	| xs:string 	| false 	|
| anonymousProxy	| xs:boolean 	| false 	|
| proxyScore	| xs:int 	| false 	|
| transparentProxy	| xs:boolean 	| false 	|
| corporateProxy	| xs:boolean 	| false 	|
| highRiskCountry	| xs:boolean 	| false 	|
| highRiskEmail	| xs:boolean 	| false 	|

## Action Steps ##

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| CreateUmsUser 	| Create a new UMS User object. 	| false 	|
| CreateKmsUser 	| Create a new KMS User Account corresponding to a UMS User. 	| false 	|
| CreateKmsUserKeys 	| Create a set of KMS Keys for the specified UMS User. 	| false 	|
| CreateSalesforceContact 	| Create a new or locate ab existing Salesforce Contact. 	| **true** 	|
| CreateZuoraContact 	| Create a new Contact in Zuora only if there is not one already. 	| **true** 	|

## Constraints ##

1. The UMS User and the User's Domain must be enabled. _(CreateKmsUserKeys)_
1. If Salesforce cannot be accessed than this Action Step will be retried at a future time. _(CreateSalesforceContact)_
1. If Zuora cannot be accessed than this Action Step will be retried at a future time. _(CreateZuoraContact)_

## JobTicket Results ##

1. KMS_USER holds the ID for the UserAccount created in the KMS. _(CreateKmsUser)_
1. KMS_USER_KEY holds the ID for the UserAccessKeys created in KMS. _(CreateKmsUserKeys)_
1. SALESFORCE_CONTACT will contain the Salesforce Contact ID. _(CreateSalesforceContact)_
1. ZUORA_DOMAIN_ACCOUNT will contain the Zuora Account ID. _CreateZuoraContact_