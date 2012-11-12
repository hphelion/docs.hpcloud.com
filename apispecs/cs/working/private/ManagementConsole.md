# Management Console

Hitherto the MC has stored data in its own Mongo service and defined its own database and set of collections. Control Services was added to the HP Cloud deployment in the Maine release. CS also maintains its own Mongo service and database. 

There are two primary problems with maintaining separate Mongo services for MC and CS. First, we must install and maintain two separate systems. In the current release CS and MC do not even share the same Mongo version. Second, MC and CS maintain their own copies of exactly the same data without any mechanism for automated reconciliation. This has led to issues of data inconsistencies during the Augusta timeframe.

For the Texas release we plan to expose Control Service APIs to allow the Management Console to easily store and access persistent data from the CS Mongo database. This will prevent issues of data inconsistencies. Additionally, the CS Mongo service will be configured with a second database dedicated to MC. The MC database will only store transient data and will not require backup. This will alleviate the overhead of installing and maintain to separate versions and installations in the data center.

This page describes the proposed  APIs that the Management Console will use to access persistent data that is maintained in the Control Services database. The following experimental APIs are available only on the Texas development branch. The APIs are currently not listed in the list of published Control Services APIs while they are under development.

#### Issues to be Resolved ####

* PurgeUser action must cascade to the user's preferences. Need to check PurgeDomain call to see if it also propagates...
* We need to review the contents of the UserDetails class. What fields should we add and/or remove.
* Need to configure the security XML file so that only MC can access these APIs.
* Might be nice to bundle the UserDetails with the Token call so MC could grab everything for a user in one go.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

## User Details
#### GET [HPKeystoneExtensionBaseURI]/users/details/{userId}
*Privilege Level: MC-CS Certificate*

The UserDetails class is a dynamically constructed amalgamation of many different database collections.

**Request Data**

**URL Parameters**

* *userId* - Long - The id of the user

**Data Parameters**

