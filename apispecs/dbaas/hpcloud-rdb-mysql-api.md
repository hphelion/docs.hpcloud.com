---
layout: page
permalink: /api/dbaas/
title: Relational Database for MySQL (dbaas) API
description: "Relational Database for MySQL API Documentation."
keywords: "MySQL, RDB, DBaaS"
product: dbaas
publish: false

---
# Relational Database for MySQL (dbaas) API

# 1. Overview

This document describes the HP Cloud Relational Database for MySQL API, which allows you to create database instances and snapshots that you can then interact with using your favorite database client.

Questions? Comments? Let us know over at our forum.


## 1.1 API Maturity Level

**Maturity Level**: Public

**Version API Status**: BETA

---


# 2. Architecture View


## 2.1 Overview
The HP Cloud Relational Database for MySQL (RDB-MySQL) allows clients to create database instances on demand. This document is intended for software developers interested in developing applications that utilize the RDB-MySQL API.

This guide assumes the reader is familiar with RESTful web services, HTTP/1.1, and JSON and/or XML serialization formats.

## 2.2 Conceptual/Logical Architecture View
*Describe the logical components of the system and their responsibilities*

## 2.3 Infrastructure Architecture View
*Describe how the API fits into the overall HPCS Infrastructure*

## 2.4 Entity Relationship Diagram
*Describe the relationships between the various entities (resources) involved in the API*


---

# 3. Account-level View
Like all HP Cloud offerings, authentication for RDB-MySQL is achieved through the Identity Service, which will return an X-Auth-Token that is used for subsequent requests to individual services.



## 3.1 Accounts
For additional details on the Identity Service, please refer to https://docs.hpcloud.com/identity


## 3.2 Regions and Availability Zones
*Describe the availability of the service API in different regions and availability zones. State plans for future expansion as well.*

**Region(s)**: region-a

**Availability Zone(s)**: az-1, az-2, az-3 

**Future Expansion**: region-b


## 3.3 Service Catalog
The service is exposed in the service catalog, as shown in the following fragment:


    {
       service catalog fragment here
    }


---


# 4. REST API Specifications
The HP Cloud RDB-MySQL API is implemented using a RESTful web service interface. All requests to authenticate and operate against the RDB-MySQL API should be performed using SSL over HTTP (HTTPS) on TCP port 443.

Similarly, all response types are in JSON as well.

## 4.1 Service API Operations


**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseUri**: {Host}/v1.1/{tenant_id}

**Admin URI**: N/A

###Database Instance Operations

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Instance | List all database instances                        | GET         | /instances                      | Y                 |                 |
| Instance | Create a new database instance                     | POST        | /instances                      | Y                 |                 |
| Instance | Get information about a specific database instance | GET         | /instances/*instance_id*        | Y                 |                 |
| Instance | Delete a specific database instance                | DELETE      | /instances/*instance_id*        | Y                 |                 |
| Instance | Perform an action on a specific database instance  | POST        | /instances/*instance_id*/action | Y                 |                 |

