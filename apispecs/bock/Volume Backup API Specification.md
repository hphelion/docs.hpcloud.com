---
layout: page
permalink: /api/block-storage/backup/
title: HP Cloud Block Storage Volume Backup API
description: "HP Cloud Block Storage Volume Backup API Specifications"
keywords: "bock, volumes, block storage, backup"
product: block-storage

---
# HP Cloud Block Storage Volume Backup API

# 1. Overview

The HP Volume Backup service is an extension to the HP Cloud Block Storage API
which allows users to create backups of HP Cloud Block Storage Volumes to
HP Cloud Object Storage. The service is handled by one or more Backup service
managers running on HP Cloud Block Storage servers. Backups are created in
userspace on HP Cloud Object Storage and can be accessed by the user via the
documented HP Cloud Object Storage API if required.

## 1.1 API Maturity Level

**Maturity Level**: *Public* (HP Cloud Block Storage is currently in Public Beta)

**Version API Status**: *CURRENT*

---


# 2. Architecture View

The backups service consists of an extension to the HP Cloud Block Storage API
and an additional HP Cloud Block Storage service. The API extension is
responsible for processing client requests and despatching them to the
appropriate component. Information requests (_show backup_, _list backups_,
_list backup details_) retrieve information directly from the database.
Requests which require operations on volumes or object storage are routed to 
one of the Backup services via the scheduler service.

---

# 3. Account-level View


## 3.1 Accounts

The backups service sits on top of and uses the existing HP Cloud Block Storage
and HP Cloud Object Storage APIs. Users can perform backup operations on
volumes they already have access to and can only perform backup operations to 
object storage which their existing object storage permissions allow. The backup
service does not add any additional relationships and relies on the underlying APIs
to control access.

## 3.2 Regions and Availability Zones

The backups service is provided in all regions and zones which 
provide a block storage service.

**Region(s)**: region-a

**Availability Zone(s)**: az-1, az-2, az-3 

**Future Expansion**: region-b


## 3.3 Service Catalog

Same as parent [API](/api/block-storage/storage/)

---

# 4. REST API Specifications

## 4.1 Service API Operations


**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseUri**: {Host}/v1.1/{tenant_id}/hp-volume-backups

