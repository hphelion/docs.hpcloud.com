##  ForgotPasswordReset
#### POST [HPKeystoneExtensionBaseURI]/action/ForgotPasswordReset
*Privilege Level: Anonymous*  
 
*Constraints:*  

None

This action causes a reset password email to be sent to the user specified by the username parameter. The nonce and passwordResetTime are set in the database and the nonce sent in a templated email to the users registered address.


**Request Data**  

**URL Parameters**

None

**Data Parameters**

| Parameter Name	| Parameter Type	| Is Required	|
| :--------------	| :--------------	| :-----------	|
| username	| xs:string	| true	|

XML

```
POST http://host:port/v2.0/HP-IDM/v1.0/action/ForgotPasswordReset HTTP/1.1
Accept: application/json
Content-Type: application/xml
User-Agent: Exploder 12.3
Host: localhost:9999
Connection: keep-alive

<JobTicket>
  <actionParams>
    <entry><key>username</key><value>demouser</value></entry>
  </actionParams>
</JobTicket>
```

**Success Response**

**Status Code**

TBD

**Response Data**

No parameters are returned since the nonce is in the email and shouldn't be returned to the user by any other means.

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

| Step Name	| Step Description	| Is Retryable	|
| :---------	| :---------------	| :------------	|
| ForgotPasswordResetOnUmsUser	| Set a nonce in the UMS User and set passwordResetTime to the current time	| true	|
| SendForgotPasswordResetEmail	| Send the nonce to the user in a templated email.	| true	|

##Email Integration##

After submission of an email a **CtrlSvcsContactActivity** Salesforce object is created with **ActvityType** set to a value from the table below.

| Templates Used	| CtrlSvcsContactActivity Type 	|
| -------------- 	| ---------------------------- 	|
| PASSWORD_RESET_EMAIL_ID 	| PasswordRecoveryEmail	|

Email messages are stored in the database. The email template is stored under the template name. Before being sent each email is processed by replacing text of the for %keyword% with a specific value. Replacement values available in the welcome email are listed in the following table.

| Email Text 	| Replaced With 	|
| ---------- 	| --------------	|
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