This call does not require a request body

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "user" : {
    "state" : "Colorado",
    "country" : "United States",
    "status" : "ENABLED",
    "city" : "Fort Collins",
    "accountId" : "37598452056865",
    "domainId" : "71688867269283",
    "contactId" : null,
    "billingId" : "4028e6963577fe0d0135828a2e5647d8",
    "addressLine1" : "1234 Harmony Road",
    "addressLine2" : "MS 5678",
    "zip" : "97222",
    "phone" : "9705551212",
    "company" : "Hewlett Packard Cloud Seeding",
    "website" : "http://www.hp.com",
    "emailAddress" : "bozo@hp.com",
    "passwordResetCount" : null,
    "passwordResetTime" : null,
    "passwordLockoutStartTime" : null,
    "username" : "JL1329334986631",
    "firstName" : "James",
    "lastName" : "Long",
    "passwordLockoutCount" : null,
    "passwordLockoutWindow" : null,
    "timeLastSuccessfulLogin" : null,
    "passwordRetryTimespan" : null,
    "passwordRetryStartTime" : null
  },
  "domain" : {
    "name" : "71688867269283-DOMAIN",
    "state" : "Colorado",
    "country" : "United States",
    "status" : "ENABLED",
    "description" : null,
    "city" : "Fort Collins",
    "domainId" : "71688867269283",
    "contactId" : null,
    "billingId" : "4028e6963577fe0d0135828a2b7f47d1",
    "addressLine1" : "1234 Harmony Road",
    "addressLine2" : "MS 5678",
    "zip" : "97222",
    "phone" : "9705551212",
    "company" : "Hewlett Packard Cloud Seeding",
    "website" : "http://www.hp.com",
    "emailAddress" : "bozo@hp.com"
  },
  "tenants" : [ {
    "name" : "NoveTenant1329334994693",
    "status" : "ENABLED",
    "description" : "Compute",
    "tenantId" : "39525494045831",
    "billingId" : null,
    "swiftAccountHash" : null
  } ],
  "jobs" : [ {
    "status" : "COMPLETE",
    "action" : "TEST",
    "errorDescription" : "",
    "submission" : null,
    "completion" : null,
    "jobticketId" : ""
  } ],
  "preferences" : {
    "substore" : [ {
      "storeName" : "UI Preferences",
      "store" : {
        "substore" : [ ],
        "preference" : [ {
          "key" : "Font",
          "value" : "Dingbat"
        }, {
          "key" : "BackgroundColor",
          "value" : "BLACK"
        }, {
          "key" : "ForegroundColor",
          "value" : "BROWN"
        } ]
      }
    } ],
    "preference" : [ ],
    "accountId" : "37598452056865",
    "id" : {
      "time" : 1329335008000,
      "machine" : 224520590,
      "timeSecond" : 1329335008,
      "inc" : -1996416285,
      "new" : false
    },
    "setId" : true,
    "idHex" : null,
    "version" : 1,
    "setVersion" : true,
    "dateRecordAdded" : 1329335008246,
    "setDateRecordAdded" : true,
    "dateLastModified" : 1329335008246,
    "setDateLastModified" : true,
    "bs" : false,
    "immutable" : null
  },
  "id" : null,
  "setId" : false,
  "idHex" : null,
  "version" : 0,
  "setVersion" : true,
  "dateRecordAdded" : null,
  "setDateRecordAdded" : false,
  "dateLastModified" : null,
  "setDateLastModified" : false,
  "bs" : false,
  "immutable" : null
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<userDetails>
    <version>0</version>
    <domain>
        <addressLine1>1234 Harmony Road</addressLine1>
        <addressLine2>MS 5678</addressLine2>
        <billingId>4028e6963577fe0d0135828a2b7f47d1</billingId>
        <city>Fort Collins</city>
        <company>Hewlett Packard Cloud Seeding</company>
        <country>United States</country>
        <domainId>71688867269283</domainId>
        <emailAddress>bozo@hp.com</emailAddress>
        <name>71688867269283-DOMAIN</name>
        <phone>9705551212</phone>
        <state>Colorado</state>
        <status>ENABLED</status>
        <website></website>
        <zip>97222</zip>
    </domain>
    <jobTickets>
        <jobTicket>
            <action>TEST</action>
            <errorDescription></errorDescription>
            <jobticketId></jobticketId>
            <status>COMPLETE</status>
        </jobTicket>
    </jobTickets>
    <userPreferences>
        <dateLastModified>2012-02-15T12:43:28.246-07:00</dateLastModified>
        <dateRecordAdded>2012-02-15T12:43:28.246-07:00</dateRecordAdded>
        <id/>
        <version>1</version>
        <userId>37598452056865</userId>
        <substores>
            <substore>
                <storeName>UI Preferences</storeName>
                <store>
                    <substores/>
                    <preferences>
                        <preference>
                            <key>Font</key>
                            <value>Dingbat</value>
                        </preference>
                        <preference>
                            <key>BackgroundColor</key>
                            <value>BLACK</value>
                        </preference>
                        <preference>
                            <key>ForegroundColor</key>
                            <value>BROWN</value>
                        </preference>
                    </preferences>
                </store>
            </substore>
        </substores>
        <preferences/>
    </userPreferences>
    <tenants>
        <tenant>
            <services>
                <service>
                    <regionCode>az-1.region-a.geo-1</regionCode>
                    <serviceName>Compute</serviceName>
                    <status>ENABLED</status>
                </service>
                <service>
                    <regionCode>az-1.region-a.geo-1</regionCode>
                    <serviceName>Block Storage</serviceName>
                    <status>ENABLED</status>
                </service>
                <service>
                    <regionCode>az-1.region-a.geo-1</regionCode>
                    <serviceName>Image Management</serviceName>
                    <status>ENABLED</status>
                </service>
            </services>
            <description>Compute</description>
            <name>NoveTenant1329334994693</name>
            <status>ENABLED</status>
            <tenantId>39525494045831</tenantId>
        </tenant>
    </tenants>
    <user>
        <accountId>37598452056865</accountId>
        <addressLine1>1234 Harmony Road</addressLine1>
        <addressLine2>MS 5678</addressLine2>
        <billingId>4028e6963577fe0d0135828a2e5647d8</billingId>
        <city>Fort Collins</city>
        <company>Hewlett Packard Cloud Seeding</company>
        <country>United States</country>
        <domainId>71688867269283</domainId>
        <emailAddress>bozo@hp.com</emailAddress>
        <firstName>James</firstName>
        <lastName>Long</lastName>
        <phone>9705551212</phone>
        <state>Colorado</state>
        <status>ENABLED</status>
        <username>JL1329334986631</username>
        <website></website>
        <zip>97222</zip>
    </user>
</userDetails>
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

An incorrect user id will result in a service unavailable response.
 
```
{
  "serviceUnavailable" : {
    "code" : 500,
    "details" : "Server error",
    "message" : "Service unavailable",
    "otherAttributes" : {
    }
  }
}
```

An incorrect auth token will result in a service unavailable response.

