---
layout: page
title: HP Cloud Image Service API Reference
permalink: /api/image/
description: This document describes the HP Cloud Image Service. HP Cloud Image is based on OpenStack Glance.
keywords: Image, Glance, OpenStack

---

# HP Cloud Image Service API V1 Specifications

**Date:**

**Document Version:**

# 1. Overview

This document describes the HP Cloud Image Service, which is based on OpenStack Glance.

## 1.1 API Maturity Level

### 1.1.1 Maturity Level Definitions

The maturity levels are defined as follows:

+ Beta. The functions and features are available publically. While HP expects the feature to operate as advertised, we do not offer a Service Level Agreement (SLA) for the service or feature.

+ Public.

+ Release to General Availability (GA). At this level of maturity, all features and functions are expected to operate as advertised. In particular, there is a Service Level Agreement (SLA) defined and in place.

### 1.1.2 Maturity Level

**Maturity Level**: *Public*

**Version API Status**: *CURRENT*

# 2. Architectural View

## 2.1 Overview

The HP Cloud Image Service provides services for discovering, registering, and retrieving virtual machine images. The HP Cloud Image Service has a RESTful API that allows querying of VM image metadata as well as retrieval of the actual image.

## 2.2 Images

### 2.2.1 Image Files

A image file refers to a virtual disk image file that HP Compute service can load up to create a virtual machine.

### 2.2.2 Image Metadata

