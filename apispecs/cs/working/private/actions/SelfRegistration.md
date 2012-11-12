# SelfRegistration

## Description ##

This action sets up a new Domain and User using minimal parameters. Keys are created for the user, and Accounts are created in both Salesforce and Zuora. In order to support MC IP address validation there are two additional parameters. ipCheckSucceeded store a boolean value indicating whether or not the IP address of the client is not blocked. ipAddress contains the actual address.

## Validation Modes ##

**No Validation**: In this mode all the required entities (user, domain, etc....) are created in the mongodb and the Sales Force and they are set to \*enabled\* state. Welcome email will be sent to customer immediately after successful registration process.

In this mode the user is activated immediately. If **sendWelcomeEmail**=true the email is sent immediately.

**Email Validation Mode**: In this mode, where **emailValidationType**!=None, the user is created in a suspended state and a validation email sent. See Action Parameters for the different validation modes. If **sendWelcomeEmail**=true and **emailValidationType**!='None' then the welcome email is sent on successful validation.

The **emailValidationRequired** flag is retained for the time being for backward compatibility. If this flag is set then it's equivalent to an **emailValidationType** of 'EmailVerification'. If both these parameters are specified then **emailValidationType** takes precedence.

Note that the **EmailVerification** action must handle validations from this action.

**See: Self Registration & Email Validation Work Flow**

## PrivilegeLevel ##

**Anonymous**

## Examples ##

    POST http://host:port/v2.0/HP-IDM/v1.0/action/SelfRegistration HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	Content-Length: 512
	{"JobTicket" : {
		"actionParams" : {
			"username":"jason",
      		"password":"this4now",
      		"emailAddress":"jason@hp.com",
      		"emailValidationRequired":"true"
      		}
      	}
	}

## Action Parameters ##

| Parameter Name	| Parameter Type 	| Is Required 	| Default 	|
| :--------------	| :--------------	| :---------- 	| :------- 	|
| state 	| xs:string 	| false 	| 	|
| password 	| xs:string 	| **true** 	| 	|
| addressLine1 	| xs:string 	| false 	| 	|
| addressLine2 	| xs:string 	| false 	| 	|
| city 	| xs:string 	| false 	| 	|
| zip 	| xs:string 	| false 	| 	|
| country 	| xs:string 	| false 	| 	|
| phone 	| xs:string 	| false 	| 	|
| company 	| xs:string 	| false 	| 	|
| website 	| xs:string 	| false 	| 	|
| emailAddress 	| xs:string 	| **true** 	| 	|
| username 	| xs:string 	| **true** 	| 	|
| firstName 	| xs:string 	| false 	| 	|
| lastName 	| xs:string 	| false 	| 	|
| ipAddress 	| xs:string 	| false 	| 	|
| promoCode 	| xs:string 	| false	| 	|
| partnerCode 	| xs:string 	| false 	| 	|
| riskScore 	| xs:int 	| false 	| 	|
| phoneInBillingLocation 	| xs:string 	| false 	| 	|
| ipBillingDistance	| xs:int 	| false 	| 	|
| ipCity 	| xs:string 	| false 	| 	|
| ipRegion 	| xs:string 	| false 	| 	|
| ipCountry 	| xs:string 	| false 	| 	|
| anonymousProxy 	| xs:boolean 	| false 	| 	|
| proxyScore 	| xs:int 	| false 	| 	|
| transparentProxy 	| xs:boolean 	| false 	| 	|
| corporateProxy 	| xs:boolean 	| false 	| 	|
| highRiskCountry 	| xs:boolean 	| false 	| 	|
| highRiskEmail 	| xs:boolean 	| false 	| 	|
| emailValidationRequired 	| xs:boolean 	| false 	| 	|
| referringUrl 	| xs:string 	| false 	| 	|
| useCase	| xs:string 	| false 	| 	|
| sendWelcomeEmail 	| xs:boolean 	| false 	| false	|
| emailValidationType 	| xs:string 	| false 	| None	|

