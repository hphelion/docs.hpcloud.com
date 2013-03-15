---
layout: page
permalink: /api/identity/
title: Identity Services API
description: "HP Cloud Identity Services API documenation."
keywords: "Keystone, Identity Services"
product: identity
---

# Identity Services API

# 1. Overview

*Brief introduction and overview of the service and its intended use.*



## 1.1 API Maturity Level


**Maturity Level**: GA

**Version API Status**: CURRENT


---

# 2. Account-level View
*Describe the relationship of the API with respect to the accounts, groups, tenants, regions, availability zones etc.*


## 2.1 Accounts
*Describe the structure of the user accounts, groups and tenants. Currently this might be described separately in context of Control Services, but in future each service API needs to state their usage. In future CS might support complex group hierarchies, enterprise account structures while there maybe a phased adoption by individual service APIs*

## 2.2 Regions and Availability Zones
*Describe the availability of the service API in different regions and availability zones. State plans for future expansion as well.*

**Region(s)**: region-a, region-b

**Availability Zone(s)**: az-1, az-2, az-3

**Future Expansion**:


## 2.3 Service Catalog

The service is exposed in the service catalog, as shown in the following fragment:

    {
        "name": "Identity",
        "type": "identity",
        "endpoints": [
            {
                "publicURL": "https://region-b.geo-1.identity.hpcloudsvc.com:35357/v2.0/",
                "region": "region-b.geo-1",
                "versionId": "2.0",
                "versionInfo": "https://region-b.geo-1.identity.hpcloudsvc.com:35357/v2.0/",
                "versionList": "https://region-b.geo-1.identity.hpcloudsvc.com:35357"
            },
            {
                "publicURL": "https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/",
                "region": "region-a.geo-1",
                "versionId": "2.0",
                "versionInfo": "https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/",
                "versionList": "https://region-a.geo-1.identity.hpcloudsvc.com:35357"
            }
        ]
    }

---


# 3. REST API Specifications
*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*

## 3.1 Service API Operations


**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseUri**: {Host}/v2.0

**Admin URI**: N/A

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? |
| :------- | :------------------- | :---------- | :--------------------- | :---------------- |
| Projects | [List Projects](#list_projects) | GET | /projects | Y/Y |
| Tokens | [Authenticate](#authenticate) | POST | /v3/auth/tokens | Y/Y |
| Tokens | [Rescope Token](#rescope_token) | POST | /v3/auth/tokens | Y/Y |
| Tokens | [Revoke Token](#revoke_token) | DELETE | /v3/auth/tokens/ | Y/Y |
| Versions | [GET Versions](#get_versions) | DELETE | /v3/auth/tokens/ | Y/Y |

## 3.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

## 3.3 Common Response Headers
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *

## 3.4 Service API Operation Details
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*


### 3.4.1 Projects

Project is a collection of services, and associated with zero or more users who have access to these services via role references.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 3.4.1.1 List Projects#### {#list_projects}
#### GET /projects

This API returns a listing of all projects for which the holder of the provided token has a role assignment. If the user is not a valid, an error is returned.

**Request Data**

This API supports pagination. See Pagination for more details.

This API also supports an optional *name* filter for get-by-name. Pagination and *name* filter are mutually exclusive.

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional)} - string - the resource Id of the last item in the previous list
* *name* (Optional) - string - name of the project to be returned

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

    GET /v3/projects HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v3/projects/ HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

Optional:

JSON

With *name* filter.

    GET /v3/projects?name=projectName HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

With *projectId* filter.

    GET /v3/projects/00000000005002 HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

With pagination.

    GET /v3/projects?limit=2 HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

With the authenticated user's domain that are enabled.

    GET /v3/projects?enabled=true HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

XML

With pagination.

    GET /v3/projects?limit=100&marker=S4DFJ123SF HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

A list of projects in the specified format is returned.

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "ArrayList" : [ {
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005001",
        "name" : "HP Cloud System Domain's-Tenant01",
        "otherAttributes" : {
        }
      }, {
        "description" : "Test tenant 2 is an enabled tenant",
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005002",
        "name" : "Test tenant 2",
        "otherAttributes" : {
        }
      }, {
        "description" : "Test tenant 3 is a terminated tenant",
        "domain_id" : "00000000001001",
        "enabled" : false,
        "id" : "00000000005003",
        "name" : "Test tenant 3",
        "otherAttributes" : {
        }
      } ]
    }

With *name* filter.

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "ArrayList" : [ {
        "description" : "Test tenant 2 is an enabled tenant",
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005002",
        "name" : "Test tenant 2",
        "otherAttributes" : {
        }
      } ]
    }

With Pagination

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "ArrayList" : [ {
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005001",
        "name" : "HP Cloud System Domain's-Tenant01",
        "otherAttributes" : {
        }
      }, {
        "description" : "Test tenant 2 is an enabled tenant",
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005002",
        "name" : "Test tenant 2",
        "otherAttributes" : {
        }
      } ]
    }

