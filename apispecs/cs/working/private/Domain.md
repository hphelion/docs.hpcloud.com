# Domain

The entity that serves as a collection of users, groups, roles, and tenants. It represents the primary relationship between the customer and HP.  A Domain can be an individual or company.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## Check for existence of domain name 
#### HEAD [HPKeystoneExtensionBaseURI]/domains?name=domainName 
*Privilege Level: Anonymous*

This API does case insensitive domainName lookup in system. It returns http status code 200 (Ok) when provided domainName exists and returns 404 (not found) when provided domainName is not found in the system. If provided domainName is blank or missing, then it returns 204 (No content). The domain name with extra spaces is converted to single space in-between words and then look up is done for its existence. So domain name " Abc Corp" and "ABC    Corp" are treated as same and will be found if entry is there in system. In system, the corresponding name is going to be stored as "abc corp" in a separate field.    
  
{{PRIVATE}} As this API just checks for existence of provided domainName, it does not do look into status (or any other entity attribute) for case when matching domain is found.

**Request Data**

This API does not require http header X-Auth-Token and is protected by client certificate authentication. There is no response body returned in API response data. 

**URL Parameters**

* *name* - string - name of the domain to look for existence (required)

**Data Parameters**

This call does not require a request body

JSON

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
```

XML

Case-insensitive lookup of above domainName

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=domain_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
```

Optional:

JSON 

When provided domainName not found

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
```

When missing domainName in request

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
```

**Success Response**

There is no response body returned. Status code indicates the result where 200 indicates that provided name exists and 404 indicates when name does not exist.

**Status Code**

200 - OK , 404 - NOT FOUND

**Response Data**

This call does not return a response body and result is determined through returned http status code. Response body is present only in case of errors.

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:15:56 GMT
```

XML

Response for case-insensitive lookup of above domainName

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:17:00 GMT
```

**Error Response**

Status code 204 is returned when either domain name is missing or blank.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 204 | No Content | When domainName is missing or blank |  
| 400 | Bad Request | Malformed request in URI |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

When provided domainName is not found

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: \-1
Content-Type: text/html;charset=utf-8
Content-Length: 952
Date: Tue, 21 Aug 2012 19:17:43 GMT
```

When missing domainName in request

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: \-1
Date: Tue, 21 Aug 2012 19:18:23 GMT
```


Curl Example

```
curl -k  --cert dev_hpmiddleware.pem  -I -H "Accept: application/json" "https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21565"
```

**Additional Notes**



## Create a Domain 
#### GET [HPKeystoneExtensionBaseURI]/domains 
*Privilege Level: System Adminstrator (SA)*

Creates a domain using the specified request body. A response body is also returned with the new domain information with a service generated domainId.

**Request Data**

This API does require http header X-Auth-Token

**URL Parameters**



**Data Parameters**

See schema file, domain.xsd, for more details on the request and response data structure.



* *name* - string - Name of the domain to be created
* *description* - (Optional) - string - description of domain
* *addressLine1* (Optional) - string - 
* *addressLine2* (Optional) - string - 
* *city* (Optional) - string - 
* *state* (Optional) - string - 
* *zip* (Optional) - string - 
* *country* (Optional) - string - 
* *phone* (Optional) - string - 
* *company* (Optional) - string - 
* *website* (Optional) - string - 
* *emailAddress* (Optional) - string -



JSON

```
POST https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
Content-Type: application/json
Content-Length: 495
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

{
  "domain" : {
    "description" : "See's Candies Domain",
    "anies" : null,
    "addressLine1" : "128, Market Blvd",
    "addressLine2" : null,
    "city" : "San Francisco",
    "company" : null,
    "country" : "USA",
    "domainId" : "50277849949620",
    "emailAddress" : "owner@sees.com",
    "name" : "Sees Candies",
    "otherAttributes" : {
    },
    "phone" : "1-800-555-1212",
    "state" : "CA",
    "status" : "enabled",
    "website" : "www.sees.com",
    "zip" : "90210"
  }
}
```