**emailValidationType Values**

| Value	| Effect 	|
| ------	| --------	|
| None 	| Perform no email validation. 	|
| EmailVerification 	| Send verification email with a link that activates the user.	|
| EmailVerificationWithPwdCollection 	| Send verification email with a link that activates the user and capture a password .	|

## Action Steps ##

| Step Name 	| Step Description	| Is Retryable 	|
| -----------	| -----------------	| --------------	|
| CreateUmsUserAndDomain 	| Create a new UMS User and Domain. The User will be configured as the Administrator for the new Domain. 	| false 	|
| CreateKmsDomain 	| Create a new KMS Tenant corresponding to a UMS Domain. 	| false 	|
| CreateKmsUser 	| Create a new KMS User Account corresponding to a UMS User. 	| false 	|
| CreateKmsUserKeys 	| Create a set of KMS Keys for the specified UMS User. 	| false 	|
| CreateSalesforceAccount 	| Create a new Salesforce Account. No Salesforce Contact is created with the new Account. 	| false 	|
| CreateSalesforceContact 	| Create a new or a locate existing Salesforce Contact. A query is performed based on the User's email address. If an existing contact is found, then it is assumed to correspond to the UMS User. 	| false 	|
| CreateZuoraDomainAndContact 	| Create a new Account and Contact in Zuora that correspond with the given Domain and User. 	| false 	|

## Constraints ##

1. The UMS User and the User's Domain must be enabled. _(CreateKmsUserKeys)_

## JobTicket Results ##

1. UMS_USER holds the accountId for the user created in the UMS. _(CreateUmsUserAndDomain)_
1. UMS_DOMAIN holds the domainId for the domain created in the UMS. _CreateUmsUserAndDomain_
1. KMS_TENANT holds the ID for the tenant created in KMS. _(CreateKmsDomain)_
1. KMS_USER holds the ID for the UserAccount created in the KMS. _(CreateKmsUser)_
1. KMS_USER_KEY holds the ID for the UserAccessKeys created in KMS. _(CreateKmsUserKeys)_
1. SALESFORCE_ACCOUNT will contain the Salesforce Account ID. _(CreateSalesforceAccount)_
1. SALESFORCE_CONTACT will contain the Salesforce Contact ID. _(CreateSalesforceContact)_
1. ZUORA_DOMAIN_ACCOUNT will contain the Zuora Account ID. _(CreateZuoraDomainAndContact)_

##Email Integration##

After submission of an email a **CtrlSvcsContactActivity** Salesforce object is created with **ActvityType** set to a value from the table below.

| Templates Used	| CtrlSvcsContactActivity Type 	|
| --------------- 	| ---------------------------- 	|
| WELCOME_TO_CLOUD_EMAIL_ID 	| WelcomeEmailSent	|
| EMAIL_VERIFICATION_EMAIL_ID 	| VerificationEmailSent	|
| EMAIL_VERIFICATION_EMAIL_WITH_PWD_COLLECT_EMAIL_ID	| VerifEmailWithPwdCollectSent	|

Email messages are stored in the database. The email template is stored under the template name. Before being sent each email is processed by replacing text of the for %keyword% with a specific value. Replacement values available in the welcome email are listed in the following table.

| Email Text 	| Replaced With 	|
| ----------- 	| --------------	|
| %accountId% 	| user.accountId 	|
| %username% 	| user.username 	|
| %firstName% 	| user.firstName 	|
| %lastName% 	| user.lastName 	|
| %addressLine1% 	| user.addressLine1 	|
| %addressLine2% 	| user.addressLine2 	|
| %city% 	| user.city 	|
| %state% 	| user.state 	|
| %zip% 	| user.zip 	|
| %country% 	| user.country 	|
| %phone% 	| user.phone 	|
| %company% 	| user.company 	|
| %website% 	| user.website 	|
| %emailAddress% 	| user.emailAddress 	|
| %ResetToken%	| user.nonce	|
