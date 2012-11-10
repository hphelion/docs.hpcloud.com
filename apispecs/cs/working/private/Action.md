# Action

This page contains information about the 8 available Action Service REST APIs.

    Post Action
    Get Jobs by Account
    Get A Job
    Restart Timed-Out Job
    Delete a Job
    Get Error Jobs
    Get a Count of Error Jobs
    Get Error Jobs by Category
    Delete Error Jobs by Category
    Get Jobs by Status
    Get Job Count by Status

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

## Post action
#### POST [HPKeystoneExtensionBaseURI]/action/{action}?timeOut=60000
Privilege Level: {Privilege Level}*

Submit an action to be executed. Each action takes a specific set of execution parameters within the content of the Post. (For an exact list of parameters for each Action, click the link below.) In the absence of any query parameters, the Action will be submitted and the call will immediately return a Job Ticket. The Job Ticket contains information about the executing Job, and can be refreshed through the job API call.
An Action request may contain the timeOut query parameter that is set to a non-zero positive value. The value indicates that the request should wait at least the given length of time for the Action to complete - either successfully or due to error. If the Action does not complete with the time period then the job is cancelled and any completed action steps will be rolled back.

Please see [Appendix A: Avaiable Actions](#available_action) for detail information on the actions.

**Request Data**

See documentation of the multifarious actions that can be posted at the Available Actions page.   Examples below are illustrative only.

**URL Parameters**

* *{action}* - String - The action for which to create a job ticket
* *{timeout}* - Long - The timeout.  Without the timeout specified the returned JobTicket would have a state of PENDING instead of COMPLETE

**Data Parameters**

The parameters are dependent on the action being posted.  See documentation under Available Actions.

JSON

```
POST https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/action/updateDomain?timeOut=60000 HTTP/1.1
X-Auth-Token: HPAuth_4e89f121318cd70066d68c2e
Date: Mon, 3 Oct 2011 11:30:10 -0600
Content-Type: application/json
User-Agent: Maxwell/Smart
Host: Pat Sajak
 
{"JobTicket": {"actionParams":{"status": "SUSPENDED_3", "domainId": "92636548281306"}}}
```

**Success Response**

**Status Code**

201 (Created)

**Response Data**

Examples below are illustrative only.  Actual results will depend on the action being posted - see documentation under Available Actions.

JSON

```
{
  "JobTicket" : {
    "action" : "UpdateDomain",
    "actionParams" : {
    },
    "actionResults" : {
      "SALESFORCE_ACCOUNT" : "001Q000000Yg8SJIAZ",
      "UMS_DOMAIN" : "92636548281306"
    },
    "completion" : "2012-10-30T16:18:03.145Z",
    "errorCategory" : "",
    "errorDescription" : "",
    "status" : "COMPLETE",
    "stepStatus" : {
      "UpdateKmsDomain" : "COMPLETE",
      "UpdateZuoraAccount" : "COMPLETE",
      "UpdateServicesForDomain" : "COMPLETE",
      "UpdateSalesforceAccount" : "COMPLETE",
      "UpdateUmsDomain" : "COMPLETE"
    },
    "submission" : "2012-10-30T16:18:01.140Z",
    "ticketId" : "508ffdb9e4b0c294a11da454"
  }
}
```


**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X POST -H 'User-Agent: Jakarta Commons-HttpClient/3.1' -H 'Content-Type: application/json' --cert <cert-path> --cacert <ca-cert-path> --data '{"JobTicket": {"actionParams":{"status": "SUSPENDED_3", "domainId": "92636548281306"}}}' -H 'X-Auth-Token: <auth-token>' [HPKeystoneExtensionBaseURI]/action/UpdateDomain?timeOut=20000
```

## Get Jobs By Account
#### GET [HPKeystoneExtensionBaseURI]/job?accountId=12345
*Privilege Level: {Privilege Level}*

Return a list of all Job Tickets submitted by the specified Account ID. 

When an Action is submitted it is not executed immediately. Instead, the Action request parameters are stored in the database within an instance of JobTicket. A JobTicket contains all of the request parameters, and also includes submission date and execution status. (Note that old JobTickets are periodically purged from the system after a configurable length of time.)

**Request Data**

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *accountId* - Long - The UMS User Id for the account

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "TicketList" : {
    "Tickets" : [ {
      "action" : "UpdateUser",
      "actionParams" : {
      },
      "actionResults" : {
        "mailToOldAddress" : "dkennedy@hp.com",
        "accountId" : "60809900579962",
        "mailToNewAddress" : "david.kennedy@hp.com",
        "SALESFORCE_CONTACT" : "003Q000000a25LNIAY",
        "emailed" : "EMAIL_UPDATED_EMAIL_ID:dkennedy@hp.com,EMAIL_UPDATED_EMAIL_ID:david.kennedy@hp.com"
      },
      "completion" : "2012-10-30T10:19:44.435Z",
      "errorCategory" : "",
      "errorDescription" : "",
      "status" : "COMPLETE",
      "stepStatus" : {
        "UpdateZuoraContact" : "COMPLETE",
        "SendEmailUpdateEmails" : "COMPLETE",
        "UpdateSalesforceContact" : "COMPLETE",
        "UpdateUmsUser" : "COMPLETE",
        "UpdateKmsUser" : "COMPLETE"
      },
      "submission" : "2012-10-30T10:19:40.590Z",
      "ticketId" : "508fa9bce4b0c294a11da398"
    } ]
  }
}
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k -s -S --connect-timeout 2 --noproxy 127.0.0.1,localhost,hpcloud.net -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job?accountId=60809900579962
```

## Get A Job Ticket
#### GET [HPKeystoneExtensionBaseURI]/job/{ticketId}
*Privilege Level: {Privilege Level}*

This call will return the specified Job Ticket, and will optionally block the caller until the Job Ticket is marked as complete.

This request accepts a query parameter, "timeOut", that specifies the length of time in milliseconds to wait until the given Job Ticket is marked as complete. If the "timeOut" query parameter is not present or is set to zero then the call will return immediately with the current state of the Action Job.

**Request Data**

**URL Parameters**

* *ticketId* - 24 digit hex - The id of the ticket to be retrieved.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "JobTicket" : {
    "action" : "ActivateService",
    "actionError" : {
      "category" : "PROVISIONING",
      "httpErrorCode" : 404,
      "message" : "Registered Service [ComputeERROR] not found.",
      "retryable" : false,
      "stackTrace" : [ {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
        "fileName" : "ActionStepBase.java",
        "lineNumber" : 548,
        "methodName" : "validateZuoraProduct"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
        "fileName" : "ActionStepBase.java",
        "lineNumber" : 517,
        "methodName" : "loadProduct"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription",
        "fileName" : "CreateZuoraSubscription.java",
        "lineNumber" : 24,
        "methodName" : "initializeAndValidate"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
        "fileName" : "ActionBase.java",
        "lineNumber" : 361,
        "methodName" : "executeAction"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
        "fileName" : "ActivateService.java",
        "lineNumber" : 46,
        "methodName" : "executeAction_aroundBody0"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
        "fileName" : "ActivateService.java",
        "lineNumber" : 45,
        "methodName" : "executeAction"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
        "fileName" : "ActionBase.java",
        "lineNumber" : 325,
        "methodName" : "run"
      }, {
        "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
        "fileName" : "ThreadPoolExecutor.java",
        "lineNumber" : 886,
        "methodName" : "runTask"
      }, {
        "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
        "fileName" : "ThreadPoolExecutor.java",
        "lineNumber" : 908,
        "methodName" : "run"
      }, {
        "declaringClass" : "java.lang.Thread",
        "fileName" : "Thread.java",
        "lineNumber" : 662,
        "methodName" : "run"
      } ]
    },
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : "2012-10-29T09:57:58.552Z",
    "errorCategory" : "PROVISIONING",
    "errorDescription" : "Registered Service [ComputeERROR] not found.",
    "status" : "ERROR",
    "stepStatus" : {
      "CreateZuoraSubscription" : "PENDING",
      "ProvisionService" : "PENDING",
      "FindOrCreateUmsTenant" : "PENDING"
    },
    "submission" : "2012-10-29T09:57:57.082Z",
    "ticketId" : "508e5325e4b02ace8d0d20e6"
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<JobTicket>
	<actionParams />
	<stepStatus>
		<entry>
			<key>CreateZuoraSubscription</key>
			<value>PENDING</value>
		</entry>
		<entry>
			<key>ProvisionService</key>
			<value>PENDING</value>
		</entry>
		<entry>
			<key>FindOrCreateUmsTenant</key>
			<value>PENDING</value>
		</entry>
	</stepStatus>
	<actionResults />
	<action>ActivateService</action>
	<actionError>
		<category>PROVISIONING</category>
		<httpErrorCode>404</httpErrorCode>
		<message>Registered Service [ComputeERROR] not found.</message>
		<retryable>false</retryable>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
			</declaringClass>
			<fileName>ActionStepBase.java</fileName>
			<lineNumber>548</lineNumber>
			<methodName>validateZuoraProduct</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
			</declaringClass>
			<fileName>ActionStepBase.java</fileName>
			<lineNumber>517</lineNumber>
			<methodName>loadProduct</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription
			</declaringClass>
			<fileName>CreateZuoraSubscription.java</fileName>
			<lineNumber>24</lineNumber>
			<methodName>initializeAndValidate</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
			</declaringClass>
			<fileName>ActionBase.java</fileName>
			<lineNumber>361</lineNumber>
			<methodName>executeAction</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
			</declaringClass>
			<fileName>ActivateService.java</fileName>
			<lineNumber>46</lineNumber>
			<methodName>executeAction_aroundBody0</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
			</declaringClass>
			<fileName>ActivateService.java</fileName>
			<lineNumber>45</lineNumber>
			<methodName>executeAction</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
			</declaringClass>
			<fileName>ActionBase.java</fileName>
			<lineNumber>325</lineNumber>
			<methodName>run</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
			</declaringClass>
			<fileName>ThreadPoolExecutor.java</fileName>
			<lineNumber>886</lineNumber>
			<methodName>runTask</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
			</declaringClass>
			<fileName>ThreadPoolExecutor.java</fileName>
			<lineNumber>908</lineNumber>
			<methodName>run</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>java.lang.Thread</declaringClass>
			<fileName>Thread.java</fileName>
			<lineNumber>662</lineNumber>
			<methodName>run</methodName>
		</stackTrace>
	</actionError>
	<completion>2012-10-29T09:57:58.552Z</completion>
	<errorCategory>PROVISIONING</errorCategory>
	<errorDescription>Registered Service [ComputeERROR] not found.
	</errorDescription>
	<status>ERROR</status>
	<submission>2012-10-29T09:57:57.082Z</submission>
	<ticketId>508e5325e4b02ace8d0d20e6</ticketId>
</JobTicket>
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/{ticketId}
```

## Restart a TIMEDOUT Job
#### PUT [HPKeystoneExtensionBaseURI]/job/{ticketId}
*Privilege Level: {Privilege Level}*

Some Actions contain Steps that are retryable. Examples are calls to Zuora or Salesforce, which might fail due to internet connectivity issues. These steps contain a retry count the determines how many times they should re-attempt execution. Once all retries have been used up the Step and the Action are tagged with the TIMEDOUT status.

This API resets an Action and its Steps from TIMEDOUT to RETRY. This will cause the job to be executed again.

**Request Data**

**URL Parameters**

* *{ticketId}* - 24 digit hex - The id of the ticket to be retrieved.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 508
Date: Thu, 06 Oct 2011 16:38:15 GMT
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k -s -S --connect-timeout 2 --noproxy 127.0.0.1,localhost,hpcloud.net -m 30 -X PUT -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: HPAuth_07ea10efcbcd4a16441f45c7b4bc7aad0a657688576ec67a55ee6e2f00eea8b8" [HPKeystoneExtensionBaseURI]/job/508fa9bce4b0c294a11da398
```

## Delete a Job
#### DELETE HPKeystoneExtensionBaseURI/job/{ticketId}
*Privilege Level: {Privilege Level}*

This API call deletes a specified Job Ticket.

Job Tickets for Actions which complete successfully are eventually removed from the system. But Actions which fail must have their Job Tickets manually deleted using this API call.

**Request Data**

```
DELETE https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/4e8c7849318cf2e142e76ef4 HTTP/1.1
X-Auth-Token: HPAuth_4e8c7849318cf2e142e76ef1
Date: Wed, 5 Oct 2011 09:31:28 -0600
User-Agent: Maxwell/Smart
Host: Pat Sajak
```

**URL Parameters**

* *ticketId* - Long - The id of the ticket to be deleted

**Data Parameters**

This call does not require a request body.

**Success Response**

204 - OK

**Response Data**

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 05 Oct 2011 15:31:25 GMT
```

**Error Response**

400 (Bad Request)               Malformed request in URI or request body.
401 (Unauthorized)              The caller does not have the privilege required to perform the operation.
403 (Forbidden)                 Disabled or suspended user making the request.
500 (Internal Server Error)     The server encountered a problem while processing the request.
503 (Service Unavailable)       The server is unavailable to process the request.

**Curl Example**

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X DELETE -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/{ticketId}
```

## Get Error Jobs
#### GET [HPKeystoneExtensionBaseURI]/job/error
*Privilege Level: {Privilege Level}*

Return a list of all Job Tickets that are in the ERROR or CANCELLED state.

**Request Data**

This call requires no data.

**URL Parameters**

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "TicketList" : {
    "Tickets" : [ {
      "action" : "ActivateService",
      "actionError" : {
        "category" : "PROVISIONING",
        "httpErrorCode" : 404,
        "message" : "Registered Service [ComputeERROR] not found.",
        "retryable" : false,
        "stackTrace" : [ {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
          "fileName" : "ActionStepBase.java",
          "lineNumber" : 548,
          "methodName" : "validateZuoraProduct"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
          "fileName" : "ActionStepBase.java",
          "lineNumber" : 517,
          "methodName" : "loadProduct"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription",
          "fileName" : "CreateZuoraSubscription.java",
          "lineNumber" : 24,
          "methodName" : "initializeAndValidate"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 361,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
          "fileName" : "ActivateService.java",
          "lineNumber" : 46,
          "methodName" : "executeAction_aroundBody0"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
          "fileName" : "ActivateService.java",
          "lineNumber" : 45,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 325,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 886,
          "methodName" : "runTask"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 908,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.lang.Thread",
          "fileName" : "Thread.java",
          "lineNumber" : 662,
          "methodName" : "run"
        } ]
      },
      "actionParams" : {
      },
      "actionResults" : {
      },
      "completion" : "2012-10-29T09:57:58.552Z",
      "errorCategory" : "PROVISIONING",
      "errorDescription" : "Registered Service [ComputeERROR] not found.",
      "status" : "ERROR",
      "stepStatus" : {
        "CreateZuoraSubscription" : "PENDING",
        "ProvisionService" : "PENDING",
        "FindOrCreateUmsTenant" : "PENDING"
      },
      "submission" : "2012-10-29T09:57:57.082Z",
      "ticketId" : "508e5325e4b02ace8d0d20e6"
    }, {
      "action" : "ActivateService",
      "actionError" : {
        "category" : "PROVISIONING",
        "httpErrorCode" : 404,
        "message" : "Registered Service [ComputeERROR] not found.",
        "retryable" : false,
        "stackTrace" : [ {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
          "fileName" : "ActionStepBase.java",
          "lineNumber" : 548,
          "methodName" : "validateZuoraProduct"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
          "fileName" : "ActionStepBase.java",
          "lineNumber" : 517,
          "methodName" : "loadProduct"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription",
          "fileName" : "CreateZuoraSubscription.java",
          "lineNumber" : 24,
          "methodName" : "initializeAndValidate"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 361,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
          "fileName" : "ActivateService.java",
          "lineNumber" : 46,
          "methodName" : "executeAction_aroundBody0"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
          "fileName" : "ActivateService.java",
          "lineNumber" : 45,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 325,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 886,
          "methodName" : "runTask"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 908,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.lang.Thread",
          "fileName" : "Thread.java",
          "lineNumber" : 662,
          "methodName" : "run"
        } ]
      },
      "actionParams" : {
      },
      "actionResults" : {
      },
      "completion" : "2012-10-29T10:00:14.231Z",
      "errorCategory" : "PROVISIONING",
      "errorDescription" : "Registered Service [ComputeERROR] not found.",
      "status" : "ERROR",
      "stepStatus" : {
        "CreateZuoraSubscription" : "PENDING",
        "ProvisionService" : "PENDING",
        "FindOrCreateUmsTenant" : "PENDING"
      },
      "submission" : "2012-10-29T10:00:12.917Z",
      "ticketId" : "508e53ace4b02ace8d0d20f7"
    } ]
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<TicketList>
	<Tickets>
		<actionParams />
		<stepStatus>
			<entry>
				<key>CreateZuoraSubscription</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>ProvisionService</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>FindOrCreateUmsTenant</key>
				<value>PENDING</value>
			</entry>
		</stepStatus>
		<actionResults />
		<action>ActivateService</action>
		<actionError>
			<category>PROVISIONING</category>
			<httpErrorCode>404</httpErrorCode>
			<message>Registered Service [ComputeERROR] not found.</message>
			<retryable>false</retryable>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
				</declaringClass>
				<fileName>ActionStepBase.java</fileName>
				<lineNumber>548</lineNumber>
				<methodName>validateZuoraProduct</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
				</declaringClass>
				<fileName>ActionStepBase.java</fileName>
				<lineNumber>517</lineNumber>
				<methodName>loadProduct</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription
				</declaringClass>
				<fileName>CreateZuoraSubscription.java</fileName>
				<lineNumber>24</lineNumber>
				<methodName>initializeAndValidate</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>361</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
				</declaringClass>
				<fileName>ActivateService.java</fileName>
				<lineNumber>46</lineNumber>
				<methodName>executeAction_aroundBody0</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
				</declaringClass>
				<fileName>ActivateService.java</fileName>
				<lineNumber>45</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>325</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>886</lineNumber>
				<methodName>runTask</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>908</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.lang.Thread</declaringClass>
				<fileName>Thread.java</fileName>
				<lineNumber>662</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
		</actionError>
		<completion>2012-10-29T09:57:58.552Z</completion>
		<errorCategory>PROVISIONING</errorCategory>
		<errorDescription>Registered Service [ComputeERROR] not found.
		</errorDescription>
		<status>ERROR</status>
		<submission>2012-10-29T09:57:57.082Z</submission>
		<ticketId>508e5325e4b02ace8d0d20e6</ticketId>
	</Tickets>
	<Tickets>
		<actionParams />
		<stepStatus>
			<entry>
				<key>CreateZuoraSubscription</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>ProvisionService</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>FindOrCreateUmsTenant</key>
				<value>PENDING</value>
			</entry>
		</stepStatus>
		<actionResults />
		<action>ActivateService</action>
		<actionError>
			<category>PROVISIONING</category>
			<httpErrorCode>404</httpErrorCode>
			<message>Registered Service [ComputeERROR] not found.</message>
			<retryable>false</retryable>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
				</declaringClass>
				<fileName>ActionStepBase.java</fileName>
				<lineNumber>548</lineNumber>
				<methodName>validateZuoraProduct</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
				</declaringClass>
				<fileName>ActionStepBase.java</fileName>
				<lineNumber>517</lineNumber>
				<methodName>loadProduct</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription
				</declaringClass>
				<fileName>CreateZuoraSubscription.java</fileName>
				<lineNumber>24</lineNumber>
				<methodName>initializeAndValidate</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>361</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
				</declaringClass>
				<fileName>ActivateService.java</fileName>
				<lineNumber>46</lineNumber>
				<methodName>executeAction_aroundBody0</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
				</declaringClass>
				<fileName>ActivateService.java</fileName>
				<lineNumber>45</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>325</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>886</lineNumber>
				<methodName>runTask</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>908</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.lang.Thread</declaringClass>
				<fileName>Thread.java</fileName>
				<lineNumber>662</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
		</actionError>
		<completion>2012-10-29T10:00:14.231Z</completion>
		<errorCategory>PROVISIONING</errorCategory>
		<errorDescription>Registered Service [ComputeERROR] not found.
		</errorDescription>
		<status>ERROR</status>
		<submission>2012-10-29T10:00:12.917Z</submission>
		<ticketId>508e53ace4b02ace8d0d20f7</ticketId>
	</Tickets>
</TicketList>
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-excpetions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/error
```

## Get a Count of Error Jobs
#### GET [HPKeystoneExtensionBaseURI]/job/error/count
*Privilege Level: {Privilege Level}*

Return a count of all error job tickets in the database. Error tickets have a status of either ERROR or TIMEDOUT.

**Request Data**

The call does not require any parameters.

**URL Parameters**

**Data Parameters**

This call does not require a request body.

**Success Response**

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: text/plain
Transfer-Encoding: chunked
Date: Thu, 06 Oct 2011 16:12:00 GMT
 
7
```

**Status Code**

200 - OK

**Response Data**

```
48
```

**Error Response**

400 (Bad Request)               Malformed request in URI or request body.
401 (Unauthorized)              The caller does not have the privilege required to perform the operation.
403 (Forbidden)                 Disabled or suspended user making the request.
500 (Internal Server Error)     The server encountered a problem while processing the request.
503 (Service Unavailable)       The server is unavailable to process the request.

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Curl Example**

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/error/count
```
## Get Error Jobs by Category
#### GET [HPKeystoneExtensionBaseURI]/job/error/{category}
*Privilege Level: {Privilege Level}*

Job Tickets that are in the ERROR state will have an Action Exception attached to them. Action Exceptions are categorize, and can be retrieved or delete in bulk by category. This API is used to retreive all ERROR action jobs whose Action Exceptions are of a specified category. The list of all categories is found on the Action Exception page.

**Request Data**

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *category* - String - The category of errors to get.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "TicketList" : {
    "Tickets" : [ {
      "action" : "EnterpriseUserEmailVerification",
      "actionError" : {
        "category" : "USER_INPUT",
        "httpErrorCode" : 400,
        "message" : "Missing required parameter [PASSWORD]",
        "retryable" : false,
        "stackTrace" : [ {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ums.ValidateEmailVerificationNonce",
          "fileName" : "ValidateEmailVerificationNonce.java",
          "lineNumber" : 36,
          "methodName" : "initializeAndValidate"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 361,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.EnterpriseUserEmailVerification",
          "fileName" : "EnterpriseUserEmailVerification.java",
          "lineNumber" : 76,
          "methodName" : "executeAction_aroundBody2"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.EnterpriseUserEmailVerification",
          "fileName" : "EnterpriseUserEmailVerification.java",
          "lineNumber" : 75,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 325,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 886,
          "methodName" : "runTask"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 908,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.lang.Thread",
          "fileName" : "Thread.java",
          "lineNumber" : 662,
          "methodName" : "run"
        } ]
      },
      "actionParams" : {
      },
      "actionResults" : {
      },
      "completion" : "2012-10-29T14:21:10.641Z",
      "errorCategory" : "USER_INPUT",
      "errorDescription" : "Missing required parameter [PASSWORD]",
      "status" : "ERROR",
      "stepStatus" : {
        "ActivateUmsUser" : "PENDING",
        "UpdateSalesforceContact" : "PENDING",
        "ValidateEmailVerificationNonce" : "PENDING",
        "SendWelcomeEmail" : "PENDING",
        "UpdateKmsUser" : "PENDING"
      },
      "submission" : "2012-10-29T14:21:10.621Z",
      "ticketId" : "508e90d6e4b02ace8d0d2525"
    }, {
      "action" : "ForgotPasswordReset",
      "actionError" : {
        "category" : "USER_INPUT",
        "httpErrorCode" : 403,
        "message" : "domain is in state: SUSPENDED_3",
        "retryable" : false,
        "stackTrace" : [ {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser",
          "fileName" : "ForgotPasswordResetOnUmsUser.java",
          "lineNumber" : 56,
          "methodName" : "checkOperationPermitted"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser",
          "fileName" : "ForgotPasswordResetOnUmsUser.java",
          "lineNumber" : 29,
          "methodName" : "doExecuteStep_aroundBody0"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser",
          "fileName" : "ForgotPasswordResetOnUmsUser.java",
          "lineNumber" : 26,
          "methodName" : "doExecuteStep"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
          "fileName" : "ActionStepBase.java",
          "lineNumber" : 179,
          "methodName" : "executeStep"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 383,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ForgotPasswordReset",
          "fileName" : "ForgotPasswordReset.java",
          "lineNumber" : 45,
          "methodName" : "executeAction_aroundBody0"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ForgotPasswordReset",
          "fileName" : "ForgotPasswordReset.java",
          "lineNumber" : 44,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 325,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 886,
          "methodName" : "runTask"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 908,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.lang.Thread",
          "fileName" : "Thread.java",
          "lineNumber" : 662,
          "methodName" : "run"
        } ]
      },
      "actionParams" : {
      },
      "actionResults" : {
      },
      "completion" : "2012-10-29T14:22:09.475Z",
      "errorCategory" : "USER_INPUT",
      "errorDescription" : "domain is in state: SUSPENDED_3",
      "status" : "ERROR",
      "stepStatus" : {
        "ForgotPasswordResetOnUmsUser" : "ERROR",
        "SendForgotPasswordResetEmail" : "PENDING"
      },
      "submission" : "2012-10-29T14:22:09.239Z",
      "ticketId" : "508e9111e4b02ace8d0d258b"
    } ]
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<TicketList>
	<Tickets>
		<actionParams />
		<stepStatus>
			<entry>
				<key>ActivateUmsUser</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>UpdateSalesforceContact</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>ValidateEmailVerificationNonce</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>SendWelcomeEmail</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>UpdateKmsUser</key>
				<value>PENDING</value>
			</entry>
		</stepStatus>
		<actionResults />
		<action>EnterpriseUserEmailVerification</action>
		<actionError>
			<category>USER_INPUT</category>
			<httpErrorCode>400</httpErrorCode>
			<message>Missing required parameter [PASSWORD]</message>
			<retryable>false</retryable>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ums.ValidateEmailVerificationNonce
				</declaringClass>
				<fileName>ValidateEmailVerificationNonce.java</fileName>
				<lineNumber>36</lineNumber>
				<methodName>initializeAndValidate</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>361</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.EnterpriseUserEmailVerification
				</declaringClass>
				<fileName>EnterpriseUserEmailVerification.java</fileName>
				<lineNumber>76</lineNumber>
				<methodName>executeAction_aroundBody2</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.EnterpriseUserEmailVerification
				</declaringClass>
				<fileName>EnterpriseUserEmailVerification.java</fileName>
				<lineNumber>75</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>325</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>886</lineNumber>
				<methodName>runTask</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>908</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.lang.Thread</declaringClass>
				<fileName>Thread.java</fileName>
				<lineNumber>662</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
		</actionError>
		<completion>2012-10-29T14:21:10.641Z</completion>
		<errorCategory>USER_INPUT</errorCategory>
		<errorDescription>Missing required parameter [PASSWORD]
		</errorDescription>
		<status>ERROR</status>
		<submission>2012-10-29T14:21:10.621Z</submission>
		<ticketId>508e90d6e4b02ace8d0d2525</ticketId>
	</Tickets>
	<Tickets>
		<actionParams />
		<stepStatus>
			<entry>
				<key>ForgotPasswordResetOnUmsUser</key>
				<value>ERROR</value>
			</entry>
			<entry>
				<key>SendForgotPasswordResetEmail</key>
				<value>PENDING</value>
			</entry>
		</stepStatus>
		<actionResults />
		<action>ForgotPasswordReset</action>
		<actionError>
			<category>USER_INPUT</category>
			<httpErrorCode>403</httpErrorCode>
			<message>domain is in state: SUSPENDED_3</message>
			<retryable>false</retryable>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser
				</declaringClass>
				<fileName>ForgotPasswordResetOnUmsUser.java</fileName>
				<lineNumber>56</lineNumber>
				<methodName>checkOperationPermitted</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser
				</declaringClass>
				<fileName>ForgotPasswordResetOnUmsUser.java</fileName>
				<lineNumber>29</lineNumber>
				<methodName>doExecuteStep_aroundBody0</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser
				</declaringClass>
				<fileName>ForgotPasswordResetOnUmsUser.java</fileName>
				<lineNumber>26</lineNumber>
				<methodName>doExecuteStep</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
				</declaringClass>
				<fileName>ActionStepBase.java</fileName>
				<lineNumber>179</lineNumber>
				<methodName>executeStep</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>383</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ForgotPasswordReset
				</declaringClass>
				<fileName>ForgotPasswordReset.java</fileName>
				<lineNumber>45</lineNumber>
				<methodName>executeAction_aroundBody0</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ForgotPasswordReset
				</declaringClass>
				<fileName>ForgotPasswordReset.java</fileName>
				<lineNumber>44</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>325</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>886</lineNumber>
				<methodName>runTask</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>908</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.lang.Thread</declaringClass>
				<fileName>Thread.java</fileName>
				<lineNumber>662</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
		</actionError>
		<completion>2012-10-29T14:22:09.475Z</completion>
		<errorCategory>USER_INPUT</errorCategory>
		<errorDescription>domain is in state: SUSPENDED_3</errorDescription>
		<status>ERROR</status>
		<submission>2012-10-29T14:22:09.239Z</submission>
		<ticketId>508e9111e4b02ace8d0d258b</ticketId>
	</Tickets>
</TicketList>
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-excpetions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/error/USER_INPUT
```

## Delete Error Jobs by Category
#### DELETE HPKeystoneExtensionBaseURI/job/error/{category}
*Privilege Level: {Privilege Level}*

Job Tickets that are in the ERROR state will have an Action Exception attached to them. Action Exceptions are categorized, and can be retrieved or delete in bulk by category. This API is used to delete all ERROR action jobs whose Action Exceptions are of a specified category. The list of all categories is found on the Action Exception page.

**Request Data**

```
DELETE https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/USER_INPUT HTTP/1.1
X-Auth-Token: HPAuth_4e8c7849318cf2e142e76ef1
Date: Wed, 5 Oct 2011 09:31:28 -0600
User-Agent: Maxwell/Smart
Host: Pat Sajak
```

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{category}* - String - See the action exception page.

**Data Parameters**

This call does not require a request body.

**Success Response**

204 - OK

**Response Data**


**Error Response**

* 400 (Bad Request) 		Malformed request in URI or request body.
* 401 (Unauthorized)		The caller does not have the privilege required to perform the operation.
* 403 (Forbidden)		Disabled or suspended user making the request.
* 500 (Internal Server Error) 	The server encountered a problem while processing the request.
* 503 (Service Unavailable)	The server is unavailable to process the request.

**Response Data**

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 05 Oct 2011 15:31:25 GMT
```

**Curl Example**

```
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

## Get Jobs By Status
#### GET [HPKeystoneExtensionBaseURI]/job/status/{status}
*Privilege Level: {Privilege Level}*

Return all Job Tickets from the database which have the given status value. The Action Page provides a list of all possible status values.

**Request Data**

**URL Parameters**

* *{status}* - Job status - 
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{
  "TicketList" : {
    "Tickets" : [ {
      "action" : "UserNameRecovery",
      "actionParams" : {
      },
      "actionResults" : {
        "emailed" : "USERNAME_RECOVERY_EMAIL_ID:dkennedy@hp.com"
      },
      "completion" : "2012-10-30T08:45:52.842Z",
      "errorCategory" : "",
      "errorDescription" : "",
      "status" : "COMPLETE",
      "stepStatus" : {
        "SendUserNameRecoveryEmail" : "COMPLETE"
      },
      "submission" : "2012-10-29T17:28:53.089Z",
      "ticketId" : "508ebcd52cdc77bc0f3990bd"
    }, {
      "action" : "SelfRegistration",
      "actionParams" : {
      },
      "actionResults" : {
        "SALESFORCE_ACCOUNT" : "001Q000000Yg7gWIAR",
        "KMS_TENANT" : "28117301830361",
        "SALESFORCE_CONTACT" : "003Q000000a25LNIAY",
        "UMS_USER" : "60809900579962",
        "ZUORA_DOMAIN_ACCOUNT" : "2c92c0f93aaaf209013ab12f47ce1720",
        "emailed" : "WELCOME_TO_CLOUD_EMAIL_ID:dkennedy@hp.com",
        "KMS_USER_KEY" : "ADXJR934XW5NHK7H92TF",
        "KMS_USER" : "60809900579962",
        "UMS_DOMAIN" : "28117301830361",
        "KMS_SECRET_KEY" : "v7QPZBeLiOX+OB3VncGlCMDGsAkI4whsEPvjDft+"
      },
      "completion" : "2012-10-30T10:19:38.466Z",
      "errorCategory" : "",
      "errorDescription" : "",
      "status" : "COMPLETE",
      "stepStatus" : {
        "CreateKmsUserKeys" : "COMPLETE",
        "CreateZuoraAccountAndContact" : "COMPLETE",
        "CreateKmsDomain" : "COMPLETE",
        "CreateUmsUserAndDomain" : "COMPLETE",
        "SendWelcomeEmail" : "COMPLETE",
        "CreateSalesforceContactAndAccount" : "COMPLETE",
        "CreateKmsUser" : "COMPLETE"
      },
      "submission" : "2012-10-30T10:19:24.505Z",
      "ticketId" : "508fa9ace4b0c294a11da38a"
    }, {
      "action" : "UpdateUser",
      "actionParams" : {
      },
      "actionResults" : {
        "mailToOldAddress" : "dkennedy@hp.com",
        "accountId" : "60809900579962",
        "mailToNewAddress" : "david.kennedy@hp.com",
        "SALESFORCE_CONTACT" : "003Q000000a25LNIAY",
        "emailed" : "EMAIL_UPDATED_EMAIL_ID:dkennedy@hp.com,EMAIL_UPDATED_EMAIL_ID:david.kennedy@hp.com"
      },
      "completion" : "2012-10-30T10:19:44.435Z",
      "errorCategory" : "",
      "errorDescription" : "",
      "status" : "COMPLETE",
      "stepStatus" : {
        "UpdateZuoraContact" : "COMPLETE",
        "SendEmailUpdateEmails" : "COMPLETE",
        "UpdateSalesforceContact" : "COMPLETE",
        "UpdateUmsUser" : "COMPLETE",
        "UpdateKmsUser" : "COMPLETE"
      },
      "submission" : "2012-10-30T10:19:40.590Z",
      "ticketId" : "508fa9bce4b0c294a11da398"
    } ]
  }
}
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exceptions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/status/COMPLETE
```

## Get Job Count by Status
#### GET [HPKeystoneExtensionBaseURI]/job/status/{status}/count
*Privilege Level: {Privilege Level}*

Return a count of all Job Tickets from the database which have the given status value. The Action Page provides a list of all possible status values.

**Request Data**

**URL Parameters**

* *{status}* - String - The status of the tasks required

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
26
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exceptions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/status/COMPLETE/count
```


