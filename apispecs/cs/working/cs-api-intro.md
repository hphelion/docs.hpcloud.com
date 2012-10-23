---
layout: page
title:
title_section:
description:
group: apispec

---
{% include JB/setup %}


# 1. Overview

*Brief introduction and overview of the service and its intended use.*



## 1.1 API Maturity Level


**Maturity Level**: GA

**Version API Status**: CURRENT


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

**Region(s)**: region-a, region-b

**Availability Zone(s)**: az-1, az-2, az-3

**Future Expansion**:


## 3.3 Service Catalog

The service is exposed in the service catalog, as shown in the following fragment:

```
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
```

---


# 4. REST API Specifications
*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*

## 4.1 Service API Operations


**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseUri**: {Host}/v2.0

**Admin URI**: N/A

{API_INDEX_TABLE_PLACE_HOLDER}

## 4.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

## 4.3 Common Response Headers
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *

## 4.4 Service API Operation Details
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*