The metadata of an image includes all the formation about the image, e.g. image identifier, name, status, size, disk format, container format, owner, and custom properties. Not all metadata are required to be specified with a value when adding a new image to HP Cloud Image Service, more detailed can be found in [section 4.4.2.2](#4422-add-a-new-image).

#### 2.2.2.1 Name

Its value should be the name of the image. Note that the name of an image is not unique as it would be an unrealistic expectation of users to know all the unique names of all other user's images.

#### 2.2.2.2 Identifier

Each image has an identifier, which is guaranteed to be unique to an Availability Zone in HP Cloud 1.0. For Availability Zone please refer to [section 3.2](#32-regions-and-availability-zones).

#### 2.2.2.3 Status

Images in HP Cloud Image Service can be in one the following statuses:

+ queued

The image identifier has been reserved for an image in the HP Cloud Image Service. No image data has been uploaded to HP Cloud Image Service and the image size was not explicitly set to zero on creation.

+ saving

Denotes that an image's raw data is currently being uploaded to HP Cloud Image Service. When an image is registered with a call to `POST /images` and there is an `x-image-meta-location` header present, that image will never be in the saving status (as the image data is already available in some other location).

+ active

Denotes an image that is fully available in HP Cloud Image Service. This occurs when the image data is uploaded, or the image size is explicitly set to zero on creation.

+ killed

Denotes that an error occurred during the uploading of an image's data, and that the image is not readable.

+ deleted

The HP Cloud Image Service has retained the information about the image, but it is no longer available to use. An image in this state will be removed automatically at a later date.

+ pending_delete

This is similiar to deleted, however, the image data has not yet been removed. An image in this state is recoverable.

#### 2.2.2.4 Disk and Container Format

When adding an image to HP Cloud Image Service, specifying the image's disk format and container format is **not** required in HP Cloud 1.0.

#### Disk Format

The disk format of a virtual machine image is the format of the underlying disk image. Virtual appliance vendors have different formats for laying out the information contained in a virtual machine disk image.

You can set your image's container format to one of the following:

+ raw:
This is an unstructured disk image format

+ vhd:
This is the VHD disk format, a common disk format used by virtual machine monitors from VMWare, Xen, Microsoft, VirtualBox, and others

+ vmdk:
Another common disk format supported by many common virtual machine monitors

+ vdi:
A disk format supported by VirtualBox virtual machine monitor and the QEMU emulator

+ iso:
An archive format for the data contents of an optical disc (e.g. CDROM).

+ qcow2:
A disk format supported by the QEMU emulator that can expand dynamically and supports Copy on Write

+ aki:
This indicates what is stored in HP Cloud Image Service is an Amazon kernel image

+ ari:
This indicates what is stored in HP Cloud Image Service is an Amazon ramdisk image

+ ami:
This indicates what is stored in HP Cloud Image Service is an Amazon machine image

#### Container Format

The container format refers to whether the virtual machine image is in a file format that also contains metadata about the actual virtual machine.

Note that the container format string is not currently used by HP Cloud Image Service or other OpenStack components, so it is safe to simply specify bare as the container format if you are unsure.

You can set your image's container format to one of the following:

+ bare:
This indicates there is no container or metadata envelope for the image

+ ovf:
This is the OVF container format

+ aki:
This indicates what is stored in HP Cloud Image Service is an Amazon kernel image

+ ari:
This indicates what is stored in HP Cloud Image Service is an Amazon ramdisk image

+ ami:
This indicates what is stored in HP Cloud Image Service is an Amazon machine image

#### 2.2.2.5 Size

The image size in Bytes.

#### 2.2.2.6 Checksum

The MD5 checksum of the image file data.

#### 2.2.2.7 Min-ram

The minimum ram required in megabytes to run this image on a server.

#### 2.2.2.8 Min-disk

The minimum disk space required in gigabytes to run this image on a server.

#### 2.2.2.9 Owner

HP Cloud Image Service normally sets the owner of an image to be the tenant or user (depending on the "owner_is_tenant" configuration option) of the authenticated user adding the image.

#### 2.2.2.10 Custom Image Properties

HP Cloud Image Service allows a set of custom, free-form image properties stored with the image metadata. There is no limit on the number of free-form key/value attributes that can be attached to the image. However, keep in mind that the 8K limit on the size of all HTTP headers sent in a request will effectively limit the number of image properties.

#### Properties added by HP Cloud Compute Service when creating a snapshot

|Name |Description |Example  |Comment  |
|:------- | :-------- | :------- | :-------- |
|architecture | arch type | 'x86_64' or 'i686' |
|image_location| location | 'snapshot' or 'local' |
|image_state| state | 'available' or 'creating' |
|owner_id | tenant ID of the owner | |
|user_id | user name of the owner |
|instance_uuid|uuid of creating instance | |
|instance_ref| reference URL |
|ramdisk_id | Image ID of associated Ramdisk | |
|kernel_id | Image ID of associated Kernel Image || typically None|
|image_type | type | 'snapshot' |
|backup_type| | | typically None

#### Properties added to HP Public Images

|Name |Description |Type  |Example  |Comment  |
|:------- | :-------- | :------- | :-------- | :-------- |
|com.hp_1_os_distro | OS name | string | 'org.ubuntu', 'org.centos', 'com.microsoft.server' | Will track org.openstack_1_os_distro in the future |
|com.hp_1_os_version | OS version | string | '12.04', '5.6', '2008 R2 Enterprise SP1' | Will track org.openstack_1_os_version in the future |
| com.hp_1_image_build_datetime | date and time of image build in UTC | string | '2012-09-14 03:36:18' | ISO 8601 format.  Will track any future org.openstack_1_os_date property  |
| com.hp_1_architecture | arch type | string | 'x86_64', 'i686' | Will track org.openstack_1_architecture in the future. Note this will be treated independently of the 'architecture' attribute added by Nova |
| com.hp_1_image_type | image type | string | 'kernel', 'ramdisk', 'machine', 'disk' | machine == AMI; disk == qcow2 raw image; this property will not be required when the glance API properties disk_format, container_format are visible to the DEVEX UI |
| com.hp_1_image_lifecycle | image lifecycle state | string | 'deprecated' or 'active' | absense of (a value for) this property should be interpreted as 'active' |
| com.hp_1_default_fs | image default filesystem type | string | None, 'ext3', 'ext4', 'ntfs' | |
| com.hp_1_root_partition | root partition number | string | None, '1' to '9' | |
| com.hp_1_provider | WHO provides the image | string | com.hp, com.canonical, com.activestate etc. | note a ubuntu image built by HP would have com.hp as the provider |
| com.hp_1_bootable_volume | is this image compatible with bootable volumes? | boolean | true or false | in the absense of this flag assume the image is compatible with bootable volumes |

#### hp_image_license

The hp_image_license property is custom to HP and has the following semantics:

+ Value is private to HP;

+ Not removable once set;

+ Will be copied to all snapshots taken in Nova using the image;

+ Applicable to non-public Windows images (snapshots);

+ Applied to Windows images only by HP

## 2.3 Image Ownership and Sharing

The ownership of an image is defined by the value of its 'owner' attribute. The value of this attribute will be a tenant identifier extracted from the request context at image creation time or NULL. Ownership of an image is shared across all users that belong to the tenant identified in the 'owner' attribute of an image. Therefore, a A NULL owner indicates that the image is not owned by any specific tenant.

A user may share an image he owns with another tenant. When sharing with another tenant, the original owner can also indicate whether the recipient can share the image further.  Modification of shared images is still restricted to the user that owns it.

## 2.4 Authentication and Access Controls

### 2.4.1 Authentication

HP Cloud Image Service depends on Control Service (CS) API to handle authentication of clients. You must obtain an authentication token from CS and send it along with all API requests to Image Service through the `X-Auth-Token` header. HP Cloud Image Service will communicate back to CS to verify the token validity and obtain your identity credentials. Anonymous users cannot access HP Cloud Image Service APIs.

### 2.4.2 Access Control

Access to an image is controlled with the ownership of the image and whether the image is public or private.

Public images with an owner can be accessed by all users, but modifications are restricted to a user that owns it or Admin users.

Public images without an owner may be accessed by anyone, but modifications are restricted solely to Admins.

Private images with an owner can only be accessed or modified by the user that owns it or Admin users.

Private images may also have a null owner. These images will only be accessible and modifiable by Admins.

# 3. Account Level View

## 3.1 Accounts

+ Authenticated Users -- Any user that has authenticated against an authentication service (e.g. HP Cloud Control Services) and does not have the admin role
+ Admin Users -- Any user that has authenticated against an authentication service and has the admin role returned by the authentication service in that tenant's list of roles. The Admin role is HP restricted.

## 3.2 Regions and Availability Zones

Region(s): region-a

Availability Zone(s): az-1, az-2, az-3

Future Expansion: region-b

## 3.3 Service Catalog

The listing below shows a fragment of the Service Catalog returned by the HP Identity Service which contains the endpoints for the HP Cloud Image Service.

    {
        "endpoints": [
            {
                "region": "***********",
                "tenantId": "***********",
                "versionId": "1.0",
                "versionList": "https://glance1.example.com:9292",
                "versionInfo": "https://glance1.example.com:9292/v1.0/",
                "publicURL": "https://glance1.example.com:9292/v1.0"
            }
        ],
        "type": "image",
        "name": "Image Management"
    }

# 4. REST API Specifications

## 4.1 Service API Operations

| Resource | Operation                                      | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
|:---------|:-----------------------------------------------|:------------|:-----------------------|:------------------|:---------------:|
| **Image Metadata** | [List Images](#4411-list-images) | GET         | /v1/images             | Y/N               |  |
| **Image Metadata** | [List Images Details](#4412-list-images-in-more-detail) | GET | /v1/images/detail | Y/N |
| **Image Metadata** | [Filtering Images Lists](#4413-filtering-images-lists) | GET | /v1/images?KEY=VALUE | Y/N |
| **Image Metadata** | [Filtering on Custom Properties](#4414-filtering-on-custom-properties) | GET | /v1/images/detail?property-KEY=VALUE | Y/N |
| **Image Metadata** | [Paginating a List of Images](#4415-paginating-a-list-of-images) | GET | /v1/images?limit=LIMIT&marker=ID | Y/N |
| **Image Metadata** | [Retrieve Image Metadata](#4416-retrieve-image-metadata) | HEAD | /v1/images/<IMAGE_ID> | Y/N |
| **Image Metadata** | [Update an Image](#4417-update-an-image) | PUT | /v1/images/<IMAGE_ID> | Y/N |
| **Image Data** | [Retrieve Raw Image Data](#4421-retrieve-raw-image-data) | GET | /v1/images/<IMAGE_ID> | Y/N |
| **Image Data** | [Add a New Image](#4422-add-a-new-image) | POST | /v1/images | Y/N |
| **Image Data** | [Two-step Adding New Image](#4423-two-step-adding-new-image) | POST /v1/images | PUT /v1/images/<IMAGE_ID> | Y/N | |
| **Image Memberships** | [List Image Memberships](#4431-list-image-memberships) | GET | /v1/images/<IMAGE_ID>/members | Y/N |
| **Image Memberships** | [List Shared Images](#4432-list-shared-images) | GET | /v1/shared-images/<TENANT_ID> | Y/N |
| **Image Memberships** | [Add a Member to an Image](#4433-add-a-member-to-an-image) | PUT | /v1/images/<IMAGE_ID>/members/<TENANT_ID> | Y/N |
| **Image Memberships** | [Remove a Member from an Image](#4434-remove-a-member-from-an-image) | DELETE | /v1/images/members/<TENANT_ID> | Y/N |
| **Image Memberships** | [Replace a Membership List for an Image](#4435-replace-a-membership-list-for-an-image) | PUT | /v1/images/<IMAGE_ID>/members | Y/N |

## 4.2 Common Request Headers

### 4.2.1 Accept

Where applicable, this determines what Content-Types are acceptable, for example:

    text (text/plain)
    JSON (application/json)

### 4.2.2 Content-Type

Where applicable, this indicates the MIME type of an object. For example when adding a new image a header of `Content-Type: application/octet-stream` should be specified.

### 4.2.3 X-Auth-Token

When specified, this identifies the user making the request. See section 2.4 for more information about tokens.

### 4.2.4 Content-Length

Where applicable, this is the length in bytes of the body of the request.

## 4.3 Common Response Headers

### 4.3.1 Content-Type

When the response includes a body, this indicates the MIME type of the response.

### 4.3.2 Content-Length

When the response includes a body, this indicates the length of the body in bytes.

## 4.4 Service API Operation Details

### 4.4.1 Image Metadata

Status Lifecycle: N/A

Rate Limits: N/A

Quota Limits: N/A

Business Rules: None

#### 4.4.1.1 List Images

Retrieve a list of available images that the authenticated user has access to. This includes images owned by the user, images shared with the user and public images.

    GET /v1/images

**status codes**

200 - OK

**query parameter**

+ limit=LIMIT

The `LIMIT` is a numeric value that you wish to limit the number of images returned per call. If no limit specified, Glance returns **25** images at a time by default.

+ marker=ID

The `marker` query parameter is to specify an image id **after** which the page of images starts. The image with the ID specified will not be shown.

See section 4.4.1.3 for more parameters that can be used for filtering.

**request**

No request body required.

**response**

JSON-encoded data. For example:

    {'images':
      [
        {
         'name': 'Ubuntu 12.04 Plain',
         'disk_format': 'vhd',
         'container_format': 'ovf',
         'size': 5368709120,
         'checksum': '61eabaf2bf278703738b433ff884c91f',
         'id': 9087
        }
      ]
    }

**curl example**

    curl -v -k -X GET -H "x-auth-token: ***" https://localhost:9292/v1/images?limit=5

    > GET /v1/images?limit=5 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 200 OK
    < Content-Type: text/html; charset=UTF-8
    < Content-Type: application/json
    < Content-Length: 752
    < Date: Thu, 24 Jan 2013 22:28:29 GMT
    <

    {"images": [
      {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19775, "size": 419430400}, 
      {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19773, "size": 419430400}, 
      {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19767, "size": 419430400}, 
      {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19765, "size": 419430400}, 
      {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19763, "size": 419430400}
    ]}

#### 4.4.1.2 List Images in More Detail

Retrieve a more detailed list of available images that the authenticated user has access to. This includes images owned by the user, images shared with the user and public images.

    GET /v1/images/detail

**status codes**

200 - OK

**query parameters**

+ limit=LIMIT

The `LIMIT` is a numeric value that you wish to limit the number of images returned per call. If no limit specified, Glance returns **25** images at a time by default.

+ marker=ID

The `marker` query parameter is to specify an image id after which the page of images starts.

**request**

No request body required.

**response**

JSON-encoded data. For example:

    {'images':
      [
        {
         "status": "active", 
         "name": "UbuntuServer2-snap1", 
         "deleted": false, 
         "container_format": "bare", 
         "created_at": "2012-11-07T14:36:00", 
         "disk_format": "qcow2", 
         "updated_at": "2012-11-07T14:36:34", 
         "properties": {
            "instance_uuid": "a249a5a4-66ff-4b9c-a90b-d0ec5419f074", 
            "image_location": "snapshot", 
            "image_state": "available", 
            "user_id": "96028022561439", 
            "creator": "XXX", 
            "image_type": "snapshot", 
            "instance_ref": "http://nv1.example.net/v1.1/355478", 
            "ramdisk_id": null, 
            "kernel_id": null, 
            "backup_type": null, 
            "version": "1.0.0", 
            "architecture": "amd64", 
            "owner_id": "16488133588404"
         },
         "min_disk": 0, 
         "id": 18279, 
         "checksum": "c5d96e1cf62c0bcf9c633f14e2f01c3e", 
         "owner": "16488133588404", 
         "is_public": false, 
         "deleted_at": null, 
         "min_ram": 0, 
         "size": 686751744
        }
      ]
    }

**curl example**

This example shows a list of images with more detailed information, e.g. properties. The `marker` parameter is used for displaying images following a certain image ID.

    curl -v -k -X GET -H "x-auth-token: ***" "https://localhost:9292/v1/images/detail?marker=18817&limit=3"

    > GET /v1/images/detail?marker=18817&limit=3 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 200 OK
    < Content-Type: text/html; charset=UTF-8
    < Content-Type: application/json
    < Content-Length: 4007
    < Date: Thu, 24 Jan 2013 22:49:08 GMT
    <
    {"images": [
       {
         "status": "active", 
         "name": "UbuntuServer2-snap1", 
         "deleted": false, 
         "container_format": "bare", 
         "created_at": "2012-11-07T14:36:00", 
         "disk_format": "qcow2", 
         "updated_at": "2012-11-07T14:36:34", 
         "properties": {
            "instance_uuid": "a249a5a4-66ff-4b9c-a90b-d0ec5419f074", 
            "image_location": "snapshot", 
            "image_state": "available", 
            "user_id": "96028022561439", 
            "creator": "XXX", 
            "image_type": "snapshot", 
            "instance_ref": "http://nv1.example.net/v1.1/355478", 
            "ramdisk_id": null, 
            "kernel_id": null, 
            "backup_type": null, 
            "version": "1.0.0", 
            "architecture": "amd64", 
            "owner_id": "16488133588404"
         },
         "min_disk": 0, 
         "id": 18279, 
         "checksum": "c5d96e1cf62c0bcf9c633f14e2f01c3e", 
         "owner": "16488133588404", 
         "is_public": false, 
         "deleted_at": null, 
         "min_ram": 0, 
         "size": 686751744
       },
       {
         "status": "active", 
         "name": "CentOSServer2-snap1", 
         "deleted": false, 
         "container_format": "bare", 
         "created_at": "2012-11-07T14:23:15", 
         "disk_format": "qcow2", 
         "updated_at": "2012-11-07T14:23:47", 
         "properties": {
            "instance_uuid": "a249a5a4-66ff-4b9c-a90b-d0ec5419f074", 
            "image_location": "snapshot", 
            "image_state": "available", 
            "user_id": "96028022561439", 
            "creator": "XXX", 
            "image_type": "snapshot", 
            "instance_ref": "http://nv1.example.net/v1.1/355478", 
            "ramdisk_id": null, 
            "kernel_id": null, 
            "backup_type": null, 
            "version": "1.0.0", 
            "architecture": "amd64", 
            "owner_id": "16488133588404"
         },
         "min_disk": 0, 
         "id": 18277, 
         "checksum": "6778f493facefbc3d590312b996ef62d", 
         "owner": "16488133588404", 
         "is_public": false, 
         "deleted_at": null, 
         "min_ram": 0, 
         "size": 686751744
       },
       {
         "status": "active", 
         "name": "RHELServer2-snap1", 
         "deleted": false, 
         "container_format": "bare", 
         "created_at": "2012-11-07T14:10:08", 
         "disk_format": "qcow2", 
         "updated_at": "2012-11-07T14:10:39", 
         "properties": {
             "instance_uuid": "a249a5a4-66ff-4b9c-a90b-d0ec5419f074", 
             "image_location": "snapshot", 
             "image_state": "available", 
             "user_id": "96028022561439", 
             "creator": "XXX",
             "image_type": "snapshot", 
             "instance_ref": "http://nv1.example.net/v1.1/355478", 
             "ramdisk_id": null, 
             "kernel_id": null, 
             "backup_type": null, 
             "version": "1.0.0", 
             "architecture": "amd64", 
             "owner_id": "16488133588404"
          },
          "min_disk": 0, 
          "id": 18275, 
          "checksum": "21604fa1db7a15cd4a68520713412335", 
          "owner": "16488133588404", 
          "is_public": false, 
          "deleted_at": null, 
          "min_ram": 0, 
          "size": 686751744
        }
    ]}

#### 4.4.1.3 Filtering Images Lists

Both the `GET /v1/images` and `GET /v1/images/detail` requests take certain query parameters that serve to filter the returned list of images.

    GET  /v1/images?KEY=VALUE

**status codes**

200 - OK

**query parameters**

+ name=NAME

Filters images having a name attribute matching NAME.

+ container_format=FORMAT

Filters images having a container_format attribute matching FORMAT

+ disk_format=FORMAT

Filters images having a disk_format attribute matching FORMAT

+ status=STATUS

Filters images having a status attribute matching STATUS

+ size_min=BYTES

Filters images having a size attribute greater than or equal to BYTES

+ size_max=BYTES

Filters images having a size attribute less than or equal to BYTES

These two resources also accept sort parameters:

+ sort_key=KEY

Results will be ordered by the specified image attribute `KEY`. Accepted values include `id`, `name`, `status`, `disk_format`, `container_format`, `size`, `created_at` (default) and `updated_at`.

+ sort_dir=DIR

Results will be sorted in the direction `DIR`. Accepted values are `asc` for ascending or `desc` (default) for descending.

**request**

No request body required

**response**

JSON-encoded data

**curl example**

    curl -v -k -H "x-auth-token: ***" https://localhost:9292/v1/images?name=img1
    
    > GET /v1/images?name=img1 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 200 OK
    < Content-Type: text/html; charset=UTF-8
    < Content-Type: application/json
    < Content-Length: 156
    < Date: Mon, 04 Mar 2013 02:06:45 GMT
    <
    {"images": [{"name": "img1", "container_format": "bare", "disk_format": "qcow2", "checksum": "ee4586987802dcf17d7abc08e3583a14", "id": 34933, "size": 525}]}

#### 4.4.1.4 Filtering on Custom Properties

A list of images can be filtered based on custom properties.

    GET /v1/images/detail?property-KEY=VALUE

**status codes**

200 - OK

**query parameters**

Any custom property name

**request**

No request body required

**response**

JSON-encoded data

**curl example**

    curl -v -k -H "x-auth-token: ***" https://localhost:9292/v1/images/detail?property-instance_uuid=a249a5a4-66ff-4b9c-a90b-d0ec5419f074
    > GET /v1/images/detail?property-instance_uuid=a249a5a4-66ff-4b9c-a90b-d0ec5419f074 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 200 OK
    < Content-Type: text/html; charset=UTF-8
    < Content-Type: application/json
    < Content-Length: 3208
    < Date: Mon, 04 Mar 2013 23:42:44 GMT
    <
    {"images": [
        {"status": "active", 
         "name": "Server2-snap1", 
         "deleted": false, 
         "container_format": "bare", 
         "created_at": "2012-11-07T14:36:00", 
         "disk_format": "qcow2", 
         "updated_at": "2012-11-07T14:36:34", 
         "properties": {
             "instance_uuid": "a249a5a4-66ff-4b9c-a90b-d0ec5419f074", 
             "image_location": "snapshot", 
             "image_state": "available", 
             "user_id": "96028022561439", 
             "creator": "joe", 
             "image_type": "snapshot", 
             "instance_ref": "http://nv.hpcloud.net:8774/v1.1/servers/35", 
             "ramdisk_id": null, 
             "kernel_id": null, 
             "backup_type": null, 
             "version": "1.0.0", 
             "architecture": "amd64", 
             "owner_id": "16488133588404"}, 
         "min_disk": 0, 
         "id": 18279, 
         "checksum": "c5d96e1cf62c0bcf9c633f14e2f01c3e", 
         "owner": "16488133588404", 
         "is_public": false, 
         "deleted_at": null, 
         "min_ram": 0, 
         "size": 686751744}, 
     ]}

#### 4.4.1.5 Paginating a list of images

A combination of **limit** and **marker** query parameters can be used to paginate a list of images. For example the following request will confine the resulting page length to be LIMIT, and the first image of this page is the one right after ID.

    GET /v1/images?limit=LIMIT&marker=ID

**status codes**

200 - OK

**query parameters**

+ limit

+ marker

**request**

No request body required

**response**

JSON-encoded data

**curl example**

First we request a list of images without specifying the **limit** parameter, as a result 25 images were returned.

    curl -v -k -X GET -H "x-auth-token: ***" "https://localhost:9292/v1/images"

    > GET /v1/images HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 200 OK
    < Content-Type: text/html; charset=UTF-8
    < Content-Type: application/json
    < Content-Length: 3602
    < Date: Sat, 26 Jan 2013 03:07:06 GMT
    <
    {"images": [
      {"name": "T1", "container_format": null, "disk_format": null, "checksum": "3f8ad80bece5aabec127446bf3bd7a02", "id": 20405, "size": 819200}, 
      {"name": "T1", "container_format": null, "disk_format": null, "checksum": null, "id": 20401, "size": 0}, 
      {"name": "T1", "container_format": null, "disk_format": null, "checksum": null, "id": 20399, "size": 0},
      {"name": "T1", "container_format": null, "disk_format": null, "checksum": null, "id": 20395, "size": 0},
      {"name": "T1", "container_format": null, "disk_format": null, "checksum": "3f8ad80bece5aabec127446bf3bd7a02", "id": 20229, "size": 819200},
      {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19775, "size": 419430400},
      {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19773, "size": 419430400},
      {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19767, "size": 419430400},
      {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19765, "size": 419430400},
      {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19763, "size": 419430400},
      {"name": "My Image", "container_format": "ovf", "disk_format": "raw", "checksum": null, "id": 19759, "size": 0},
      {"name": "My Image", "container_format": "ovf", "disk_format": "raw", "checksum": null, "id": 19757, "size": 0},
      {"name": "My Image", "container_format": "ovf", "disk_format": "raw", "checksum": null, "id": 19755, "size": 0},
      {"name": "My Image", "container_format": "ovf", "disk_format": "raw", "checksum": null, "id": 19753, "size": 0},
      {"name": "glance-monitor-image", "container_format": "bare", "disk_format": "raw", "checksum": "ce85a03ab0c622b5f9e7aa8c1e764f5f", "id": 7, "size": 1024},
      {"name": "glance-monitor-image", "container_format": "bare", "disk_format": "raw", "checksum": "ce85a03ab0c622b5f9e7aa8c1e764f5f", "id": 6, "size": 1024},
      {"name": "Ubuntu Precise 12.04 LTS Server 64-bit", "container_format": "bare", "disk_format": "qcow2", "checksum": "68e1a9b478e7768b813460fc399d0ac9", "id": 19227, "size": 238419968},
      {"name": "test_image", "container_format": "ovf", "disk_format": "raw", "checksum": "3f8ad80bece5aabec127446bf3bd7a02", "id": 18817, "size": 819200},
      {"name": "Server2-snap1", "container_format": "bare", "disk_format": "qcow2", "checksum": "c5d96e1cf62c0bcf9c633f14e2f01c3e", "id": 18279, "size": 686751744},
      {"name": "Server2-snap1", "container_format": "bare", "disk_format": "qcow2", "checksum": "6778f493facefbc3d590312b996ef62d", "id": 18277, "size": 686751744},
      {"name": "Server2-snap1", "container_format": "bare", "disk_format": "qcow2", "checksum": "21604fa1db7a15cd4a68520713412335", "id": 18275, "size": 686751744},
      {"name": "Server2-snap1", "container_format": "bare", "disk_format": "qcow2", "checksum": "21604fa1db7a15cd4a68520713412335", "id": 18273, "size": 686751744},
      {"name": "Server1-snap1", "container_format": "bare", "disk_format": "qcow2", "checksum": "2ceadb1ab14775fc809b13301cbe2f10", "id": 18271, "size": 686751744},
      {"name": "Server1-snap1", "container_format": "bare", "disk_format": "qcow2", "checksum": "7402dab7e233cb81d8d9cc8b0b4d10e1", "id": 18269, "size": 686751744},
      {"name": "Server1-snap1", "container_format": "bare", "disk_format": "qcow2", "checksum": "241001b584803f30e3b6b135a66e3b09", "id": 18267, "size": 686751744}
    ]}

Then we set the page length to be 3 by **limit**, and try to retrieve the images that are after **19775** in the list above. So we got:

    curl -v -k -X GET -H "x-auth-token: ***" "https://localhost:9292/v1/images?limit=3&marker=19775"

    > GET /v1/images?limit=3&marker=19775 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 200 OK
    < Content-Type: text/html; charset=UTF-8
    < Content-Type: application/json
    < Content-Length: 456
    < Date: Sat, 26 Jan 2013 03:08:16 GMT
    <

    {"images": [
       {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19773, "size": 419430400},
       {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19767, "size": 419430400},
       {"name": "T1", "container_format": "bare", "disk_format": "qcow2", "checksum": "61eabaf2bf278703738b433ff884c91f", "id": 19765, "size": 419430400}
    ]}

#### 4.4.1.6 Retrieve Image Metadata

    HEAD /v1/images/<IMAGE_ID>

**status codes**

200 - OK

**request**

No request body required

**response**

The metadata is returned as a set of HTTP headers that begin with the prefix `x-image-meta-`.

For example:

    X-Image-Meta-Property-User_id: 96028022561439
    X-Image-Meta-Status: active
    X-Image-Meta-Property-Image_state: available
    X-Image-Meta-Min_disk: 0
    X-Image-Meta-Owner: 16488133588404
    X-Image-Meta-Property-Instance_ref: http://nv1.example.net/v1.1/355478
    X-Image-Meta-Name: Server2-snap1
    X-Image-Meta-Container_format: bare
    X-Image-Meta-Property-Image_type: snapshot
    X-Image-Meta-Created_at: 2012-11-07T14:36:00
    X-Image-Meta-Property-Image_location: snapshot
    X-Image-Meta-Min_ram: 0
    X-Image-Meta-Updated_at: 2012-11-07T14:36:34
    X-Image-Meta-Property-Backup_type:
    X-Image-Meta-Id: 18279
    X-Image-Meta-Property-Instance_uuid: a249a5a4-66ff-4b9c-a90b-d0ec5419f074
    X-Image-Meta-Deleted_at:
    X-Image-Meta-Property-Ramdisk_id:
    X-Image-Meta-Property-Architecture: amd64
    X-Image-Meta-Property-Kernel_id:
    X-Image-Meta-Deleted: False
    X-Image-Meta-Checksum: c5d96e1cf62c0bcf9c633f14e2f01c3e
    X-Image-Meta-Property-Creator: XXX
    X-Image-Meta-Size: 686751744
    X-Image-Meta-Property-Version: 1.0.0
    X-Image-Meta-Is_public: False
    X-Image-Meta-Property-Owner_id: 16488133588404
    X-Image-Meta-Disk_format: qcow2

**curl example**

    curl -v -k -X HEAD -H "x-auth-token: ***" https://localhost:9292/v1/images/18279

    > HEAD /v1/images/18279 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 200 OK
    < Content-Type: text/html; charset=UTF-8
    < Content-Length: 0
    < X-Image-Meta-Property-User_id: 96028022561439
    < X-Image-Meta-Status: active
    < X-Image-Meta-Property-Image_state: available
    < X-Image-Meta-Min_disk: 0
    < X-Image-Meta-Owner: 16488133588404
    < X-Image-Meta-Property-Instance_ref: http://nv1.example.net/v1.1/355478
    < X-Image-Meta-Name: Server2-snap1
    < X-Image-Meta-Container_format: bare
    < X-Image-Meta-Property-Image_type: snapshot
    < X-Image-Meta-Created_at: 2012-11-07T14:36:00
    < X-Image-Meta-Property-Image_location: snapshot
    < X-Image-Meta-Min_ram: 0
    < X-Image-Meta-Updated_at: 2012-11-07T14:36:34
    < X-Image-Meta-Property-Backup_type:
    < X-Image-Meta-Id: 18279
    < X-Image-Meta-Property-Instance_uuid: a249a5a4-66ff-4b9c-a90b-d0ec5419f074
    < X-Image-Meta-Deleted_at:
    < X-Image-Meta-Property-Ramdisk_id:
    < X-Image-Meta-Property-Architecture: amd64
    < X-Image-Meta-Property-Kernel_id:
    < X-Image-Meta-Deleted: False
    < X-Image-Meta-Checksum: c5d96e1cf62c0bcf9c633f14e2f01c3e
    < X-Image-Meta-Property-Creator: XXX
    < X-Image-Meta-Size: 686751744
    < X-Image-Meta-Property-Version: 1.0.0
    < X-Image-Meta-Is_public: False
    < X-Image-Meta-Property-Owner_id: 16488133588404
    < X-Image-Meta-Disk_format: qcow2
    < Location: https://localhost:9292/v1/images/18279
    < Etag: c5d96e1cf62c0bcf9c633f14e2f01c3e
    < Date: Thu, 24 Jan 2013 23:41:48 GMT

#### 4.4.1.7 Update an Image

    PUT /v1/images/<IMAGE_ID>

**status codes**

200 - OK

**request**

HP Cloud Image Service will view as image metadata any HTTP header that it receives in a PUT request where the header key is prefixed with the strings `x-image-meta-` and `x-image-meta-property-`.

If an image was previously reserved, and thus is in the `queued` state, then image raw data can be added by including it as the request body. If the image already has data associated with it (e.g. not in the `queued` state), then including a request body will result in a 409 Conflict exception.

**response**

On success, the `PUT` request will return the image metadata encoded as HTTP headers.

**curl example**

This example adds a new property to an image.

    curl -v -k -X PUT -H "x-auth-token: ***" -H "x-image-meta-property-Name: newname" https://localhost:9292/v1/images/18817

    > PUT /v1/images/18817 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    > x-image-meta-property-Name: newname
    >
    < HTTP/1.1 200 OK
    < Content-Length: 399
    < Content-Type: application/json
    < Location: https://localhost:9292/v1/images/18817
    < Etag: 3f8ad80bece5aabec127446bf3bd7a02
    < Date: Fri, 25 Jan 2013 00:02:36 GMT
    <

    {"image": {
         "status": "active", 
         "name": "test_image", 
         "deleted": false, 
         "container_format": "ovf", 
         "created_at": "2012-11-19T21:52:03", 
         "disk_format": "raw", 
         "updated_at": "2012-11-19T21:52:04", 
         "properties": {
             "name": "newname"
         }, 
         "min_disk": 0, 
         "id": 18817, 
         "checksum": "3f8ad80bece5aabec127446bf3bd7a02", 
         "owner": "16488133588404", 
         "is_public": false, 
         "deleted_at": null, 
         "min_ram": 0, 
         "size": 819200
    }}

### 4.4.2 Image data

Status Lifecycle: N/A

Rate Limits: N/A

Quota Limits: N/A

Business Rules: None

#### 4.4.2.1 Retrieve Raw Image Data

    GET /v1/images/<IMAGE_ID>

**status codes**

200 - OK

**request**

No request body required

**response**

The metadata is returned as a set of HTTP headers that begin with the prefix `x-image-meta-`, and the image itself is encoded into the response body. 

#### 4.4.2.2 Add a New Image

    POST /v1/images

**status codes**

201 - CREATED

**request**

The metadata about the image is sent to HP Cloud Image Service in HTTP headers. The body of the HTTP request to the API will be the MIME-encoded disk image data.

Image Metadata in HTTP Headers:

HP Cloud Image Service will view as image metadata any HTTP header that it receives in a POST request where the header key is prefixed with the strings `x-image-meta-` and `x-image-meta-property-`.

The list of metadata headers are listed below.

+ x-image-meta-name (required)

Its value should be the name of the image.

+ x-image-meta-id (optional)

When present, HP Cloud Image Service will use the supplied identifier for the image. If the identifier already exists in that HP Cloud Image Service node, then a 409 Conflict will be returned by HP Cloud Image Service.

When this header is not present, HP Cloud Image Service will generate an identifier for the image and return this identifier in the response (see below)

+ x-image-meta-disk_format (optional)

Valid values are one of aki, ari, ami, raw, iso, vhd, vdi, qcow2, or vmdk.

+ x-image-meta-container_format (optional)

Valid values are one of aki, ari, ami, bare, or ovf.

+ x-image-meta-size (optional)

When present, HP Cloud Image Service assumes that the expected size of the request body will be the value of this header. If the length in bytes of the request body does not match the value of this header, HP Cloud Image Service will return a 400 Bad Request.

When not present, HP Cloud Image Service will calculate the image's size based on the size of the request body.

+ x-image-meta-checksum (optional)

When present, HP Cloud Image Service will verify the checksum generated from the backend store when storing your image against this value and return a 400 Bad Request if the values do not match.

+ x-image-meta-min-ram (optional)

When present it shall be the expected minimum ram required in megabytes to run this image on a server.

When not present, the image is assumed to have a minimum ram requirement of 0.

+ x-image-meta-min-disk (optional)

When present it shall be the expected minimum disk space required in gigabytes to run this image on a server.

When not present, the image is assumed to have a minimum disk space requirement of 0.

+ x-image-meta-owner (optional)

This header is only meaningful for admins.

HP Cloud Image Service normally sets the owner of an image to be the tenant or user (depending on the "owner_is_tenant" configuration option) of the authenticated user issuing the request. However, if the authenticated user has the Admin role, this default may be overridden by setting this header to null or to a string identifying the owner of the image.

+ x-image-meta-property-*

When HP Cloud Image Service receives any HTTP header whose key begins with the string prefix `x-image-meta-property-`, HP Cloud Image Service adds the key and value to a set of custom, free-form image properties stored with the image. The key is the lower-cased string following the prefix x-image-meta-property- with dashes and punctuation replaced with underscores.

For example, if the following HTTP header were sent:

`x-image-meta-property-distro  Ubuntu 10.10`
Then a key/value pair of "distro"/"Ubuntu 10.10" will be stored as image metadata with the image in HP Cloud Image Service.

There is no limit on the number of free-form key/value attributes that can be attached to the image. However, keep in mind that the 8K limit on the size of all HTTP headers sent in a request will effectively limit the number of image properties.

**response**

JSON-encoded metadata of the new image

**curl example**

    curl -v -k -X POST -H "x-auth-token: ***" -H "X-Image-Meta-Name: post_example" -H "X-Image-Meta-Is-Public: True" -H "Content-Type: application/octet-stream" --data-binary @/home/lijam/img-800k https://localhost:9292/v1/images

    > POST /v1/images HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    > X-Image-Meta-Name: post_example
    > X-Image-Meta-Is-Public: True
    > Content-Type: application/octet-stream
    > Content-Length: 819200
    > Expect: 100-continue
    >
    < HTTP/1.1 100 Continue
    < HTTP/1.1 201 Created
    < Content-Type: application/json
    < Content-Length: 384
    < Location: https://localhost:9292/v1/images/20405
    < Etag: 3f8ad80bece5aabec127446bf3bd7a02
    < Date: Fri, 25 Jan 2013 04:55:41 GMT
    <

    {"image": {
        "status": "active", 
        "name": "post_example", 
        "deleted": false, 
        "container_format": null, 
        "created_at": "2013-01-25T04:55:41", 
        "disk_format": null, 
        "updated_at": "2013-01-25T04:55:41", 
        "properties": {}, 
        "min_disk": 0, 
        "id": 20405, 
        "checksum": "3f8ad80bece5aabec127446bf3bd7a02", 
        "owner": "16488133588404", 
        "is_public": true, 
        "deleted_at": null, 
        "min_ram": 0, 
        "size": 819200
    }}

#### 4.4.2.3 Two-step Adding New Image

Another way to add a new image to HP Cloud Image Service is to first register an image via a POST request and then upload the image data via a PUT.

    POST /v1/images
    PUT /v1/images/<IMAGE_ID>

**status codes**

POST: 201 - CREATED

PUT: 200 - OK

**request**

POST: 'x-image-meta-name' is required, no request body required

PUT: 'Content-Type' is required, request body should be the image data

**response**

POST: JSON-encoded metadata

PUT: JSON-encoded metadata

**curl example**

    curl -v -k -X POST -H "x-auth-token: ***" -H "x-image-meta-name: litest1" https://localhost:9292/v1/images
    > POST /v1/images HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    > x-image-meta-name: litest1
    >
    < HTTP/1.1 201 Created
    < Content-Type: application/json
    < Content-Length: 328
    < Location: https://localhost:9292/v1/images/48341
    < Etag: None
    < Date: Tue, 05 Mar 2013 03:13:59 GMT
    <
    {"image": {"status": "queued", "name": "litest1", "deleted": false, "container_format": null, "created_at": "2013-03-05T03:13:59", "disk_format": null, "updated_at": null, "properties": {}, "min_disk": 0, "id": 48341, "checksum": null, "owner": "16488133588404", "is_public": false, "deleted_at": null, "min_ram": 0, "size": 0}}


    curl -v -k -X PUT -H "x-auth-token: ***" -H "Content-Type: application/octet-stream" --data-binary @/home/lijam/img-800k https://localhost:9292/v1/images/48341
    > PUT /v1/images/48341 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    > Content-Type: application/octet-stream
    > Content-Length: 819200
    > Expect: 100-continue
    >
    < HTTP/1.1 100 Continue
    < HTTP/1.1 200 OK
    < Content-Length: 380
    < Content-Type: application/json
    < Location: https://localhost:9292/v1/images/48341
    < Etag: 3f8ad80bece5aabec127446bf3bd7a02
    < Date: Tue, 05 Mar 2013 03:16:50 GMT
    <
    {"image": {"status": "active", "name": "litest1", "deleted": false, "container_format": null, "created_at": "2013-03-05T03:13:59", "disk_format": null, "updated_at": "2013-03-05T03:16:50", "properties": {}, "min_disk": 0, "id": 48341, "checksum": "3f8ad80bece5aabec127446bf3bd7a02", "owner": "16488133588404", "is_public": false, "deleted_at": null, "min_ram": 0, "size": 819200}}

### 4.4.3 Image Membership

Status Lifecycle: N/A

Rate Limits: N/A

Quota Limits: N/A

Business Rules: None

#### 4.4.3.1 List Image Memberships

Retrieve a list of the other tenants (or users, if "owner_is_tenant" is False) that may access a given image.

    GET /v1/images/<IMAGE_ID>/members

**status codes**

200 - OK

**request**

No request body required

**response**

JSON data

    {'members': [
     {'member_id': '12345',
      'can_share': false}
     ]}

**curl example**

    curl -v -k -X GET -H "x-auth-token: ***" https://localhost:9292/v1/images/34933/members
    > GET /v1/images/34933/members HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 200 OK
    < Content-Type: text/html; charset=UTF-8
    < Content-Type: application/json
    < Content-Length: 66
    < Date: Mon, 04 Mar 2013 02:25:53 GMT
    <
    {"members": [{"can_share": false, "member_id": "16488133588505"}]}

#### 4.4.3.2 List Shared Images

Retrieve a list of images which are shared with a given tenant.

    GET /v1/shared-images/<TENANT_ID>

**status codes**

200 - OK

**request**

No request body required

**reponse**

JSON data

    {'shared_images': [
     {'image_id': '100',
      'can_share': false}
     ]}

**curl example**

    curl -v -k -X GET -H "x-auth-token: ***" https://localhost:9292/v1/shared-images/16488133588404
    > GET /v1/shared-images/16488133588404 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 200 OK
    < Content-Type: text/html; charset=UTF-8
    < Content-Type: application/json
    < Content-Length: 60
    < Date: Mon, 04 Mar 2013 03:18:59 GMT
    <
    {"shared_images": [{"image_id": 20399, "can_share": false}]}

#### 4.4.3.3 Add a Member to an Image

To authorize a tenant to access a private image.

    PUT /v1/images/<IMAGE_ID>/members/<TENANT_ID>

**status codes**

204 - No Content

**request**

With no body, this will add the membership to the image, leaving existing memberships unmodified and defaulting new memberships to have `can_share` set to false. We may also optionally attach a body of the following form:

    {'member':
     {'can_share': true}
    }

If such a body is provided, both existing and new memberships will have `can_share` set to the provided value (either true or false). This query will return a 204 ("No Content") status code.

**response**

No response body

**curl example**

    curl -v -k -X PUT -H "x-auth-token: ***" https://localhost:9292/v1/images/34933/members/16488133588505
    > PUT /v1/images/34933/members/16488133588505 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 204 No Content
    < Content-Type: text/html; charset=UTF-8
    < Content-Length: 0
    < Date: Mon, 04 Mar 2013 02:25:28 GMT
    <

#### 4.4.3.4 Remove a Member from an Image

To revoke a tenant's right to access a private image.

    DELETE /v1/images/<IMAGE_ID>/members/<TENANT_ID>

**status codes**

This query will return a 204 ("No Content") status code.

**request**

No request body

**response**

No response body

**curl example**

    curl -v -k -X DELETE -H "x-auth-token: ***" https://localhost:9292/v1/images/34933/members/16488133588505
    > DELETE /v1/images/34933/members/16488133588505 HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    >
    < HTTP/1.1 204 No Content
    < Content-Type: text/html; charset=UTF-8
    < Content-Length: 0
    < Date: Mon, 04 Mar 2013 02:48:35 GMT

#### 4.4.3.5 Replace a Membership List for an Image

The full membership list for a given image may be replaced. 

    PUT /v1/images/<IMAGE_ID>/members

**status codes**

204 - No Content

**request**

with a body of the following form:

    {'memberships': [
     {'member_id': 'tenant1',
      'can_share': false}
     ...]}

All existing memberships which are not named in the replacement body are removed, and those which are named have their `can_share` settings changed as specified. (The `can_share` setting may be omitted, which will cause that setting to remain unchanged in the existing memberships.) All new memberships will be created, with `can_share` defaulting to false if it is not specified.

**response**

No response body

**curl example**

    curl -v -k -X PUT -H "x-auth-token: ***" -H "Content-Type: application/json" -d '{"memberships": [{"member_id": "16488133588505", "can_share": false}]}' https://localhost:9292/v1/images/34933/members
    > PUT /v1/images/34933/members HTTP/1.1
    > Host: localhost:9292
    > Accept: */*
    > x-auth-token: ***
    > Content-Type: application/json
    > Content-Length: 70
    >
    < HTTP/1.1 204 No Content
    < Content-Type: text/html; charset=UTF-8
    < Content-Length: 0
    < Date: Mon, 04 Mar 2013 03:11:09 GMT