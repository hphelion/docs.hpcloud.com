---
layout: page
title: Messaging API
title_section: DevEx
description: 
group: apispec

---
{% include JB/setup %}


# 1. Overview
*Brief introduction and overview of the service and its intended use.*

The HP Cloud Message Hub is a lightweight messaging platform/solution for messaging between the management console and the Network Operations Center (NOC), the Support group and customers.

The first iteration is essentially a prototype and will implement the following types of messages:

- External Platform Alerts



## 1.1 API Maturity Level
*State the maturity level in which the API is in currently, based on the pre-defined stages i.e. Experimental (early Alpha, available internally only), Exploratory (Private-beta ready), Public (Public-beta ready), GA (Release to General Availability, SLAs defined.*  
*The versions schema, status field, supports an enumeration of ALPHA, BETA, CURRENT and DEPRECATED. The versions->status field should correspond to the Maturity Level for the API, i.e. ALPHA for Experimental, BETA for Exploratory, CURRENT for Public and GA, DEPRECATED for all other versions of the API that are not supported anymore.*


**Maturity Level**: *Experimental*

**Version API Status**: *ALPHA*


---


# 2. Architecture View


## 2.1 Overview
*References to architectural details of the service.*

## 2.2 Conceptual/Logical Architecture View
*Describe the logical components of the system and their responsibilities*

## 2.3 Infrastructure Architecture View
*Describe how the API fits into the overall HPCS Infrastructure*

## 2.4 Entity Relationship Diagram
*Describe the relationships between the various entities (resources) involved in the API*


---

# 3. Account-level View
*Describe the relationship of the API with respect to the accounts, groups, tenants, regions, availability zones etc.*


## 3.1 Accounts
*Describe the structure of the user accounts, groups and tenants. Currently this might be described separately in context of Control Services, but in future each service API needs to state their usage. In future CS might support complex group hierarchies, enterprise account structures while there maybe a phased adoption by individual service APIs*

## 3.2 Regions and Availability Zones
*Describe the availability of the service API in different regions and availability zones. State plans for future expansion as well.*

**Region(s)**: region-a

**Availability Zone(s)**: az-1, az-2, az-3 

**Future Expansion**: region-b


## 3.3 Service Catalog
*Describe if the service API is exposed via the service catalog. Reference the fragment of the service catalog showing the structure.*

The service is exposed in the service catalog, as shown in the following fragment:

```
{
   service catalog fragment here
}
```

---

# 4. REST API Specifications
*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*

## 4.1 Service API Operations


**Host**: https://az-1.region-a.geo-1.sp.hpcloudsvc.com

**BaseUri**: /

**Admin URI**: N/A

| Resource | Operation                 | HTTP Method           | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------------ | :----------           | :--------------------- | :---------------- | :-------------: |
| External Platform Alert | Create a new External Platform Alert | POST | {BaseURI}/external_platform_alert | JSON only | Admin |


## 4.2 Common Request Headers
*List the common request headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

Content-Type: json


## 4.3 Common Response Headers
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc.*

## 4.4 Service API Operation Details
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*

### 4.4.1 [Resource]
*Describe the resource and what information they provide. Then enumerate all the API method calls below.*

The External Platform Alert provides critical platform feedback to both internal and external users of the Management Console. See the wiki for [Messaging Characteristics](https://wiki.hpcloud.net/display/iaas/Messaging+Characteristics) 


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.1.1 Create an External PLatform Alert
#### HTTP Verb: POST /external_platform_alert

*Description about the method call*

**Request Data**

*Specify all the required/optional url and data parameters for the given method call.*





**URL Parameters**

*Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.*

None

**Data Parameters**

*List all the attributes that comprises the data structure*

* title - string - brief title of the message to convey significance
* message - string - message being sent
* token - string - Control Services token of the user creating the message

*Either put 'This call does not require a request body' or include JSON/XML request data structure*

JSON

```
{ :title => 'Test Message', 
  :message => 'This is a <strong>test</strong> message', 
  :token => 'HPAuth_abcdefghijklmnopqrs' }
```

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

*Either put 'This call does not require a request body' or include JSON/XML response data structure*

JSON

```
{json data structure here}
```

XML

```
<xml data structure here>
```

**Error Response**

*Enumerate all the possible error status codes and any content that is returned.*

**Status Code**

500 - Internal Server Error

**Response Data**

JSON

```
{"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}
```

XML

```
<xml data structure here>
```

**Curl Example**

```
curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]
```

**Additional Notes**

*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*


---

# 5. AMQP API Specifications
*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*

## 5.1 Service API Operations


**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseUri**: {Host}/v1.1/{tenant_id}

**Admin URI**: N/A

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |
| R1       | {Short desc. of the call} | {GET/POST/DELETE/PUT} | {BaseURI}/{path} | {Y/N}    |                 |


## 5.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

## 5.3 Common Response Headers
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *

## 5.4 Service API Operation Details
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*

### 5.4.1 [Resource]
*Describe the resource and what information they provide. Then enumerate all the API method calls below.*

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 5.4.1.1 {Short description of the method call}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}

*Description about the method call*

**Request Data**

*Specify all the required/optional url and data parameters for the given method call.*

**URL Parameters**

*Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.*

* *name_of_attribute* - {data type} - {description of the attribute}
* *name_of_attribute* - {data type} - {description of the attribute}
* *name_of_attribute* (Optional) - {data type} - {description of the attribute}

**Data Parameters**

*List all the attributes that comprises the data structure*

* *name_of_attribute* - {data type} - {description of the attribute}
* *name_of_attribute* - {data type} - {description of the attribute}
* *name_of_attribute* (Optional) - {data type} - {description of the attribute}

*Either put 'This call does not require a request body' or include JSON/XML request data structure*

JSON

```
{json data structure here}
```

XML

```
<xml data structure here>
```

Optional:

JSON

```
{json data structure here}
```

XML

```
<xml data structure here>
```

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

*Either put 'This call does not require a request body' or include JSON/XML response data structure*

JSON

```
{json data structure here}
```

XML

```
<xml data structure here>
```

**Error Response**

*Enumerate all the possible error status codes and any content that is returned.*

**Status Code**

500 - Internal Server Error

**Response Data**

JSON

```
{"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}
```

XML

```
<xml data structure here>
```

**Curl Example**

```
curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]
```

**Additional Notes**

*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*





---



# 6. Additional References

## 6.1 Resources

**Wiki Page**: {Link to Wiki page}

**Code Repo**:  {Link to the internal Github repo}

**API Lead Contact**: {Name of contact}

---

# 7. Glossary

{Put down definitions of terms and items that need explanation.}

---