###Flavor Operations

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Flavor   | List all flavors                                   | GET         | /flavors                        | Y                 |                 |
| Flavor   | List all flavors in detail                         | GET         | /flavors/detail                 | Y                 |                 |
| Flavor   | Get a specific flavor                              | GET         | /flavors/*flavor_id*            | Y                 |                 |

###Security Group Operations

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Security Group | List all security groups                     | GET         | /security-groups                | Y                 |                 |
| Security Group | Get details for a specific security group    | GET         | /security-groups/*security_group_id* | Y                 |                 |
| Security Group | Create a new rule for a security group       | POST        | /security-group-rules           | Y                 |                 |
| Security Group | Get information about a specific database instance snapshot | GET      | /security-group-rules/*security_group_rule_id* | Y                 |                 |
| Security Group | Delete a specific database instance snapshot | DELETE      | //security-group-rules/*security_group_rule_id* | Y                 |                 |

###Version Operations

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Version  | List all API versions                              | GET         | /                               | Y                 |                 |
| Version  | Get a specific version specified by version_id     | GET         | /version_id                     | Y                 |                 |



## 4.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

## 4.3 Common Response Headers
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *

## 4.4 Service API Operation Details

### 4.4.1 Database Instance
*Describe the resource and what information they provide. Then enumerate all the API method calls below.*

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.1.1 Returns a list of all database instances
#### GET /instances

Returns a list of all database instances

**Request Data**

    GET /v1.0/<tenant_id>/instances HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351

**Data Parameters**

This call does not require a request body

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header


    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 525
    Date: Wed, 07 Mar 2012 17:35:09 GMT


JSON Body


    {
        "created": "2012-10-29T22:34:53", 
        "flavor": {
            "id": "103", 
            "links": [
                {
                    "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/103", 
                    "rel": "self"
                }
            ]
        }, 
        "id": "eabe9e32-6ce0-4a36-9750-df415606b44c", 
        "links": [
            {
                "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/eabe9e32-6ce0-4a36-9750-df415606b44c", 
                "rel": "self"
            }
        ], 
        "name": "My_Instance", 
        "status": "building"
    }


**Error Response**

Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), internal server error (500)


**Curl Example**


    $ curl -X GET \
        -H "X-Auth-Token: HPAuth_4f7db4b6e4b02499a5ccb04a" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/instances




#### 4.4.1.2 Create a new database instance
#### POST /instances

Create a new database instance

**Request Data**


    POST /v1.0/<tenant_id>/instances HTTP/1.1
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Content-Length: 119


**Data Parameters**

*List all the attributes that comprises the data structure*

* *name_of_attribute* - {data type} - {description of the attribute}
* *name_of_attribute* - {data type} - {description of the attribute}
* *name_of_attribute* (Optional) - {data type} - {description of the attribute}

JSON


    {
        "instance": 
        {
            "name": "My_Instance",
            "flavorRef": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/103",
            "port": "3306",
            "dbtype":
            {
                "name": "mysql",
                "version": "5.5"
            }
        }
    }


**Success Response**

**Status Code**

201 - Created

**Response Data**

Header


    HTTP/1.1 201 Created
    Content-Type: application/json
    Content-Length: 633
    Date: Wed, 07 Mar 2012 19:03:59 GMT
    



JSON Body


    {
        "created": "2012-10-29T22:34:53", 
        "credential": {
            "password": "PazmhxNwyJD8bxvcZDTL", 
            "username": "dbas"
        }, 
        "flavor": {
            "id": "103", 
            "links": [
                {
                    "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/103", 
                    "rel": "self"
                }
            ]
        }, 
        "hostname": "", 
        "id": "eabe9e32-6ce0-4a36-9750-df415606b44c", 
        "links": [
            {
                "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/instances/eabe9e32-6ce0-4a36-9750-df415606b44c", 
                "rel": "self"
            }
        ], 
        "name": "My_Instance", 
        "security_groups": [
            {
                "id": "0af5ee60-9d40-4737-b6c4-2ab75f51ce40", 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/security-groups/0af5ee60-9d40-4737-b6c4-2ab75f51ce40", 
                        "rel": "self"
                    }
                ]
            }
        ], 
        "status": "building"
    }


**Error Response**

Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), internal server error (500)

**Curl Example**


    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "X-Auth-Token: HPAuth_0c1bf996869092ee62be650e15cd721da3df29260baff6858ef66a5ab2b1ee83" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/instances \
        -d '{"instance":{"name": "My_2nd_Instance","flavorRef": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/flavors/102","port": "3306","dbtype":{"name": "mysql","version": "5.5"}}}'


**Additional Notes**

Note that this is your only opportunity to record the username and password. The hostname of the instance will be populated once the database is in a 'running' state. To get the hostname, poll the 'Get a database instance' operation until the field is not empty and the status is 'running'"


#### 4.4.1.3 Get a database instance
#### GET /instances/*instance_id*

Returns information about the database instance specified by *instance_id*

**Request Data**


    GET /v1.0/<tenant_id>/instances/ef9e2591-7f3c-472b-b86f-f6b90f2cce5d HTTP/1.1
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351


**Data Parameters**


This call does not require a request body

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header


    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 596
    Date: Wed, 07 Mar 2012 17:43:00 GMT


JSON Body


    {
        "created": "2012-10-29T22:34:53", 
        "flavor": {
            "id": "103", 
            "links": [
                {
                    "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/103", 
                    "rel": "self"
                }
            ]
        }, 
        "hostname": "15.185.172.99", 
        "id": "eabe9e32-6ce0-4a36-9750-df415606b44c", 
        "links": [
            {
                "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/instances/eabe9e32-6ce0-4a36-9750-df415606b44c", 
                "rel": "self"
            }
        ], 
        "name": "test", 
        "port": 3306, 
        "security_groups": [
            {
                "id": "0af5ee60-9d40-4737-b6c4-2ab75f51ce40", 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/security-groups/0af5ee60-9d40-4737-b6c4-2ab75f51ce40", 
                        "rel": "self"
                    }
                ]
            }
        ], 
        "status": "running", 
        "updated": "2012-10-29T22:34:56"
    }


**Error Response**

Error Response Code(s): internal server error (500), not found (404), forbidden (403), unauthorized (401), badRequest (400)

**Curl Example**


    $ curl -X GET \
        -H "X-Auth-Token: HPAuth_4f7db4b6e4b02499a5ccb04a" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/instances/eabe9e32-6ce0-4a36-9750-df415606b44c 
    


#### 4.4.1.4 Delete a database instance
#### DELETE /instances/*instance_id*

Deletes the database instance specified by *instance_id*

**Request Data**



    DELETE /v1.0/<tenant_id>/instances/ef9e2591-7f3c-472b-b86f-f6b90f2cce5d HTTP/1.1
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351


**Data Parameters**

This call does not require a request body.

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

204 - No Content

**Response Data**

HEADER


    HTTP/1.1 204 No Content
    Content-Length: 58
    Content-Type: text/plain; charset=UTF-8
    Date: Wed, 07 Mar 2012 19:41:22 GMT


Body will be empty

**Error Response**


Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), not found (404), internal server error (500)

**Curl Example**


    $ curl -i -X DELETE \
        -H "X-Auth-Token: HPAuth_4f7db4b6e4b02499a5ccb04a" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/instances/701ce26f-7522-4d33-85c4-94117dec7a92 


#### 4.4.1.5 Restart a specific instance
#### POST /instances/*instance_id*/action   
Restarts the database instance specified by *instance_id*