With authenticated user's domain that are enabled

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "ArrayList" : [ {
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005001",
        "name" : "HP Cloud System Domain's-Tenant01",
        "otherAttributes" : {
        }
      }, {
        "description" : "Test tenant 2 is an enabled tenant",
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005002",
        "name" : "Test tenant 2",
        "otherAttributes" : {
        }
      } ]
    }

With projectId filter

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "project" : {
        "description" : "Test tenant 2 is an enabled tenant",
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005002",
        "name" : "Test tenant 2",
        "otherAttributes" : {
        }
      }
    }

XML

    

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

***List Projects***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/projects"

***Get Project By Name***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/projects?name=MyProject"

**Additional Notes**


### 3.4.2 Tokens

An unique identifier which is used to identify the privilege of the user.


1. Given a user name & password, get a token to represent the user.
2. Given a token, validate the token and return user, domain, project, roles and potential endpoints.
3. Given a valid token, request another token with a different domain/project (change domain/project being represented with the user).
4. Given a valid token, force it's immediate revocation.

//  Add stuff about uniqueness once it is done

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 3.4.2.1 Authenticate#### {#authenticate}
#### POST /v3/auth/tokens

This API is used to authenticate a user to be able to use an OpenStack service. The result of a successful authentication is a token to be used with service requests. A credential is used to obtain a token. We currently support username/password and  access/secret key credentials. If authentication succeeds, the response will include an authentication token and service catalog ( list of available services for that user ). Tokens are valid for 12 hours. Issued tokens can become invalid in two cases:

1. the token has expired
2. the token has been revoked.

Besides using a username and password, another way to authenticate is using symmetric keys. Symmetric keys are user access key and secret key pairs provisioned for user account. In this type of credential data, request body is expected to contain an access key and a secret key information belonging to the user. Once those keys are verified, a new token is created. In this type of authentication, the only change is in expected request body data (please see related example below). There is no difference in response format/content whether authentication is done using password credential data or access key credential data.

##### Service Catalog:

In case of un-scoped token request, the service catalog is going to include global active endpoint templates as endpoints in its data. In case of scoped token request, the service catalog is going to include tenant specific endpoints as well as global active endpoint templates as endpoints.

##### Scoped Tokens:

A token can be scoped either to a domain or to a project.  ProjectId or DomainId/DomainName can be used to socpe the token to project or domain respecively. ProjectName can also be used, in that case caller need to qualify the project using domain informationm, since project name is not globally unique. Project name is unqiue only in its domain

A project scoped token will also return service endpoints for other services associated with the project in question. An unscoped token will likely not contain service endpoints except for those for the Identity Service. Note that if prjoect information is unknown, an unscoped token can be obtained and then a list of projects obtained. Project information can also be found in the Management Console.

**Request Data**

See examples below.

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

JSON

