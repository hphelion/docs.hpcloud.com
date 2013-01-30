---
layout: page
permalink: /api/block-storage/storage/
title: HP Cloud Block Storage API
description: "HP Cloud Block Storage API Specifications"
keywords: "bock, block storage, volumes"
product: block-storage

---

# HP Cloud Block Storage API Specifications

## 1. Overview

This document describes the Block Storage Service for Nova. The service
provides persistent block devices for virtual machines executing in Nova.
Bock volumes can store boot images, user data or both.

### 1.1 API Maturity Level


**Maturity Level**: Public stage - Bock is currently in public beta in all AZs of AW2, i.e. AW2 AZ1, AZ2 and AZ3

**Version API Status**: CURRENT


## 2. Architecture View

### 2.1 Conceptual/Logical Architecture View
The Nova volume service consists of an extension to the Nova API and an
additional API entry point. The API extension allows the caller to create
volumes that persist independently of Nova Virtual Machines. One or more of
these volumes can be attached to a Nova Virtual Machine, then they can be
mounted and used as standard block storage devices.

The API also provides an interface to create a read-only snapshot of an
existing Volume, and to create standard volumes from these snapshots.

### 2.2 Infrastructure Architecture View

This API is implemented as a Nova API Resource Extension and leverages the
existing infrastructure to deliver the service.

## 3. Account-level View

### 3.1 Accounts

The volumes API is an extension to the existing Nova API and as such,
requires no additional user accounts.


### 3.2 Regions and Availability Zones

It is expected that the volumes service will be provided in all
regions and zones which provide the Nova compute service.


### 3.3 Service Catalog

The Block Storage is exposed in the service catalog, as shown in the following fragment:


    {
          "name": "Block Storage",
          "type": "volume",
          "endpoints": [
            {
              "tenantId": "{tenant_id}",
              "publicURL": "https:\/\/az-1.region-a.geo-1.compute.hpcloudsvc.com\/v1.1\/{tenant_id}",
              "region": "az-1.region-a.geo-1",
              "versionId": "1.1",
              "versionInfo": "https:\/\/az-1.region-a.geo-1.compute.hpcloudsvc.com\/v1.1\/",
              "versionList": "https:\/\/az-1.region-a.geo-1.compute.hpcloudsvc.com"
            },
            {
              "tenantId": "{tenant_id}",
              "publicURL": "https:\/\/az-3.region-a.geo-1.compute.hpcloudsvc.com\/v1.1\/{tenant_id}",
              "region": "az-3.region-a.geo-1",
              "versionId": "1.1",
              "versionInfo": "https:\/\/az-3.region-a.geo-1.compute.hpcloudsvc.com\/v1.1\/",
              "versionList": "https:\/\/az-3.region-a.geo-1.compute.hpcloudsvc.com"
            },
            {
              "tenantId": "{tenant_id}",
              "publicURL": "https:\/\/az-2.region-a.geo-1.compute.hpcloudsvc.com\/v1.1\/{tenant_id}",
              "region": "az-2.region-a.geo-1",
              "versionId": "1.1",
              "versionInfo": "https:\/\/az-2.region-a.geo-1.compute.hpcloudsvc.com\/v1.1\/",
              "versionList": "https:\/\/az-2.region-a.geo-1.compute.hpcloudsvc.com"
            }
          ]
    }

### 3.4 Faults

When an error occurs at request time, the system will return an HTTP error
response code denoting the type of error. The system will also return
additional information about the fault in the body of the response.

The error codes and error messages returned are dscribed in the Nova Compute
documentation.

## 4. REST API Specifications

### 4.1 Service API Operations

**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseURI**: {Host}/v1.1/{tenant_id}

**Admin URI**: N/A