**Admin URI**: N/A

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |
| **backups**  | List backups         | GET         | {BaseURI}              | Y/**N**           |                 |
|          | List backups details | GET         | {BaseURI}/detail       | Y/**N**           |                 |
|          | Show backup details  | GET         | {BaseURI}/{backup_id}  | Y/**N**           |                 |
|          | Create backup        | POST        | {BaseURI}              | Y/**N**           |                 |
|          | Delete backup        | DELETE      | {BaseURI}/{backup_id}  | Y/**N**           |                 |
|          | Restore backup       | POST        | {BaseURI}/{backup_id}/restore  | Y/**N**           |                 |


## 4.2 Common Request Headers

Same as parent [API](/api/block-storage/storage/)

## 4.3 Common Response Headers

Same as parent [API](/api/block-storage/storage/)

## 4.4 Service API Operation Details

### 4.4.1 Backups

Backups are point in time dumps of the contents of block storage volumes to 
object storage. They can be restored at any time to an available block storage
volume (either the same volume original used for the backup or a different one).

**Status Lifecycle**

"creating" => "available" (after creation) => "restoring" (during restore) => "available" => "deleting" (during delete)

In the event of an error, during any operation, status is set to "error"

Volumes are set to "backing-up" during backup creation and "restoring-backup" during backup restore.

**Rate Limits**

N/A

**Quota Limits**

The backup service does not enforce any quota limits. The backup service uses
the block storage and object storage services both of which enforce their own
quota limits. 

#### 4.4.1.1 List backups
#### GET /hp-volume-backups

List backup ids and status. 

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

XML

_Not supported._

**Error Response**

**Status Code**

500 - Internal Server Error

**Response Data**

JSON

    {"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}

XML

_Not supported._

**Curl Example**

    curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri]

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

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

_Not supported._

**Error Response**

**Status Code**

500 - Internal Server Error

**Response Data**

JSON

    {"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}

XML

_Not supported._

**Curl Example**

    curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri]/detail

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

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

_Not supported._

**Error Response**

**Status Code**

500 - Internal Server Error

**Response Data**

JSON

    {"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}

XML

_Not supported._


**Status Code**

404 - Not Found

**Response Data**

JSON

    {"itemNotFound": {"message": "Backup [backup_id] could not be found.", "code": 404}}

XML

_Not supported._

**Curl Example**

    curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri]/[backup_id]

**Additional Notes**

None.

#### 4.4.1.4 Create backup
#### POST /hp-volume-backups

Creates a volume backup by backing the volume up to object storage.

**Request Data**

**URL Parameters**

None.

**Data Parameters**

* *volume_id* - integer - Id of the volume to be backed up.
* *display_name* (Optional) - string - User defined name for the backup.
* *display_description* (Optional) - string - User defined description for the backup.
* *container* (Optional) - string - The name of the object storage container to which the volume is to be backed up.

JSON

    {
        "backup": {
            "display_name": "backup-001",
            "display_description": "Nightly Backup 03-Sep-2012",
            "volume_id": "9",
            "container": "nightlybackups",
         }
    }

XML

_Not supported._

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

_Not supported._

**Error Response**

**Status Code**

500 - Internal Server Error

**Response Data**

JSON

    {"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}

XML

_Not supported._

**Status Code**

400 - Bad Request

**Response Data**

JSON

    {"badRequest": {"message": "Incorrect request body format.", "code": 400}}

**Status Code**

400 - Bad Request

**Response Data**

JSON

    {"badRequest": {"message": "Invalid volume: Volume to be backed up must be available", "code": 400}}

XML

_Not supported._

**Status Code**

404 - Not Found

**Response Data**

JSON

    {"itemNotFound": {"message": "Volume [volume_id] could not be found.", "code": 404}}

XML

_Not supported._

**Curl Example**

    curl -i -H "X-Auth-Token: <Auth_Token>" -d'{"backup": {"display_name": "backup-001", "display_description": "Nightly Backup 03-Sep-2012", "volume_id": "9", "container": "nightlybackups" }}' [BaseUri]

**Additional Notes**

This operation is asynchronous. You must list backups repeatedly to determine whether the backup was created.
If the container is not specified a default container will be used. If a container does not exist the service will create it.

#### 4.4.1.5 Delete backup
#### DELETE /hp-volume-backups/[backup_id]

Delete a previous volume backup.

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

    {"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}

XML

_Not supported._

**Status Code**

400 - Bad Request

**Response Data**

JSON

    {"badRequest": {"message": "Invalid backup: Backup status must be available or error", "code": 400}}

XML

_Not supported._

**Status Code**

404 - Not Found

**Response Data**

JSON

    {"itemNotFound": {"message": "Backup [backup_id] could not be found.", "code": 404}}

XML

_Not supported._

**Curl Example**

    curl -i -X DELETE -H "X-Auth-Token: <Auth_Token>" [BaseUri]/[backup_id]

**Additional Notes**

This operation is asynchronous. You must list backups repeatedly to determine whether the backup was deleted.


#### 4.4.1.6 Restore backup
#### POST /hp-volume-backups/[backup_id]/restore

Restore specified backup to a volume. 

**Request Data**

**URL Parameters**

* *backup_id* - integer - Id of the backup to be restored.

**Data Parameters**

* *volume_id* - integer - Id of the volume to which the backup should be restored.

JSON

    {
        "restore": {
            "volume_id": "9",
         }
    }

XML

_Not supported._

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "restore": {
            "backup_id": "1",
            "volume_id": "9",
         }
    }

XML

_Not supported._

**Error Response**

**Status Code**

500 - Internal Server Error

**Response Data**

JSON

    {"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}

XML

_Not supported._

**Status Code**

400 - Bad Request

**Response Data**

JSON

    {"badRequest": {"message": "Incorrect request body format.", "code": 400}}

XML

_Not supported._

**Status Code**

400 - Bad Request

**Response Data**

JSON

    {"badRequest": {"message": "Invalid volume: Volume to be restored to must be available", "code": 400}}

XML

_Not supported._

**Status Code**

400 - Bad Request

**Response Data**

JSON

    {"badRequest": {"message": "Invalid volume: Volume to be restored to is smaller than the backup to be restored", "code": 400}}

**Status Code**

400 - Bad Request

**Response Data**

JSON

    {"badRequest": {"message": "Volume quota exceeded. You cannot create a volume of size [backup_size]G", "code": 400}}

XML

_Not supported._

**Status Code**

400 - Bad Request

**Response Data**

JSON

    {"badRequest": {"message": "Invalid backup: Backup status must be available", "code": 400}}

**Status Code**

404 - Not Found

**Response Data**

JSON

    {"itemNotFound": {"message": "Backup [backup_id] could not be found.", "code": 404}}

XML

_Not supported._

**Curl Example**

    curl -i -H "X-Auth-Token: <Auth_Token>" -d'{"restore": { "volume_id": "9" }}' [BaseUri]/[backup_id]/restore

**Additional Notes**

If the volume is not specified, this operation will create a new volume for the restore. This operation is asynchronous. To check the status of the restore operation, the user should *show volume* for the [volume_id] returned in the response (status will be set to *restoring* while the the restore operation runs, *error_restoring* if the restore operation fails and *available* if the restore operation succeeds).