Authenticate using userid/password credential for an unscoped token.

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "21243386194835",
                    "password": "secrete"
                }
            }
        }
    }


Authenticate using username/password credential for an unscoped token.  User is qualified using domain name

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "21243386194835",
                    "password": "secrete",
                    "domain" : {
                       "name" : "HPCSDemoDomain"
                     }
                }
            }
        }
    }


Authenticate using username/password credential for an unscoped token.  User is qualified using domain id

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "name": "HPCSDemoDomain_User1",
                    "password": "secrete",
      	       "domain" : {
    		  "id" : "94710780204290"
    	        }
                }
            }
        }
    }


Authenticate using password credential,scoped to a project using prject id.

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "453453453545",
                    "password": "secrete"
                }
            }
        },
        "scope": {
            "project": {
                "id": "94710780204290"
            }
        }
       }
    }

Authenticate using password credential,scoped to a project using prject name.  Project name is qualified using domain Id

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "453453453545",
                    "password": "secrete"
                }
            }
        },
        "scope": {
            "project": {
                "name": "HPCSDemoDomain_dev_project",
                "domain" : {
    		  "id" : "94710780204290"
    	     }
            }
        }
       }
    }

Authenticate using password credential, scoped to a doamin using domain name. 

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "453453453545",
                    "password": "secrete"
                }
            }
        },
        "scope": {
            "domain" : {
    	  "name" : "HPCSDemoDomain"
             }
         }
        }
       }
    }


Authenticate using password credential, scoped to a doamin using domain id. 

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "453453453545",
                    "password": "secrete"
                }
            }
        },
        "scope": {
            "domain" : {
    	  "id" : "94710780204290"
             }
         }
        }
       }
    }


Authenticate using access key credential.

    {
       "auth":{
          "identity":{
             "methods":[
                "accessKey"
             ],
             "accessKey":{
                "accessKey":"VCAVE3Y6RL9K8ADVKMY5",
                "secretKey":"quyNVz7gMtpG9QsLz0DUrqGocYbr5X+KGbkJsqzs"
             }
          }
       }
    }


Rescope token.

    {
       "auth":{
          "identity":{
             "methods":[
                "tokens"
             ],
             "token":{
                "id":"HPAuth_a6f32cefceb798cedd3183c71c07a3d169c8ad613e0c951ae5f426c015dd3210"
             }
          }
       }
    }
    

XML

Authenticate using password credential for a unscoped token.

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <auth xmlns="http://docs.openstack.org/identity/api/v3.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/common/api/v1.0">
        <identity>
             <methods>password</methods>
            <password>
                <user name="haneeftest" password="haneeftest"/>
            </password>
        </identity>    
    </auth>
    
    


Authenticate using password credential for a Project unscoped token.

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <auth xmlns="http://docs.openstack.org/identity/api/v3.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/common/api/v1.0">
        <identity>
             <methods>password</methods>
            <password>
                <user name="haneeftest" password="haneeftest"/>
            </password>
        </identity>    
        <scope>
            <project name="HPCSDeomonDomain_DevProject">
                <domain name="HPCSDemonDomain"/>
            </project>
        </scope>
    </auth>
    
    

Authenticate using access key credential Domain scoped

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <auth xmlns="http://docs.openstack.org/identity/api/v3.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/common/api/v1.0">
        <identity>
             <methods>password</methods>
            <password>
                 <accessKey accessKey="quyNVz7gMtpG9QsLz0DUrqGocYbr5X+KGbkJsqzs" secretKey="VCAVE3Y6RL9K8ADVKMY5"/>
            </password>
        </identity>    
        <scope>
            <domain name="HPCSDeomonDomain">
            </domain>
        </scope>
    </auth>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

