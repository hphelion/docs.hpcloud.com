# CreateUser

## Description ##

First, create a new User within the specified Domain in Control Services, and create accesskeys for the User. Next, create a new Contact for this user in Salesforce beneath the Salesforce Account of the Domain. Finally, if there is not already a Zuora Contact, then create one based on the user info.

In order to support MC IP address validation there are two additional parameters. ipCheckSucceeded store a boolean value indicating whether or not the IP address of the client is not blocked. ipAddress contains the actual address.


## Validation Modes ##

**Default Mode**: In this mode the user is activated immediately. If **sendWelcomeEmail**=true the email is also sent immediately.

**Email Validation Mode**: In this mode, where **emailValidationType**!=None, the user is created in a suspended state and a validation email sent. See Action Parameters for the different validation modes. If **sendWelcomeEmail**=true and **emailValidationType**!=None then the welcome email is sent on successful validation.

Note that the **EnterpriseUserEmailVerification** action must handle validations from this action.

## PrivilegeLevel ##

**System Admin, Domain Admin**

## Examples ##

    http://host:port/v2.0/HP-IDM/v1.0/action/createuser

## Action Parameters ##

| Parameter Name | Parameter Type | Is Required | Default |
| :------------- | :------------- | :---------- | :------ |
| state	| xs:string 	| false 	| 	|
| password 	| xs:string 	| **true**	| 	|
| domainId	| xs:string 	| **true** 	| 	|
| addressLine1	| xs:string 	| false 	| 	|
| addressLine2	| xs:string 	| false 	| 	|
| city	| xs:string 	| false 	| 	|
| zip	| xs:string 	| false 	| 	|
| country	| xs:string 	| false 	| 	|
| phone	| xs:string 	| false 	| 	|
| company	| xs:string 	| false 	| 	|
| website	| xs:string 	| false 	| 	|
| emailAddress	| xs:string 	| false 	| 	|
| username 	| xs:string 	| **true**	| 	|
| firstName	| xs:string 	| false 	| 	|
| lastName	| xs:string 	| false 	| 	|
| ipAddress	| xs:string 	| false 	| 	|
| promoCode	| xs:string	| false	| 	|
| partnerCode	| xs:string	| false	| 	|
| riskScore	| xs:int 	| false 	| 	| 
| phoneInBillingLocation	| xs:string 	| false 	| 	|
| ipBillingDistance	| xs:int 	| false 	| 	|
| ipCity	| xs:string 	| false 	| 	|
| ipRegion	| xs:string 	| false 	| 	|
| ipCountry	| xs:string 	| false 	| 	|
| anonymousProxy	| xs:boolean 	| false 	| 	|
| proxyScore	| xs:int 	| false 	| 	|
| transparentProxy	| xs:boolean 	| false 	| 	|
| corporateProxy	| xs:boolean 	| false 	| 	|
| highRiskCountry	| xs:boolean 	| false 	| 	|
| highRiskEmail	| xs:boolean 	| false 	| 	|
| sendWelcomeEmail 	| xs:boolean 	| false	| false	|
| emailValidationType 	| xs:string 	| false 	| None	|
| homeRegion	| xs:string 	| false 	| 	|

**emailValidationType Values**

| Value	| Effect 	|
| ------	| --------	|
| None 	| Perform no email validation. 	|
| EmailVerification 	| Send verification email with a link that activates the user.	|
| EmailVerificationWithPwdCollection 	| Send verification email with a link that activates the user and capture a password .	|

## Action Steps ##

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| CreateUmsUser 	| Create a new UMS User object. 	| false 	|
| CreateKmsUser 	| Create a new KMS User Account corresponding to a UMS User. 	| false 	|
| CreateKmsUserKeys 	| Create a set of KMS Keys for the specified UMS User. 	| false 	|
| CreateSalesforceContact 	| Create a new or locate an existing Salesforce Contact. 	| **true** 	|
| CreateZuoraContact 	| Create a new Contact in Zuora only if there is not one already. 	| **true** 	|

## Constraints ##

1. The UMS User and the User's Domain must be enabled. _(CreateKmsUserKeys)_
1. If Salesforce cannot be accessed than this Action Step will be retried at a future time. _(CreateSalesforceContact)_
1. If Zuora cannot be accessed than this Action Step will be retried at a future time. _(CreateZuoraContact)_

## JobTicket Results ##

1. KMS_USER holds the ID for the UserAccount created in the KMS. _(CreateKmsUser)_
1. KMS_USER_KEY holds the ID for the UserAccessKeys created in KMS. _(CreateKmsUserKeys)_
1. SALESFORCE_CONTACT will contain the Salesforce Contact ID. _(CreateSalesforceContact)_
1. ZUORA_DOMAIN_ACCOUNT will contain the Zuora Account ID. _(CreateZuoraContact)_

## Region Resolution ##
{{PRIVATE}} If homeRegion is specified in input data, then CS user, authz user grants, group refs are created in specified homeRegion. If home region is not specified in input data, then CS user and related entities are created in same region as domain's region. All user related authz grants, group ref are created in new user's region. The created user's geoRegion is passed to KMS steps (CreateKmsUser,  CreateKmsUserKeys) which is going to create related KMS entities in user's geoRegion. Currently we are not propagating region to salesforce and zuora side.

## Email Integration ##

After submission of an email a **CtrlSvcsContactActivity** Salesforce object is created with **ActvityType** set to a value from the table below.

| Templates Used	| CtrlSvcsContactActivity Type 	|
| -------------- 	| ----------------------------- 	|
| WELCOME_TO_CLOUD_EMAIL_ID 	| WelcomeEmailSent	|
| EMAIL_ENTERPRISE_VERIFICATION_EMAIL_ID 	| EmailVerifEmailSent	|
| EMAIL_ENTERPRISE_VERIFICATION_WITH_PWD_COLLECT_EMAIL_ID 	| EntVerifEmailWithPwdCollectSent	|

Email messages are stored in the database. The email template is stored under the template name. Before being sent each email is processed by replacing text of the for %keyword% with a specific value. Replacement values available in the welcome email are listed in the following table.

| Email Text 	| Replaced With 	|
| ---------- 	| -------------- 	|
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