**Request Data**



    POST /v1.0/<tenant_id>/instances/ef9e2591-7f3c-472b-b86f-f6b90f2cce5d/action HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Content-Length: 0

**Data Parameters**

*List all the attributes that comprises the data structure*

* *name_of_attribute* - {data type} - {description of the attribute}

JSON


    {
        "restart": {}
    }


**Success Response**

**Status Code**

204 - No Content

**Response Data**

Header


    HTTP/1.1 204 No Content
    Date: Wed, 11 Apr 2012 01:10:22 GMT
    Server: Apache/2.2.17 (Ubuntu)
    Content-Length: 0
    Content-Type: application/json

**Error Response**


Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), not found (404), internal server error (500)

**Curl Example**


    $curl -i -X POST \
        -H "Content-Type: application/json" \
        -H "X-Auth-Token: HPAuth_0c1bf996869092ee62be650e15cd721da3df29260baff6858ef66a5ab2b1ee83" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/instances/9dfcd988-3b57-4bc7-92d1-88dbc8a0080d/action  \
        -d '{"restart":{}}' 


#### 4.4.1.6 Reset the password of a specific instance
#### POST /instances/*instance_id*/action

Resets the password for the database instance specified by instance_id

**Request Data**


    POST /v1.0/<tenant_id>/instances/ef9e2591-7f3c-472b-b86f-f6b90f2cce5d/action HTTP/1.1
    User-Agent: curl/7.21.4 (universal-apple-darwin11.0) libcurl/7.21.4 OpenSSL/0.9.8r zlib/1.2.5
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4f4fcc24e4b04e2d592e7d79
    Content-Length: 0


**Data Parameters**

*List all the attributes that comprises the data structure*

* *name_of_attribute* - {data type} - {description of the attribute}

JSON


    {
        "reset-password": {}
    }


**Success Response**

**Status Code**

200 - OK

**Response Data**

Header


    HTTP/1.1 200 OK
    Date: Wed, 11 Apr 2012 16:50:51 GMT
    Server: Apache/2.2.17 (Ubuntu)
    Content-Length: 36
    Content-Type: application/json

JSON Body


    {
        "password": "CaFreeNbKQY4h9MkzyuD"
    }


**Error Response**

Error Response Code(s): badRequest (400) unauthorized (401), forbidden (403), not found (404), internal server error (500),

**Curl Example**


    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "X-Auth-Token: HPAuth_0c1bf996869092ee62be650e15cd721da3df29260baff6858ef66a5ab2b1ee83" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/instances/9dfcd988-3b57-4bc7-92d1-88dbc8a0080d/action   \
        -d '{"reset-password":{}}' 