```
{
  "serviceUnavailable" : {
    "code" : 500,
    "details" : "Server error",
    "message" : "Service unavailable",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

**Curl Example**

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/users/details/<user-id>
```


## User Preferences
#### GET [HPKeystoneExtensionBaseURI]/preferences/{userId}
*Privilege Level: MC-CS Certificate*

The UserPreference database collection is nothing more that a set of nested hash maps that is associated with a specific user.  Querying it returns that hash map.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
Only the user id is required to retrieve the preferences.


**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *userId* - Long - The id of the user.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{ "substore":
  [
    { "storeName":"Stuff",
      "store":
        {
          "substore":[],
          "preference":
            [
              {"key":"Key 1","value":"Value One"},
              {"key":"Something Else","value":"Another thing...."},
              {"key":"Crap","value":"More Crap"}
            ],
        }
    },
    { "storeName":"More Stuff",
      "store":
        {
          "substore":[],
          "preference":
            [
              {"key":"Quote","value":"\"There is nothing either good or bad, but thinking makes it so.\""},
              {"key":"Source","value":"Hamlet II,ii"},
              {"key":"Author","value":"Billy Shakespeare"}
            ],
        }
    }
  ],
  "preference":[],
  "accountId":"1329330396830",
  "id":{"time":1329330396000,"machine":224492956,"timeSecond":1329330396,"inc":827625712,"new":false},
  "setId":true,
  "idHex":"4f3bf8dc0d617d9c315490f0",
  "version":1,
  "setVersion":true,
  "dateRecordAdded":1329330396999,
  "setDateRecordAdded":true,
  "dateLastModified":1329330396999,
  "setDateLastModified":true,
  "bs":false,
  "immutable":null
}
```

XML

```
{xml data structure here}
```

**Error Response**

**Status Code**


| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation   |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


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
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<userPreferences>
    <dateLastModified>2012-02-15T11:16:13.421-07:00</dateLastModified>
    <dateRecordAdded>2012-02-15T11:16:13.421-07:00</dateRecordAdded>
    <id/>
    <version>1</version>
    <userId>1329329773337</userId>
    <substores>
        <substore>
            <storeName>Stuff</storeName>
            <store>
                <substores/>
                <preferences>
                    <preference>
                        <key>Key 1</key>
                        <value>Value One</value>
                    </preference>
                    <preference>
                        <key>Something Else</key>
                        <value>Another thing....</value>
                    </preference>
                    <preference>
                        <key>Crap</key>
                        <value>More Crap</value>
                    </preference>
                </preferences>
            </store>
        </substore>
        <substore>
            <storeName>More Stuff</storeName>
            <store>
                <substores/>
                <preferences>
                    <preference>
                        <key>Quote</key>
                        <value>&quot;There is nothing either good or bad, but thinking makes it so.&quot;</value>
                    </preference>
                    <preference>
                        <key>Source</key>
                        <value>Hamlet II,ii</value>
                    </preference>
                    <preference>
                        <key>Author</key>
                        <value>Billy Shakespeare</value>
                    </preference>
                </preferences>
            </store>
        </substore>
    </substores>
    <preferences/>
</userPreferences>
```