XML

```
POST /v2.0/HP-IDM/v1.0/domains HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f47d0b12cdc8b1c3905dbda
Host: localhost:9999
Connection: keep-alive
Content-Length: 617
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled">
  <description>Hp's Private Cloud Domain</description>
</domain>
```

Optional:


**Success Response**

The response body contains data for newly created domain with http status code of 201.

**Status Code**

201 - CREATED

**Response Data**

Response data structure is same as input domain data

JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=5A0C0E3AD8FBB574807901C3F1FB5741; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 426
Date: Tue, 30 Oct 2012 20:19:32 GMT

{
  "domain" : {
    "description" : "See's Candies Domain",
    "addressLine1" : "128, Market Blvd",
    "city" : "San Francisco",
    "country" : "USA",
    "domainId" : "25279093386747",
    "emailAddress" : "owner@sees.com",
    "name" : "Sees Candies",
    "otherAttributes" : {
    },
    "phone" : "1-800-555-1212",
    "state" : "CA",
    "status" : "enabled",
    "website" : "www.sees.com",
    "zip" : "90210"
  }
}
```

XML

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 643
Date: Fri, 24 Feb 2012 18:02:43 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" domainId="80354991891807" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled">
  <description>Hp's Private Cloud Domain</description>
</domain>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**


| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 409 | Identity Fault | A Domain with the required parameters already exist in the system.  |  
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

In case domain name already exists
```
HTTP/1.1 409 Conflict
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=8AD5634E0DBA2968E3136CDB8F3C6EB5; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 154
Date: Tue, 30 Oct 2012 20:20:32 GMT

{
  "IdentityFault" : {
    "message" : "Identity fault",
    "details" : "Domain already exists",
    "code" : 409,
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
curl -k --cert dev_hpmiddleware.pem  -XPOST -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" -d '{  "domain" : {  "name" : "Sees Candies 6" } }'  https://localhost:35357/v2.0/HP-IDM/v1.0/domains
```

**Additional Notes**



## Delete a Domain 
#### DELETE [HPKeystoneExtensionBaseURI]/domains/{domainId} 
*Privilege Level: System Adminstrator (SA)*

Deletes the specified domain by its {domainID}. This API deletes the Users, Tenants, Groups, Roles, RoleRefs and Grants associated to the Domain.

**Request Data**

This API does require http header X-Auth-Token

**URL Parameters**



**Data Parameters**

This call does not require a request body

JSON

```
DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```

XML

Now trying to delete previously deleted domain, expecting error.

```
DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```

Optional:



**Success Response**

There is no respone body and respons code of 204 is returned after successful deletion of domain.

**Status Code**

204 - No Content

**Response Data**

This call does not have a response body other than in case of errors.

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=38FAFEF8E7816E6B717B1328FC6AFF49; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Tue, 30 Oct 2012 21:30:16 GMT
```

XML

Response for deleting previously deleted domain.

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=5E50B7163151DDF072B2B0E5AF5B33BF; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 368
Date: Tue, 30 Oct 2012 21:31:04 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?><itemNotFound xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="404"><message>Not found</message><details>Domain does not exist</details></itemNotFound>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request. This error is also returned when there is dependent data that needs to be removed as well |  
| 404 | Not Found | The Domain for domainId does not exist    |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

Response for deleting previously deleted domain.

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=E58C6550A98478BD88C3392EB379F734; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 148
Date: Tue, 30 Oct 2012 21:43:21 GMT

{
  "itemNotFound" : {
    "code" : 404,
    "details" : "Domain does not exist",
    "message" : "Not found",
    "otherAttributes" : {
    }
  }
}
```

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
curl -k --cert dev_hpmiddleware.pem  -XDELETE -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196
```

**Additional Notes**



## Get a Domain 
#### GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## {getalldomains}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## {getgroupsfordomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## {getservicesforadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## {gettenantsforadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## {getusersforadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## {listroles}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## {transferownershipofadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## {updateadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


