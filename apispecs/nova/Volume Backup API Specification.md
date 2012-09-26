---
layout: page
title: Volume Backup API
title_section: The API specifications for the HP Volume Backup service.
description: "Volume Backup API Specifications"
group: apispec

---
{% include JB/setup %}


# 1. Overview

The HP Volume Backup service is an extension to the OpenStack Nova API
which allows users to create backups of Nova volumes to Openstack Swift.
The service is handled by one or more Backup service managers which are
expected to run on the same servers as the Nova volume service. Backups are
created in userspace on Swift and can be manipulated by the user directly if
they wish.

## 1.1 API Maturity Level

**Maturity Level**: Beta stage - Volume Backup is currently under development 
and planned to be made available in the Beastie Boys release

**Version API Status**: *BETA*


---


# 2. Architecture View


## 2.1 Overview

An overview of the backups service is available in [HP Volume Backups (overview)](https://wiki.hpcloud.net/display/iaas/HP+Volume+Backups+%28BOCK-1756%29#HPVolumeBackups%28BOCK-1756%29-Overview)
*References to architectural details of the service.*

## 2.2 Conceptual/Logical Architecture View
*Describe the logical components of the system and their responsibilities*
The backups service consists of an extension to the Nova API and an additional 
Nova service which runs on volume nodes. The API extension is responsible for processing 
client requests and despatching them to the appropriate component in Nova. Information
requests (show backup, list backups, list backup details) retrieve information
directly from the Nova database. Requests which require operations on volumes or Swift
are routed to one of the Backup services. Requests on a specific volume are routed 
directly to the appropriate volume node (create backup, restore backup) while
requests that do nott involve a specific volume are routed via the Nova scheduler
(delete backup).

## 2.3 Infrastructure Architecture View
This API is implemented as an extension to the Nova API and leverages the existing
infrastructure to deliver the service.

## 2.4 Entity Relationship Diagram
See the Overview above for details of the entities involved in the API.

---

# 3. Account-level View


## 3.1 Accounts

The backups service sits on top and uses the existing Volumes and Swift APIs. Users can perform
backup operations on volumes they already have access to and can only perform
backup operations on Swift which their existing Swift permissions allow. The backup service does
not add any additional relationships and relies on the underlying Volumes and Swift APIs to
control access.

## 3.2 Regions and Availability Zones

It is expected that the backups service will be provided in all regions and zones which 
provide a volumes service.

**Region(s)**: region-a

**Availability Zone(s)**: az-1, az-2, az-3 

**Future Expansion**: region-b


## 3.3 Service Catalog

*[TBD](https://wiki.hpcloud.net/display/iaas/Service+Registration+with+CS)* 

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


**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseUri**: {Host}/v1.1/{tenant_id}/hp-volume-backups

**Admin URI**: N/A

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |
| backups  | List backups         | GET         | {BaseURI}              | Y/**N**           |                 |
|          | List backups details | GET         | {BaseURI}/detail       | Y/**N**           |                 |
|          | Show backup details  | GET         | {BaseURI}/{backup_id}  | Y/**N**           |                 |
|          | Create backup        | POST        | {BaseURI}              | Y/**N**           |                 |
|          | Delete backup        | DELETE      | {BaseURI}/{backup_id}  | Y/**N**           |                 |
|          | Restore backup       | POST        | {BaseURI}/{backup_id}/restore  | Y/**N**           |                 |


## 4.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

Same as parent API

## 4.3 Common Response Headers
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *

Same as parent API

## 4.4 Service API Operation Details
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*

### 4.4.1 Backups

Backups are point in time dumps of the contents of Nova volumes to Swift. They can be restored
at any time to an available Nova volume (either the same volume original used for the backup
or a different one).

*Describe the resource and what information they provide. Then enumerate all the API method calls below.*

**Status Lifecycle**

"creating" => "available" (after creation) => "restoring" (during restore) => "available" => "deleting" (during delete)

In the event of an error, during any operation, status is set to "error"

Volumes are set to "backing-up" during backup creation and "restoring-backup" during backup restore.

**Rate Limits**

N/A

**Quota Limits**

The backup service does not enforce any quota limits. The backup service interfaces with the volumes service and swift,
both of which enforce their own quota limits. 

**Business Rules**

None.

#### 4.4.1.1 List backups
#### GET /hp-volume-backups

List backup ids and status. 

**Request Data**

**URL Parameters**

None.

**Data Parameters**

This call does not require a request body. 

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

JSON

```
{
    "backups": [
        {
            "id": "1",
            "status": "available",
        },
        {
            "id": "2",
            "status": "creating",
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

#### 4.4.1.2 List backups details
#### GET /hp-volume-backups/detail

List details for all backups.

**Request Data**

**URL Parameters**

None.

**Data Parameters**

This call does not require a request body.

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

JSON

```
{
    "backups": [
        {
            "id": "1",
            "display_name": "backup-001",
            "display_description": "Nightly Backup 03-Sep-2012",
            "volume_id": "9",
            "container": "nightlybackups",
            "status": "available",
            "fail_reason": null,
            "created_at": "2012-09-03T22:00:00Z",
            "size": 10,
            "object_count": 2
        },
        {
            "id": "2",
            "display_name": "backup-002",
            "display_description": "Nightly Backup 04-Sep-2012",
            "volume_id": "9",
            "container": "nightlybackups",
            "status": "creating",
            "fail_reason": null,
            "created_at": "2012-09-04T22:00:00Z",
            "size": 10,
            "object_count": 2
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
curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri]/detail
```

**Additional Notes**

None.


#### 4.4.1.3 Show backup details
#### GET /hp-volume-backups/[backup_id]

Show details for a specified backup.

**Request Data**

**URL Parameters**

* *backup_id* - integer - Id of the backup to be displayed.

**Data Parameters**

This call does not require a request body.

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

JSON

```
{
    "backup": {
            "id": "1",
            "display_name": "backup-001",
            "display_description": "Nightly Backup 03-Sep-2012",
            "volume_id": "9",
            "container": "nightlybackups",
            "status": "available",
            "fail_reason": null,
            "created_at": "2012-09-03T22:00:00Z",
            "size": 10,
            "object_count": 2
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
{"itemNotFound": {"message": "Backup [backup_id] could not be found.", "code": 404}}
```

XML

```
Not supported.
```

**Curl Example**

```
curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri]/[backup_id]
```

**Additional Notes**

*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*

#### 4.4.1.4 Create backup
#### POST /hp-volume-backups

Creates a volume backup by backing the volume up to Swift.

**Request Data**

**URL Parameters**

None.

**Data Parameters**

* *volume_id* - integer - Id of the volume to be backed up.
* *display_name* (Optional) - string - User defined name for the backup.
* *display_description* (Optional) - string - User defined description for the backup.
* *container* (Optional) - string - The name of the swift container to which the volume is to be backed up.

JSON

```
{
    "backup": {
        "display_name": "backup-001",
        "display_description": "Nightly Backup 03-Sep-2012",
        "volume_id": "9",
        "container": "nightlybackups",
     }
}
```

XML

```
Not supported.
```

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

JSON

```
{
    "backup": {
        "id": "1",
        "display_name": "backup-001",
        "display_description": "Nightly Backup 03-Sep-2012",
        "volume_id": "9",
        "container": "nightlybackups",
        "status": "creating",
        "created_at": "2012-09-03T22:00:00Z",
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

400 - Bad Request

**Response Data**

JSON

```
{"badRequest": {"message": "Incorrect request body format.", "code": 400}}
```

**Status Code**

400 - Bad Request

**Response Data**

JSON

```
{"badRequest": {"message": "Invalid volume: Volume to be backed up must be available", "code": 400}}
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
curl -i -H "X-Auth-Token: <Auth_Token>" -d'{"backup": {"display_name": "backup-001", "display_description": "Nightly Backup 03-Sep-2012", "volume_id": "9", "container": "nightlybackups" }}' [BaseUri]
```

**Additional Notes**

This operation is asynchronous. You must list backups repeatedly to determine whether the backup was created.
If the container is not specified a default container will be used. If a container does not exist the service will create it.

#### 4.4.1.5 Delete backup
#### DELETE /hp-volume-backups/[backup_id]

Delete a previous volume backup from Swift.

**Request Data**

**URL Parameters**

* *backup_id* - integer - Id of the backup to be deleted.

**Data Parameters**

This call does not require a request body.

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

202 - Accepted

**Response Data**

This call does not return a response body.

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

400 - Bad Request

**Response Data**

JSON

```
{"badRequest": {"message": "Invalid backup: Backup status must be available or error", "code": 400}}
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
{"itemNotFound": {"message": "The resource could not be found.", "code": 404}}
```

XML

```

**Curl Example**

```
curl -i -X DELETE -H "X-Auth-Token: <Auth_Token>" [BaseUri]/[backup_id]
```

**Additional Notes**

This operation is asynchronous. You must list backups repeatedly to determine whether the backup was deleted.


Restore backup

#### 4.4.1.6 Restore backup
#### POST /hp-volume-backups/[backup_id]/restore

Restore specified backup to a volume. 

**Request Data**

**URL Parameters**

* *backup_id* - integer - Id of the backup to be deleted.

**Data Parameters**

* *volume_id* - integer - Id of the volume to be backed up.

JSON

```
{
    "restore": {
        "volume_id": "9",
     }
}
```

XML

```
Not supported.
```

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

JSON

```
{
    "restore": {
        "backup_id": "1",
        "volume_id": "9",
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

400 - Bad Request

**Response Data**

JSON

```
{"badRequest": {"message": "Incorrect request body format.", "code": 400}}
```

XML

```
Not supported.
```

**Status Code**

400 - Bad Request

**Response Data**

JSON

```
{"badRequest": {"message": "Invalid volume: Volume to be restored to must be available", "code": 400}}
```

XML

```
Not supported.
```

**Status Code**

400 - Bad Request

**Response Data**

JSON

```
{"badRequest": {"message": "Invalid volume: Volume to be restored to is smaller than the backup to be restored", "code": 400}}
```

**Status Code**

400 - Bad Request

**Response Data**

JSON

```
{"badRequest": {"message": "Volume quota exceeded. You cannot create a volume of size nnG", "code": 400}}
```

XML

```
Not supported.
```

**Status Code**

400 - Bad Request

**Response Data**

JSON

```
{"badRequest": {"message": "Invalid backup: Backup status must be available", "code": 400}}
```

**Status Code**

404 - Not Found

**Response Data**

JSON

```
{"itemNotFound": {"message": "Backup [backup_id] could not be found.", "code": 404}}
```

XML

```
Not supported.
```

**Curl Example**

```
curl -i -H "X-Auth-Token: <Auth_Token>" -d'{"restore": { "volume_id": "9" }}' [BaseUri]/[backup_id]/restore

```

**Additional Notes**

If the volume is not specified, this operation will create a new volume for the restore. This operation is asynchronous. To check the status of the restore operation, the user should show volume for the volume_id returned in the response (status will be set to restoring while the the restore operation runs, error_restoring if the restore operation fails and available if the restore operation succeeds).

---

# 5. Additional References

## 5.1 Resources

**Wiki Page**: https://wiki.hpcloud.net/display/iaas/HP+Volume+Backups+%28BOCK-1756%29

**Code Repo**: git@keg.dev.uswest.hpcloud.net:nova

**API Lead Contact**: Francis Moorehead / Stephen Mulcahy

---

# 6. Glossary

{Put down definitions of terms and items that need explanation.}

---