Curl Example

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <path-to-cert> --cacert <path-to-cacert> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/preferences/<userId>
```

#### PUT [HPKeystoneExtensionBaseURI]/preferences/{userId}
*Privilege Level: MC-CS Certificate*

The UserPreference database collection is nothing more that a set of nested hash maps that is associated with a specific user.  Values may be updated.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
Only the user id is required to retrieve the preferences.


**URL Parameters**

Not yet documented

* *userId* - Long - The id of the user.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

Not yet documented.

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation   |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

503 - Service Unavailable

**Response Data**

JSON

```
{"userDetails": {
   "bs": false,
   "domain":    {
      "domainId": "33678705570176",
      "emailAddress": "kim.jensen2@hp.com",
      "name": "33678705570176-DOMAIN",
      "owners": ["41145980532179"],
      "status": "ENABLED"
   },
   "jobTickets": [],
   "setDateLastModified": false,
   "setDateRecordAdded": false,
   "setId": false,
   "setVersion": true,
   "tenants":    [
            {
         "description": "Object Storage",
         "name": "TS1-TC2A-SwiftTestTenant12112012141901492",
         "services": [         {
            "regionCode": "region-a.geo-1",
            "serviceName": "Object Storage",
            "status": "ENABLED"
         }],
         "status": "ENABLED",
         "tenantId": "19893479403843"
      },
            {
         "description": "Object Storage",
         "name": "TS1-TC2C-SwiftTestTenant12112012141901492",
         "services": [         {
            "regionCode": "region-a.geo-1",
            "serviceName": "Object Storage",
            "status": "ENABLED"
         }],
         "status": "ENABLED",
         "tenantId": "33349277569059"
      },
            {
         "description": "Object Storage",
         "name": "TS1-TC2D-SwiftTestTenant12112012141901492",
         "services": [         {
            "regionCode": "region-a.geo-1",
            "serviceName": "Object Storage",
            "status": "ENABLED"
         }],
         "status": "ENABLED",
         "tenantId": "51153082887747"
      },
            {
         "description": "Object Storage",
         "name": "TS1-TC2B-SwiftTestTenant12112012141901492",
         "services": [         {
            "regionCode": "region-a.geo-1",
            "serviceName": "Object Storage",
            "status": "ENABLED"
         }],
         "status": "ENABLED",
         "tenantId": "73489722654413"
      }
   ],
   "user":    {
      "accountId": "41145980532179",
      "dateRecordAdded": "2012-11-12T22:19:01.539Z",
      "domainId": "33678705570176",
      "emailAddress": "kim.jensen2@hp.com",
      "status": "ENABLED",
      "timeLastSuccessfulLogin": "2012-11-12T22:19:02.961Z",
      "username": "SW_12112012141901492"
   },
   "userPreferences":    {
      "bs": false,
      "preferenceNames": [],
      "preferences": [],
      "setDateLastModified": false,
      "setDateRecordAdded": false,
      "setId": false,
      "setVersion": true,
      "substoreNames": [],
      "substores": [],
      "version": 0
   },
   "version": 0
}}

```

XML
```
<userDetails>
   <version>0</version>
   <domain>
      <domainId>33678705570176</domainId>
      <emailAddress>kim.jensen2@hp.com</emailAddress>
      <name>33678705570176-DOMAIN</name>
      <owners>
         <owner>41145980532179</owner>
      </owners>
      <status>ENABLED</status>
   </domain>
   <jobTickets/>
   <userPreferences>
      <version>0</version>
      <substores/>
      <preferences/>
   </userPreferences>
   <tenants>
      <tenant>
         <services>
            <service>
               <regionCode>region-a.geo-1</regionCode>
               <serviceName>Object Storage</serviceName>
               <status>ENABLED</status>
            </service>
         </services>
         <description>Object Storage</description>
         <name>TS1-TC2A-SwiftTestTenant12112012141901492</name>
         <status>ENABLED</status>
         <tenantId>19893479403843</tenantId>
      </tenant>
      <tenant>
         <services>
            <service>
               <regionCode>region-a.geo-1</regionCode>
               <serviceName>Object Storage</serviceName>
               <status>ENABLED</status>
            </service>
         </services>
         <description>Object Storage</description>
         <name>TS1-TC2C-SwiftTestTenant12112012141901492</name>
         <status>ENABLED</status>
         <tenantId>33349277569059</tenantId>
      </tenant>
      <tenant>
         <services>
            <service>
               <regionCode>region-a.geo-1</regionCode>
               <serviceName>Object Storage</serviceName>
               <status>ENABLED</status>
            </service>
         </services>
         <description>Object Storage</description>
         <name>TS1-TC2D-SwiftTestTenant12112012141901492</name>
         <status>ENABLED</status>
         <tenantId>51153082887747</tenantId>
      </tenant>
      <tenant>
         <services>
            <service>
               <regionCode>region-a.geo-1</regionCode>
               <serviceName>Object Storage</serviceName>
               <status>ENABLED</status>
            </service>
         </services>
         <description>Object Storage</description>
         <name>TS1-TC2B-SwiftTestTenant12112012141901492</name>
         <status>ENABLED</status>
         <tenantId>73489722654413</tenantId>
      </tenant>
   </tenants>
   <user>
      <accountId>41145980532179</accountId>
      <dateRecordAdded>2012-11-12T14:19:01.539-08:00</dateRecordAdded>
      <domainId>33678705570176</domainId>
      <emailAddress>kim.jensen2@hp.com</emailAddress>
      <status>ENABLED</status>
      <timeLastSuccessfulLogin>2012-11-12T14:19:02.961-08:00</timeLastSuccessfulLogin>
      <username>SW_12112012141901492</username>
   </user>
</userDetails>
```

**Curl Example**

Not yet documented.


