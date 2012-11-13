---
layout: page
title: HP Bootable Volume API
title_section: The API specifications for the HP Bootable Volume service.
description: "Bootable Volume API Specifications"
group: apispec

---
{% include JB/setup %}


# 1. Overview

The HP Bootable Volume API is an extension to the OpenStack Nova API
which allows users to create persistent volumes which are pre-initialized
with a bootable image (from Glance). The API changes are implemented in two
separate facilities. The first, is a simple extension to the volume-create
API call, and the second is a new API call to retrieve those volumes which
are bootable.

## 1.1 API Maturity Level

**Maturity Level**: Beta stage - Bootable Volumes are currently under
development and planned to be made available in the Beastie Boys release

**Version API Status**: *BETA*


---


# 2. Architecture View


## 2.1 Overview

An overview of the bootable volume service is available in [Persistent Instances](https://wiki.hpcloud.net/display/iaas/Persistent+instances+aka+Boot-able+volumes)

## 2.2 Conceptual/Logical Architecture View
The bootable volume service consists of an extension to the Nova API and an
additional API entry point, specific to HP. The API extension allows the
caller to create a volume with an Operating System image pre-initialized on
the new volume.

Once this volume is created, it can be used as the root partition (/dev/vda)
on a new instance, so that the file system is both resilient and persistent.
Specifically, the volume is stored in an external RAID disk array, and can
outlive the instance.

## 2.3 Infrastructure Architecture View
This API is implemented as a Nova API Resource Extension and leverages the
existing infrastructure to deliver the service.

## 2.4 Entity Relationship Diagram
See the Overview above for details of the entities involved in the API.

---

# 3. Account-level View

## 3.1 Accounts

The bootable volumes API is an extension to the existing nova-volumes API and
as such, requires no additional user accounts.

## 3.2 Regions and Availability Zones

It is expected that the bootable volumes service will be provided in all
regions and zones which provide a volumes service.

## 3.3 Service Catalog

The service catalog is unaltered.


---


# 4. REST API Specifications

## 4.1 Service API Operations


**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseUri**: {Host}/v1.1/{tenant_id}/hp-bootable-volumes

**Admin URI**: N/A

| Resource     | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
| :-------     | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |
| **volumes**  | List bootable volumes | GET         | {BaseURI}              | Y/**N**           |                  |
|              | Show volume details   | GET         | {BaseURI}/{volume_id}  | Y/**N**           |                 |

## 4.2 Common Request Headers

Same as parent API

## 4.3 Common Response Headers

Same as parent API

## 4.4 Service API Operation Details

### 4.4.1 Bootable Volumes

A Bootable Volume is a persistent-storage volume which has been
pre-initialized with a bootable operating-system image, during creation.

The volume can be used as the root file system for a new instance, and offers
a persistent storage model to an otherwise ephemeral instance. Persistent
storage doesn't have the inherent reliability risks associated with regular
(ephemeral) storage, due to the architecture of the storage solution. As such,
an instance created from a bootable volume can be terminated without losing
the volume or its contents. A new instance can be created from the same
volume.

When creating a volume, a Glance image ID is given to the volume-create
command, and once created, the volume is pre-initialized with the specified
image data.

Internal flags are maintained to indicate that the volume is "bootable" and
this API is used to retrieve only those volumes which have been created in
this manner.

**Status Lifecycle**

"creating" => "downloading" => "available" (after creation)
"available" => "deleting" (during delete)

In the event of an error, during any operation, status is set to "error"

**Rate Limits**

N/A

**Quota Limits**

The quota limits that apply are the same as those which apply for regular
volumes. Bootable volumes are in fact a subset of regular volumes and can
be displayed, snapshotted and deleted in similar fashion to regular volumes.

**Business Rules**

None.

#### 4.4.1.1 List volumes
#### GET /hp-bootable-volumes

List only those volumes which are bootable.

**Request Data**

**URL Parameters**

None.

**Data Parameters**

This call does not require a request body. 

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
    "volumes": [
        {
            "attachments": [
                {
                    "device": "vda", 
                    "id": 10, 
                    "serverId": 1, 
                    "volumeId": 10
                }
            ], 
            "availabilityZone": "nova", 
            "createdAt": "2012-10-11 13:37:44", 
            "displayDescription": null, 
            "displayName": "FBSD1", 
            "id": 10, 
            "metadata": {}, 
            "size": 20, 
            "snapshotId": "", 
            "sourceImageRef": "4", 
            "status": "in-use", 
            "volumeType": null
        }, 
        {
            "attachments": [], 
            "availabilityZone": "nova", 
            "createdAt": "2012-10-31 15:17:54", 
            "displayDescription": null, 
            "displayName": null, 
            "id": 11, 
            "metadata": {}, 
            "size": 10, 
            "snapshotId": "", 
            "sourceImageRef": "4", 
            "status": "available", 
            "volumeType": null
        }
    ]
}
```

XML

```
Not supported.
```

**Error Response**

**Status Code**

500 - Internal Server Error

**Response Data**

JSON

```
{"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}
```

XML

```
Not supported.
```

**Curl Example**

```
curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri]
```

**Additional Notes**

None.

#### 4.4.1.2 Show volume details
#### GET /hp-bootable-volumes/[volume_id]

Show details for a specified bootable volume.

**Request Data**

**URL Parameters**

* *volume_id* - integer - Id of the volume to be displayed.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
    "volume": {
        "attachments": [], 
        "availabilityZone": "nova", 
        "createdAt": "2012-11-08 16:39:05", 
        "displayDescription": null, 
        "displayName": "test1", 
        "id": 5, 
        "metadata": {}, 
        "size": 15, 
        "snapshotId": "", 
        "sourceImageRef": "4", 
        "status": "available", 
        "volumeType": null
    }
}
```

XML

```
Not supported.
```

**Error Response**

**Status Code**

500 - Internal Server Error

**Response Data**

JSON

```
{"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}
```

XML

```
Not supported.
```


**Status Code**

404 - Not Found

**Response Data**

JSON

```
{"itemNotFound": {"message": "Volume [volume_id] could not be found.", "code": 404}}
```

XML

```
Not supported.
```

**Curl Example**

```
curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri]/[volume_id]
```

**Additional Notes**

All of the data output is identical to that displayed for the regular
volume-show API with the exception of sourceImageRef which refers to the
original imageRef (image_id) used to create the volume. It is this parameter
which indicates that the volume can be used to boot an instance.

# 5. Additional References

## 5.1 Resources

**Wiki Page**: https://wiki.hpcloud.net/display/iaas/Persistent+instances+aka+Boot-able+volumes

**Code Repo**: git@keg.dev.uswest.hpcloud.net:nova

**API Lead Contact**: Dermot Tynan

---

# 6. Glossary

{Put down definitions of terms and items that need explanation.}

---