**Additional Notes**

Note that, like the database creation call, this is your only chance to record the password returned.

### 4.4.2 Flavor Operations

#### 4.4.2.1 List all flavors
#### GET /flavors

Returns a list of all available flavors

**Request Data**


    GET /v1.0/123456789/flavors HTTP/1.1
    User-Agent: curl/7.21.4 (universal-apple-darwin11.0) libcurl/7.21.4 OpenSSL/0.9.8r zlib/1.2.5
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4f4fcc24e4b04e2d592e7d79


**Data Parameters**
This call does not require a request body

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

Header


    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 739
    Date: Mon, 24 Sep 2012 11:35:09 GMT


JSON Body


    {
        "flavors": [
            {
                "id": 100, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/100", 
                        "rel": "self"
                    }
                ], 
                "name": "xsmall", 
                "ram": 1, 
                "vcpu": 1
            },
            {
                "id": 101, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/101", 
                        "rel": "self"
                    }
                ], 
                "name": "small", 
                "ram": 2, 
                "vcpu": 2
            },
            {
                "id": 102, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/102", 
                        "rel": "self"
                    }
                ], 
                "name": "medium", 
                "ram": 4, 
                "vcpu": 2
            },
            {
                "id": 103, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/103", 
                        "rel": "self"
                    }
                ], 
                "name": "large", 
                "ram": 8, 
                "vcpu": 4
            },
            {
                "id": 104, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/104", 
                        "rel": "self"
                    }
                ], 
                "name": "xlarge", 
                "ram": 16, 
                "vcpu": 4
            },
            {
                "id": 105, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/105", 
                        "rel": "self"
                    }
                ], 
                "name": "2xlarge", 
                "ram": 32, 
                "vcpu": 8
            }
        ]
    }


**Error Response**

Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), internal server error (500)

**Curl Example**


    $ curl -X GET \
        -H "Content-Type: application/json" \
        -H "X-Auth-Token: HPAuth_247365d0107526319ebccc4f05d0525a93fa050eae075ad881bbb57434438ff6" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/flavors


#### 4.4.2.2 List all flavors with detail
#### GET /flavors/detail

Returns a list of all flavors with detail

**Request Data**


    GET /v1.0/123456789/flavors/detail HTTP/1.1
    User-Agent: curl/7.21.4 (universal-apple-darwin11.0) libcurl/7.21.4 OpenSSL/0.9.8r zlib/1.2.5
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4f4fcc24e4b04e2d592e7d79


**Data Parameters**

This call does not require a request body

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

Header


    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 739
    Date: Mon, 24 Sep 2012 11:35:09 GMT


JSON Body


    {
        "flavors": [
            {
                "id": 100, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/100", 
                        "rel": "self"
                    }
                ], 
                "name": "xsmall", 
                "ram": 1, 
                "vcpu": 1
            },
            {
                "id": 101, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/101", 
                        "rel": "self"
                    }
                ], 
                "name": "small", 
                "ram": 2, 
                "vcpu": 2
            },
            {
                "id": 102, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/102", 
                        "rel": "self"
                    }
                ], 
                "name": "medium", 
                "ram": 4, 
                "vcpu": 2
            },
            {
                "id": 103, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/103", 
                        "rel": "self"
                    }
                ], 
                "name": "large", 
                "ram": 8, 
                "vcpu": 4
            },
            {
                "id": 104, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/104", 
                        "rel": "self"
                    }
                ], 
                "name": "xlarge", 
                "ram": 16, 
                "vcpu": 4
            },
            {
                "id": 105, 
                "links": [
                    {
                        "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/105", 
                        "rel": "self"
                    }
                ], 
                "name": "2xlarge", 
                "ram": 32, 
                "vcpu": 8
            }
        ]
    }


**Error Response**

Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), internal server error (500)

**Curl Example**


    $ curl -X GET \
        -H "Content-Type: application/json" \
        -H "X-Auth-Token: HPAuth_247365d0107526319ebccc4f05d0525a93fa050eae075ad881bbb57434438ff6" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/flavors/detail


#### 4.4.2.3 Get a flavor
#### GET /flavors/*flavor_id*   

Get a flavor specified by *flavor_id*

