# CreditCardDetailsUpdated
## POST [HPKeystoneExtensionBaseURI]/action/creditcarddetailsupdated
*Privilege Level: System Admin*

This action is invoked when the user has modified their credit card details, it's primary purpose is to log the fact that the user has changed some aspect of the credit card payment data in Salesforce. It also updates the Zuora domain account and maps credit card's address to the address of billTo contact of the domain account. 

Currently this action assumes that it is invoked only when the user has entered their credit card details for the first time. Other behaviours may be added in the future.

A new Salesforce Contact.CtrlSvcsContactActivity object will be created with a type of **CreditCardDetailsEntered**.

## PrivilegeLevel ##

**System Administration, Domain Administration, Self-Service**

## Examples ##

    http://host:port/v2.0/HP-IDM/v1.0/action/creditcarddetailsupdated

## Action Parameters ##

| Parameter Name 	| Parameter Type 	| Is Required 	| Default 	|
| :------------- 	| :------------- 	| :---------- 	| :------ 	|
| sendWelcomeEmail	| xs:boolean 	| false	| false	|
| sendCreditCardDetailsEnteredEmail	| xs:boolean 	| false	| false	|
| paymentMethodId	| xs:String 	| true	| false	|

## Action Steps ##

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| LogActivityInSalesforce 	| Log the activity against the salesforce contact. 	| false 	|
| UpdateZuoraAccountBillToAddress 	| Update Zuora account's contact billTo and soldTo address 	| false 	|
| SendCreditCardDetailsEnteredEmail 	| Create a new KMS User Account corresponding to a UMS User. 	| false 	|

## Constraints ##

## JobTicket Results ##

N/A

## Email Integration ##

After submission of an email a **CtrlSvcsContactActivity** Salesforce object is created with **ActvityType** set to a value from the table below.

| Templates Used	| CtrlSvcsContactActivity Type 	|
| -------------- 	| ----------------------------- 	|
| WELCOME_TO_CLOUD_EMAIL_ID 	| WelcomeEmailSent	|
| CREDIT_CARD_DETAILS_ENTERED_EMAIL_ID 	| CreditCardDetailsEnteredEmail	|

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
