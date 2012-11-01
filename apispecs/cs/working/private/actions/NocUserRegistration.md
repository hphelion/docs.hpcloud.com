# NocUserRegistration

## Description ##

N/A

## PrivilegeLevel ##

N/A

## Examples ##

N/A

## Action Parameters ##

| Parameter Name	| Parameter Type	| Is Required	|
| -----------	| ------------------	| -------------	|
| state 	| xs:string 	| false 	|
| password 	| xs:string 	| **true** 	|
| addressLine1 	| xs:string 	| false 	|
| addressLine2 	| xs:string 	| false 	|
| city 	| xs:string 	| false 	|
| zip 	| xs:string 	| false 	|
| country 	| xs:string 	| false 	|
| phone 	| xs:string 	| false 	|
| company 	| xs:string 	| false 	|
| website 	| xs:string 	| false 	|
| emailAddress 	| xs:string 	| false 	|
| username 	| xs:string 	| **true** 	|
| firstName 	| xs:string 	| false 	|
| lastName 	| xs:string 	| false 	|


## Action Steps ##
| Step Name 	| Step Description 	| Is Retryable 	|
| -- 	| -- 	| -- 	|
| CreateUmsUser 	| Create a new UMS User object. 	| false 	|
| CreateKmsUser 	| Create a new KMS User Account corresponding to a UMS User. 	| false 	|
| CreateKmsUserKeys 	| Create a set of KMS Keys for the specified UMS User. 	| false 	|
| CreateSalesforceContactAndAccount 	| Create a new or a locate existing Salesforce Contact. A query is performed based on the User's email address. If an existing contact is found, then it is assumed to correspond to the UMS User. 	| false 	|

## Constraints ##

1. The User's name and company are checked against the HP Restricted Parties List. If there is a hit then the new User and existing Domain are disabled after creation. _(CreateUmsUser)_
1. The UMS User and the User's Domain must be enabled. _(CreateKmsUserKeys)_
1. If Salesforce cannot be accessed than this Action Step will be retried at a future time. _(CreateSalesforceContactAndAccount)_


## JobTicket Results ##

1. KMS_USER holds the ID for the UserAccount created in the KMS. _(CreateKmsUser)_
1. KMS_USER_KEY holds the ID for the UserAccessKeys created in KMS. _(CreateKmsUserKeys)_
1. SALESFORCE_CONTACT will contain the Salesforce Contact ID. _(CreateSalesforceContactAndAccount)_