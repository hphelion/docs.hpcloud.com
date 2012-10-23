---  
title : Action Operations

---  

**Post Action **
----------------
**POST**

***[HPKeystoneExtensionBaseURI]/action/{action}?timeOut=60000***

Submit an action request for execution. Return a job ticket.

#### **Detailed Description**

Submit an action to be executed. Each action takes a specific set of
execution parameters within the content of the Post. *(For an exact list
of parameters for each Action, click the link below.)* In the absence of
any query parameters, the Action will be submitted and the call will
immediately return a Job Ticket. The Job Ticket contains information
about the executing Job, and can be refreshed through the
[job](#ActionOperations-GetJob) API call.

An Action request may contain the timeOut query parameter that is set to
a non-zero positive value. The value indicates that the request should
wait at least the given length of time for the Action to complete -
either successfully or due to error. If the Action does not complete
with the time period then the job is cancelled and any completed action
steps will be rolled back.

**For a complete description of all available actions see the**** 
****[Available Actions](https://wiki.hpcloud.net/display/iaas/Available+Actions "Available Actions")**** ****page.**

#### **Normal Response Codes**

**201** (Created)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

Yes

gzip

 No

#### **Query String Values**

**timeOut=*****\<milliseconds\>***

**Web Application Description Language (WADL) Definition of API**

~~~
<resource path="action">
    <resource path="{action}">
        <param name="action" style="template" default=""/>
        <method name="POST">
            <doc title="Create a pending Job Ticket containing the parameters to perform the specified Action."/>
            <request>
                <param xmlns:xs="http://www.w3.org/2001/XMLSchema" name="timeOut" style="query" type="xs:long" default="0"/>
                <representation mediaType="application/json"/>
                <representation mediaType="application/xml"/>
            </request>
            <response>
                <representation mediaType="application/json"/>
                <representation mediaType="application/xml"/>
            </response>
        </method>
    </resource>
</resource>
~~~

#### **Request and Response schema,  XML Schema Definition **

[JobTicket.xsd](xsd/JobTicket.xsd)

#### **Example(s)**

*Note that in the following examples a timeOut value of 60 seconds is
specified. Without this query parameter the returned JobTicket would
have a state of PENDING instead of COMPLETE. Also note that Action
Parameters are write-only. They are stored encrypted in the database,
and are not included in the returned JobTicket instance.*

**JSON Request**

~~~
POST https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/action/createDomain?timeOut=60000 HTTP/1.1
X-Auth-Token: HPAuth_4e89f121318cd70066d68c2e
Date: Mon, 3 Oct 2011 11:30:10 -0600
Content-Type: application/json
User-Agent: Maxwell/Smart
Host: Pat Sajak

{ "JobTicket" : { "actionParams" : { "name" : "TestDom_1317663010554", "company" : "ArvindCo" } } }
~~~

**JSON Response**

~~~
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 738
Date: Mon, 03 Oct 2011 17:30:13 GMT

{
  "JobTicket" : {
    "action" : "createDomain",
    "actionParams" : { },
    "actionResults" : {
      "SALESFORCE_ACCOUNT" : "001V0000003cerDIAQ",
      "KMS_TENANT" : "38995611887804",
      "domainId" : "38995611887804",
      "zuoraDomainAcct" : "4028e69632bcaec40132cad5f62a1416"
    },
    "completion" : 1317663013245,
    "errorDescription" : "",
    "status" : "COMPLETE",
    "stepStatus" : {
      "CreateZuoraDomainAccount" : "COMPLETE",
      "CreateKmsDomain" : "COMPLETE",
      "CreateSalesforceAccount" : "COMPLETE",
      "CreateUmsDomain" : "COMPLETE"
    },
    "submission" : 1317663009960,
    "ticketId" : "4e89f121318cd70066d68c31"
  }
}
~~~

**XML Request**

~~~
POST https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/action/createDomain?timeOut=60000 HTTP/1.1
X-Auth-Token: HPAuth_4e8cb8c3318cf2e142e77157
Date: Wed, 5 Oct 2011 14:06:44 -0600
Content-Type: application/xml
Accept: application/xml
User-Agent: Maxwell/Smart
Host: Pat Sajak

<JobTicket>
  <actionParams>
    <entry><key>name</key><value>TestDom_1317845202814</value></entry>
    <entry><key>company</key><value>ArvindCo</value></entry>
  </actionParams>
</JobTicket>
~~~

**XML Response**

~~~
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=F8BCE4AEF0DF12C5BB97CE10E3883DFC; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 959
Date: Wed, 05 Oct 2011 20:06:47 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<JobTicket>
  <actionParams/>
  <stepStatus>
    <entry><key>CreateZuoraDomainAccount</key><value>COMPLETE</value></entry>
    <entry><key>CreateKmsDomain</key><value>COMPLETE</value></entry>
    <entry><key>CreateSalesforceAccount</key><value>COMPLETE</value></entry>
    <entry><key>CreateUmsDomain</key><value>COMPLETE</value></entry>
  </stepStatus>
  <actionResults>
    <entry><key>SALESFORCE_ACCOUNT</key><value>001V0000003ePc5IAE</value></entry>
    <entry><key>KMS_TENANT</key><value>47161213735800</value></entry>
    <entry><key>domainId</key><value>47161213735800</value></entry>
    <entry><key>zuoraDomainAcct</key><value>4028e69632bcaec40132d5b204781340</value></entry>
  </actionResults>
  <action>createDomain</action>
  <completion>2011-10-05T14:06:46.983-06:00</completion>
  <errorDescription></errorDescription>
  <status>COMPLETE</status>
  <submission>2011-10-05T14:06:42.707-06:00</submission>
  <ticketId>4e8cb8d2318cf2e142e7715a</ticketId>
</JobTicket>
~~~

**Get Jobs**
------------

Verb

URI

Description

**GET**

*[[HPKeystoneExtensionBaseURI]/job?accountId](#ActionOperations-GetJobs)**=12345*

Get a list of all job tickets for the given accountId.

#### **Detailed Description**

Return a list of all Job Tickets submitted by the specified Account
ID*. *

When an Action is submitted it is not executed immediately. Instead, the
Action request parameters are stored in the database within an instance
of JobTicket. A JobTicket contains all of the request parameters, and
also includes submission date and execution status. *(Note that old
JobTickets are periodically purged from the system after a configurable
length of time.)*

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

Yes

gzip

 No

#### **Query String Values**

'limit' and 'marker' values. See [Pagination with limit and
marker](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")

**Web Application Description Language (WADL) Definition of API**

~~~
<resources base="https://kswj2.fc.hp.com:8443/v2.0/">
    <resource path="job">
        <method name="GET">
            <request>
                <param name="accountId" style="query" default=""/>
                <param name="skip" style="query" default="0"/>
                <param name="limit" style="query" default="2147483647"/>
            </request>
            <response>
                <representation mediaType="application/json"/>
                <representation mediaType="application/xml"/>
            </response>
        </method>
    </resource>
</resources>
~~~

#### **Request and Response schema,  XML Schema Definition **

[JobTicket.xsd](xsd/JobTicket.xsd)

#### **Example(s)**

**Request**

~~~
GET https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job?accountId=000000003002 HTTP/1.1
X-Auth-Token: HPAuth_4e8ddf46b76008bbc7900ac5
Date: Thu, 6 Oct 2011 11:03:07 -0600
Content-Type: application/json
Accept: application/json
User-Agent: Maxwell/Smart
Host: Pat Sajak
~~~

**Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 7449
Date: Thu, 06 Oct 2011 17:03:04 GMT

{
"TicketList" : {
  "Tickets" : [ {
        "action" : "createSwiftAccount",
        "actionParams" : {
        },
        "actionResults" : {
        },
        "completion" : 1315848685171,
        "errorDescription" : "Missing required parameter [regionCode]",
        "status" : "ERROR",
        "stepStatus" : {
        },
        "submission" : 1315848685142,
        "ticketId" : "4e6e41edb760291563f2a4ca"
      }, {
        "action" : "createSwiftAccount",
        "actionParams" : {
        },
        "actionResults" : {
        },
        "completion" : 1315848686306,
        "errorDescription" : "Missing required parameter [productRatePlan]",
        "status" : "ERROR",
        "stepStatus" : {
        },
        "submission" : 1315848686283,
        "ticketId" : "4e6e41eeb760291563f2a4cd"
      }, {
        "action" : "createSwiftAccount",
        "actionParams" : {
        },
        "actionResults" : {
        },
        "completion" : 1315848829943,
        "errorDescription" : "Missing required parameter [serviceName]",
        "status" : "ERROR",
        "stepStatus" : {
        },
        "submission" : 1315848829914,
        "ticketId" : "4e6e427db760291563f2a4da"
     } ]
    }
  }
~~~

**Get Error Jobs**
------------------

Verb

URI

Description

**GET**

[*[HPKeystoneExtensionBaseURI]/job/error*](#ActionOperations-GetErrorJobs)

Get a list of all Error or Timed Out jobs.

#### **Detailed Description**

Return a list of all Job Tickets that are in the ERROR or CANCELLED
state.

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

Yes

gzip

 No

#### **Query String Values**

'limit' and 'marker' values. See [Pagination with limit and
marker](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")

**Web Application Description Language (WADL) Definition of API**

~~~
<resources base="https://kswj2.fc.hp.com:8443/v2.0/">
    <resource path="job">
        <resource path="error">
            <method name="GET">
                <request>
                    <param name="skip" style="query" default="0"/>
                    <param name="limit" style="query" default="2147483647"/>
                </request>
                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>
        </resource>
    </resource>
</resources>
~~~

#### **Request and Response schema,  XML Schema Definition **

[JobTicket.xsd](xsd/JobTicket.xsd)

#### **Example(s)**

**JSON Request**

~~~
GET https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/error HTTP/1.1
X-Auth-Token: HPAuth_4e8dd34eb76008bbc7900a04
Date: Thu, 6 Oct 2011 10:12:04 -0600
Content-Type: application/json
Accept: application/json
User-Agent: Maxwell/Smart
Host: Pat Sajak
~~~

**JSON Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Transfer-Encoding: chunked
Date: Thu, 06 Oct 2011 16:12:00 GMT

{"TicketList" : {
  "Tickets" : [ {
    "action" : "createSwiftAccount",
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : 1315847317737,
    "errorDescription" : "Missing required parameter [serviceName]",
    "status" : "ERROR",
    "stepStatus" : {
    },
    "submission" : 1315847317683,
    "ticketId" : "4e6e3c95b760291563f2a49d"
  }, {
    "action" : "createSwiftAccount",
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : 1315848682945,
    "errorDescription" : "Missing required parameter [productRatePlan]",
    "status" : "ERROR",
    "stepStatus" : {
    },
    "submission" : 1315848682916,
    "ticketId" : "4e6e41eab760291563f2a4c7"
  }, {
    "action" : "purgeDomain",
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : 1315970203783,
    "errorDescription" : "Missing required parameter [domainId]",
    "status" : "ERROR",
    "stepStatus" : {
    },
    "submission" : 1315970203772,
    "ticketId" : "4e701c9bb7605d4ca2aa140c"
~~~

**Get Error Jobs by Category**
------------------------------

Verb

URI

Description

**GET**

*[[HPKeystoneExtensionBaseURI]/job/error/{category}](#ActionOperations-GetErrorJobs)*

Get a list of all Error or Timed Out jobs.

#### **Detailed Description**

Job Tickets that are in the ERROR state will have an Action Exception
attached to them. Action Exceptions are categorize, and can be retrieved
or delete in bulk by category. This API is used to retreive all ERROR
action jobs whose Action Exceptions are of a specified category. The
list of all categories is found on the [Action
Exception](https://wiki.hpcloud.net/display/iaas/Action+Exceptions "Action Exceptions") page.

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

Yes

gzip

 No

#### **Query String Values**

'limit' and 'marker' values. See [Pagination with limit and
marker](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")

**Web Application Description Language (WADL) Definition of API**

~~~
<resources base="https://kswj2.fc.hp.com:8443/v2.0/">
    <resource path="job">
        <resource path="error">
            <method name="GET">
                <param name="category" style="template" default=""/>
                <request>
                    <param name="skip" style="query" default="0"/>
                    <param name="limit" style="query" default="2147483647"/>
                </request>
                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>
        </resource>
    </resource>
</resources>
~~~

#### **Request and Response schema,  XML Schema Definition **

[JobTicket.xsd](xsd/JobTicket.xsd)

#### **Example(s)**

**JSON Request**

~~~
GET https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/error/AUTH HTTP/1.1
X-Auth-Token: HPAuth_4e8dd34eb76008bbc7900a04
Date: Thu, 6 Oct 2011 10:12:04 -0600
Content-Type: application/json
Accept: application/json
User-Agent: Maxwell/Smart
Host: Pat Sajak
~~~

**JSON Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Transfer-Encoding: chunked
Date: Thu, 06 Oct 2011 16:12:00 GMT


{"TicketList" : {
  "Tickets" : [ {
    "action" : "createSwiftAccount",
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : 1315847317737,
    "errorDescription" : "Missing required parameter [serviceName]",
    "status" : "ERROR",
    "stepStatus" : {
    },
    "submission" : 1315847317683,
    "ticketId" : "4e6e3c95b760291563f2a49d"
  }, {
    "action" : "createSwiftAccount",
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : 1315848682945,
    "errorDescription" : "Missing required parameter [productRatePlan]",
    "status" : "ERROR",
    "stepStatus" : {
    },
    "submission" : 1315848682916,
    "ticketId" : "4e6e41eab760291563f2a4c7"
  }, {
    "action" : "purgeDomain",
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : 1315970203783,
    "errorDescription" : "Missing required parameter [domainId]",
    "status" : "ERROR",
    "stepStatus" : {
    },
    "submission" : 1315970203772,
    "ticketId" : "4e701c9bb7605d4ca2aa140c"
~~~

**Get a Count of Error Jobs**
-----------------------------

Verb

URI

Description

**GET**

[*[HPKeystoneExtensionBaseURI]/job/error/count*](#ActionOperations-ErrorCount)

Get a count of all error jobs.

#### **Detailed Description**

Return a count of all error job tickets in the database. Error tickets
have a status of either ERROR or TIMEDOUT.

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

No

JSON

No

text/plain

Yes

#### **Query String Values**

'limit' and 'marker' values. See [Pagination with limit and
marker](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")

**Web Application Description Language (WADL) Definition of API**

~~~
<resources base="https://kswj2.fc.hp.com:8443/v2.0/">
    <resource path="job">
        <resource path="error">
            <resource path="count">
                <method name="GET">
                    <response>
                        <representation mediaType="text/plain"/>
                    </response>
                </method>
            </resource>
        </resource>
    </resource>
</resources>
~~~

#### **Request and Response schema,  XML Schema Definition **

[n](xsd/JobTicket.xsd)/a

#### **Example(s)**

**JSON Request**

~~~
GET https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/error/count
X-Auth-Token: HPAuth_4e8dd34eb76008bbc7900a04
Date: Thu, 6 Oct 2011 10:12:04 -0600
Content-Type: text/plain
Accept: text/plain
User-Agent: Maxwell/Smart
Host: Pat Sajak
~~~

**JSON Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: text/plain
Transfer-Encoding: chunked
Date: Thu, 06 Oct 2011 16:12:00 GMT

7
~~~

**Get Jobs by Status**
----------------------

Verb

URI

Description

**GET**

[*[HPKeystoneExtensionBaseURI]/job/status/{status}*](#ActionOperations-JobByStatus)

Return all Jobs with the given status.

#### **Detailed Description**

Return all Job Tickets from the database which have the given status
value. The [Action
Page](https://wiki.hpcloud.net/display/iaas/CSI+Action+Service "CSI Action Service")
provides a list of all possible status values.

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

Yes

gzip

 No

#### **Query String Values**

'limit' and 'marker' values. See [Pagination with limit and
marker](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")

**Web Application Description Language (WADL) Definition of API**

~~~
<resources base="https://kswj2.fc.hp.com:8443/v2.0/">
    <resource path="job">
        <resource path="status">
            <method name="GET">
                <param name="status" style="template" default=""/>
                <request>
                    <param name="skip" style="query" default="0"/>
                    <param name="limit" style="query" default="2147483647"/>
                </request>
                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>
        </resource>
    </resource>
</resources>
~~~

#### **Request and Response schema,  XML Schema Definition **

[JobTicket.xsd](xsd/JobTicket.xsd)

#### **Example(s)**

**JSON Request**

~~~
GET https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/status/ERROR HTTP/1.1
X-Auth-Token: HPAuth_4e8dd34eb76008bbc7900a04
Date: Thu, 6 Oct 2011 10:12:04 -0600
Content-Type: application/json
Accept: application/json
User-Agent: Maxwell/Smart
Host: Pat Sajak
~~~

**JSON Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Transfer-Encoding: chunked
Date: Thu, 06 Oct 2011 16:12:00 GMT


{"TicketList" : {
  "Tickets" : [ {
    "action" : "createSwiftAccount",
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : 1315847317737,
    "errorDescription" : "Missing required parameter [serviceName]",
    "status" : "ERROR",
    "stepStatus" : {
    },
    "submission" : 1315847317683,
    "ticketId" : "4e6e3c95b760291563f2a49d"
  }, {
    "action" : "createSwiftAccount",
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : 1315848682945,
    "errorDescription" : "Missing required parameter [productRatePlan]",
    "status" : "ERROR",
    "stepStatus" : {
    },
    "submission" : 1315848682916,
    "ticketId" : "4e6e41eab760291563f2a4c7"
  }, {
    "action" : "purgeDomain",
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : 1315970203783,
    "errorDescription" : "Missing required parameter [domainId]",
    "status" : "ERROR",
    "stepStatus" : {
    },
    "submission" : 1315970203772,
    "ticketId" : "4e701c9bb7605d4ca2aa140c"
~~~


**Get Job Count by Status**
---------------------------

Verb

URI

Description

**GET**

[*[HPKeystoneExtensionBaseURI]/job/status/{status}/count*](#ActionOperations-JobCountByStatus)

Return a count of all Jobs with the given status.

#### **Detailed Description**

Return a count of all Job Tickets from the database which have the given
status value. The [Action
Page](https://wiki.hpcloud.net/display/iaas/CSI+Action+Service "CSI Action Service") provides
a list of all possible status values.

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

No

JSON

No

text/plain

Yes

#### **Query String Values**

n/a

**Web Application Description Language (WADL) Definition of API**

~~~
<resources base="https://kswj2.fc.hp.com:8443/v2.0/">
    <resource path="job">
        <resource path="status">
            <param name="category" style="template" default=""/>
            <resource path="count">
                <method name="GET">
                    <response>
                        <representation mediaType="text/plain"/>
                    </response>
                </method>
            </resource>
        </resource>
    </resource>
</resources>
~~~

#### **Request and Response schema,  XML Schema Definition **

[JobTicket.xsd](xsd/JobTicket.xsd)

#### **Example(s)**

**JSON Request**

~~~
GET https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/error/ERROR/count HTTP/1.1
X-Auth-Token: HPAuth_4e8dd34eb76008bbc7900a04
Date: Thu, 6 Oct 2011 10:12:04 -0600
Content-Type: text/plain
Accept: text/plain
User-Agent: Maxwell/Smart
Host: Pat Sajak
~~~

**JSON Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: text/plain
Transfer-Encoding: chunked
Date: Thu, 06 Oct 2011 16:12:00 GMT

4
~~~


**Delete Error Jobs by Category**
---------------------------------

Verb

URI

Description

DELETE

***HPKeystoneExtensionBaseURI/job/error/{category}***

Delete all error jobs of the specified category.

#### **Detailed Description**

Job Tickets that are in the ERROR state will have an Action Exception
attached to them. Action Exceptions are categorize, and can be retrieved
or delete in bulk by category. This API is used to delete all ERROR
action jobs whose Action Exceptions are of a specified category. The
list of all categories is found on the [Action
Exception](https://wiki.hpcloud.net/display/iaas/Action+Exceptions "Action Exceptions")
page.

#### **Normal Response Codes**

**204** (No Content)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

Yes

gzip

 No

#### **Query String Values**

N/A

**Web Application Description Language (WADL) Definition of API**

~~~
<resources base="https://kswj2.fc.hp.com:8443/v2.0/">
    <resource path="job">
        <resource path="category">
            <method name="DELETE">
                <request>
                </request>
                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>
        </resource>
    </resource>
</resources>
~~~

#### **Request and Response schema,  XML Schema Definition **

N/A

#### **Example(s)**

**Request**

~~~
  DELETE https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/USER_INPUT HTTP/1.1
  X-Auth-Token: HPAuth_4e8c7849318cf2e142e76ef1
  Date: Wed, 5 Oct 2011 09:31:28 -0600
  User-Agent: Maxwell/Smart
  Host: Pat Sajak
~~~

**Response**

~~~
  HTTP/1.1 204 No Content
  Server: Apache-Coyote/1.1
  Cache-Control: no-cache
  Pragma: no-cache
  Expires: -1
  Date: Wed, 05 Oct 2011 15:31:25 GMT
~~~


**Get A Job Ticket**
--------------------

Verb

URI

Description

**GET**

[*[HPKeystoneExtensionBaseURI]/job/{ticketId}?timeOut=60000*](#ActionOperations-GetJob)

Get the specified job ticket.

#### **Detailed Description**

This call will return the specified Job Ticket, and will optionally
block the caller until the Job Ticket is marked as complete.

This request accepts a query parameter, "timeOut", that specifies the
length of time in milliseconds to wait until the given Job Ticket is
marked as complete. If the "timeOut" query parameter is not present or
is set to zero then the call will return immediately with the current
state of the Action Job.

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

*Parameter*

*Required*

*Description*

*timeOut*

*false*

* *The time in milliseconds to wait until the specified Job Ticket has
been marked COMPLETE.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

Yes

gzip

 No

**Web Application Description Language (WADL) Definition of API**

~~~
<resources base="https://kswj2.fc.hp.com:8443/v2.0/">
    <resource path="job">
        <resource path="{ticketId}">
            <param name="ticketId" style="template" default=""/>
            <method name="GET">
                <request>
                    <param xmlns:xs="http://www.w3.org/2001/XMLSchema" name="timeOut" style="query" type="xs:long" default="0"/>
                </request>
                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>
        </resource>
    </resource>
</resources>
~~~

#### **Request and Response schema,  XML Schema Definition **

[JobTicket.xsd](xsd/JobTicket.xsd)

#### **Example(s)**

**JSON Request**

~~~
GET https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/4f56485f8fd2c0c00932b6ec?timeOut=90000 HTTP/1.1
X-Auth-Token: HPAuth_4e8dd975b76008bbc7900a31
Date: Thu, 6 Oct 2011 10:38:19 -0600
Content-Type: application/json
Accept: application/json
User-Agent: Maxwell/Smart
Host: Pat Sajak
~~~

**JSON Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 508
Date: Thu, 06 Oct 2011 16:38:15 GMT

{
  "JobTicket" : {
    "action" : "NocUserRegistration",
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : "2012-03-06T17:24:47.326Z",
    "errorDescription" : "Subject is unauthorized to perform this action",
    "status" : "ERROR",
    "stepStatus" : {
      "CreateUmsUser" : "ERROR",
      "CreateKmsUserKeys" : "PENDING",
      "CreateSalesforceContactAndAccount" : "PENDING",
      "CreateKmsUser" : "PENDING"
    },
    "submission" : "2012-03-06T17:24:47.264Z",
    "ticketId" : "4f56485f8fd2c0c00932b6ec"
  }
}
~~~


**Restart a TIMEDOUT Job**
--------------------------

Verb

URI

Description

**PUT**

[*[HPKeystoneExtensionBaseURI]/job/{ticketId}*](#ActionOperations-GetJob)

Restart the specified TIMEDOUT Job.

#### **Detailed Description**

Some Actions contain Steps that are retryable. Examples are calls to
Zuora or Salesforce, which might fail due to internet connectivity
issues. These steps contain a retry count the determines how many times
they should re-attempt execution. Once all retries have been used up the
Step and the Action are tagged with the TIMEDOUT status.

This API resets an Action and its Steps from TIMEDOUT to RETRY. This
will cause the job to be executed again.

**Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

none

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

Yes

gzip

 No

**Web Application Description Language (WADL) Definition of API**

~~~
<resources base="https://kswj2.fc.hp.com:8443/v2.0/">
    <resource path="job">
        <resource path="{ticketId}">
            <param name="ticketId" style="template" default=""/>
            <method name="GET">
                <request>
                    <param xmlns:xs="http://www.w3.org/2001/XMLSchema" name="timeOut" style="query" type="xs:long" default="0"/>
                </request>
                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>
        </resource>
    </resource>
</resources>
~~~

#### **Request and Response schema,  XML Schema Definition **

[JobTicket.xsd](xsd/JobTicket.xsd)

#### **Example(s)**

**JSON Request**

~~~
PUT https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/4f56485f8fd2c0c00932b6ec?timeOut=90000 HTTP/1.1
X-Auth-Token: HPAuth_4e8dd975b76008bbc7900a31
Date: Thu, 6 Oct 2011 10:38:19 -0600
Content-Type: application/json
Accept: application/json
User-Agent: Maxwell/Smart
Host: Pat Sajak
~~~

**JSON Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 508
Date: Thu, 06 Oct 2011 16:38:15 GMT
~~~


**Delete A Job Ticket**
-----------------------

Verb

URI

Description

DELETE

***HPKeystoneExtensionBaseURI/job/{ticketId}***

Delete the specified Action Job Ticket.

#### **Detailed Description**

This API call deletes a specified Job Ticket.

Job Tickets for Actions which complete successfully are eventually
removed from the system. But Actions which fail must have their Job
Tickets manually deleted using this API call.

#### **Normal Response Codes**

**204** (No Content)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

Yes

gzip

 No

#### **Query String Values**

N/A

**Web Application Description Language (WADL) Definition of API**

~~~
<resources base="https://kswj2.fc.hp.com:8443/v2.0/">
    <resource path="job">
        <resource path="error">
            <method name="DELETE">
                <request>
                </request>
                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>
        </resource>
    </resource>
</resources>
~~~

#### **Request and Response schema,  XML Schema Definition **

N/A

#### **Example(s)**

**Request**

~~~
  DELETE https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/4e8c7849318cf2e142e76ef4 HTTP/1.1
  X-Auth-Token: HPAuth_4e8c7849318cf2e142e76ef1
  Date: Wed, 5 Oct 2011 09:31:28 -0600
  User-Agent: Maxwell/Smart
  Host: Pat Sajak
~~~

**Response**

~~~
  HTTP/1.1 204 No Content
  Server: Apache-Coyote/1.1
  Cache-Control: no-cache
  Pragma: no-cache
  Expires: -1
  Date: Wed, 05 Oct 2011 15:31:25 GMT
~~~

* * * * *

### Get All Actions *(Deprecated)*

Verb

URI

Description

**GET** 

**[HP*****KeystoneExtensionBaseURI]/action**** *

Return a list of all available actions.

#### **Detailed Description**

Return a list of all available actions. Actions are compositions of
simple service requests that may be executed together to perform a
higher level action.

For a complete description of all available actions see the [Available
Actions](https://wiki.hpcloud.net/display/iaas/Available+Actions "Available Actions")
page.

#### **Normal Response Codes**

**200** (OK)

#### Error Response Codes

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

'limit' and 'marker' values. See [Pagination with limit and
marker](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

Yes

gzip

 No

#### **Web Application Description Language (WADL) Definition of API**
```
    <resource path="action">
        <method name="GET">
            <doc title="Return a list of all available Actions."/>
            <request>
                <param default="0" style="query" name="marker"/>
                <param default="2147483647" style="query" name="limit"/>
            </request>
            <response>
                <representation mediaType="application/json"/>
                <representation mediaType="application/xml"/>
            </response>
        </method>
    </resource>  
```

#### **Request and Response schema,  XML Schema Definition **

[JobTicket.xsd](xsd/JobTicket.xsd)

#### **Example(s)**

##### XML Request

~~~
GET /action HTTP/1.1
Host: localhost:8888
account_id: 000000003001
Content-Type: application/xml
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 4314
Date: Tue, 09 Aug 2011 20:57:27 GMT

<actionList>
    <action>
        <name>CreateUser</name>
        <description>Create a new User within the specified Domain.</description>
        <parameters>...</parameters>
    </action>
    <action>
        <name>CreateSwiftAccount</name>
        <description/>
        <parameters>
            <parameter>
                <name>accountId</name>
                <required>false</required>
                <type>xs:string</type>
            </parameter>
            <parameter>
                <name>domainId</name>
                <required>false</required>
                <type>xs:string</type>
            </parameter>
        </parameters>
    </action>
    <action>
        <name>CreateDomain</name>
        <description>Create a new Domain.</description>
        <parameters>...</parameters>
    </action>
    <action>
        <name>UserState</name>
        <description>
        Set the state for this User. Valid states are: enabled, disabled, suspended:3, deleted, and purged.
        </description>
        <parameters>
            <parameter>
                <name>state</name>
                <required>true</required>
                <type>xs:string</type>
            </parameter>
            <parameter>
                <name>accountId</name>
                <required>true</required>
                <type>xs:string</type>
            </parameter>
        </parameters>
    </action>
    <action>
        <name>DomainState</name>
        <description>
        Set the state for this Domain. Valid states are: enabled, suspended:3, deleted, and purged.
        </description>
        <parameters>
            <parameter>
                <name>state</name>
                <required>true</required>
                <type>xs:string</type>
            </parameter>
            <parameter>
                <name>domainId</name>
                <required>true</required>
                <type>xs:string</type>
            </parameter>
        </parameters>
    </action>
</actionList>
~~~
