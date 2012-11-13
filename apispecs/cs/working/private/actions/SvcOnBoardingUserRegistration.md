# SvcOnBoardingUserRegistration

## Description ##

This action will create a user in system domain with required privilege to register a new service in CS infrastructure. Mostly this action would be called by NOC person using cs-manage script.

## PrivilegeLevel ##

**Caller must have SuperAdmin or L3-plus-support role.**

## Examples ##

## Action Parameters ##

| Parameter Name	| Parameter Type 	| Is Required 	|
| :-------------	| :-------------	| :------------ 	|
| password 	| xs:string 	| **true**	|
| emailAddress 	| xs:string 	| **true** 	|
| username 	| xs:string 	| **true** 	|
| serviceId	| xs:string 	| **true** 	|

## Action Steps ##

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| CheckForExistingService 	| This step will check if a service is specified serviceId already exist in system, if yes then it would not go further.	| false 	|
| CreateUmsUser 	| Create a new UMS User object. 	| false 	|
| CreateKmsUser 	| Create a new KMS User Account corresponding to a UMS User. 	| false 	|
| CreateKmsUserKeys 	| Create a set of KMS Keys for the specified UMS User. 	| false 	|
| CreateSalesforceContactAndAccount 	| Create a new or a locate existing Salesforce Contact. A query is performed based on the User's email address. If an existing contact is found, then it is assumed to correspond to the UMS User. 	| false 	|
| CreateSvcRegAuthzPolicies 	| This step would create required policy on the above created user account.	| false 	|

## Constraints ##

1. Service with given serviceId should not exist in system, if exist there would be exception thrown.
1. The User's name and company are checked against the HP Restricted Parties List. If there is a hit then the new User and existing Domain are disabled after creation. _CreateUmsUser_
1. The UMS User and the User's Domain must be enabled. _CreateKmsUserKeys_
1. If Salesforce cannot be accessed than this Action Step will be retried at a future time. _CreateSalesforceContactAndAccount_

## JobTicket Results ##

1. KMS_USER holds the ID for the UserAccount created in the KMS. _CreateKmsUser_
1. KMS_USER_KEY holds the ID for the UserAccessKeys created in KMS. _CreateKmsUserKeys_
1. SALESFORCE_CONTACT will contain the Salesforce Contact ID. _CreateSalesforceContactAndAccount_