Unscoped token response

    HTTP/1.1 200 OK
    X-Auth-Token: a32b28f56a874de3a22abfb2312b7199
    Content-Type: application/json
    Date: Tue, 12 Feb 2013 01:21:54 GMT
    Transfer-Encoding: chunked
     
     
    {
       "token":{
          "methods":[
             "password"
          ],
          "domain":{
             "otherAttributes":{
    
             }
          },
          "project":{
             "otherAttributes":{
    
             }
          },
          "roles":[
             {
                "id":"00000000004003",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004003",
                      "rel":"self"
                   }
                ],
                "name":"domainadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004004",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004004",
                      "rel":"self"
                   }
                ],
                "name":"domainuser",
                "otherAttributes":{
    
                }
             }
          ],
          "user":{
             "domain":{
                "id":"94710780204290",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/domains/94710780204290",
                      "rel":"self"
                   }
                ],
                "name":"HPCSDemoDomain",
                "otherAttributes":{
    
                }
             },
             "id":"21243386194835",
             "link":[
                {
                   "href":"https://localhost:35357/v3/users/21243386194835",
                   "rel":"self"
                }
             ],
             "name":"HPCSDemoDomain_Admin",
             "otherAttributes":{
    
             }
          },
          "catalog":[
             {
                "endpoints":[
                   {
                      "id":"130_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/130_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"100",
                      "url":"https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"identity"
             },
             {
                "endpoints":[
                   {
                      "id":"190001_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/190001_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"190",
                      "url":"http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"metering"
             }
          ],
          "expires_at":"2013-03-13T10:10:29.161Z",
          "issued_at":"2013-03-12T17:56:59.469Z",
          "otherAttributes":{
    
          }
       }
    }


Project scoped tokens response


    HTTP/1.1 200 OK
    X-Auth-Token: a32b28f56a874de3a22abfb2312b7199
    Content-Type: application/json
    Date: Tue, 12 Feb 2013 01:21:54 GMT
    Transfer-Encoding: chunked
     
    {
       "token":{
          "methods":[
             "password"
          ],
          "domain":{
             "otherAttributes":{
    
             }
          },
          "project":{
             "domain":{
                "id":"94710780204290",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/domains/94710780204290",
                      "rel":"self"
                   }
                ],
                "name":"haneeftest",
                "otherAttributes":{
    
                }
             },
             "id":"56524744656491",
             "link":[
                {
                   "href":"https://localhost:35357/v3/projects/56524744656491",
                   "rel":"self"
                }
             ],
             "name":"haneeftest_project",
             "otherAttributes":{
    
             }
          },
          "roles":[
             {
                "id":"00000000004024",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004024",
                      "rel":"self"
                   }
                ],
                "name":"user",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004013",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004013",
                      "rel":"self"
                   }
                ],
                "name":"block-admin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004016",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004016",
                      "rel":"self"
                   }
                ],
                "name":"netadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004003",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004003",
                      "rel":"self"
                   }
                ],
                "name":"domainadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004025",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004025",
                      "rel":"self"
                   }
                ],
                "name":"sysadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004004",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004004",
                      "rel":"self"
                   }
                ],
                "name":"domainuser",
                "otherAttributes":{
    
                }
             }
          ],
          "user":{
             "domain":{
                "id":"94710780204290",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/domains/94710780204290",
                      "rel":"self"
                   }
                ],
                "name":"haneeftest",
                "otherAttributes":{
    
                }
             },
             "id":"21243386194835",
             "link":[
                {
                   "href":"https://localhost:35357/v3/users/21243386194835",
                   "rel":"self"
                }
             ],
             "name":"haneeftest",
             "otherAttributes":{
    
             }
          },
          "catalog":[
             {
                "endpoints":[
                   {
                      "id":"130_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/130_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"100",
                      "url":"https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"identity"
             },
             {
                "endpoints":[
                   {
                      "id":"160_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/160_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"140",
                      "url":"https://glance.rndd.aw1.hpcloud.net:9292/v1.0"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"image"
             },
             {
                "endpoints":[
                   {
                      "id":"140_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/140_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"130",
                      "url":"https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"volume"
             },
             {
                "endpoints":[
                   {
                      "id":"190001_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/190001_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"190",
                      "url":"http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"metering"
             },
             {
                "endpoints":[
                   {
                      "id":"100_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/100_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"120",
                      "url":"http://az1-nv-schedule-0000.rndd.aw1.hpcloud.net:8774/v1.1/56524744656491"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"compute"
             }
          ],
          "expires_at":"2013-03-13T10:22:37.047Z",
          "issued_at":"2013-03-12T22:22:37.047Z",
          "otherAttributes":{
    
          }
       }
    }
    

XML

XML response unscoped token

    
    <?xml version="1.0" encoding="UTF-8"?>
    <token xmlns="http://docs.openstack.org/identity/api/v3.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/common/api/v1.0">
       <expires_at>2013-03-13T10:30:43.137Z</expires_at>
       <issued_at>2013-03-12T17:56:59.469Z</issued_at>
       <methods>password</methods>
       <domain />
       <project />
       <catalog type="identity">
          <endpoints id="130_P" interface="public" region="region-a.geo-1" url="https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/" service_id="100">
             <ns2:link rel="self" href="https://localhost:35357/v3/endpoints/130_P" />
          </endpoints>
       </catalog>
       <catalog type="metering">
          <endpoints id="190001_P" interface="public" region="region-a.geo-1" url="http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/" service_id="190">
             <ns2:link rel="self" href="https://localhost:35357/v3/endpoints/190001_P" />
          </endpoints>
       </catalog>
       <roles id="00000000004003" name="domainadmin">
          <ns2:link rel="self" href="https://localhost:35357/v3/roles/00000000004003" />
       </roles>
       <roles id="00000000004004" name="domainuser">
          <ns2:link rel="self" href="https://localhost:35357/v3/roles/00000000004004" />
       </roles>
       <user id="21243386194835" name="haneeftest">
          <domain id="94710780204290" name="haneeftest">
             <ns2:link rel="self" href="https://localhost:35357/v3/domains/94710780204290" />
          </domain>
          <ns2:link rel="self" href="https://localhost:35357/v3/users/21243386194835" />
       </user>
    </token>
    
    

XML response project scoped  token

    
    <?xml version="1.0" encoding="UTF-8"?>
    <token xmlns="http://docs.openstack.org/identity/api/v3.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/common/api/v1.0">
       <expires_at>2013-03-13T10:33:25.133Z</expires_at>
       <issued_at>2013-03-12T17:56:59.469Z</issued_at>
       <methods>password</methods>
       <domain />
       <project />
       <catalog type="identity">
          <endpoints id="130_P" interface="public" region="region-a.geo-1" url="https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/" service_id="100">
             <ns2:link rel="self" href="https://localhost:35357/v3/endpoints/130_P" />
          </endpoints>
       </catalog>
       <catalog type="metering">
          <endpoints id="190001_P" interface="public" region="region-a.geo-1" url="http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/" service_id="190">
             <ns2:link rel="self" href="https://localhost:35357/v3/endpoints/190001_P" />
          </endpoints>
       </catalog>
       <roles id="00000000004003" name="domainadmin">
          <ns2:link rel="self" href="https://localhost:35357/v3/roles/00000000004003" />
       </roles>
       <user id="21243386194835" name="haneeftest">
          <domain id="94710780204290" name="haneeftest">
             <ns2:link rel="self" href="https://localhost:35357/v3/domains/94710780204290" />
          </domain>
          <ns2:link rel="self" href="https://localhost:35357/v3/users/21243386194835" />
       </user>
    </token>
    


**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Response Data**

JSON

    {
      "identityFault": {
        "message": "Fault",
        "details": "Error Details...",
        "code": 500
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8"?>
    <identityFault xmlns="http://docs.openstack.org/identity/api/v2.0"
              code="500">
            <message>Fault</message>
            <details>Error Details...</details>
    </identityFault>

Curl Example

***Authenticate with Username/Password and Tenant ID***

    curl -X POST -H "Content-Type: application/json"
         https://region-a.geo-1.identity.hpcloudsvc.com:35357/v3/auth/tokens
         -d '{"auth": {"identity": {	"methods": ["password"],"password": {"user": {"id": "342343232432", "password": "Super secret"	}}},"scope": {  "project": {"id": "453454354"} }} }'
    

***Authenticate with Access Keys and Tenant ID***

    

**Additional Notes**


#### 3.4.2.2 Rescope Token#### {#rescope_token}
#### POST /v3/auth/tokens

This API provides the ability to re-scope a valid token with another tenant. An existing unexpired token, regardless of its currently scoped or not, can be scoped to another tenant as long as the user has valid association with that tenant.

Re-scoping of token can be done from 1) unscoped token to a scoped token for specific tenant 2) scoped token from one tenant to another tenant 3) scoped token to unscoped token (with no tenantId and tenantName specified in request). Re-scoping of token does not alter the token expiration time and same token id is returned in response.

##### Service Catalog:

In case of un-scoped token request, the service catalog is going to include global active endpoint templates as endpoints in its data. In case of scoped token request, the service catalog is going to include tenant specific endpoints as well as global active endpoint templates as endpoints.

**Request Data**


**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

JSON

Domain Scoping

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 154
    
    {
        "auth": {
            "identity": {
                "methods": ["token"],
                "token": {
                    "id": "HPAuth_332fa874565d61c87f50cf37af955cf5e95f1e174c95776855780f584b3386e3"
                }
            },
            "scope": {
                "domain": {
                    "id": "345435435435435"               
                }
            }
        }
    }

Project Scoping

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 154
    
    {
        "auth": {
            "identity": {
                "methods": ["token"],
                "token": {
                    "id": "--token-id--"
                }
            },
            "scope": {
                "project": {          
                    "name": "HPCSDemoDomain_dev_Project",
    	       "domain": {
             	       "id": "345435435435435"               
    	        }
                }
            }
        }
    }

XML

    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    Content-Length: 195
    
    

**Success Response**


**Status Code**

200 - OK

**Response Data**


JSON

    HTTP/1.1 200 OK
    X-Auth-Token: a32b28f56a874de3a22abfb2312b7199
    Content-Type: application/json
    Date: Tue, 12 Feb 2013 01:21:54 GMT
    Transfer-Encoding: chunked
     
    {
       "token":{
          "methods":[
             "password"
          ],
          "domain":{
             "otherAttributes":{
    
             }
          },
          "project":{
             "domain":{
                "id":"94710780204290",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/domains/94710780204290",
                      "rel":"self"
                   }
                ],
                "name":"haneeftest",
                "otherAttributes":{
    
                }
             },
             "id":"56524744656491",
             "link":[
                {
                   "href":"https://localhost:35357/v3/projects/56524744656491",
                   "rel":"self"
                }
             ],
             "name":"haneeftest_project",
             "otherAttributes":{
    
             }
          },
          "roles":[
             {
                "id":"00000000004024",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004024",
                      "rel":"self"
                   }
                ],
                "name":"user",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004013",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004013",
                      "rel":"self"
                   }
                ],
                "name":"block-admin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004016",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004016",
                      "rel":"self"
                   }
                ],
                "name":"netadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004003",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004003",
                      "rel":"self"
                   }
                ],
                "name":"domainadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004025",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004025",
                      "rel":"self"
                   }
                ],
                "name":"sysadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004004",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004004",
                      "rel":"self"
                   }
                ],
                "name":"domainuser",
                "otherAttributes":{
    
                }
             }
          ],
          "user":{
             "domain":{
                "id":"94710780204290",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/domains/94710780204290",
                      "rel":"self"
                   }
                ],
                "name":"haneeftest",
                "otherAttributes":{
    
                }
             },
             "id":"21243386194835",
             "link":[
                {
                   "href":"https://localhost:35357/v3/users/21243386194835",
                   "rel":"self"
                }
             ],
             "name":"haneeftest",
             "otherAttributes":{
    
             }
          },
          "catalog":[
             {
                "endpoints":[
                   {
                      "id":"130_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/130_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"100",
                      "url":"https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"identity"
             },
             {
                "endpoints":[
                   {
                      "id":"160_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/160_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"140",
                      "url":"https://glance.rndd.aw1.hpcloud.net:9292/v1.0"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"image"
             },
             {
                "endpoints":[
                   {
                      "id":"140_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/140_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"130",
                      "url":"https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"volume"
             },
             {
                "endpoints":[
                   {
                      "id":"190001_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/190001_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"190",
                      "url":"http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"metering"
             },
             {
                "endpoints":[
                   {
                      "id":"100_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/100_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"120",
                      "url":"http://az1-nv-schedule-0000.rndd.aw1.hpcloud.net:8774/v1.1/56524744656491"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"compute"
             }
          ],
          "expires_at":"2013-03-13T10:22:37.047Z",
          "issued_at":"2013-03-12T22:22:37.047Z",
          "otherAttributes":{
    
          }
       }
    }
     
    

XML

    

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

**Response Data**

JSON

    {
      "identityFault": {
        "message": "Fault",
        "details": "Error Details...",
        "code": 500
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8"?>
    <identityFault xmlns="http://docs.openstack.org/identity/api/v2.0"
              code="500">
            <message>Fault</message>
            <details>Error Details...</details>
    </identityFault>

Curl Example

    curl -k -H "Content-Type: application/json" -d '{"auth": {"identity": {"methods": ["tokens"],"token": {	"id": "HPAuth_a6f32cefceb798cedd3183c71c07a3d169c8ad613e0c951ae5f426c015dd3210"}}}}' -X POST https://region-a.geo-1.identity.hpcloudsvc.com:35357/v3/auth/tokens

**Additional Notes**


#### 3.4.2.3 Revoke Token#### {#revoke_token}
#### DELETE /v3/auth/tokens/

This API is used to revoke an authentication token. This operation does not require a request body. Once a token has been revoked, attempts to validate the token via GET /tokens/ will fail with a 404 (item not found) as the token no longer exists. Trying revoke a non existing token, including one which has expired will also return a 404 (item not found).


**HTTP Headers**

| Header Name | Description | Required | Comments |
| :-----------| :-----------| :------- | :--------| 
| X_Auth-Token       | Callers authorization token |  Y  | |
| X-Subject-Token    | Token to be deleted         |  Y  | |
| Accept		   | Content Type of response    |  N  |Defaults to Json |

**Request Data**


**URL Parameters**

None

**Data Parameters**

This call does not require a request body.

**Success Response**


**Status Code**

200 - OK

**Response Data**


**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |


**Response Data**

JSON

    {"forbidden":{"message":"Full authentication is required to access this resource","code":403}}

XML

    <?xml version="1.0" encoding="UTF-8"?><forbidden xmlns="http://docs.openstack.org/identity/api/v2.0" code="403"><message>Full authentication is required to access this resource</message></forbidden>

Curl Example

    curl -k -X DELETE -H "X-Auth-Token:HPAuth_23423423424234" -H "X-Subject-Token: HPAuth_45345345345454534"   https://region-a.geo-1.identity-internal.hpcloudsvc.com/v3/auth/tokens

**Additional Notes**

Keystone doesn't require X-Auth-Token headers. HPCS requires X-Auth-Token header


### 3.4.3 Versions



**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 3.4.3.1 GET Versions#### {#get_versions}
#### GET /



**Request Data**


**URL Parameters**



**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.

JSON

    

XML

    

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

A list of tenants in the specified format is returned.

JSON

    

XML

    

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

***Get Versions***

 

**Additional Notes**

---

