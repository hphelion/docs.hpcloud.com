---
layout: page
permalink: /api/block-storage/
title: HP Cloud Block Storage API
description: "HP Cloud Block Storage API Specification"
keywords: "block storage, volume, cinder, bootable volume, volume backup"
product: block-storage
published: false

---

# HP Cloud Block Storage API Specification

*Date:* 31-Jan-2013

*Document Version:* 0.1

## 1. Overview

The HP Cloud Block Storage service is based on 
[OpenStack Cinder](http://docs.openstack.org/developer/cinder/).

HP Cloud Block Storage provides persistent block devices that can be attached
to [HP Cloud Compute instances](/api/compute). HP 
Cloud Block Storage volumes can be created in sizes from 1GB to 2047GB. Volumes
attached to instances can be used as standard block devices. As volumes are
exposed as standard block devices, the user is responsible for partitioning
 them and creating filesystems on them. There are no limitations on what 
filesystems can be created on volumes other than those imposed by the operating
 system running on the instance to which to volume is attached. Volumes persist 
until the user deletes them. A volume can only be attached to one instance at
 a time.

HP Cloud Block Storage provides data durability with volume snapshots and volume
backups. Snapshots capture the point in time state of a volume and are quick
and inexpensive to create. They do not require the original volume from which
they are taken to remain available after creation. To use a snapshot, the user
must create a new volume from the snapshot. Backups are full copies of volumes
stored to [HP Object Storage](/api/object-storage). Since they are full copies, 
they take longer to create than snapshots. Backups are independent of the original
volume once created and are intended for archival and disaster recovery purposes.

HP Cloud Block Storage also supports bootable volumes, volumes which are pre-initialized
 with an operating system image.

### 1.1 API Maturity Level

**Maturity Level**: *GA* (HP Cloud Block Storage is General Availability)

**Version API Status**: *CURRENT*

### 1.2 Document History

| Version | Date       | Description                                 |
| :----------- | :----------| :------------------------------------------ |
| 0.1          | 31-Jan-2013 | Initial draft.                              |

### 1.3 API Changes from <cloud 1.0> to <cloud 1.1>

TODO(smulcahy) Change the title of this and fill in with changes

## 2. Architecture View

### 2.1 Overview

The HP Cloud Block Storage API is implemented as a set of RESTful web services. All
volume, snapshot and backup operations can be performed with standard HTTP
calls. See the [Wikipedia article on REST](http://en.wikipedia.org/wiki/REST)
 for more information.

### 2.2 Resources

The HP Cloud Block Storage API allows the management of the following resources:

* [Volumes](#volume_resource)
* [Volume Snapshots](#volume_snapshot_resource)
* [Volume Backups](#volume_backup_resource)

#### 2.2.1 HP Cloud Block Storage Volumes #### {#volume_resource}

Volumes are persistent block devices provided by the HP Cloud Block
Storage API. Data on volumes is accessed in the same way that a user accesses
data on local physical block devices. On creation, volumes are in an unattached 
state (and the volume status is _available_). Volume size is specified at creation
time and is fixed for the lifetime of the volume. Volume sizes can be from 
1GB to 2047GB in units of 1GB. Volumes have an optional _display-name_ and
_display_description_ associated with them. 

__Bootable volumes__ can be created by specifying an _image-id_ when creating
a new volume. The _image-id_ must refer to a suitable image available from
the image service. The bootable volume can be used as the root file system for
a new instance, and offers a persistent storage model to an otherwise ephemeral
instance. An instance created from a bootable volume can be terminated without
losing the volume or its contents. A new instance can be created from the same
volume.

Volumes may also be created from existing [Volume Snapshots](#volume_snapshot_resource)
by specifying the _snapshot-id_ at volume creation.

Custom metadata may be associated with a volume at creation time using a set
of optional key-value pairs.

#### 2.2.2 HP Cloud Block Storage Volume Snapshots #### {#volume_snapshot_resource}

Volume Snapshots capture the point in time state of a volume. They are quick
and inexpensive to create. They do not require the original volume from which
they are taken to remain available. Volumes must be in an unattached state (with
a volume status of _available_) before a snapshot can be taken from them. To
use a snapshot, a new volume must be created from a snapshot. Volume snapshots
cannot be attached or otherwise used directly.

#### 2.2.3 HP Cloud Block Storage Volume Backups #### {#volume_backup_resource}

Volume Backups are full copies of volumes stored in HP Object Storage. Since
they are full copies, they take longer to create than snapshots. Backups are
independent of the original volume once created and are intended for archival
and disaster recovery purposes. Volumes must be in an unattached state (with
a volume status of _available_) before a backup can be taken from them. To use
a backup, the backup must be restored to a new or existing volume.

### 2.3 Conceptual/Logical Architecture View

The HP Cloud Block Storage facility consists of a,

* The HP Cloud Block Storage API - a RESTful API which allows users to view,
create, delete, modify, snapshot, backup and restore volumes.
* An extension to the [HP Cloud Compute API](/api/compute) which allows users
 to attach/detach volumes to/from instances.
* The volume service which handles volume requests.
* The volume backup service which handles volume backup requests.

The compute service handles the volume attach/detach requests,
communicating directly with the volume service to do so.

The volume backup service handles volume backup requests, communicating
directly with the volume service and the HP Cloud Object Storage service to
do so.

## 3. Account-level View

### 3.1 Accounts

An account is created when a user first signs up with HP Cloud. A _tenant_
(with an associated _tenant_id_) is also created on first signing up with
the cloud. All calls to HP Cloud Block Storage APIs include the users 
_tenant_id_ as part of the call.

For additional details on accounts and tenants, please refer to the
[HP Cloud Identity Service Overview](/identity).

### 3.2 Regions and Availability Zones

**Region(s)**: region-a

**Availability Zone(s)**: az-1, az-2, az-3 

**Future Expansion**: region-b


### 3.3 Service Catalog

The listing below shows a fragment of the Service Catalog returned by the
Identity Service which contains the endpoints for HP Cloud Block Storage. Note
that a set of endpoints is returned for each AZ. (The string which identifies
the AZ is called `"region"` in the Service Catalog.

TODO(smulcahy): replace with service_catalog from HP Cloud Grizzly installation

    {
        "name": "cinder", 
        "type": "volume"
        "endpoints": [
            {
                "adminURL": "http://10.2.1.240:8776/v1/5e954f3ec5e6416eb2c2b8ee6207630a", 
                "id": "7abf92e7fedb4ff1a62fb502620b75d9", 
                "internalURL": "http://10.2.1.240:8776/v1/5e954f3ec5e6416eb2c2b8ee6207630a", 
                "publicURL": "http://10.2.1.240:8776/v1/5e954f3ec5e6416eb2c2b8ee6207630a", 
                "region": "RegionOne"
            }
        ], 
        "endpoints_links": [], 
    }, 


## 4. REST API Specifications

### 4.1 Service API Operations ### {#service_api}

#### 4.1.1 HP Cloud Block Storage Service API Operations

TODO(smulcahy): clarify endpoints for production

**Host** (US West Region): https://region-a.geo-1.block.hpcloudsvc.com

**Host** (US East Region): https://region-b.geo-1.block.hpcloudsvc.com

**BaseURI**: {Host}/v1/{tenant_id}

**Admin URI**: (TODO(smulcahy): clarify this for production, cinder does include admin uri?)


| Resource      | Operation                                                 | HTTP Method   | Path                          | JSON/XML?         | Privilege Level   |
| :-------      | :-------------------                                      | :----------   | :---------------------        | :---------------- | :--------------   |
| **Volumes**   | [List volumes](#list_volumes)                             | GET           | /volumes                      | Y/Y               |                   |
|               | [List volumes details](#list_volumes_details)             | GET           | /volumes/detail               | Y/Y               |                   |
|               | [Get volume details](#get_volume_details)                 | GET           | /volumes/{volume_id}          | Y/Y               |                   |
|               | [Create volume](#create_volume)                           | POST          | /volumes                      | Y/Y               |                   |
|               | [Delete volume](#delete_volume)                           | DELETE        | /volumes/{volume_id}          | Y/Y               |                   |
| **Snapshots** | [List volume snapshots](#list_snapshots)                  | GET           | /snapshots                    | Y/Y               |                   |
|               | [List volume snapshots details](#list_snapshots_details)  | GET           | /snapshots/detail             | Y/Y               |                   |
|               | [Get volume snapshot details](#get_snapshot_details)      | GET           | /snapshots/{snapshot_id}      | Y/Y               |                   |
|               | [Create volume snapshot](#create_snapshot)                | POST          | /snapshots                    | Y/Y               |                   |
|               | [Delete volume snapshot](#delete_snapshot)                | DELETE        | /snapshots/{snapshot_id}      | Y/Y               |                   |
| **Backups**   | [List volume backups](#list_backups)                      | GET           | /backups                      | Y/Y               |                   |
|               | [List volume backups details](#list_backups_details)      | GET           | /backups/detail               | Y/Y               |                   |
|               | [Get volume backup details](#get_backup_details)          | GET           | /backups/{backup_id}          | Y/Y               |                   |
|               | [Create volume backup](#create_backup)                    | POST          | /backups                      | Y/Y               |                   |
|               | [Delete volume backup](#delete_backup)                    | DELETE        | /backups/{backup_id}          | Y/Y               |                   |
|               | [Restore volume backup](#restore_backup)                  | POST          | /backups/{backup_id}/restore  | Y/Y               |                   |


#### 4.1.2 HP Cloud Compute Service API Operations

TODO(smulcahy): clarify endpoints for production

**Host** (US West Region): https://region-a.geo-1.compute.hpcloudsvc.com

**Host** (US East Region): https://region-b.geo-1.compute.hpcloudsvc.com

**BaseURI**: {Host}/v2/{tenant_id}

**Admin URI**: TODO(smulcahy): clarify this for production, does nova include admin uri?


| Resource      | Operation                                             | HTTP Method   | Path                                                      | JSON/XML?         | Privilege Level   |
| :-------      | :-------------------                                  | :----------   | :---------------------                                    | :---------------- | :--------------   |
| **Servers**   | [List attached volumes](#list_attached_volumes)       | GET           | /servers/{server_id}/os-volume_attachments                | Y/Y               |                   |
|               | [Attach a volume](#attach_volume)                     | POST          | /servers/{server_id}/os-volume_attachments                | Y/Y               |                   |
|               | [Detach a volume](#detach_volume)                     | DELETE        | /servers/{server_id}/os-volume_attachments/{volume_id}    | Y/Y               |                   |
|               | [Get attached volume details](#get_attvolume_details) | GET           | /servers/{server_id}/os-volume_attachments/{volume_id}    | Y/Y               |                   |

### 4.2 Common Request Headers

Many operations accept request headers. This section provides an overview of
each request header. Consult the specific operation to determine if the
header applies to the operation and any other notes that are of interest.

#### 4.2.1 Accept #### {#accept_request}

Where applicable, this specifies the media types which are acceptable for the
response. The tables in [Service API Operations](#service_api) detail which
media types are supported for each operation. Typically, all operations
support either of the following formats:

* JSON (application/json)
* XML (application/xml)

The response format can also be specified by adding a _.json_ or _.xml_
extension to the request URI. If both an _Accept_ header and an
extension are used, the extension takes precedence. If no response format
is requested, JSON is the default.

For example:

    curl -H "Accept: application/json" ...

#### 4.2.2 Content-Type #### {#content_type_request}

Where applicable, this indicates the media type of the request body. The tables
in [Service API Operations](#service_api) detail which formats are supported
for each operation. Typically, all operations support either of the following
formats:

* JSON (application/json)
* XML (application/xml)

For example:

    curl -H "Content-Type: application/json" ...

#### 4.2.3 X-Auth-Token #### {#x_auth_token_request}

All requests to the HP Cloud Block Storage API must be accompanied by a token.
This is issued by the HP Cloud Identify Service in response to a successful
authentication request. Each token has a scope which describes which resources
are accessible with it. If the token is not specified or if an invalid or
expired token is specified, the request will fail.

### 4.3 Common Response Headers

#### 4.3.1 Content-Type #### {#content_type_response}

When the response includes a body, this indicates the media type of the
response body. For operations that return a body, an [Accept](#accept_request)
request header can be used to request a JSON or XML response.

#### 4.3.2 Content-Length #### {#content_length_response}

When the response includes a body, this indicates the length of the body in
bytes.

#### 4.3.3 Date #### {#date_response}

When supplied, the Date header is the time of the operation expressed in GMT
(effectively UTC) as shown in the following example:
 
      HTTP/1.1 200 OK
      Date: Sun, 06 Nov 1994 08:49:37 GMT

#### 4.3.4 X-Compute-Request-Id #### {#request_id_response}

The HP Cloud Block Storage API generates a unique id for each request received.
This id is reported in the response with the _X-Compute-Request-Id_ header and
can be used by support to track individual requests within the system in the
event of a failure.

## 4.4 Error Responses

When an error occurs at request time, the system will return an HTTP
error response code denoting the type of error. The system will also
return additional information about the fault in the body of the
response.

JSON

    {
        "badRequest": {
            "code": 400
            "message": "Malformed request body",
        }
    }

XML

    <badRequest code="400"
    xmlns="http://docs.openstack.org/volume/api/v1">
      <message>Malformed request body</message>
    </badRequest>

The error code is returned in the body of the response for convenience.
The message section returns a human-readable message that is appropriate
for display to the end user.

The following error codes are used by HP Cloud Block Storage.

|Code               | Description                                                                                                   | Notes                                                                                             |
|:---               | :----------                                                                                                   | :----                                                                                             |
| 5xx Server Error  | Response codes starting with 5 indicate the server has experienced an error and cannot process the request.   | Retry the request after a short delay. Contact HP Cloud support if the error persists.            |
| 400 Bad Request   | The request could not be processed by the server due to malformed syntax.                                     | Fix the request.                                                                                  |
| 401 Unauthorized  | This usually means that the [authorization token](#x_auth_token_request) is missing, invalid or expired.      | Supply a valid token, possibly by request a new one with valid credentials.                       |
| 403 Forbidden     | The request was a valid request, you do not have the appropriate access rights to the resource.               |                                                                                                   |
| 404 Not Found     | The requested resource could not be found.                                                                    | Either your are using an incorrect url or the resource request never existed or has been deleted. |

The OverLimit fault is generated when any limit threshold is exceeded. Limits
can be either transient limits (the number of requests allowed per second) or
static limits (the number of volumes or backups allowed for a particular
tenant). When a transient OverLimit fault occurs, the time in seconds after which
another request is allowed in returned in the _Retry-After_ response header. 

JSON

    {
        "overLimit" : {
            "code" : 413,
            "message" : "This request was rate-limited.",
        }
    }

XML

    <?xml version="1.0" encoding="UTF-8"?>
    <overLimit
        xmlns="http://docs.openstack.org/compute/api/v1.1"
        code="413"
      <message>"This request was rate-limited.</message>
    </overLimit>

## 4.5 Service API Operation Details

TODO(smulcahy) Add a section detailing how we use availability zones
particularly describing the differences between how we do things and 
how other openstack deployments might?

### 4.5.1 Volumes

See [HP Cloud Block Storage Volumes](#volume_resource) for details.

**Status Lifecycle**

_creating_ => _available_ (creation of standard volume)

_downloading_ => _available_ (creation of bootable volume)

_available_ => _attaching_ (during attach)

_attaching_ => _in-use_ (after attach)

_in-use_ => _detaching_ (during detach)

_detaching_ => _available_ (after detach)

_available_ => _backing-up_ (during volume backup creation)

_available_ => _restoring-backup_ (during volume backup restore)

In the event of an error the status can be  set to _error_. If an error occurs
 during attach, the status is set to _error_attaching_  and if an error occurs
during detach, the volume status is set to _error_detaching_. If an error occurs 
while restoring  a backup to a volume, the volume status is set to _error_restoring_.

**Rate Limits**

N/A

**Quota Limits**

The quota as configured for the tenant governs the size of the volume that can
be created. An exception will be raised if quota is exceeded. Sample exception:

    413 Request Entity Too Large
    {
        "overLimit": {
            "code": 413, 
            "message": "VolumeSizeExceedsAvailableQuota: Requested volume exceeds allowed volume size quota", 
            "retryAfter": 0
        }
    }

The error reported to the user when using the standard python-cinderclient is:
    "ERROR: VolumeSizeExceedsAvailableQuota: Requested volume exceeds allowed volume size quota (HTTP 413) (Request-ID: req-3135cb3b-5ca9-4f5e-8f57-7225cdddc6d2)"

Note the inclusion of the _Request-ID_ which can be used by support to trace this request in backend logs.

**Business Rules**

When creating a volume from an existing snapshot, passing in a size in the
create volume call has no effect. The size of the snapshot is used to create
the new volume. Currently, if you use the nova api, you have to specify a
size. What will actually happen is that the size you specify will be recorded
in the database and used for describe and quota operations, but the actual
volume will be the same size as the origin volume. This is a known issue.

TODO(smulcahy) check if this is still an issue

##### 4.5.1.1 List volumes #### {#list_volumes}
###### GET /volumes

Lists volumes for this tenant.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "volumes": [
            {
                "attachments": [], 
                "availability_zone": "nova", 
                "bootable": "false", 
                "created_at": "2013-01-23T11:25:03.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "128a2078-0de3-4ff2-bf9f-d315e91fe3bb", 
                "metadata": {}, 
                "size": 200, 
                "snapshot_id": null, 
                "source_volid": null, 
                "status": "error", 
                "volume_type": "None"
            }, 
            {
                "attachments": [
                    {
                        "device": "/dev/vdd", 
                        "id": "29b53979-c09d-4944-a170-5430aac864df", 
                        "server_id": "c31ae64f-03d4-4bc9-b2bf-06f80db0ff62", 
                        "volume_id": "29b53979-c09d-4944-a170-5430aac864df"
                    }
                ], 
                "availability_zone": "nova", 
                "bootable": "true", 
                "created_at": "2013-01-21T16:36:19.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "29b53979-c09d-4944-a170-5430aac864df", 
                "metadata": {}, 
                "size": 5, 
                "snapshot_id": null, 
                "source_volid": null, 
                "status": "in-use", 
                "volume_type": "None"
            }, 
            {
                "attachments": [], 
                "availability_zone": "nova", 
                "bootable": "false", 
                "created_at": "2013-01-21T14:32:27.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "d9f5479a-a9af-4e96-b418-0d9a602a8b03", 
                "metadata": {}, 
                "size": 2, 
                "snapshot_id": "2ee9a7ed-48f3-481c-a20e-6c53bf08c067", 
                "source_volid": null, 
                "status": "available", 
                "volume_type": "None"
            }, 
    

XML

    <?xml version="1.0" ?>
    <volumes xmlns="http://docs.openstack.org/volume/api/v1" xmlns:atom="http://www.w3.org/2005/Atom">
        <volume availability_zone="nova" created_at="2013-01-23 11:25:03" display_description="None" display_name="None" id="128a2078-0de3-4ff2-bf9f-d315e91fe3bb" size="200" snapshot_id="None" source_volid="None" status="error" volume_type="None">
            <attachments/>
            <metadata/>
        </volume>
        <volume availability_zone="nova" created_at="2013-01-21 16:36:19" display_description="None" display_name="None" id="29b53979-c09d-4944-a170-5430aac864df" size="5" snapshot_id="None" source_volid="None" status="in-use" volume_type="None">
            <attachments>
                <attachment device="/dev/vdd" id="29b53979-c09d-4944-a170-5430aac864df" server_id="c31ae64f-03d4-4bc9-b2bf-06f80db0ff62" volume_id="29b53979-c09d-4944-a170-5430aac864df"/>
            </attachments>
            <metadata/>
        </volume>
        <volume availability_zone="nova" created_at="2013-01-21 14:32:27" display_description="None" display_name="None" id="d9f5479a-a9af-4e96-b418-0d9a602a8b03" size="2" snapshot_id="2ee9a7ed-48f3-481c-a20e-6c53bf08c067" source_volid="None" status="available" volume_type="None">
            <attachments/>
            <metadata/>
        </volume>
        <volume availability_zone="nova" created_at="2013-01-17 11:39:56" display_description="None" display_name="None" id="9b93609e-229f-4e99-8f1e-721fcd86e7db" size="1" snapshot_id="None" source_volid="None" status="available" volume_type="None">
            <attachments/>
            <metadata/>
        </volume>
    </volumes>

**Curl Examples**

TODO(smulcahy) Verify we are using CURRENT api for all examples (that should be v2 for volumes and v1 for backups??)

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/volumes
    
    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/volumes

##### 4.5.1.2 List volumes details #### {#list_volumes_details}
###### GET /volumes/detail

Lists volumes for this tenant, providing more detail about each volume
than [List volumes](#list_volumes).

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "volumes": [
            {
                "attachments": [], 
                "availability_zone": "nova", 
                "bootable": "false", 
                "created_at": "2013-01-23T11:25:03.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "128a2078-0de3-4ff2-bf9f-d315e91fe3bb", 
                "metadata": {}, 
                    "size": 200, 
                "snapshot_id": null, 
                "source_volid": null, 
                "status": "error", 
                "volume_type": "None"
            }, 
            {
                "attachments": [
                    {
                        "device": "/dev/vdd", 
                        "id": "29b53979-c09d-4944-a170-5430aac864df", 
                        "server_id": "c31ae64f-03d4-4bc9-b2bf-06f80db0ff62", 
                        "volume_id": "29b53979-c09d-4944-a170-5430aac864df"
                    }
                ], 
                "availability_zone": "nova", 
                "bootable": "true", 
                "created_at": "2013-01-21T16:36:19.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "29b53979-c09d-4944-a170-5430aac864df", 
                "metadata": {}, 
                "size": 5, 
                "snapshot_id": null, 
                "source_volid": null, 
                "status": "in-use", 
                "volume_image_metadata": {
                    "image_id": "62560ce2-ee31-4ee6-bc9b-81a98fd3d52b", 
                    "image_name": "precise-server-cloudimg-i386"
                }, 
                "volume_type": "None"
            }, 
            {
                "attachments": [], 
                "availability_zone": "nova", 
                "bootable": "false", 
                "created_at": "2013-01-21T14:32:27.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "d9f5479a-a9af-4e96-b418-0d9a602a8b03", 
                "metadata": {}, 
                "size": 2, 
                "snapshot_id": "2ee9a7ed-48f3-481c-a20e-6c53bf08c067", 
                "source_volid": null, 
                "status": "available", 
                "volume_type": "None"
            }, 
            {
                "attachments": [], 
                "availability_zone": "nova", 
                "bootable": "false", 
                "created_at": "2013-01-17T11:39:56.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "9b93609e-229f-4e99-8f1e-721fcd86e7db", 
                "metadata": {}, 
                "size": 1, 
                "snapshot_id": null, 
                "source_volid": null, 
                "status": "available", 
                "volume_type": "None"
            }
        ]
    }


XML

    <?xml version="1.0" ?>
    volumes xmlns="http://docs.openstack.org/volume/api/v1" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:os-vol-image-meta="http://docs.openstack.org/volume/ext/volume_image_metadata/api/v1">
       <volume availability_zone="nova" created_at="2013-01-23 11:25:03" display_description="None" display_name="None" id="128a2078-0de3-4ff2-bf9f-d315e91fe3bb" size="200" snapshot_id="None" source_volid="None" status="error" volume_type="None">
           <attachments/>
           <metadata/>
       </volume>
       <volume availability_zone="nova" created_at="2013-01-21 16:36:19" display_description="None" display_name="None" id="29b53979-c09d-4944-a170-5430aac864df" size="5" snapshot_id="None" source_volid="None" status="in-use" volume_type="None">
           <attachments>
               <attachment device="/dev/vdd" id="29b53979-c09d-4944-a170-5430aac864df" server_id="c31ae64f-03d4-4bc9-b2bf-06f80db0ff62" volume_id="29b53979-c09d-4944-a170-5430aac864df"/>
           </attachments>
           <metadata/>
           <volume_image_metadata>
               <meta key="image_id">62560ce2-ee31-4ee6-bc9b-81a98fd3d52b</meta>
               <meta key="image_name">precise-server-cloudimg-i386</meta>
           </volume_image_metadata>
       </volume>
       <volume availability_zone="nova" created_at="2013-01-21 14:32:27" display_description="None" display_name="None" id="d9f5479a-a9af-4e96-b418-0d9a602a8b03" size="2" snapshot_id="2ee9a7ed-48f3-481c-a20e-6c53bf08c067" source_volid="None" status="available" volume_type="None">
           <attachments/>
           <metadata/>
       </volume>
       <volume availability_zone="nova" created_at="2013-01-17 11:39:56" display_description="None" display_name="None" id="9b93609e-229f-4e99-8f1e-721fcd86e7db" size="1" snapshot_id="None" source_volid="None" status="available" volume_type="None">
           <attachments/>
           <metadata/>
       </volume>
    /volumes>

**Curl Examples**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/volumes/detail
    
    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/volumes/detail


##### 4.5.1.3 Get volume details #### {#get_volume_details}
###### GET /volumes/{volume_id}

Gets the details of the volume specified by {volume_id}.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *volume_id* - The identifier for the volume.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "volume": {
            "attachments": [], 
            "availability_zone": "nova", 
            "bootable": "false", 
            "created_at": "2013-01-17T11:39:56.000000", 
            "display_description": null, 
            "display_name": null, 
            "id": "9b93609e-229f-4e99-8f1e-721fcd86e7db", 
            "metadata": {}, 
            "size": 1, 
            "snapshot_id": null, 
            "source_volid": null, 
            "status": "available", 
            "volume_type": "None"
        }
    }

XML

    <?xml version="1.0" ?>
    <volume availability_zone="nova" created_at="2013-01-17 11:39:56" display_description="None" display_name="None" id="9b93609e-229f-4e99-8f1e-721fcd86e7db" size="1" snapshot_id="None" source_volid="None" status="available" volume_type="None" xmlns="http://docs.openstack.org/volume/api/v1" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:os-vol-image-meta="http://docs.openstack.org/volume/ext/volume_image_metadata/api/v1">
        <attachments/>
        <metadata/>
    </volume>

**Curl Examples**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/volumes/${VOLUME_ID}

    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/volumes/${VOLUME_ID}



##### 4.5.1.4 Create volume #### {#create_volume}
###### POST /volumes

Create a new volume of a given size in the specified _availability_zone_.

If the _snapshot_id_ attribute is not null then the volume created is a copy
of the specified snapshot. If the _imageRef_ parameter is not null then a
bootable volume is created.

The request is invalid if both the _snapshot_id_ and the _ImageRef_ parameters are
specified and both are not null.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.

**Data Parameters**

* *availability_zone* - string - The availability zone (az1, az2 or az3)
* *display_description* (Optional) - string - Description for the volume
* *display_name* (Optional) - string - Name of the volume
* *imageRef* (Optional) - string - Id of an image service image from which to create the volume
* *metadata* (Optional) - hash or dictionary - Metadata key/value pairs
* *size* - integer - Size of the volume in GB
* *snapshot_id* (Optional) - string - Id of a volume snapshot from which to create the volume
* *source_volid* (Optional) - string - Id of a volume from which to create the volume
* *volume_type* (Optional) - string - The volume type, this parameter is currently ignored

JSON

    {
        "volume":{
            "availability_zone": "az3", 
            "size":1,
            "display_name":"test-vol-001",
            "display_description":"Test volume for demo purposes"
        }
    }


XML

    <volume availability_zone="nova" size="1"/>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "volume": {
            "attachments": [], 
            "availability_zone": "az1", 
            "bootable": "false", 
            "created_at": "2013-01-30T13:38:50.411386", 
            "display_description": null, 
            "display_name": null, 
            "id": "b6f6b5fb-ba09-44c9-a263-b4acbdbf1d38", 
            "metadata": {}, 
            "size": 1, 
            "snapshot_id": null, 
            "source_volid": null, 
            "status": "creating", 
            "volume_type": "None"
        }
    }

XML
    <?xml version='1.0' encoding='utf-8'?>
    <volume xmlns:atom="http://www.w3.org/2005/Atom"
        xmlns="http://docs.openstack.org/volume/api/v1" status="creating"
        display_name="None" availability_zone="nova"
        created_at="2013-01-30 13:50:55.134360" display_description="None"
        volume_type="None" snapshot_id="None" source_volid="None"
        id="8276e101-2d67-4e67-b63f-78b3a34e678c" size="1">
      <attachments />
      <metadata />
    </volume>

**Curl Examples**

    curl -i -H "Content-Type: application/json" -H "x-auth-token: ${AUTH_TOKEN}" -d '{"volume": {"size": 1, "availability_zone": "az1" }}' ${BASE_URI}/v1/${TENANT_ID}/volumes

    curl -i -H "Accept: application/xml" -H "Content-Type: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" -d '<volume availability_zone="nova" size="1"/>' ${BASE_URI}/v1/${TENANT_ID}/volumes


TODO(smulcahy) Add additional examples and request/response samples for scenarios such as creating from snapshot, bfv and so on
TODO(smulcahy) Clarify that some options are mutually exclusive options (imageRef/snapshot_id/source_volid)

##### 4.5.1.5 Delete volume #### {#delete_volume}
###### DELETE /volumes/{volume_id}

Delete the volume specified by {volume_id}.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *volume_id* - The identifier for the volume.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

202 - Accepted

TODO(smulcahy) verify all success status codes and document error codes in a common section

**Response Data**

This call does not return a response body.

**Curl Example**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" -X DELETE ${BASE_URI}/v1/${TENANT_ID}/volumes/${VOLUME_ID}

### 4.5.2 Volume Snapshots

See [HP Cloud Block Storage Volume Snapshots](#volume_snapshot_resource) for details.

**Status Lifecycle**

_creating_ => _available_ (after creation)

In the event of an error status is set to _error_.

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

After you create a snapshot from a volume you can delete the volume and
continue to work with the snapshot. Similarly, after you create a volume
from a snapshot you can delete the snapshot and continue to work with the
volume.

You can not create a snapshot from a volume that is attached to a server
unless the optional _force_ parameter is set to _true_ during snapshot
creation.
TODO(smulcahy) verify this is correct

##### 4.5.2.1 List volume snapshots #### {#list_snapshots}
###### GET /snapshots

Lists volume snapshots for this tenant.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "snapshots": [
            {
                "created_at": "2013-01-30T16:44:13.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "0500944b-1179-4b1c-9f31-b3f0da8e669c", 
                "size": 1, 
                "status": "available", 
                "volume_id": "64f5d2fb-d836-4063-b7e2-544d5c1ff607"
            }, 
            {
                "created_at": "2013-01-30T16:41:58.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "e45fed49-801d-4a61-8927-5c8005a1c584", 
                "size": 1, 
                "status": "available", 
                "volume_id": "64f5d2fb-d836-4063-b7e2-544d5c1ff607"
            }
        ]
    }

XML

    <?xml version='1.0' encoding='utf-8'?>
    <snapshots>
      <snapshot status="available" display_name="None"
      created_at="2013-01-30 16:44:13" display_description="None"
      volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"
      id="0500944b-1179-4b1c-9f31-b3f0da8e669c" size="1" />
      <snapshot status="available" display_name="None"
      created_at="2013-01-30 16:41:58" display_description="None"
      volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"
      id="e45fed49-801d-4a61-8927-5c8005a1c584" size="1" />
    </snapshots>

**Curl Examples**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/snapshots
    
    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/snapshots


##### 4.5.2.2 List volumes snapshots details #### {#list_snapshots_details}
###### GET /snapshots/detail

Lists volume snapshots for this tenant, providing more detail about each
snapshot than [List volume snapshots](#list_snapshots).

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {    
        "snapshots": [
            {
                "created_at": "2013-01-30T16:44:13.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "0500944b-1179-4b1c-9f31-b3f0da8e669c", 
                "os-extended-snapshot-attributes:progress": "100%", 
                "os-extended-snapshot-attributes:project_id": "e56a97501ac64da4af7c7a6f4ecb7426", 
                "size": 1, 
                "status": "available", 
                "volume_id": "64f5d2fb-d836-4063-b7e2-544d5c1ff607"
            }, 
            {
                "created_at": "2013-01-30T16:41:58.000000", 
                "display_description": null, 
                "display_name": null, 
                "id": "e45fed49-801d-4a61-8927-5c8005a1c584", 
                "os-extended-snapshot-attributes:progress": "100%", 
                "os-extended-snapshot-attributes:project_id": "e56a97501ac64da4af7c7a6f4ecb7426", 
                "size": 1, 
                "status": "available", 
                "volume_id": "64f5d2fb-d836-4063-b7e2-544d5c1ff607"
            }
        ]
    }

XML

    <?xml version='1.0' encoding='utf-8'?>
    <snapshots xmlns:os-extended-snapshot-attributes="http://docs.openstack.org/volume/ext/extended_snapshot_attributes/api/v1">

      <snapshot status="available" display_name="None"
      created_at="2013-01-30 16:44:13" display_description="None"
      volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"
      id="0500944b-1179-4b1c-9f31-b3f0da8e669c" size="1"
      os-extended-snapshot-attributes:project_id="e56a97501ac64da4af7c7a6f4ecb7426"
      os-extended-snapshot-attributes:progress="100%" />
      <snapshot status="available" display_name="None"
      created_at="2013-01-30 16:41:58" display_description="None"
      volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"
      id="e45fed49-801d-4a61-8927-5c8005a1c584" size="1"
      os-extended-snapshot-attributes:project_id="e56a97501ac64da4af7c7a6f4ecb7426"
      os-extended-snapshot-attributes:progress="100%" />
    </snapshots>

**Curl Examples**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/snapshots/deail
    
    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/snapshots/detail


##### 4.5.2.3 Get volume snapshot details #### {#get_snapshot_details}
###### GET /snapshots/{snapshot_id}

Gets the details of the snapshot specified by _snapshot_id_.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *snapshot_id* - The identifier for the snapshot.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "snapshot": {
            "created_at": "2013-01-30T17:37:06.000000", 
            "display_description": null, 
            "display_name": null, 
            "id": "49bfe04f-32c6-4804-805d-9c3d0040a11f", 
            "os-extended-snapshot-attributes:progress": "100%", 
            "os-extended-snapshot-attributes:project_id": "e56a97501ac64da4af7c7a6f4ecb7426", 
            "size": 1, 
            "status": "available", 
            "volume_id": "64f5d2fb-d836-4063-b7e2-544d5c1ff607"
        }
    }

XML

    <?xml version='1.0' encoding='utf-8'?>
    <snapshot xmlns:os-extended-snapshot-attributes="http://docs.openstack.org/volume/ext/extended_snapshot_attributes/api/v1"
    status="available" display_name="None"
    created_at="2013-01-30 17:37:06" display_description="None"
    volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"
    id="49bfe04f-32c6-4804-805d-9c3d0040a11f" size="1"
    os-extended-snapshot-attributes:project_id="e56a97501ac64da4af7c7a6f4ecb7426"
    os-extended-snapshot-attributes:progress="100%" />

**Curl Examples**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/snapshots/${SNAPSHOT_ID}

    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/snapshots/${SNAPSHOT_ID}


##### 4.5.2.4 Create volume snapshot #### {#create_snapshot}
###### POST /snapshots

Create a new snapshot of the specified volume.

The snapshot will be created in the _availability_zone_ of the specified
volume. 

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.

**Data Parameters**

* *display_description* (Optional) - string - Description for the snapshot
* *display_name* (Optional) - string - Name of the snapshot
* *force* (Optional) - boolean - Defaults to false.
* *volume_id* - string - Id of the volume from which to create the snapshot

JSON

    {
        "snapshot": {
            "display_description": null, 
            "display_name": null, 
            "force": false, 
            "volume_id": "64f5d2fb-d836-4063-b7e2-544d5c1ff607"
        }
    }

XML

    <snapshot display_name="None" display_description="None"
    force="false" volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"/>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "snapshot": {
            "created_at": "2013-01-30T19:15:22.014175", 
            "display_description": null, 
            "display_name": null, 
            "id": "64f0946c-2863-4392-afe3-94f3f600f5e8", 
            "size": 1, 
            "status": "creating", 
            "volume_id": "64f5d2fb-d836-4063-b7e2-544d5c1ff607"
        }
    }

XML
    <?xml version='1.0' encoding='utf-8'?>
    <snapshot status="creating" display_name="None"
    created_at="2013-01-30 19:16:10.149951" display_description="None"
    volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"
    id="9b211c57-7fb5-4811-88ea-15fc30908dba" size="1" />

**Curl Examples**

    curl -i -H "Content-Type: application/json" -H "x-auth-token: ${AUTH_TOKEN}" -d '{"snapshot": { "volume_id": "64f5d2fb-d836-4063-b7e2-544d5c1ff607" }}' ${BASE_URI}/v1/${TENANT_ID}/snapshots

    curl -i -H "Accept: application/xml" -H "Content-Type: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" -d '<snapshot volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"/>' ${BASE_URI}/v1/${TENANT_ID}/snapshots


##### 4.5.2.5 Delete volume snapshot #### {#delete_snapshot}
###### DELETE /snapshots/{snapshot_id}

Delete the snapshot specified by _snapshot_id_.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *snapshot_id* - The identifier for the snapshot.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

202 - Accepted

**Response Data**

This call does not return a response body.

**Curl Example**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" -X DELETE ${BASE_URI}/v1/${TENANT_ID}/snapshots/${SNAPSHOT_ID}


### 4.5.3 Volume Backups

See [HP Cloud Block Storage Volume Backups](#volume_backup_resource) for details.

**Status Lifecycle**

_creating_ => _available_ (after creation)

_available_ => _restoring_ (during restore)

_available_ => _deleting_ (during delete)

In the event of an error, during any operation, status is set to _error_

Volume status is set to _backing-up_ during backup creation and
 _restoring-backup_  during backup restore. If an error occurs while restoring
 a backup to a volume, the volume status is set to _error_restoring_.

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

N/A


##### 4.5.3.1 List volume backups #### {#list_backups}
###### GET /backups

Lists volume backups for this tenant.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.

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
                "id": 1, 
                "status": "available"
            }, 
            {
                "id": 2, 
                "status": "creating"
            }
        ]
    }

XML

    <?xml version='1.0' encoding='utf-8'?>
    <backups xmlns:backups="http://docs.openstack.org/volume/ext/backups/api/v1.1">
      <backup status="available" id="1" />
      <backup status="available" id="2" />
    </backups>

**Curl Examples**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/backups
    
    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/backups


##### 4.5.3.2 List volume backups details #### {#list_backups_details}
###### GET /backups/detail

Lists volume backups for this tenant, providing more detail about each
backup than [List volume backups](#list_backups).

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.

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
                "availability_zone": "az1", 
                "container": "volumebackups", 
                "created_at": "2013-01-31T12:43:30.000000", 
                "display_description": null, 
                "display_name": null, 
                "fail_reason": null, 
                "id": 1, 
                "object_count": 22, 
                "size": 1, 
                "status": "available", 
                "volume_id": "795114e8-7489-40be-a978-83797f2c1dd3"
            }, 
            {
                "availability_zone": "az1", 
                "container": "volumebackups", 
                "created_at": "2013-01-31T12:44:32.000000", 
                "display_description": null, 
                "display_name": null, 
                "fail_reason": null, 
                "id": 2, 
                "object_count": 22, 
                "size": 1, 
                "status": "available", 
                "volume_id": "795114e8-7489-40be-a978-83797f2c1dd3"
            }
        ]
    }


XML

    <?xml version='1.0' encoding='utf-8'?>
    <backups xmlns:backups="http://docs.openstack.org/volume/ext/backups/api/v1.1">

      <backup status="available" object_count="22"
      container="volumebackups" availability_zone="az1"
      created_at="2013-01-31 12:43:30" fail_reason="None"
      display_description="None"
      volume_id="795114e8-7489-40be-a978-83797f2c1dd3"
      display_name="None" id="1" size="1" />
      <backup status="available" object_count="22"
      container="volumebackups" availability_zone="az1"
      created_at="2013-01-31 12:44:32" fail_reason="None"
      display_description="None"
      volume_id="795114e8-7489-40be-a978-83797f2c1dd3"
      display_name="None" id="2" size="1" />
    </backups>

**Curl Examples**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/backups/deail
    
    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/backups/detail


##### 4.5.3.3 Get volume backup details #### {#get_backup_details}
###### GET /backups/{backup_id}

Gets the details of the backup specified by {backup_id}.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *backup_id* - The identifier for the backup.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "backup": {
            "availability_zone": "az1", 
            "container": "volumebackups", 
            "created_at": "2013-01-31T12:43:30.000000", 
            "display_description": null, 
            "display_name": null, 
            "fail_reason": null, 
            "id": 1, 
            "object_count": 22, 
            "size": 1, 
            "status": "available", 
            "volume_id": "795114e8-7489-40be-a978-83797f2c1dd3"
        }
    }

XML

    <?xml version='1.0' encoding='utf-8'?>
    <backup xmlns:backups="http://docs.openstack.org/volume/ext/backups/api/v1.1"
    status="available" object_count="22" container="volumebackups"
    availability_zone="nova" created_at="2013-01-31 12:43:30"
    fail_reason="None" display_description="None"
    volume_id="795114e8-7489-40be-a978-83797f2c1dd3"
    display_name="None" id="1" size="1" />

**Curl Examples**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/backups/${BACKUP_ID}

    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v1/${TENANT_ID}/backups/${BACKUP_ID}


##### 4.5.3.4 Create volume backup #### {#create_backup}
###### POST /backups

Create a new backup of the specified volume, copying the contents of the
volume to the tenant's HP Cloud Object Storage. The backup will be created
in a container called _volumebackups_ if the container name is not
specified. If the container does not exist, it will be created.

The backup will be created in the _availability_zone_ of the specified
volume.

The volume data is split into chunks (normally 50MB in size but this may
change) and written to files named as follows,

    volume_<volume id>/<YYYYMMDDHHMMSS>/az_<availability zone>_backup_<backup id>-<object number>

For example,

    volume_795114e8-7489-40be-a978-83797f2c1dd3/20130131124331/az_az1_backup_1-00001

This operation is asynchronous. You must list backups repeatedly to determine
if the backup has been created.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.

**Data Parameters**

* *container* (Optional) - string - The name of the object storage container to which the volume is to be backed up.
* *display_description* (Optional) - string - Description for the backup
* *display_name* (Optional) - string - Name of the backup
* *volume_id* - string - Id of the volume from which to create the backup

JSON

    {
        "backup": {
            "container": null, 
            "display_description": null, 
            "display_name": null, 
            "volume_id": "64f5d2fb-d836-4063-b7e2-544d5c1ff607"
        }
    }

XML

    <backup container="None" display_name="None" display_description="None"
    volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"/>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "backup": {
            "availability_zone": null, 
            "container": null, 
            "created_at": "2013-01-31T13:09:42.457824", 
            "display_description": null, 
            "display_name": null, 
            "fail_reason": null, 
            "id": 3, 
            "object_count": null, 
            "size": 1, 
            "status": "creating", 
            "volume_id": "795114e8-7489-40be-a978-83797f2c1dd3"
        }
    }

XML

    <?xml version='1.0' encoding='utf-8'?>
    <backup xmlns:backups="http://docs.openstack.org/volume/ext/backups/api/v1.1"
    status="creating" object_count="None" container="None"
    availability_zone="None" created_at="2013-01-31 13:13:17.604988"
    fail_reason="None" display_description="None"
    volume_id="795114e8-7489-40be-a978-83797f2c1dd3"
    display_name="None" id="4" size="1" />

**Curl Examples**

    curl -i -H "Content-Type: application/json" -H "x-auth-token: ${AUTH_TOKEN}" -d '{"backup": {"volume_id": "'${VOLUME_ID}'" }}' ${BASE_URI}/v1/${TENANT_ID}/backups

    curl -i -H "Accept: application/xml" -H "Content-Type: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" -d '<backup volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"/>' ${BASE_URI}/v1/${TENANT_ID}/backups

TODO(smulcahy) Make sure all curl examples use VOLUME_ID rather than specific id

##### 4.5.3.5 Delete volume backup #### {#delete_backup}
###### DELETE /backups/{backup_id}

Delete the backup specified by {backup_id}.

This operation is asynchronous. You must list backups repeatedly to determine
if the backup has been deleted.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *backup_id* - The identifier for the backup.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

202 - Accepted

**Response Data**

This call does not return a response body.

**Curl Example**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" -X DELETE ${BASE_URI}/v1/${TENANT_ID}/backups/${BACKUP_ID}


##### 4.5.3.6 Restore volume backup #### {#restore_backup}
###### POST /backups/{backup_id}/restore

Restore the specific backup to a volume. The backup objects for this backup
will be copied from the tenant's HP Cloud Object Storage to a volume.

**If a _volume_id_ is specified in the request, that volume will be
overwritten with the backup data. If no _volume_id_ is specified, a new
volume will be created and used for the restore operation.**

TODO(smulcahy) investigate what behaviour we want relating to availability_zone,
I'm guessing we want to be able to specify the az through the api for backup
creation.

This operation is asynchronous. To check the status of the restore operation,
the user can call [Get volume details](#get_volume_details) for the _volume_id_ 
returned in the response (status will be set to _restoring_ while the the 
restore operation runs, _error_restoring_ if the restore operation fails and
_available_ if the restore operation succeeds).

**Request Data**

**URL Parameters**

* *backup_id* - The identifier for the backup.
* *tenant_id* - The unique identifier of the tenant or account.

**Data Parameters**

* *volume_id* - string - Id of the volume to which the backup should be restored.

JSON

    {
        "restore": {
            "volume_id": "64f5d2fb-d836-4063-b7e2-544d5c1ff607",
         }
    }

XML

    <restore volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"/>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "restore": {
            "backup_id": 2, 
            "volume_id": "795114e8-7489-40be-a978-83797f2c1dd3"
        }
    }

XML

    <?xml version='1.0' encoding='utf-8'?>
    <restore xmlns:backups="http://docs.openstack.org/volume/ext/backups/api/v1.1"
    backup_id="2" volume_id="795114e8-7489-40be-a978-83797f2c1dd3" />

**Curl Examples**

    curl -i -H "Content-Type: application/json" -H "x-auth-token: ${AUTH_TOKEN}" -d '{"restore": {"volume_id": "'${VOLUME_ID}'" }}' ${BASE_URI}/v1/${TENANT_ID}/backups/${BACKUP_ID}/restore

    curl -i -H "Accept: application/xml" -H "Content-Type: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" -d '<restore volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"/>' ${BASE_URI}/v1/${TENANT_ID}/backups/${BACKUP_ID}/restore

TODO(smulcahy) add common section(s) with error codes


### 4.5.4 Servers

See [HP Cloud Compute Service Servers](/api/compute#Server) for details of
the Server resource. From the HP Cloud Block Storage Service perspective,
a server is system to which a [volume](#volume_resource) can be attached.
When a volume is attached to a server, the server can mount the volume
and use it as a normal block storage device (allowing it to be partitioned,
formatted with a filesystem and so on).

**Status Lifecycle**

The volume status lifecycle for attach/detach is as follows:

_available_ => _attaching_ (during attach)

_attaching_ => _in-use_ (after attach)

_in-use_ => _detaching_ (during detach)

_detaching_ => _available_ (after detach)

If an error occurs during attach, the volume status is set to _error_attaching_
 and if an error occurs during detach, the volume status is set to _error_detaching_.

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

N/A


##### 4.5.4.1 List attached volumes #### {#list_attached_volumes}
###### GET /servers/{server_id}/os-volume_attachments

Lists the volumes attached to the server specified by {server_id}.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *server_id* - The identifier for the server.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "volumeAttachments": [
            {
                "device": "/dev/vdb", 
                "id": "795114e8-7489-40be-a978-83797f2c1dd3", 
                "serverId": "bb6a4f73-c851-4d62-8ef4-56c9b6c12df1", 
                "volumeId": "795114e8-7489-40be-a978-83797f2c1dd3"
            }
        ]
    }

XML

    <?xml version='1.0' encoding='utf-8'?>
    <volumeAttachments>
      <volumeAttachment device="/dev/vdb"
      serverId="bb6a4f73-c851-4d62-8ef4-56c9b6c12df1"
      id="795114e8-7489-40be-a978-83797f2c1dd3"
      volumeId="795114e8-7489-40be-a978-83797f2c1dd3" />
    </volumeAttachments>

**Curl Examples**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v2/${TENANT_ID}/servers/${SERVER_ID}/os-volume_attachments

    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v2/${TENANT_ID}/servers/${SERVER_ID}/os-volume_attachments


##### 4.5.4.2 Attach a volume #### {#attach_volume}
###### POST /servers/{server_id}/os-volume_attachments

Attach the volume specified by _volume_id_ to the server specified by
_server_id_.

**Request Data**

**URL Parameters**

* *server_id* - The identifier for the server.
* *tenant_id* - The unique identifier of the tenant or account.

**Data Parameters**

* *volume_id* - string - Id of the volume to attach
* *device* - string - Name of the device mount point
TODO(smulcahy): check if auto works with HP Cloud

JSON

    {
        "volumeAttachment": {
            "device": "/dev/vdb", 
            "volumeId": "795114e8-7489-40be-a978-83797f2c1dd3"
        }
    }

XML

    <volumeAttachment device="/dev/vdb"
    volume_id="64f5d2fb-d836-4063-b7e2-544d5c1ff607"/>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "volumeAttachment": {
            "device": "/dev/vdc", 
            "id": "c3b1a45c-9f3a-4226-af72-f38709ab25f2", 
            "serverId": "bb6a4f73-c851-4d62-8ef4-56c9b6c12df1", 
            "volumeId": "c3b1a45c-9f3a-4226-af72-f38709ab25f2"
        }
    }

XML

    <?xml version='1.0' encoding='utf-8'?>
    <volumeAttachment device="/dev/vdc"
    serverId="bb6a4f73-c851-4d62-8ef4-56c9b6c12df1"
    id="c3b1a45c-9f3a-4226-af72-f38709ab25f2"
    volumeId="c3b1a45c-9f3a-4226-af72-f38709ab25f2" />

**Curl Examples**

    curl -i -H "Content-Type: application/json" -H "x-auth-token: ${AUTH_TOKEN}" -d '{"volumeAttachment": {"device": "/dev/vdc", "volumeId": "c3b1a45c-9f3a-4226-af72-f38709ab25f2" }}' ${BASE_URI}/v2/${TENANT_ID}/servers/${SERVER_ID}/os-volume_attachments   
 
    curl -i -H "Accept: application/xml" -H "Content-Type: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" -d '<volumeAttachment device="/dev/vdc" volumeId="c3b1a45c-9f3a-4226-af72-f38709ab25f2"/>' ${BASE_URI}/v2/${TENANT_ID}/servers/${SERVER_ID}/os-volume_attachments

##### 4.5.4.3 Detach a volume #### {#detach_volume}
###### DELETE /servers/{server_id}/os-volume_attachments/{volume_id}

Detach the volume specified by _volume_id_ from the server specified by
_server_id_.

**Request Data**

**URL Parameters**

* *server_id* - The identifier for the server.
* *tenant_id* - The unique identifier of the tenant or account.
* *volume_id* - The identifier of the volume to detach.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

202 - Accepted

**Response Data**

This call does not return a response body.

**Curl Example**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" -X DELETE ${BASE_URI}/v2/${TENANT_ID}/servers/${SERVER_ID}/os-volume_attachments/${VOLUME_ID}


##### 4.5.4.4 Get attached volume details #### {#get_attvolume_details}
###### GET /servers/{server_id}/os-volume_attachments/{volume_id}

Gets the details of the volume specified by _volume_id_ attached to _server_id_.

**Request Data**

**URL Parameters**

* *server_id* - The identifier for the server.
* *tenant_id* - The unique identifier of the tenant or account.
* *volume_id* - The identifier of the volume to detach.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "volumeAttachment": {
            "device": "/dev/vdc", 
            "id": "c3b1a45c-9f3a-4226-af72-f38709ab25f2", 
            "serverId": "bb6a4f73-c851-4d62-8ef4-56c9b6c12df1", 
            "volumeId": "c3b1a45c-9f3a-4226-af72-f38709ab25f2"
        }
    }

XML

    <?xml version='1.0' encoding='utf-8'?>
    <volumeAttachment device="/dev/vdc"
    serverId="bb6a4f73-c851-4d62-8ef4-56c9b6c12df1"
    id="c3b1a45c-9f3a-4226-af72-f38709ab25f2"
    volumeId="c3b1a45c-9f3a-4226-af72-f38709ab25f2" />

**Curl Examples**

    curl -i -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v2/${TENANT_ID}/servers/${SERVER_ID}/os-volume_attachments/${VOLUME_ID}

    curl -i -H "Accept: application/xml" -H "x-auth-token: ${AUTH_TOKEN}" ${BASE_URI}/v2/${TENANT_ID}/servers/${SERVER_ID}/os-volume_attachments/${VOLUME_ID}