| Resource | Operation            | HTTP Method | Path                   | JSON/XML? | Privilege Level |
| :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |
| **Versions** | [Version information](#version_info)  | GET     | {Host}/v1.1/           | Y/**N**  |  |
|          | [Version list](#list_versions)         | GET         | {Host}/                | Y/**N**  |  |
| **Volumes**  | [List volumes](#list_volumes)         | GET     | {BaseUri}/os-volumes   | Y/**N**  |  |
|          | [Create new volume](#create_new_volume)    | POST        | {BaseUri}/os-volumes   | Y/**N**  |  |
|          | [Get volume details](#get_volume_details)   | GET         | {BaseUri}/os-volumes/{volume_id}  | Y/**N**  |  |
|          | [Delete volume](#delete_volume)        | GET         | {BaseUri}/os-volumes/{volume_id}  | Y/**N**  |  |
| **Servers**  | [List attached volumes](#list_attached_volumes) | GET    | {BaseUri}/servers/{server_id}/os-volume_attachments | Y/**N**  |  |
|          | [Attach a volume](#attach_volume)  | POST            | {BaseUri}/servers/{server_id}/os-volume_attachments/{volume_id} | Y/**N**  |  |
|          | [Get attached volume details](#get_attached_volume_details)  | GET            | {BaseUri}/servers/{server_id}/os-volume_attachments/{volume_id} | Y/**N**  |  |
|          | [Detach a volume](#detach_volume)  | DELETE          | {BaseUri}/servers/{server_id}/os-volume_attachments/{volume_id} | Y/**N**  |  |
| **Snapshots** | [List volume snapshots](#list_snapshots)  | GET  | {BaseUri}/os-snapshots | Y/**N**  |  |
|           | [Create new volume snapshot](#create_snapshot) | POST | {BaseUri}/os-snapshots | Y/**N**  |  |
|           | [Get volume snapshot details](#get_snapshot_details) | GET | {BaseUri}/os-snapshots/{snapshot_id} | Y/**N**  |  |
|           | [Delete volume snapshot](#delete_snapshot)  | DELETE  | {BaseUri}/os-snapshots/{snapshot_id} | Y/**N**  |  |

### 4.2 Common Request Headers
The common request headers are defined in the Nova Compute documentation.

### 4.3 Common Response Headers
The common response hearders are defined in the Nova Compute documentation.

### 4.4 Service API Operation Details

#### 4.4.1 Versions

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

##### 4.4.1.1 Get Version Info ##### {#version_info}
###### GET /v1.1/

Lists the information about the current version of the API, like media types (json and xml), links to the public endpoint url, links to the WADL (if any), and links to the API documentation.

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
       "version":{
          "status":"CURRENT",
          "updated":"2011-01-21T11:33:21Z",
          "media-types":[
             {
                "base":"application/xml",
                "type":"application/vnd.openstack.compute-v1.1+xml"
             },
             {
                "base":"application/json",
                "type":"application/vnd.openstack.compute-v1.1+json"
             }
          ],
          "id":"v1.1",
          "links":[
             {
                "href":"https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
                "rel":"self"
             },
             {
                "href":"http://docs.rackspacecloud.com/servers/api/v1.1/cs-devguide-20110125.pdf",
                "type":"application/pdf",
                "rel":"describedby"
             },
             {
                "href":"http://docs.rackspacecloud.com/servers/api/v1.1/application.wadl",
                "type":"application/vnd.sun.wadl+xml",
                "rel":"describedby"
             }
          ]
       }
    }


XML


    Not Supported.


**Curl Example**


    curl -i -H "X-Auth-Token: {Auth_Token}" {BaseUri}/v1.1/




##### 4.4.1.2 List Versions ##### {#list_versions}
###### GET /

Lists the information about all supported and deprecated versions with links to the public endpoint urls.

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
       "versions":[
          {
             "status":"CURRENT",
             "updated":"2011-01-21T11:33:21Z",
             "id":"v1.1",
             "links":[
                {
                   "href":"https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
                   "rel":"self"
                }
             ]
          },
          {
             "status":"DEPRECATED",
             "updated":"2011-01-21T11:33:21Z",
             "id":"v1.0",
             "links":[
                {
                   "href":"https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.0/",
                   "rel":"self"
                }
             ]
          }
       ]
    }

XML


    Not Supported.


**Curl Example**

    curl -i -H "X-Auth-Token: {Auth_Token}" {BaseUri}/





#### 4.4.2 Volumes

A *Volume* represents a persistent block storage device, which can be attached 
to a Nova virtual machine. Then it can be mounted on the virtual machine and
used as a standard block device.

**Status Lifecycle**

“creating” => “available” (after creation) => “in-use” (after attach) => “available” (after detach)

**Rate Limits**

N/A

**Quota Limits**

The quota as configured for the tenant governs the size of the volume that can be created. An exception will be raised if quota is exceeded. Sample exception:


    413 Entity Too Large
    {
       "overLimit":{
          "message":"Volume quota exceeded. You cannot create a volume of size 1G",
          "code":413,
          "retryAfter":0
       }
    }

**Business Rules**

When creating a volume from an existing snapshot, passing in a size in the
create volume call has no effect. The size of the snapshot is use to create
the new volume. Currently, if you use the nova api, you have to specify a
size. What will actually happen is that the size you specify will be recorded
in the database and used for describe and quota operations, but the actual
bock volume will be the same size as the origin volume. This is a bug.

##### 4.4.2.1 List Volumes ##### {#list_volumes}
###### GET /os-volumes

Lists the block storage volumes.

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
       "volumes":[
          {
             "status":"available",
             "displayDescription":null,
             "availabilityZone":"nova",
             "displayName":"Test",
             "attachments":[{}],
             "volumeType":null,
             "snapshotId":"",
             "imageRef":"",
             "size":1,
             "id":4183,
             "createdAt":"2012-06-27 19:20:35",
             "metadata": {}
          },
          {
             "status":"available",
             "displayDescription":null,
             "availabilityZone":"nova",
             "displayName":null,
             "attachments":[{}],
             "volumeType":null,
             "snapshotId":"",
             "imageRef":"",
             "size":1,
             "id":4261,
             "createdAt":"2012-06-29 16:57:02",
             "metadata": {}
          }
       ]
    }


XML


    Not Supported.


**Curl Example**


    curl -i -H "X-Auth-Token: {Auth_Token}" \
               {BaseUri}/v1.1/{tenant_id}/os-volumes




##### 4.4.2.2 Create new volume ##### {#create_new_volume}
###### POST /os-volumes

Create a new block storage volume of a given size. If the snapshot_id attribute is not null then the volume created is a copy of the specified snapshot. If the imageRef parameter is not null then a bootable volume is created. The attribute 'availabilityZone' does not correspond to HP Cloud availability zones.

The request is invalid if both the snapshot_id and the ImageRef parameters are specified and both are not null.

**Request Data**

**URL Parameters**

None.

**Data Parameters**

* *size* - integer - Size of the volume in GBs
* *display_name* (Optional) - string - Name of the volume
* *display_description* (Optional) - string - Description for the volume
* *snapshot_id* (Optional) - integer - Id of the volume snapshot to create the volume from
* *imageRef* (Optional) - string - The id of a Glance image from which to create the volume
* *metadata* (Optional) - hash or dictionary - Metadata key/value pairs
* *availability_zone* (Optional) - string - The nova zone
* *volume_type* (Optional) - string - The volume type, this parameter is currently ignored

JSON


    {
       "volume":{
          "size":1,
          "display_name":"Test Volume",
          "display_description":"Test Volume desc"
       }
    }


XML


    Not Supported.


Optional:

Metadata: Metadata can be added while creating a volume by passing a key/value pair in the request body.  See example below.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON


    {
       "volume":{
          "status":"creating",
          "displayDescription":"Test Volume desc",
          "availabilityZone":"nova",
          "displayName":"Test Volume",
          "attachments":[{}],
          "volumeType":null,
          "snapshotId":"",
          "size":1,
          "id":4279,
          "createdAt":"2012-06-29 19:24:03",
          "metadata": {}
       }
    }


XML


    Not Supported.


**Curl Example**


    curl -i -H "X-Auth-Token: {Auth_Token}" \
       -H "Content-Type: application/json" \
       {BaseUri}/v1.1/{tenant_id}/os-volumes \
       -X POST -d '{"volume": {"size": 1, "display_name": "Test Volume","display_description": "Test Volume desc"}}'


**Optional: Example showing creating a Volume from a Snapshot**

**Request Data**

**URL Parameters**

None.

**Data Parameters**

JSON


    {
       "volume":{
          "size":1,
          "snapshot_id":31,
          "display_name":"Test Volume from snapshot 31",
          "display_description":"Test Volume desc"
       }
    }


XML


    Not Supported.


**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON


    {
       "volume":{
          "status":"creating",
          "displayDescription":"Test Volume desc",
          "availabilityZone":"nova",
          "displayName":"Test Volume from snapshot 31",
          "attachments":[{}],
          "volumeType":null,
          "snapshotId":31,
          "size":1,
          "id":4279,
          "createdAt":"2012-06-29 19:24:03",
          "metadata": {}
       }
    }


XML


    Not Supported.


**Curl Example**


    curl -i -H "X-Auth-Token: {Auth_Token}" \
       -H "Content-Type: application/json" \
       {BaseUri}/v1.1/{tenant_id}/os-volumes \
       -X POST -d '{"volume": {"size": 1, "snapshot_id": 31, "display_name": "Test Volume from snapshot 31","display_description": "Test Volume desc"}}'


**Optional: Example showing adding metadata**

**Request Data**

**URL Parameters**

None.

**Data Parameters**

JSON


    {
       "volume":{
          "size":1,
          "display_name":"Test Volume",
          "display_description":"Test Volume desc",
          "metadata":{
             "VolMeta":"VolMetaValue"
          }
       }
    }


XML


    Not Supported.


**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON


    {
       "volume":{
          "status":"creating",
          "displayDescription":"Test Volume desc",
          "availabilityZone":"nova",
          "displayName":"Test Volume",
          "attachments":[{}],
          "volumeType":null,
          "snapshotId":"",
          "size":1,
          "id":4279,
          "createdAt":"2012-06-29 19:24:03",
          "metadata":{
             "VolMeta":"VolMetaValue"
          }
       }
    }


XML


    Not Supported.


**Curl Example**

    curl -i -H "X-Auth-Token: {Auth_Token}" \
       -H "Content-Type: application/json" \
       {BaseUri}/v1.1/{tenant_id}/os-volumes \
       -X POST -d '{"volume": {"size": "1", "display_name": "Test Volume","display_description": "Test Volume desc", "metadata":{"VolMeta" : "VolMetaValue"}}}'




##### 4.4.2.3 Get Volume details ##### {#get_volume_details}
###### GET /os-volumes/{volume_id}

Gets the details of the block storage volume specified by {volume_id}.

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
       "volume":{
          "status":"available",
          "displayDescription":"Test Volume desc",
          "availabilityZone":"nova",
          "displayName":"Test Volume",
          "attachments":[{}],
          "volumeType":null,
          "snapshotId":"",
          "size":1,
          "id":4279,
          "createdAt":"2012-06-29 19:24:03",
          "metadata":{
          }
       }
    }


XML


    Not Supported.


**Curl Example**


    curl -i -H "X-Auth-Token: {Auth_Token}" \
            {BaseUri}/v1.1/{tenant_id}/os-volumes/{volume_id}



##### 4.4.2.4 Delete Volume ##### {#delete_volume}
###### DELETE /os-volumes/{volume_id}

Delete the block storage volume specified by {volume_id}.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *volume_id* - The identifier for the volume.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

202 - Accepted

**Response Data**

This call does not return a response body.

**Curl Example**


    curl -i -H "X-Auth-Token: {Auth_Token}" \
            {BaseUri}/v1.1/{tenant_id}/os-volumes/{volume_id} -X DELETE





#### 4.4.3 Servers

A server is a Nova VM instance to which a volume can be attached. When a
volume is attached to a VM, the VM can mount the volume and use it as it would
use any block storage device.

**Status Lifecycle**

“creating” => “available” (after creation)
"available" => “in-use” (after attach)
"in-use" => “available” (after detach)

**Rate Limits**

There are no specific rate limits for volume attachments or detachments.

None.

**Quota Limits**

There are no quotas or limits specific volume attachment or detachment.

None.

**Business Rules**

1.  A volume can only be attached when the status of the volume is “available”.
2.  A volume is attached when the status of the volume is “in-use”.
3.  A volume can only be detached when the status of the volume is “in-use”.
4.  A volume can be attached to only one server instance.
5.  A server can have multiple volumes attached to it.
6.  The device name should be valid and same device name cannot be repeated.
7.  The device needs to be mounted on the server, before it can be used.

##### 4.4.3.1 List attached volumes for a server ##### {#list_attached_volumes}
###### GET /servers/{server_id}/os-volume_attachments

Gets the block storage volumes attached to the server instance specified by {server_id}.

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
       "volumeAttachments":[
          {
             "device":"/dev/vdf",
             "serverId":258315,
             "id":5825,
             "volumeId":5825
          }
       ]
    }


XML


    Not Supported.


**Curl Example**


    curl -i -H "X-Auth-Token: {Auth_Token}" \
            {BaseUri}/v1.1/{tenant_id}/servers/{server_id}/os-volume_attachments



##### 4.4.3.2 Attach volume to a server ##### {#attach_volume}
###### POST /servers/{server_id}/os-volume_attachments

Attach the block storage volume specified in the request body to the server instance
specified by {server_id}.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *server_id* - The identifier for the server.

**Data Parameters**

* *volumeId* - integer - Id of the volume to attach
* *device* - string - Name of the device mount point

JSON


    {
       "volumeAttachment":{
          "volumeId":"5825",
          "device":"/dev/sdf"
       }
    }


XML

    Not Supported.


**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON


    {
       "volumeAttachment":{
          "id":"5825",
          "volumeId":"5825"
       }
    }


XML


    Not Supported.


**Curl Example**


    curl -i -H "X-Auth-Token: {Auth_Token}" \
            {BaseUri}/v1.1/{tenant_id}/servers/{server_id}/os-volume_attachments \
            -X POST -d '{"volumeAttachment": {"volumeId": "5825","device": "/dev/sdf"}}'





##### 4.4.3.3 List Details for specified attached volume ##### {#get_attached_volume_details}
###### GET /servers/{server_id}/os-volume_attachments/{volume_id}

Lists volume details for the specified volume ID.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *server_id* - The identifier for the server.
* *volume_id* - The volume id.

**Data Parameters**

This call does not require a request body.

None.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON
    {
        "volumeAttachment": {
            "device": "/dev/sdf",
            "serverId": 646675,
            "id": 73989,
             "volumeId": 73989
        }
    }

XML

    Not supported

**Curl Example**


    curl -i -H "X-Auth-Token: {Auth_Token}" \
            {BaseUri}/v1.1/{tenant_id}/servers/{server_id}/ \
            os-volume_attachments/{volume_id}



##### 4.4.3.4 Detach volume from a server ##### {#detach_volume}
###### DELETE /servers/{server_id}/os-volume_attachments/{volume_id}

Detach the block storage volume specified by {volume_id} from the server instance specified by {server_id}.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *server_id* - The identifier for the server.
* *volume_id* - The volume id.

**Data Parameters**

This call does not require a request body.

None.

**Success Response**

**Status Code**

202 - Accepted

**Response Data**

This call does not return a response body.

**Curl Example**


    curl -i -H "X-Auth-Token: {Auth_Token}" \
            {BaseUri}/v1.1/{tenant_id}/servers/{server_id}/os-volume_attachments/{volume_id}
            -X DELETE





#### 4.4.4 Snapshots

A snapshot is a readonly copy of a persistent-storage volume created by copying
from an existing persistent-storage volume. A snapshot cannot be attached to a
server and mounted, instead a standard persistent-storage volume must be created
from the snapshot, and that volume can be attached to a server and mounted.

**Status Lifecycle**

“creating” => “available” (after creation)

If an error occurs during any operation the status can be set to "error"

**Rate Limits**

**Quota Limits**

**Business Rules**

After you create a snapshot from a volume you can delete the volume and continue
to work with the snapshot. Similarly, after you create a volume from a snapshot
you can delete the snapshot and continue to work with the volume.

You can not create a snapshot that is attached to a server.

##### 4.4.4.1 List Snapshots ##### {#list_snapshots}
##### GET /os-snapshots

List all snapshots.

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
        "snapshots":[
            {
                "status": "available",
                "displayDescription": null,
                "displayName": null,
                "volumeId": 16474,
                "id": 4482,
                "createdAt": "2012-10-30 16:05:46",
                "size": 1
            },
            {
                "status": "available",
                "displayDescription": "Snapshot of Volume 16750",
                "displayName": "16750_snap",
                "volumeId": 16750,
                "id": 4512,
                "createdAt": "2012-11-08 17:35:30",
                "size": 1
            }
        ]
    }

XML

    Not Supported.

**Curl Example**

    curl -i -H "X-Auth-Token: <Auth_Token>" \
                {BaseUri}/v1.1/{tenant_id}/os-snapshots



##### 4.4.4.2 Create Snapshot ##### {#create_snapshot}
##### POST /os-snapshots

Create a snapshot from a specified volume.

**Request Data**

The request body specified the volume from which to create the snapshot,
optionally specify display information for the snapshot.

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.

**Data Parameters**

* *volume_id* - Integer - The id of the volume from which the snapshot will be generated.
* *display_name* (Optional) - string - Name of the volume
* *display_description* (Optional) - string - Description for the volume
* *force* (Optional) - Boolean - Defaults to false.

JSON

    {
        "snapshot": {
            "force": false,
            "display_name": "TestSnapshotName",
            "display_description": "Test snapshot description",
            "volume_id": 18818
        }
    }

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "snapshot": {
            "status": "creating",
            "displayDescription": "Test snapshot description",
            "displayName": "TestSnapshotName",
            "volumeId": 18818,
            "id": 5018,
            "createdAt": "2012-12-05 14:48:28.643980",
            "size": 7
        }
    }

XML

    Not Supported.

**Curl Example**

    curl -i -H "X-Auth-Token: <Auth_Token>" \
                {BaseUri}/v1.1/{tennant_id}/os-snapshots \
            -X POST \
            -d '{"snapshot": {"force": false, \
                                "display_name": "TestSnapshot2", \
                                "display_description": "Test description", \
                                "volume_id": 18818}}' \
            -H "Content-Type: application/json; charset=UTF-8"


##### 4.4.4.3 View information about a single snapshot ##### {#get_snapshot_details}
##### GET /os-snapshots

View all information about a single snapshot.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *snapshot_id* - The unique identifier of an existing Snapshot.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    {
        "snapshots": {
                "status": "available",
                "displayDescription": null,
                "displayName": null,
                "volumeId": 16474,
                "id": 4482,
                "createdAt": "2012-10-30 16:05:46",
                "size": 1
            }
    }

XML

    Not Supported.

**Curl Example**

    curl -i -H "X-Auth-Token: <Auth_Token>" \
                {BaseUri}/v1.1/{tenant_id}/os-snapshots/{snapshot_id}



##### 4.4.4.4 Delete a snapshot ##### {#delete_snapshot}
##### DELETE /os-snapshots

Delete a single snapshot.

**Request Data**

**URL Parameters**

* *tenant_id* - The unique identifier of the tenant or account.
* *snapshot_id* - The unique identifier of an existing Snapshot.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

This operation does not return a response body.

**Curl Example**

    curl -i -H "X-Auth-Token: <Auth_Token>" -X DELETE \
                {BaseUri}/v1.1/{tenant_id}/os-snapshots/{snapshot_id}