**Request Data**


    GET /v1.0/<tenant_id>/flavors/104 HTTP/1.1
    User-Agent: curl/7.21.4 (universal-apple-darwin11.0) libcurl/7.21.4 OpenSSL/0.9.8r zlib/1.2.5
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4f4fcc24e4b04e2d592e7d79


**Data Parameters**

This call does not require a request body

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header


    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 156
    Date: Wed, 07 Mar 2012 17:43:00 GMT


JSON Body


    {
      "flavor" : {
        "vcpu" : 4,
        "ram" : 16,
        "id" : 104,
        "links" : [ {
          "href" : "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/flavors/104",
          "rel" : "self"
        } ],
        "name" : "xlarge"
      }
    }


**Error Response**

Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), not found (404), internal server error (500)

**Curl Example**


    $ curl -X GET \
        -H "Content-Type: application/json" \
        -H "X-Auth-Token: HPAuth_247365d0107526319ebccc4f05d0525a93fa050eae075ad881bbb57434438ff6" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/flavors/102


### 4.4.3 Security Group Operations

#### 4.4.3.1 List all security groups
#### GET /security-groups   

Returns a list of all security groups

**Request Data**


    GET /v1.0/<tenant_id>/security-groups HTTP/1.1
    Accept: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Connection: keep-alive


**Data Parameters**

This call does not require a request body

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header


    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Content-Type: application/json
    Content-Length: 380                


JSON Body


    {  
       "security-groups": [
       {
          "id": "a6898281-99cf-40f4-9875-3a49a69cba5d",
          "name": "default",
          "description": "Default Security Group",
          "rules" : [ 
            {
              "id": "8cd186e9-2024-4644-81a9-ff83414b60eb",
              "ip_range": {
                "cidr": "15.0.0.0/0"
              }
            }
           ],
          "links" : [
            {
              "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/security-groups/a6898281-99cf-40f4-9875-3a49a69cba5d",
              "rel": "self"
            }
           ],
          "created" : "2012-09-11T20:57:22"
       }]
    }


**Error Response**

Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), internal server error (500), service unavailable (503)

**Curl Example**


    $ curl -X GET \
        -H "X-Auth-Token: HPAuth_247365d0107526319ebccc4f05d0525a93fa050eae075ad881bbb57434438ff6" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/security-groups


#### 4.4.3.2 Get a specific security group
#### GET /security-groups/*security_group_id*

Returns a specific security group specified by *security_group_id*


**Request Data**


    GET /v1.0/<tenant_id>/security-groups/a6898281-99cf-40f4-9875-3a49a69cba5d HTTP/1.1
    Accept: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Connection: keep-alive


**Data Parameters**

This call does not require a request body

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header


    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Content-Type: application/json
    Content-Length: 380


JSON Body


    {  
       "security-group": 
       {
          "id": "a6898281-99cf-40f4-9875-3a49a69cba5d",
          "name": "default",
          "description": "Default Security Group",
          "rules" : [ 
            {
              "id": "8cd186e9-2024-4644-81a9-ff83414b60eb",
              "ip_range": {
                "cidr": "15.0.0.0/0"
              }
            }
           ],
          "links" : [
            {
              "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/<tenant_id>/security-groups/a6898281-99cf-40f4-9875-3a49a69cba5d",
              "rel": "self"
            }
           ],
          "created" : "2012-09-11T20:57:22"
       }
    }


**Error Response**

Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), not found (404), internal server error (500), service unavailable (503)

**Curl Example**


    $ curl -X GET \
        -H "X-Auth-Token: HPAuth_247365d0107526319ebccc4f05d0525a93fa050eae075ad881bbb57434438ff6" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/security-groups/7539a2b3-0d0a-4586-9f5b-61f47610fa00


#### 4.4.3.3 Create a security group rule
#### POST /security-group-rules

Create a new security group rule.


**Request Data**


    POST /v1.0/<tenant_id>/security-group-rules HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Connection: keep-alive


**Data Parameters**

*List all the attributes that comprises the data structure*

* *name_of_attribute* - {data type} - {description of the attribute}
* *name_of_attribute* - {data type} - {description of the attribute}
* *name_of_attribute* (Optional) - {data type} - {description of the attribute}

JSON


    {  
       "security_group_rule": 
       {
          "security_group_id": "a6898281-99cf-40f4-9875-3a49a69cba5d",
          "cidr": "15.0.0.0/0",
          "from_port": 3306,
          "to_port": 3306
       }
    }


