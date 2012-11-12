# UpdateUser

## Description ##

Update the properties of the specified User. Property changes are propagated to all internal (UMS, KMS) and external (Salesforce) services.

In addition to set simple property values, the UpdateUser action can also set the status for a User. Now, update in password value is not allowed through 'UpdateUser' action. You will need to use UMS operation for password change.

If the user modified their email address then a notification email to the old and new address.

| Status Value 	| Privilege Level 	| Description 	|
| -- 	| -- 	| -- 	|
| ENABLED 	| SA 	| Default state to an active user. 	|
| DISABLED 	| DA 	| Disabled users can not log into their accounts. 	|
| SUSPENDED_3 	| SA 	| Disabled users can not log into their accounts. Can be re-ENABLED only by SA. 	|
| DELETED 	| SA 	| Soft delete. User data is not purged. Can be re-ENABLED only by SA. 	|



## PrivilegeLevel ##

**System Administration, Domain Administration, Self-Service**

## Examples ##

	POST http://host:port/v2.0/HP-IDM/v1.0/action/updateuser HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	Content-Length: 512
	{ "JobTicket" : {
		"actionParams" : {
      		"accountId":"44386614938865",
      		"firstName":"Kermit",
      		"lastName":"Melling"
      		"emailAddress":"kermit.melling@hp.com"
    		}
    	}
    }

	POST http://host:port/v2.0/HP-IDM/v1.0/action/updateuser HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	Content-Length: 512

	{ "JobTicket" : {
		"actionParams" : {
      		"status":"DISABLED",
    		}
		}
	}

## Action Parameters ##

| Parameter Name	| Parameter Type	| Is Required 	|
| -----------	| ------------------	| -------------	|
| state 	| xs:string 	| false 	|
| status 	| xs:string 	| false 	|
| password **DISALLOWED**	| 	| 	|
| accountId 	| xs:string 	| **true**	|
| addressLine1 	| xs:string 	| false 	|
| addressLine2 	| xs:string 	| false 	|
| city 	| xs:string 	| false 	|
| zip 	| xs:string 	| false 	|
| country 	| xs:string 	| false 	|
| phone 	| xs:string 	| false 	|
| company 	| xs:string 	| false 	|
| website 	| xs:string 	| false 	|
| emailAddress 	| xs:string 	| false 	|
| username 	| xs:string 	| false 	|
| firstName 	| xs:string 	| false 	|
| lastName 	| xs:string 	| false 	|
| ipAddress 	| xs:string 	| false 	|
| promoCode 	| xs:string 	| false	|
| partnerCode 	| xs:string 	| false	|
| riskScore 	| xs:int 	| false 	|
| phoneInBillingLocation 	| xs:string 	| false 	|
| ipBillingDistance 	| xs:int 	| false 	|
| ipCity 	| xs:string 	| false 	|
| ipRegion 	| xs:string 	| false 	|
| ipCountry 	| xs:string 	| false 	|
| anonymousProxy 	| xs:boolean 	| false 	|
| proxyScore 	| xs:int 	| false 	|
| transparentProxy 	| xs:boolean 	| false 	|
| corporateProxy 	| xs:boolean 	| false 	|
| highRiskCountry 	| xs:boolean 	| false 	|
| highRiskEmail 	| xs:boolean 	| false 	|
| homeRegion 	| xs:string 	| false 	|

## Action Steps ##
| Step Name 	| Step Description 	| Is Retryable 	|
| -- 	| -- 	|
| UpdateUmsUser 	| Update the property values for a given User in the UMS. 	| false 	|
| UpdateKmsUser 	| Update the state of a KMS User to match that of the UMS. 	| false 	|
| UpdateSalesforceContact 	| Update the appropriate Salesforce "Contact" object to match the UMS properties. 	| true 	|
| UpdateZuoraContact 	| If the given UMS User is also a Zuora Contact, then update the corresponding Zuora Contact with all the current User properties. By default, only the Domain Admin has a corresponding Zuora Contact. 	| true 	|
| SendEmailUpdateEmails 	| If the UMS user has modified their email address then send a notification email to the old and new email address. \\ 	| true 	|

## Constraints ##

1. The user "status" value can only be updated by the SA or DA. _UpdateUmsUser_
1. Once a KMS User and Keys is marked as deleted it cannot be reenabled. _UpdateKmsUser_
1. Action is ignored if UMS User has no BillingID. _UpdateZuoraContact_

## JobTicket Results ##

1. Following execution the KMS User ID will be stored in the KMS_USER field. _UpdateKmsUser_
1. Following execution the SF ContactID will be stored in the SALESFORCE_CONTACT field. _UpdateSalesforceContact_
1. If the users email address was changed then **mailToOldAddress** and **mailToNewAddress** will be set to the respective addresses.

## Email Update Email ##

If the user changes their email address then a confirmation is sent to both the old and new address. Email messages are stored in the database. The email update email is stored under the identifier **"EMAIL_UPDATED_EMAIL_ID"**. Before being sent each email is processed by replacing text of the for %<keyword>% with a specific value. Replacement values available in the welcome email are listed in the following table.

| Email Text 	| Replaced With 	|
| -- 	| -- 	|
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

After submission of a each email a **CtrlSvcsContactActivity** Salesforce object is created. The first with **ActvityType**="EmailUpdatedToOldAddress", the second with **ActvityType**="EmailUpdatedToNewAddress".