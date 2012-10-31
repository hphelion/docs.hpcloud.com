# EnterpriseUserEmailVerification

## Description ##

This action is used to validate and activate users created with the **CreateUser** action. After successful validation of the nonce this action will activate all the entities in CS and in SF.

See **CreateUser** action for email integration information. 

## PrivilegeLevel ##

**Anonymous**

## Examples ##

**Request:**

	{"JobTicket" :
        {"actionParams" :
            {"emailVerificationNonce":"eTA3Tzc5dUg4dktWQmtnVVp3VEpIYkdXT2xsNkwya2g0K2h6c21LODJ6cz1DZQ"}
        }
    }

## Action Parameters ##

| Parameter Name	| Parameter Type 	| Is Required 	|
| :--	| :--	| :- 	|
| emailVerificationNonce 	| xs:string 	| **true** 	|
| password 	| xs:string 	| false 	|

## Action Steps ##

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| ValidateEmailVerificationNonce 	| This step will verify the nonce and it validity.	| false 	|
| ActivateUmsUser	| This step will enable the UMS domain and user account 	| false 	|
| UpdateKmsUser 	| This step will update KMS user and tenant accounts 	| false 	|
| UpdateSalesforceAccount 	| This step will update the SF Account and Contact and set these to Enabled state	| false 	|
| SendWelcomeEmail 	| Send welcome email 	| false 	|

## Constraints ##

1. The verification mode chosen in CreateUser dictates whether the password parameter is required, t is an error to omit the password if it's use was indicated.

## JobTicket Results ##

1. UMS_USER holds the ID for the UserAccount updated in UMS.
1. SALESFORCE_ACCOUNT will contain the Salesforce Account ID.
1. EMAIL_VERIFY_STATUS will contains the verification status.