**Success Response**

**Status Code**

200 - OK

**Response Data**

Header


    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1
    Content-Type: application/json
    Content-Length: 380


JSON Body


    {  
       "security_group_rule": 
       {
          "id": "dddd8281-99cf-40f4-9875-3a49a69xxxxx",
          "security_group_id": "a6898281-99cf-40f4-9875-3a49a69cba5d",
          "cidr": "15.0.0.0/0",
          "from_port": 3306,
          "to_port": 3306,
          "created" : "2012-09-11T20:57:22"
       }
    }


**Error Response**

Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), not found (404), internal server error (500), service unavailable (503)

**Curl Example**


    $ curl -i -X POST \
        -H "Content-Type: application/json" \
        -H "X-Auth-Token: HPAuth_247365d0107526319ebccc4f05d0525a93fa050eae075ad881bbb57434438ff6" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/security-group-rules \
        -d '{"security_group_rule": {"security_group_id": "7539a2b3-0d0a-4586-9f5b-61f47610fa00", "cidr": "0.0.0.0/0", "from_port": 3306, "to_port": 3306 } }' 


#### 4.4.3.4 Delete a security group rule
#### DELETE /security-group-rules/*rule_id*

Deletes the security group rule specified by *rule_id*

**Request Data**


    DELETE /v1.0/<tenant_id>/security-group-rules/dddd8281-99cf-40f4-9875-3a49a69xxxxx HTTP/1.1
    Accept: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Connection: keep-alive


**Data Parameters**

This call does not require a request body

**Success Response**

**Status Code**

204 - No Content

**Response Data**

Header


    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1


No Body

**Error Response**

Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), not found (404), internal server error (500), service unavailable (503)

**Curl Example**


    $ curl -i -X DELETE \
        -H "Content-Type: application/json" \
        -H "X-Auth-Token: HPAuth_247365d0107526319ebccc4f05d0525a93fa050eae075ad881bbb57434438ff6" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0/38728063898723/security-group-rules/5ba5e21f-19ca-4d0a-8d62-418134f7d75f


### 4.4.4 Version Operations

#### 4.4.4.1 List all API versions
#### GET /

Returns a list of all API versions

**Request Data**


    GET / HTTP/1.1
    Accept: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com
    Connection: keep-alive


**Data Parameters**

This call does not require a request body

**Success Response**

**Status Code**

200 or 204

**Response Data**

Header


    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Content-Type: application/json
    Content-Length: 380


JSON Body


    {  
       "versions": [
       {
          "id": "v1.0",
          "status": "CURRENT",
          "updated": "2012-09-25T00:00:00Z",
          "links" : [
            {
              "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0",
              "rel": "self"
            }
           ]
       }]
    }


**Error Response**

Error Response Code(s): badRequest (400), unauthorized (401), forbidden (403), internal server error (500)

**Curl Example**


    $ curl -X GET \
        -H "X-Auth-Token: HPAuth_247365d0107526319ebccc4f05d0525a93fa050eae075ad881bbb57434438ff6" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/


#### 4.4.4.2 Get a specific version
#### GET /*version_id*  

Get a specific version specified by *version_id*

**Request Data**


    GET /v1.0/ HTTP/1.1
    Accept: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Connection: keep-alive


**Data Parameters**

This call does not require a request body

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header


    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Content-Type: application/json
    Content-Length: 380


JSON Body


    {  
       "version": {
          "id": "v1.0",
          "status": "CURRENT",
          "updated": "2012-09-25T00:00:00Z",
          "links" : [
            {
              "href": "https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0",
              "rel": "self"
            }
           ]
       }
    }


**Error Response**

Error Response Code(s): badRequest (400), forbidden (403), internal server error (500), serviceUnavailable (503)

**Curl Example**


    $ curl -X GET \
        -H "X-Auth-Token: HPAuth_247365d0107526319ebccc4f05d0525a93fa050eae075ad881bbb57434438ff6" \
        https://region-a.geo-1.dbaas-mysql.hpcloudsvc.com/v1.0



---

# 5. Additional References

## 5.1 Resources

**Wiki Page**: https://wiki.hpcloud.net/display/paas/Database+as+a+Service

**Code Repo**: git.paas.hpcloud.net:dbaas-api

**API Lead Contact**: {Name of contact}

---

# 6. Glossary

{Put down definitions of terms and items that need explanation.}

---

