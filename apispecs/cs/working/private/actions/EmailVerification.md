# EmailVerification
## Description ##

This action will be used to validate email verification nonce which was sent to the customer as part of self registration process. After successful validation of the nonce this action will activate all the entities in CS and in SF.

## PrivilegeLevel ##

**Anonymous**

## Examples ##

**Request:**

	{"JobTicket" :
        {"actionParams" :
            {"emailVerificationNonce":"eTA3Tzc5dUg4dktWQmtnVVp3VEpIYkdXT2xsNkwya2g0K2h6c21LODJ6cz1DZQ"}
        }
    }

**Response**

	{"JobTicket":{
		"action": "EmailVerification",
		"actionParams": {},
		"actionResults":{
			"SALESFORCE_ACCOUNT": "001Q000000W5ttYIAR",
			"UMS_USER": "80761182701046",
			"UMS_DOMAIN": "84861700411934",
			"EMAIL_VERIFY_STATUS": "COMPLETE"
			},
		"completion": "2012-08-01T20:51:15.562Z",
		"errorCategory": "",
		"errorDescription": "",
		"status": "COMPLETE",
		"stepStatus":{
			"UpdateKmsDomain": "COMPLETE",
			"UpdateSalesforceAccount": "COMPLETE",
			"ValidateEmailVerificationNonce": "COMPLETE",
			"SendWelcomeEmail": "COMPLETE",
			"ActivateUmsUserAndDomain": "COMPLETE"
			},
		"submission": "2012-08-01T20:51:13.600Z",
		"ticketId": "501996c1529528c09f16e89e"
	}

## Action Parameters ##

| Parameter Name	| Parameter Type 	| Is Required 	|
| :--	| :--	| :- 	|
| emailVerificationNonce 	| xs:string 	| **true** 	|

## Action Steps ##

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| ValidateEmailVerificationNonce 	| This step will verify the nonce and it validity.	| false 	|
| ActivateUmsUserAndDomain 	| This step will enable the UMS domain and user account 	| false 	|
| UpdateKmsDomain 	| This step will update KMS user and tenant accounts 	| false 	|
| UpdateSalesforceAccount 	| This step will update the SF Account and Contact and set these to Enabled state	| false 	|
| SendWelcomeEmail 	| Send welcome email 	| false 	|

## Constraints ##

N/A

## JobTicket Results ##

1. UMS_USER holds the ID for the UserAccount updated in UMS.
1. UMS_DOMAIN holds the ID for the Domain updated in UMS.
1. SALESFORCE_ACCOUNT will contain the Salesforce Account ID.
1. EMAIL_VERIFY_STATUS will contains the verification status.