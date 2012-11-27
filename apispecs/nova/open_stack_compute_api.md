---
layout: page
title: HP Cloud Compute Service API Reference
permalink: /api/compute/
description: This document describes the HP Cloud Compute Service. HP Cloud Compute is based on OpenStack Nova.
keywords: Compute, Nova, OpenStack

---

# HP Cloud Compute Service API Reference


# 1. Overview

This document describes the HP Cloud Compute Service. HP Cloud Compute is based on OpenStack Nova.

## 1.1 API Maturity Level

**Maturity Level**: HP Cloud Compute is currently in Public Beta.

**Version API Status**: The HP Cloud Compute Service is based on OpenStack Nova v1.1 The OpenStack v1.0  Nova API is deprecated.

# 2. HP Cloud Compute Service

##Nova Overview
###<a id="Server"></a>Servers (Virtual Machines)
####Server Operations
The APIs support a number of operations that can be performed on servers. These include:

+ [Create Server](#createServer) – Create one or more VM instances.
+ [Update Server](#updateServer) – Allows update of editable attributes (display name) of an instance.
+ [Delete server](#deleteServer) - Terminates a server.
+ [Reboot Server](#rebootServer) - Reboots a server.
+ [Rebuild Server](#rebuildServer) - Restarts a server with a new image.
+ [Create Image](#createImage) – Create a snapshot of the server

For a complete list of server operations, see section 4.1, [Service API Operations](#ServiceAPIOperations).

The following operations are part of the OpenStack Nova V1.1 API, but are not supported by HP Cloud Compute: Change Administrator Password, Resize Server, Confirm Resized Server, Revert Resized Server

####<a id="Flavors"></a>Flavors
A flavor determines the primary characteristics of a server. It includes the amount of memory to be allocated to the server, the size of the disk to be created for ephemeral storage and the number of VCPUs to be allocated.
Flavors can be listed using the nova client flavor-list command as shown below. Also see the [List Flavors](#listFlavors) API method. 

<pre><code> nova flavor-list
+-----+------------------+-----------+------+----------+-------+------------+----------+
|  ID |       Name       | Memory_MB | Swap | Local_GB | VCPUs | RXTX_Quota | RXTX_Cap |
+-----+------------------+-----------+------+----------+-------+------------+----------+
| 100 | standard.xsmall  | 1024      | 0    | 30       | 1     | 0          | 0        |
| 101 | standard.small   | 2048      | 0    | 60       | 2     | 0          | 0        |
| 102 | standard.medium  | 4096      | 0    | 120      | 2     | 0          | 0        |
| 103 | standard.large   | 8192      | 0    | 240      | 4     | 0          | 0        |
| 104 | standard.xlarge  | 16384     | 0    | 480      | 4     | 0          | 0        |
| 105 | standard.2xlarge | 32768     | 0    | 960      | 8     | 0          | 0        |
+-----+------------------+-----------+------+----------+-------+------------+----------+
</code></pre>

####<a href="ServerStates"></a>Server States
The state of a server is maintained in two values: the VM State and the Task State. The VM State is the state of the server as maintained by Nova.  The possible values for VM State are `ACIVE, BUILD, REBUILD, STOPPED, MIGRATING, RESIZING, PAUSED, SUSPENDED, RESCUE, ERROR` and `DELETED`. A server is running when it is in the `ACTIVE` state. The Task State is essentially a sub-state of the VM State. The status of a server as returned by the Create Server and Get Server Details API is a combination of the VM State and the Task State.

The following shows the sequence of states that a newly created server goes through when a user invokes Create Server. The Task state is shown following the VM state in parenthesises.

1. Create Server called
2. Nova-api creates database entry for new instance and sets state to `BUILD(scheduling)`.
3. The Nova cheduler selects compute a node on which to run the VM and sends it a request to create the VM.
4. The compute node sets state to `BUILD(networking)` and sets up networking.
5. The compute server sets the state to `BUILD(block_device_mapping)` and sets up volumes.
6. The compute server sets the state to `BUILD(spawning)` and calls the hypervisor to create the VM.
7. The VM starts and the state changes to `ACTIVE`.

The output of the nova list and nova show commands include the server status as shown below. The displayed server status includes the VM State and Task State described above. Note that the “Name” of the server shown by the commands is the “display name” of the instance as described in the [Server Names](#serverNames). 

<pre><code>$ nova list
+--------+---------------+-----------------+--------------------------------------+
|   ID   |      Name     |      Status     |               Networks               |
+--------+---------------+-----------------+--------------------------------------+
| 122745 | webserver          | ACTIVE          | private=10.4.134.153, 15.185.103.98  |
| 124817 | Server 124817 | BUILD(spawning) | private=10.4.142.174, 15.185.100.117 |
+--------+---------------+-----------------+--------------------------------------+
$ nova show 122745
+-----------------+----------------------------------------------------------+
|     Property    |                          Value                           |
+-----------------+----------------------------------------------------------+
| accessIPv4      |                                                          |
| accessIPv6      |                                                          |
| config_drive    |                                                          |
| created         | 2012-05-08T22:10:27Z                                     |
| flavor          | standard.xsmall                                          |
| hostId          | de27de97f19c947b83a714738aeb1865551d355f52626021836a4cdc |
| id              | 122745                                                   |
| image           | Ubuntu Oneiric 11.10 Server 64-bit 20120311              |
| key_name        | openstack                                                |
| metadata        | {u'foo': u'bar'}                                         |
| name            | webserver                                                     |
| private network | 10.4.134.153, 15.185.103.98                              |
| progress        | 100                                                      |
| security_groups | default                                                  |
| status          | ACTIVE                                                   |
| tenant_id       | 11692683195772                                           |
| updated         | 2012-05-09T16:34:01Z                                     |
| user_id         | 28187593996363                                           |
| uuid            | abe5e3b6-fa6d-40d5-a9ba-c97db1b3db36                     |
+-----------------+----------------------------------------------------------+
</code></pre>

The [List Servers Detail](#listDetailServers) and [Get Server Details](#getServer) API operations include server status in the information they return.


####<a id='serverNames'></a>Server Names
There are four different ways to refer to a server using the OpenStack native API:

1. The Server is assigned an *id* when it is created. This is an integer and is guaranteed to be unique within the Availability Zone in which the server was created.
2. When it is created the server is also given a [UUID](http://en.wikipedia.org/wiki/Universally_unique_identifier) . With a high degree of confidence, this identifier will be unique across all Availability Zones.
3. The Server must also be given a "display name" when it is created using the OpenStack API. This is done by including the name in the request to create the server.  Note that the display name can be any string which includes an alphabetic character. This requirement prevents the display name from having the syntax of an id or uuid. The display names of all active servers are also required to be unique.
Servers which are created with the management console are automatically assigned display names of the form Server-<time>-az-1-region-a-geo-1 where time is the time in seconds since the Epoch on which the server was created (e.g., Server-1339537527-az-1-region-a-geo-1). This name is generated by the management console.
It is not possible to provide a display name for an instance when instances are created using the EC2 RunInstances API. When an instance is created with the RunInstances API, the server will be given a default display name of "Server <id>" where <id> is the id assigned to the server (see 1. above).
4. The EC2 API and euca2ools refer to instances using names which are an 8 digit hex value preceeded by ‘i-‘. The hex value is the the server’s id (number 1 above) with leading zeros. For example, the server with id 20 is displayed as i-00000014 by euca-describe-instanaces.

The first three of these values are reported in the output of the nova show command (see the sample output above).
The server’s *id* and UUID are assigned to the server when it is created. These identifiers cannot be changed. The server's display name can be altered using the [Update Server](#updateServer) API operation.

The OpenStack API operations require that the server be identified using either its *id* or its UUID. The server's display name cannot be used in API operations. (Other than in the [Update Server](#updateServer) request mentioned above which is used to change the display name).

Nova client supports the use of the display name in commands, but this is not recommended as it may cause confusion when a display name is also a UUID.

####Personalizing a server
A number of mechanisms exist which allow a user to retrieve information about a server and to associate meta-data with the server.

#####<a id="Server Metadata"></a>Server Metadata

Each server can have metadata associated with it in the form of key/value pairs. This meta data can be accessed and modified using the [Server Metadata](#ServerMetadata) and [Server Metadata Item](#ServerMetadataItem) resources. Metadata can also be provided as an argument to [Create Server](#createServer) at the time the server is created. Metadata that is provided in this manner will be available as a json object in the image's root filesystem at /meta.js. If a [Configuration Drive](#ConfigurationDrive) is created when the server is created, the metadata will be in the file /meta.js at the root of the file system on the configuration drive.

#####<a id="EC2Metadata"></a>EC2 Metadata
You can retrieve metadata about an instance by querying the interface `http://169.254.169.254/latest/metadata`. This interface is only available on a server and returns the available meta-data as shown below.

<pre><code>ubuntu@nserver:~$ curl http://169.254.169.254/latest/meta-data
local-ipv4
reservation-id
local-hostname
placement/
ami-launch-index
public-hostname
mpi/
hostname
ami-id
public-keys/
instance-action
public-ipv4
block-device-mapping/
ami-manifest-path
security-groups
instance-type
instance-id
</code></pre>

To get information about a specific meta-data item, just append the item to the url. For example, to get the server's hostname, use the URL `http://169.254.169.254/latest/meta-data/hostname`. Some meta-data is multi-valued and is accessed by appending the path to the value desired to the URL. The example below gets public key `0` in the OpenSSH format.

    ubuntu@nserver:~$ curl http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key
    ssh-rsa AAAAB3 ... V1W4pVYcTTw==

It is also possible to provide additional meta-data at the time the server is created by supplying a Base64 encoded string as the *user_data* parameter to [Create Server](#createServer). This string can be retrieved using the URL `http://169.254.169.254/latest/meta-data/user-data`. All linux public images in the HP Cloud contain a package called CloudInit which can be used for early initialization of the instance from the user_data.

#####CloudInit
[CloudInit](https://help.ubuntu.com/community/CloudInit) is a set of scripts that are run when an image boots. These scripts are provided by an Ubuntu package that is installed  in the public images provided by HP Cloud. The scripts are controlled by a configuration which is described in [cloud-config](http://bazaar.launchpad.net/~cloud-init-dev/cloud-init/trunk/view/head:/doc/examples/cloud-config.txt). The configuration is the result of a merge of information from multiple sources including config files stored in the image, configuration parameters on the kernel command line, configuration information provided by Nova and configuration information provided by the user when creating the instance. In the HP Cloud, the latter two sources of information come from the EC2 metadata service which provides information, such as the hostname, determined by the environment along with *user_data* specified by the user at the time an instance is created.

The scripts that are run by CloudInit perform a number of different tasks including:

+ setting a default locale
+ setting hostname
+ generating ssh private keys
+ adding ssh keys to user's .ssh/authorized_keys so they can log in
+ setting up ephemeral mount points

As mentioned above, the behavior of CloudInit is determined by its configuration.  By default, it sets the locale to `en\_US.UTF-8`, sets the hostname to the value returned by the HP Cloud Compute EC2 metadata service, generates random ssh host keys, adds public-keys obtained from EC2 metatdata to the ubuntu user’s authorized keys and to root’s authorized keys, and mounts `ephemeral0` on /mnt. Note that CloudInit is one of two mechanisms that add ssh keys to authorized\_keys for the user root. The other is injection of the public key for a keypair whose name is provided as the *key_name* argument to [Create Server](#createServer). These mechanisms are independent of each other.

One of the tasks that CloudInit performs is to run user provided scripts when an instance is booted. These scripts are provided by the user at the time the instance is booted using the *user_data* argument to [Create Server](#createServer). For more information on the format of user_data see the [CloudInit - Community Ubuntu Documentation](https://help.ubuntu.com/community/CloudInit).

#####<a id="FileInjection"></a>File Injection
The [Create Server](#createServer) API has a parameter named *personality* which allows the specification of files to be injected into an image. For each file to be injected the file path in the root filesystem of the server being created is specified along with the base64 encoded contents of the file. The following json object is a the body of a Create Server request which includes a file to be injected.

<pre><code>{
    "server" : {
        "name" : "new-server-test",
        "imageRef" : 5579,
        "flavorRef" : 100,
        "metadata" : {
            "My Server Name" : "Apache1"
        },
        "personality" : [
            {
                "path" : "/etc/banner.txt",
                "contents" : "ICAgICAgDQoiQSBjbG91ZCBkb2VzIG5vdCBrbm93IHdoeSBp dCBtb3ZlcyBpbiBqdXN0IHN1Y2ggYSBkaXJlY3Rpb24gYW5k IGF0IHN1Y2ggYSBzcGVlZC4uLkl0IGZlZWxzIGFuIGltcHVs c2lvbi4uLnRoaXMgaXMgdGhlIHBsYWNlIHRvIGdvIG5vdy4g QnV0IHRoZSBza3kga25vd3MgdGhlIHJlYXNvbnMgYW5kIHRo ZSBwYXR0ZXJucyBiZWhpbmQgYWxsIGNsb3VkcywgYW5kIHlv dSB3aWxsIGtub3csIHRvbywgd2hlbiB5b3UgbGlmdCB5b3Vy c2VsZiBoaWdoIGVub3VnaCB0byBzZWUgYmV5b25kIGhvcml6 b25zLiINCg0KLVJpY2hhcmQgQmFjaA=="
            } 
        ] 
    }
}</code></pre>

The path must specify a directory in the root file system - otherwise the file will be ignored. For example, files cannot be injected in /tmp for the images provided by HP as /tmp is not in the root filesystem in these images. If a [Configuration Drive](#ConfigurationDrive) is created when the server is created, the path is relative to the file system on the configuration drive, rather than the root file system.

The *maxPersonality* quota limits the number of files which can be injected into a servers file system. The maximum size of the decoded file contents is restricted byt the *maxPersonalitySize* quota.
The maximum length of the file path is limited to 255 bytes.

#####<a id="ConfigurationDrive"></a>Configuration Drive

A configuration drive is a disk contains a FAT filesystem with configuration data that is accessible to a server. The configuration drive is created at the same time the server is created by specifying the [Create Server](#createServer) parameter *config_drive* with a value of true. This will cause a configuration drive to be created and items that are normally injected into the root filesystem of the newly created server are injected into the configuration drive instead. The items that are written to the configuration drive are:

+ server metadata
+ injected file data
+ the users's ssh public key

The server metadata is just the metadata that is provided as the value *metadata* parameter to [Create Server](#createServer). The injected file data is provided as the *personality* parameter to [Create Server](#createServer). The user's public key is specified using the *key_name* parameter to [Create Server](#createServer). These values are normally injected into the servers root file system when it is created. When a configuration drive is specified, they are injected into the filesystem on the configuration drive instead. Note that it is still possible to login to a server created in this manner as long as the server image includes CloudInit, since CloudInit will properly initialize authorized\_keys with the user's public ssh\_key independently of the injection of this value into the image that takes place when the server is created.

It is also possible to provide an imageRef as the value of the *config_drive* parameter. However, this is not useful in the HP Cloud environment as all images are either HP publicly available images or snapshots, neither of which can be usefully used as a configuration drive.

Note that the configuration drive is an API extension in later versions of OpenStack Nova. 

####<a id="Images"></a>Images
Servers are booted from disk images which are specified at the time the server is created. There are three different types of disk images: machine images, kernel images and ramdisk images. The machine image contains the root file system for the image. The kernel image is that image that is loaded when the server is launched and the ramdisk contains drivers used to boot the server. The latter two image types are optional. The machine image is always required, but the kernel and ramdisk may or may not be required depending on how the images were built.

The listing below shows the output of `nova image-list`. For kernel and ramdisk images, the image type is given in parenthesese after the full image name for images provided by HP. Machine images do not include the image type in the image's name. Any image that is marked as `(deprecated)' should not be used.

<pre><code>
$ nova image-list
+-------+------------------------------------------------------------------------+----------+--------+
|   ID  |                                  Name                                  | serverId | Status |
+-------+------------------------------------------------------------------------+----------+--------+
| 1232  | CentOS 5.6 Server 64-bit 20111207 (Kernel) (deprecated)                |          | ACTIVE |
| 1233  | CentOS 5.6 Server 64-bit 20111207 (Ramdisk) (deprecated)               |          | ACTIVE |
| 1234  | CentOS 5.6 Server 64-bit 20111207 (deprecated)                         |          | ACTIVE |
| 1235  | Ubuntu Lucid 10.04 LTS Server 64-bit 20111212 (Kernel)                 |          | ACTIVE |
| 1236  | Ubuntu Lucid 10.04 LTS Server 64-bit 20111212                          |          | ACTIVE |
| 1237  | Ubuntu Maverick 10.10 Server 64-bit 20111212 (Kernel)                  |          | ACTIVE |
| 1238  | Ubuntu Maverick 10.10 Server 64-bit 20111212                           |          | ACTIVE |
| 1239  | Ubuntu Natty 11.04 Server 64-bit 20111212 (Kernel)                     |          | ACTIVE |
| 1240  | Ubuntu Natty 11.04 Server 64-bit 20111212                              |          | ACTIVE |
| 1241  | Ubuntu Oneiric 11.10 Server 64-bit 20111212 (Kernel) (deprecated)      |          | ACTIVE |
| 1242  | Ubuntu Oneiric 11.10 Server 64-bit 20111212 (deprecated)               |          | ACTIVE |
| 1356  | CentOS 6.2 Server 64-bit 20120125 (Kernel)                             |          | ACTIVE |
| 1357  | CentOS 6.2 Server 64-bit 20120125 (Ramdisk)                            |          | ACTIVE |
| 1358  | CentOS 6.2 Server 64-bit 20120125                                      |          | ACTIVE |
| 1359  | Debian Squeeze 6.0.3 Server 64-bit 20120123 (Kernel)                   |          | ACTIVE |
| 1360  | Debian Squeeze 6.0.3 Server 64-bit 20120123 (Ramdisk)                  |          | ACTIVE |
| 1361  | Debian Squeeze 6.0.3 Server 64-bit 20120123                            |          | ACTIVE |
| 14345 | ActiveState Stackato v1.2.6 - Partner Image                            |          | ACTIVE |
| 16291 | Fedora 16 Server 64-bit 20120518                                       |          | ACTIVE |
| 22729 | BitNami Drupal 7.14-0-ubuntu-10.04.4 - Partner Image                   |          | ACTIVE |
| 22731 | BitNami WebPack 1.2-0-ubuntu-10.04.4 - Partner Image                   |          | ACTIVE |
| 4654  | BitNami DevPack 1.0-0 Ubuntu 10.04 64-bit - Partner Image              |          | ACTIVE |
| 54021 | CentOS 5.8 Server 64-bit 20120828                                      |          | ACTIVE |
| 5575  | Fedora 16 Server 64-bit 20120404 (deprecated)                          |          | ACTIVE |
| 5579  | Ubuntu Oneiric 11.10 Server 64-bit 20120311                            |          | ACTIVE |
| 59185 | foo100-image                                                           |          | ACTIVE |
| 59293 | foo-snap                                                               |          | ACTIVE |
| 59297 | ActiveState Stackato v2.2.2 - Partner Image                            |          | ACTIVE |
| 60815 | ActiveState Stackato v2.2.3 - Partner Image                            |          | ACTIVE |
| 6340  | BitNami WebPack 1.1-1 Ubuntu 10.04 64-bit - Partner Image (deprecated) |          | ACTIVE |
| 8419  | Ubuntu Precise 12.04 LTS Server 64-bit 20120424                        |          | ACTIVE |
| 9127  | ActiveState Stackato v1.2.5 - Partner Image (deprecated)               |          | ACTIVE |
| 9953  | EnterpriseDB PPAS 9.1.2 - Partner Image                                |          | ACTIVE |
| 9995  | EnterpriseDB PSQL 9.1.3 - Partner Image                                |          | ACTIVE |
+-------+------------------------------------------------------------------------+----------+--------+
</code></pre>

Images may be public or private. Public images are provided by HP and are available to all users. Private images are created by taking a snapshot of the root file system of a running server using the [Create Image](#createImage) API method. Images have an attribute which distinguishes public images provided by HP from private images (snapshots) created by the user. A user can access all the public images and any private images he owns.

#####Snapshots

Image snapshots are copies of the (virtual) disk partition containing the root file system that can be created from a running VM using [Create Image](#createImage). A snapshot is linked to the same kernel and snapshot as the image which was originally booted on the VM.  In the listing above, foo100-snap and foo-snap are snapshots created by the user.

#####<a id="ImageMetadata"></a>Image Metadata
Images can have metadata in the form of key/value pairs. This metadata can be queried and modified using operations of the [Image Metadata](#ImageMetadata) and [Image Metadata Item](#ImageMetadataItem) resources.

###Volumes (Bock)
Nova volumes are persistent virtual images that can be attached to servers (similar to Amazon Elastic Block Store (EBS)). When attached to a server, the volume appears as a disk device on which a file system can be created. The open source implementation of volumes is based on the Linux Logical Volume Manager (LVM). Bock is the HP implementation of Nova volumes which replaces the LVM based backend and provides Security, Scalablity and High Availability. For more information on Bock, see the [Bock Documentation](#BockDoc).

###Network

####Network Model

HP Cloud Compute provides two kinds of addresses for servers: fixed ips and floating ips. Fixed ips are automatically assigned to the server at the time it is created and are allocated in the 10.0.0.0/8 address range. Fixed ips can be used to address other servers across a private network within the HP Cloud Compute infrastructure. Floating ips are public addresses in the 15.0.0.0/8 address range and provide access to servers from the internet. A single floating ip is assigned to each server when it is created. It is also possible to associate additional floating ips with a server using the server action [Add Floating Ip](#addFloatingIp). All access to servers over the network is controled by [Securty Groups](#securityGroups), which are described below.

All communication between servers using 10.0.0.0/8 addresses takes place across a private network at layer 3. Broadcast and multicast between servers is not supported.

Servers can also be assigned one or more floating ips after being created using the [Add Floating Ip](#addFloatingIp) method. Floating ips assigned to servers in this way must be allocated using [Allocate Floating Ip](#allocateFloatingIp). The total number of floating ips that can be allocated to a project is limited by a per tennat quota. This quota can be retieved using [List Limits](#listLimits).

####<a id="securityGroups"></a>Security Groups
Access to servers is controlled by security groups which are a collection of rules about which sources, protocols and ports a server can receive traffic from. No traffic can be recieved by a server unless a security group rule explicitly allows it. (Due to a quirk of the network configuration, it is not possible for a server to access itself using its public (floating ip) address(es).)

The HP Cloud Compute service associates a public IP address with a server when it creates the server. It also creates the default security group shown below when an account is activated.

<pre><code>$ euca-describe-groups
GROUP   11692683195772  default default
PERMISSION      11692683195772  default ALLOWS  tcp     22      22      FROM    CIDR    0.0.0.0/0
PERMISSION      11692683195772  default ALLOWS  tcp     80      80      FROM    CIDR    0.0.0.0/0
PERMISSION      11692683195772  default ALLOWS  tcp     443     443     FROM    CIDR    0.0.0.0/0
PERMISSION      11692683195772  default ALLOWS  icmp    -1      -1      FROM    CIDR    0.0.0.0/0
PERMISSION      11692683195772  default ALLOWS  icmp    -1      -1      GRPNAME default
PERMISSION      11692683195772  default ALLOWS  tcp     1       65535   GRPNAME default
PERMISSION      11692683195772  default ALLOWS  udp     1       65536   GRPNAME default</code></pre>

The first four rules of this default security group allow ssh, http, https and ping from all sources. Note in particular, that the "`FROM CIDR 0.0.0.0/0`" means these rules apply to traffic from all sources. The remaining three rules allow tcp and udp on all ports, and ping from any server in the `default` security group.

Additional security groups can be created for a tenant using [Create Security Group](#createSecurityGroup). A security group can be associated with a server when the server is created by including its name in the list of security groups provided as the *security_groups* parameter of [Create Server](#createServer). If no security group is specified at the time a server is created, the server is associated with the default security group. You can also add/remove security groups to/from a server after it has been created using the server actions [Add Security Group](#addSecurityGroup) and [Remove Security Group](#removeSecurityGroup).

Additional rules can be added to a security group using [Create Security Group Rule](#createSecurityGroupRule). As shown in the example above, the source address for traffic can be specified as either a CIDR or as any server associated with a security group. (In the example above, the security group that is specified is the default security group itself.) Traffic within a security group is not automatically enabled. If you want to allow ports (or all traffic) within a given security group, you can create a rule using the same source and destination group as is done in the default security group created at account activation.

Any change to a security groups rules take immediate effect for any server associated with the rule when the change is made. Changes will also apply to any server subsequently associated with the security group containing the rule.

When a security group is deleted it can no longer be associated with any servers which are subsequently created. However, any server that was associated with the security group at the time the security group was deleted will continue to use that group's rules until the server itself is deleted. After deleting the security group it is not possible to change its rules.

###Tenants

A tenant has access to a collection of resources uniquely associated with the tenant.  Resources that are associated with a tenant include:

+ Server instances
+ Networks (in our case a single network is associated with all projects)
+ Security Groups
+ Images
+ Users

All resources uniquely allocated given Availability Zone. However, the tenant may have resources in multiple Availability Zones. To access resources within a given Availability Zone, the API endpoints for that Availability Zone (as listed in the [Service Catalog](#ServiceCatalog) returned by the Identity Service) must be used.

Users are created separately from tenants; a given user can be associated with no tenants or with one or more tenants.

All users in HP Cloud Compute have the OpenStack netadmin and developer roles and can thus allocate and assign floating ips, create and modify security group roles and perform all other operations described in this document.




# 3. General API Information

## 3.1 Authorization

Access to HP Cloud Compute is controlled on a per tenant basis. All HP Cloud Compute API operations have a `tenantId` parameter which identifies the particular collection of resources the user will be accessing. (See [Tenants](#Tenants).) In order to perform an API operation, the user must first obtain an authorization token scoped to the particular tenant he will be accessing. This authorization process is described in [HP Cloud Identity Service Overview](#HPCloudIdentityServiceOverview). The token obtained must be included in the `X-Auth-Token` header of any subsequent HP Cloud Compute API request. Tokens are valid for a limited period of time (on the order of 24 hours). When the token expires, subsequent attempts to access the API will return authorization failures and a new token must be obtained to continue using the API.

## 3.2 Regions and Availability Zones

In order to access HP Cloud Compute, the user must specify the endpoint for one of the HP Cloud Availability Zones (AZs). Availability Zones provide separate fault domains for HP Cloud. Failures in one AZ should not affect any resources in another AZ. Highly available applications will therefore deploy resources in more than one AZ.

Availability Zones are further clustered into regions and geographies. HP Cloud Compute is currently available in a single region (`region-a`) in a single geography (`geo-1`). The set of endpoints that a tenant can access are returned in a Service Catalog when the user calls the Indentity Service to get a token.

## <a id="ServiceCatalog"></a>3.3 Service Catalog

The listing below shows a fragment of the Service Catalog returned by the Identity Service which contains the endpoints for HP Cloud Compute. Note that a set of endpoints is returned for each AZ. (The string which identifies the AZ is called `"region"` in the Service Catalog.

	{
   	u 'endpoints' : [{
   			u 'publicURL' : u 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737',
   			u 'publicURL2' : u 'https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud',
   			u 'region' : u 'az-3.region-a.geo-1',
   			u 'tenantId' : u '36991859863737',
   			u 'versionId' : u '1.1',
   			u 'versionInfo' : u 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/',
   			u 'versionList' : u 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com'
   		}, {
   			u 'publicURL' : u 'https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737',
   			u 'publicURL2' : u 'https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud',
   			u 'region' : u 'az-2.region-a.geo-1',
   			u 'tenantId' : u '36991859863737',
   			u 'versionId' : u '1.1',
   			u 'versionInfo' : u 'https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/',
   			u 'versionList' : u 'https://az-2.region-a.geo-1.compute.hpcloudsvc.com'
   		}, {
   			u 'publicURL' : u 'https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737',
   			u 'publicURL2' : u 'https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud',
   			u 'region' : u 'az-1.region-a.geo-1',
   			u 'tenantId' : u '36991859863737',
   			u 'versionId' : u '1.1',
   			u 'versionInfo' : u 'https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/',
   			u 'versionList' : u 'https://az-1.region-a.geo-1.compute.hpcloudsvc.com'
   		}
   	],
   	u 'name' : u 'Compute',
   	u 'type' : u 'compute'
	}

##3.4 Request/Response Types

The OpenStack Compute API supports both the JSON and XML data
serialization formats. The request format is specified using the
`Content-Type` header and is required for operations that have a request
body. The response format can be specified in requests using either the
`Accept` header or adding an .xml or .json extension to the request URI.
Note that it is possible for a response to be serialized using a format
different from the request (see example below). If no response format is
specified, JSON is the default. If conflicting formats are specified
using both an `Accept` header and a query extension, the query extension
takes precedence.

Example Request with Headers - JSON

<pre><code>POST /v1.1/11692683195772/servers HTTP/1.1
Host: az-1.region-a.geo-1.compute.hpcloudsvc.com
X-Auth-Token: HPAuth_a8df744befe0a7c0e759f0601f53226af35f3f6f44c55d9b3a3c0337e7664ac2
Content-Type: application/json
Accept: application/xml
Content-Length: 63

{"server":{"name":"webserver","imageRef":5579,"flavorRef":100}}
</code></pre>

Example Response with Headers - XML

<pre><code>HTTP/1.1 202 Accepted
Content-Length: 1224
Content-Type: application/xml; charset=UTF-8
Date: Thu, 25 Oct 2012 22:37:13 GMT

&lt;server accessIPv4="" accessIPv6="" adminPass="4QAx7M8MrXVmXZSL" created="2012-10-25T22:37:13Z" hostId="" id="467571" name="webserver" status="BUILD(scheduling)" tenantId="11692683195772" updated="2012-10-25T22:37:13Z" userId="28187593996363" uuid="e5ac3d3c-cda3-4106-b60a-0a29b382fda2" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/11692683195772/servers/467571" rel="self"/&gt;
    &lt;atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/11692683195772/servers/467571" rel="bookmark"/&gt;
    &lt;image id="5579"&gt;
        &lt;atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/11692683195772/images/5579" rel="bookmark"/&gt;
    &lt;/image&gt;
    &lt;flavor id="100"&gt;
        &lt;atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/11692683195772/flavors/100" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;addresses/&gt;
    &lt;security_groups&gt;
        &lt;security_group id="9143" name="default"&gt;
            &lt;atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/11692683195772/os-security-groups/9143" rel="bookmark"/&gt;
        &lt;/security_group&gt;
    &lt;/security_groups&gt;
&lt;/server&gt;
</code></pre>

Notice, in the above example, that the content type is set to
application/json but it asks for an application/xml response with the
`Accept` header. The same result could be achieved by adding an .xml extension to the request URI as shown below.

Example Request with .xml Extension - JSON

<pre><code> POST /v1.1/11692683195772/servers.xml HTTP/1.1
User-Agent: curl/7.21.3 (x86_64-pc-linux-gnu) libcurl/7.21.3 OpenSSL/0.9.8o zlib/1.2.3.4 libidn/1.18
Host: az-1.region-a.geo-1.compute.hpcloudsvc.com
Accept: */*
X-Auth-Token: HPAuth_a8df744befe0a7c0e759f0601f53226af35f3f6f44c55d9b3a3c0337e7664ac2
Content-Type: application/json
Content-Length: 62

{"server":{"name":"dbserver","imageRef":5579,"flavorRef":100}}
</code></pre>

##3.5 Links and References

Responses to several API operations include links which refer to HP Cloud Compute resources. For example, here is the response to a call on the [Get Server](#getServer) method.

List Servers (limit=1) Response: XML

<pre><code>&lt;servers xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;server id="488379" name="web 1"&gt;
        &lt;atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/11692683195772/servers/488379" rel="self"/&gt;
        &lt;atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/11692683195772/servers/488379" rel="bookmark"/&gt;
    &lt;/server&gt;
&lt;/servers&gt;</code></pre>


List Servers (limit=1) Response: JSON

<pre><code>{
    "servers": [
        {
            "id": 488379,
            "links": [
                {
                    "href": "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/11692683195772/servers/488379",
                    "rel": "self"
                },
                {
                    "href": "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/11692683195772/servers/488379",
                    "rel": "bookmark"
                }
            ],
            "name": "web 1",
            "uuid": "7d447c46-cdde-45b4-bdf6-6412a272ce32"
        }
    ]
}</code></pre>

The link elements in the response give references to the resource, in this case a server, which include the full URI of the server. This URI could be used at a later time to perform some server action (for example, to reboot the server) and capture both the AZ and the id of the server withing the AZ.

##3.6 <a id="Pagination"></a>Paginated Collections

To reduce load on the service, list operations limit the number of items that can be returned by
a single call.
To navigate a collection, the
parameters `limit` and `marker` can be set in the URI
(e.g.?`limit`=100&`marker`=1234). The `marker` parameter is the ID of
the last item in the previous list. Items are sorted by create time in
descending order. When a create time is not available they are sorted by
ID. The `limit` parameter sets the page size. A maximum of 1000 items are returned by
a single call. Setting `limit` to a value greater than 1000 has no effect.
A marker with an invalid ID will return a badRequest (400) fault.

##3.7 <a href="Polling"></a>Efficient Polling with the Changes-Since Parameter

The ReST API allows you to poll for the status of certain operations by
performing a GET on various elements. Rather than re-downloading and
re-parsing the full status at each polling interval, your ReST client
may use the `changes-since` parameter to check for changes since a
previous request. The `changes-since` time is specified as an [ISO
8601](http://en.wikipedia.org/wiki/ISO_8601) dateTime
(2011-01-24T17:08Z). The form for the timestamp is CCYY-MM-DDThh:mm:ss.
An optional time zone may be written in by appending the form ±hh:mm
which describes the timezone as an offset from UTC. When the timezone is
not specified (2011-01-24T17:08), the UTC timezone will be assumed. If
nothing has changed since the `changes-since` time, an empty list will
be returned. If data has changed, only the items changed since the
specified time will be returned in the response. For example, performing
a GET against
https://api.servers.openstack.org/v2/224532/servers?`changes-since`=2011-01-24T17:08Z
would list all servers that have changed since Mon, 24 Jan 2011 17:08:00
UTC.

To allow clients to keep track of changes, the changes-since filter
displays items that have been *recently* deleted. Both images and
servers contain a `DELETED` status that indicates that the resource has
been removed. Implementations are not required to keep track of deleted
resources indefinitely, so sending a changes since time in the distant
past may miss deletions.

## 3.8 <a id="Limits"></a>Limits

###3.8.1 Absolute Limits

Limits are established for the following resources on a per tenant basis:

+ metadata_items: number of metadata items allowed per instance
+ instances: the maximum number of VM instances that can be created for the project
+ injected_file_content_bytes: the maximum size of an injected file
+ injected_files: the number of injected files that can be specified when a new VM instance is created
+ volumes: the number of volumes which can be created
+ gigabytes: the maximum total size of all volumes associated with the project
+ cores: the maximum of the total number of cores for project VM instances
+ ram: the maximum number of megabytes of instance RAM for the project
+ floating_ip: the maximum number of floating ips that can be assigned to the project

The limits are applied per AZ. [List Limits](#listLimits) can be used to retrieve the current value of these limits within an AZ for a tenant.

###3.8.2 Rate Limits

In order to ensure fair sharing of cloud resources, limits are placed on the rate at which an individual tenant can make requests to the HP Cloud Compute API servers. The rate limits are specified in terms of HTTP verbs (GET, PUT, POST, DELETE) and are further qualified by URL. Stricter limits are place on operations that can affect servers than on queries. This allows users to monitor the status of the environment while quarenteeing equitable sharing of resources. The rate limits are applied per tenant and apply to API calls using both the EC2 and OSAPI interfaces. Rate limiting is enforced per AZ - a tenant has a separate allowance in each AZ.

[List Limits](#listLimits) can be used to retrieve the current value of these limits within an AZ for a tenant.

##3.9 Versions

The HP Cloud Compute Service is based on OpenStack Nova v1.1 The OpenStack v1.0  Nova API is deprecated.

##3.10 Extensions

The OpenStack Compute API is extensible. Extensions serve two purposes: They allow the introduction of new features in the API without requiring a version change and they allow the introduction of vendor specific niche functionality. Applications can programmatically determine what extensions are available by using the [List Extensions](#listExtensions) and [Get Extension](#getExtension) API methods. HP Cloud Compute supports the following extensions:

+ os-keypairs
+ os-volumes
+ os-console-output
+ security_groups
+ os-floating-ips

The resourses and methods of these extensions are described in section 4.1, [ServiceAPIOperations](#ServiceAPIOperations).


##3.11 Faults

When an error occurs at request time, the system will return an HTTP
error response code denoting the type of error. The system will also
return additional information about the fault in the body of the
response.

Fault Response: XML
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;cloudServersFault
    xmlns="http://docs.openstack.org/compute/api/v1.1"
    code="500"&gt;
&lt;message&gt;Fault!&lt;/message&gt;
&lt;details&gt;Error Details...&lt;/details&gt;
&lt;/computeFault&gt;</code></pre>

Fault Response: JSON
<pre><code>{
    "cloudServersFault" : {
        "code" : 500,
        "message" : "Fault!",
        "details" : "Error Details..." 
    }
}</code></pre>

The error code is returned in the body of the response for convenience.
The message section returns a human-readable message that is appropriate
for display to the end user. The details section is optional and may
contain information—for example, a stack trace—to assist in tracking
down an error. The detail section may or may not be appropriate for
display to an end user.

The root element of the fault (e.g. cloudServersFault) may change depending
on the type of error. The following is a list of possible elements along
with their associated error codes.



| Fault Element | Associated Error Code(s) |
|:--------------|:-------------------------|
| cloudServersFault | 500, other codes possible |
| badRequest | 400 |
| unauthorized | 401 |
| resizeNotAllowed | 403 |
| itemNotFound | 404 |
| badMethod | 405 |
| inProgress | 409 |
| overLimit | 413 |
| badMediaType | 415 |
| notImplemented | 501 |
| serviceUnavailable | 503 |

Fault Response, Item Not Found: XML
<pre><code>&lt;itemNotFound code="404" 
    xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;message&gt;
        The resource could not be found.
    &lt;/message&gt;
&lt;/itemNotFound&gt;
</code></pre>

Fault Response, Item Not Found: JSON
<pre><code>{"itemNotFound": 
	{"message": "The resource could not be found.", 
	"code": 404}}
</code></pre>

The OverLimit fault is generated when a rate limit threshold is
exceeded. When an OverLimit fault occurs, the time in seconds after which another request is allowed in returned in the `Retry-After` response header. An explanation of why the request was rate   in the `details` attribute of the response.

Fault Response, Over Limit: XML
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;overLimit
    xmlns="http://docs.openstack.org/compute/api/v1.1"
    code="413"
  &lt;message&gt;"This request was rate-limited.&lt;/message&gt;
  &lt;details&gt;Error Details...&lt;/details&gt;
&lt;/overLimit&gt;
</code></pre>

Fault Response, OVer Limit: JSON
<pre><code>{
    "overLimit" : {
        "code" : 413,
        "message" : "This request was rate-limited.",
        "details" : "Error Details...",
    }
}</code></pre>


# 4. REST API Specifications

##<a id="ServiceAPIOperations"></a>4.1 Service API Operations

**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**Base URI**: [Host]/

**Admin URI**: N/A


### Compute API


###Core Compute API

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
|:---------|:---------------------|:------------|:-----------------------|:------------------|:---------------:|
| **Versions** | [Get Version Info](#versionDetails) | GET | v1.1 | Y/Y |  |
| **Extensions** | [List Extensions](#listExtensions) | GET | v1.1/{tenant_id}/extensions | Y/Y |  |
| **Extension** | [Get Extension](#getExtension) | GET | v1.1/{tenant_id}/extensions/{alias} | Y/Y |  |
| **Limits** | [List Limits](#listLimits) | GET | v1.1/{tenant_id}/limits | Y/Y |  |
| **Servers** | [List Servers](#listServers) | GET | v1.1/{tenant_id}/servers | Y/Y |  |
|  | [Create Server](#createServer) | POST | v1.1/{tenant_id}/servers | Y/Y |  |
|  | [List Servers Detail](#listDetailServers) | GET | v1.1/{tenant_id}/servers/detail | Y/Y |  |
| **Server** | [Get Server Details](#getServer) | GET | v1.1/{tenant_id}/servers/{server_id} | Y/Y |  |
|  | [Update Server Name](#updateServer) | PUT | v1.1/{tenant_id}/servers/{server_id} | Y/Y |  |
|  | [Delete Server](#deleteServer) | DELETE | v1.1/{tenant_id}/servers/{server_id} | Y/Y |  |
| **Server Action** | [Reboot Server](#rebootServer) | POST | v1.1/{tenant_id}/servers/{server_id}/action | Y/Y |  |
|  | [Rebuild Server](#rebuildServer) | POST | v1.1/{tenant_id}/servers/{server_id}/action | Y/Y |  |
|  | [Create Image](#createImage) | POST | v1.1/{tenant_id}/servers/{server_id}/action | Y/Y |  |
| **Server Metadata** | [List Metadata](#ServerMetadata_listMetadata) | GET | v1.1/{tenant_id}/servers/{server_id}/metadata | Y/Y |  |
|  | [Update Metadata](#ServerMetadata_updateMetadata) | POST | v1.1/{tenant_id}/servers/{server_id}/metadata | Y/Y |  |
|  | [Create or Replace Metadata](#ServerMetadata_setMetadata) | PUT | v1.1/{tenant_id}/servers/{server_id}/metadata | Y/Y |  |
| **Server Metadata Item** | [Get Metadata Item](#ServerMetadataItem_getMetadataItem) | GET | v1.1/{tenant_id}/servers/{server_id}/metadata/{key} | Y/Y |  |
|  | [Create or Update Metadata Item](#ServerMetadataItem_setMetadataItem) | PUT | v1.1/{tenant_id}/servers/{server_id}/metadata/{key} | Y/Y |  |
|  | [Delete Metadata Item](#ServerMetadataItem_deleteMetadataItem) | DELETE | v1.1/{tenant_id}/servers/{server_id}/metadata/{key} | Y/Y |  |
| **Images** | [List Images](#listImages) | GET | v1.1/{tenant_id}/images | Y/Y |  |
|  | [List Images Detail](#listDetailImages) | GET | v1.1/{tenant_id}/images/detail | Y/Y |  |
| **Image** | [Get Image Details](#getImage) | GET | v1.1/{tenant_id}/images/{image_id} | Y/Y |  |
|  | [Delete Image](#deleteImage) | DELETE | v1.1/{tenant_id}/images/{image_id} | Y/Y |  |
| **Image Metadata** | [List Metadata](#ImageMetadata_listMetadata) | GET | v1.1/{tenant_id}/images/{image_id}/metadata | Y/Y |  |
|  | [Update Metadata](#ImageMetadata_updateMetadata) | POST | v1.1/{tenant_id}/images/{image_id}/metadata | Y/Y |  |
|  | [Create or Replace Metadata](#ImageMetadata_setMetadata) | PUT | v1.1/{tenant_id}/images/{image_id}/metadata | Y/Y |  |
| **Image Metadata Item** | [Get Metadata Item](#ImageMetadataItem_getMetadataItem) | GET | v1.1/{tenant_id}/images/{image_id}/metadata/{key} | Y/Y |  |
|  | [Create or Update Metadata Item](#ImageMetadataItem_setMetadataItem) | PUT | v1.1/{tenant_id}/images/{image_id}/metadata/{key} | Y/Y |  |
|  | [Delete Metadata Item](#ImageMetadataItem_deleteMetadataItem) | DELETE | v1.1/{tenant_id}/images/{image_id}/metadata/{key} | Y/Y |  |
| **Flavors** | [List Flavors](#listFlavors) | GET | v1.1/{tenant_id}/flavors | Y/Y |  |
|  | [List Flavors Detail](#listDetailFlavors) | GET | v1.1/{tenant_id}/flavors/detail | Y/Y |  |
| **Flavor** | [Get Flavor Details](#getFlavor) | GET | v1.1/{tenant_id}/flavors/{flavor_id} | Y/Y |  |

###Console Output

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
|:---------|:---------------------|:------------|:-----------------------|:------------------|:---------------:|
| **Server Action** | [Get Console Output.](#getConsoleOutput) | POST | v1.1/{tenant_id}/servers/{server_id}/action | Y/Y |  |

###Floating Ips

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
|:---------|:---------------------|:------------|:-----------------------|:------------------|:---------------:|
| **Server Action** | [Add Floating Ip](#addFloatingIp) | POST | v1.1/{tenant_id}/servers/{server_id}/action | Y/Y |  |
|  | [Remove Floating Ip](#removeFloatingIp) | POST | v1.1/{tenant_id}/servers/{server_id}/action | Y/Y |  |
| **Floating Ips** | [List Floating IPs](#listFloatingIPs) | GET | v1.1/{tenant_id}/os-floating-ips | Y/Y |  |
|  | [Allocate Floating IP](#allocateFloatingIP) | POST | v1.1/{tenant_id}/os-floating-ips | Y/Y |  |
| **Floating IP** | [Get Floating Ip](#getFloatingIP) | GET | v1.1/{tenant_id}/os-floating-ips/{id} | Y/Y |  |
|  | [Deallocate Floating IP](#deallocateFloatingIP) | DELETE | v1.1/{tenant_id}/os-floating-ips/{id} | Y/Y |  |

###Keypairs

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
|:---------|:---------------------|:------------|:-----------------------|:------------------|:---------------:|
| **Keypairs** | [List Keypairs](#listKeypairs) | GET | v1.1/{tenant_id}/os-keypairs | Y/Y |  |
|  | [Create Keypair](#createKeypair) | POST | v1.1/{tenant_id}/os-keypairs | Y/Y |  |
| **Keypair** | [Get Keypair](#getKeypair) | GET | v1.1/{tenant_id}/os-keypairs/{keypair_name} | Y/Y |  |
|  | [Delete Keypair](#deleteKeypair) | DELETE | v1.1/{tenant_id}/os-keypairs/{keypair_name} | Y/Y |  |

###Security Groups

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
|:---------|:---------------------|:------------|:-----------------------|:------------------|:---------------:|
| **Server Action** | [Add Security Group](#addSecurityGroup) | POST | v1.1/{tenant_id}/servers/{server_id}/action | Y/Y |  |
|  | [Remove Security Group](#removeSecurityGroup) | POST | v1.1/{tenant_id}/servers/{server_id}/action | Y/Y |  |
| **Security Groups** | [List Security Groups](#listSecGroups) | GET | v1.1/{tenant_id}/os-security-groups | Y/Y |  |
|  | [Create Security Group](#createSecGroup) | POST | v1.1/{tenant_id}/os-security-groups | Y/Y |  |
| **Security group** | [Get Security Group](#getSecGroup) | GET | v1.1/{tenant_id}/os-security-groups/{security_group_id} | Y/Y |  |
|  | [Delete Security Group](#deleteSecGroup) | DELETE | v1.1/{tenant_id}/os-security-groups/{security_group_id} | Y/Y |  |
| **Security Group Rules** | [Create Security Group Rule](#createSecGroupRule) | POST | v1.1/{tenant_id}/os-security-group-rules | Y/Y |  |
| **Security Group Rule** | [Delete Security Group Rule](#deleteSecGroupRule) | DELETE | v1.1/{tenant_id}/os-security-group-rules/{security_group_rule_id} | Y/Y |  |

## 4.2 Common Request Headers

*Http standard request headers*

**Accept** - Internet media types that are acceptable in the response. HP Cloud Compute supports the media types application/xml and application/json.

**Content-Length** - The length of the request body in octets (8-bit bytes).

**Content-Type** - The Internet media type of the request body. Used with POST and PUT requests. Must be either application/xml or application/json.

**Host** - The domain name of the server hosting HP Cloud Compute.

*Non-standard request headers*

**X-Auth-Token** - HP Cloud authorization token.

*Example*

<pre><code>POST /v1.1/11692683195772/servers HTTP/1.1
Host: az-1.region-a.geo-1.compute.hpcloudsvc.com
Accept: */*
X-Auth-Token: HPAuth_2895c13b1118e23d977f6a21aa176fd2bd8a10e04b74bd8e353216072968832a
Content-Type: application/json
Content-Length: 85</code></pre>

## 4.3 Common Response Headers

*Http standard response headers*

**Content-Length** - The length of the response body in octets (8-bit bytes).

**Content-Type** - Internet media type of the response body.

**Date** - The date and time that the response was sent.

*Non-standard response headers*

**Retry-After** - Number of seconds to wait before a retry will succeed. This header is included in the response to an operation which was rate limited.

*Example*

<pre><code>HTTP/1.1 202 Accepted
Content-Length: 1135
Content-Type: application/json; charset=UTF-8
Date: Tue, 30 Oct 2012 16:22:35 GMT</code></pre>


## 4.4 OpenStack API Operation Details
The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.

### <a id="version"></a>4.4.1 Versions


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A list of available API versions </p>
        



#### <a id="versionDetails"></a>4.4.1.1 Get Version Info
#### GET v1.1


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Returns detailed information about this
                specific version of the API. </p>
            


######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;version id="v1.1" status="CURRENT" updated="2011-01-21T11:33:21Z" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;&lt;media-types&gt;&lt;media-type base="application/xml" type="application/vnd.openstack.compute-v1.1+xml"/&gt;&lt;media-type base="application/json" type="application/vnd.openstack.compute-v1.1+json"/&gt;&lt;/media-types&gt;&lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" rel="self"/&gt;&lt;atom:link href="http://docs.rackspacecloud.com/servers/api/v1.1/cs-devguide-20110125.pdf" rel="describedby" type="application/pdf"/&gt;&lt;atom:link href="http://docs.rackspacecloud.com/servers/api/v1.1/application.wadl" rel="describedby" type="application/vnd.sun.wadl+xml"/&gt;&lt;/version&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "version": {
        "id": "v1.1",
        "links": [
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
                "rel": "self"
            },
            {
                "href": "http://docs.rackspacecloud.com/servers/api/v1.1/cs-devguide-20110125.pdf",
                "rel": "describedby",
                "type": "application/pdf"
            },
            {
                "href": "http://docs.rackspacecloud.com/servers/api/v1.1/application.wadl",
                "rel": "describedby",
                "type": "application/vnd.sun.wadl+xml"
            }
        ],
        "media-types": [
            {
                "base": "application/xml",
                "type": "application/vnd.openstack.compute-v1.1+xml"
            },
            {
                "base": "application/json",
                "type": "application/vnd.openstack.compute-v1.1+json"
            }
        ],
        "status": "CURRENT",
        "updated": "2011-01-21T11:33:21Z"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_eeb52e2b3fad2151383af237af3ec107ceea775498c2dfc7e8087f26b3b819ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/'
</code></pre>
</div>


### <a id="extensions"></a>4.4.2 Extensions


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A list of supported extensions. </p>
        



#### <a id="listExtensions"></a>4.4.2.1 List Extensions
#### GET v1.1/{tenant_id}/extensions


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Lists all available extensions. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;extensions xmlns:atom="http://www.w3.org/2005/Atom" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;&lt;extension name="Keypairs" namespace="http://docs.openstack.org/ext/keypairs/api/v1.1" alias="os-keypairs" updated="2011-08-08T00:00:00+00:00"&gt;&lt;description&gt;Keypair Support&lt;/description&gt;&lt;/extension&gt;&lt;extension name="Volumes" namespace="http://docs.openstack.org/ext/volumes/api/v1.1" alias="os-volumes" updated="2011-03-25T00:00:00+00:00"&gt;&lt;description&gt;Volumes support&lt;/description&gt;&lt;/extension&gt;&lt;extension name="Console_output" namespace="http://docs.openstack.org/compute/ext/os-console-output/api/v1.1" alias="os-console-output" updated="2011-12-08T00:00:00+00:00"&gt;&lt;description&gt;Console log output support, with tailing ability.&lt;/description&gt;&lt;/extension&gt;&lt;extension name="SecurityGroups" namespace="http://docs.openstack.org/ext/securitygroups/api/v1.1" alias="security_groups" updated="2011-07-21T00:00:00+00:00"&gt;&lt;description&gt;Security group support&lt;/description&gt;&lt;/extension&gt;&lt;extension name="Floating_ips" namespace="http://docs.openstack.org/ext/floating_ips/api/v1.1" alias="os-floating-ips" updated="2011-06-16T00:00:00+00:00"&gt;&lt;description&gt;Floating IPs support&lt;/description&gt;&lt;/extension&gt;&lt;/extensions&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "extensions": [
        {
            "alias": "os-keypairs",
            "description": "Keypair Support",
            "links": [],
            "name": "Keypairs",
            "namespace": "http://docs.openstack.org/ext/keypairs/api/v1.1",
            "updated": "2011-08-08T00:00:00+00:00"
        },
        {
            "alias": "os-volumes",
            "description": "Volumes support",
            "links": [],
            "name": "Volumes",
            "namespace": "http://docs.openstack.org/ext/volumes/api/v1.1",
            "updated": "2011-03-25T00:00:00+00:00"
        },
        {
            "alias": "os-console-output",
            "description": "Console log output support, with tailing ability.",
            "links": [],
            "name": "Console_output",
            "namespace": "http://docs.openstack.org/compute/ext/os-console-output/api/v1.1",
            "updated": "2011-12-08T00:00:00+00:00"
        },
        {
            "alias": "security_groups",
            "description": "Security group support",
            "links": [],
            "name": "SecurityGroups",
            "namespace": "http://docs.openstack.org/ext/securitygroups/api/v1.1",
            "updated": "2011-07-21T00:00:00+00:00"
        },
        {
            "alias": "os-floating-ips",
            "description": "Floating IPs support",
            "links": [],
            "name": "Floating_ips",
            "namespace": "http://docs.openstack.org/ext/floating_ips/api/v1.1",
            "updated": "2011-06-16T00:00:00+00:00"
        }
    ]
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/extensions'
</code></pre>
</div>


### <a id="extension"></a>4.4.3 Extension


                            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Extension </p>
                        



#### <a id="getExtension"></a>4.4.3.1 Get Extension
#### GET v1.1/{tenant_id}/extensions/{alias}


            

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>alias</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">An alias is a name for a pointer to a resource, such as a named extension.</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;extension xmlns:atom="http://www.w3.org/2005/Atom" xmlns="http://docs.openstack.org/compute/api/v1.1" name="Floating_ips" namespace="http://docs.openstack.org/ext/floating_ips/api/v1.1" alias="os-floating-ips" updated="2011-06-16T00:00:00+00:00"&gt;&lt;description&gt;Floating IPs support&lt;/description&gt;&lt;/extension&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "extension": {
        "alias": "os-floating-ips",
        "description": "Floating IPs support",
        "links": [],
        "name": "Floating_ips",
        "namespace": "http://docs.openstack.org/ext/floating_ips/api/v1.1",
        "updated": "2011-06-16T00:00:00+00:00"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/extensions/os-floating-ips'
</code></pre>
</div>


### <a id="limits"></a>4.4.4 Limits


                        

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Limits </p>
                    



#### <a id="listLimits"></a>4.4.4.1 List Limits
#### GET v1.1/{tenant_id}/limits


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Returns current limits for the account. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;limits xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;rates&gt;
        &lt;rate regex="/{suburi}" uri="/{suburi}"&gt;
            &lt;limit next-available="2012-10-05T03:47:16Z" remaining="2999" unit="MINUTE" value="3000" verb="GET"/&gt;
            &lt;limit next-available="2012-10-05T03:47:15Z" remaining="199" unit="MINUTE" value="200" verb="GET"/&gt;
            &lt;limit next-available="2012-10-05T03:47:15Z" remaining="10" unit="MINUTE" value="10" verb="PUT"/&gt;
            &lt;limit next-available="2012-10-05T03:47:15Z" remaining="40" unit="MINUTE" value="40" verb="POST"/&gt;
            &lt;limit next-available="2012-10-05T03:47:15Z" remaining="60" unit="MINUTE" value="60" verb="DELETE"/&gt;
        &lt;/rate&gt;
    &lt;/rates&gt;
    &lt;absolute&gt;
        &lt;limit name="maxServerMeta" value="50"/&gt;
        &lt;limit name="maxPersonality" value="5"/&gt;
        &lt;limit name="maxImageMeta" value="50"/&gt;
        &lt;limit name="maxPersonalitySize" value="10240"/&gt;
        &lt;limit name="maxSecurityGroupRules" value="20"/&gt;
        &lt;limit name="maxSecurityGroups" value="10"/&gt;
        &lt;limit name="maxTotalInstances" value="20"/&gt;
        &lt;limit name="maxTotalRAMSize" value="102400"/&gt;
    &lt;/absolute&gt;
&lt;/limits&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "limits": {
        "absolute": {
            "maxImageMeta": 50,
            "maxPersonality": 5,
            "maxPersonalitySize": 10240,
            "maxSecurityGroupRules": 20,
            "maxSecurityGroups": 10,
            "maxServerMeta": 50,
            "maxTotalInstances": 20,
            "maxTotalRAMSize": 102400
        },
        "rate": [
            {
                "limit": [
                    {
                        "next-available": "2012-10-05T03:47:15Z",
                        "remaining": 3000,
                        "unit": "MINUTE",
                        "value": 3000,
                        "verb": "GET"
                    },
                    {
                        "next-available": "2012-10-05T03:47:15Z",
                        "remaining": 199,
                        "unit": "MINUTE",
                        "value": 200,
                        "verb": "GET"
                    },
                    {
                        "next-available": "2012-10-05T03:47:15Z",
                        "remaining": 10,
                        "unit": "MINUTE",
                        "value": 10,
                        "verb": "PUT"
                    },
                    {
                        "next-available": "2012-10-05T03:47:15Z",
                        "remaining": 40,
                        "unit": "MINUTE",
                        "value": 40,
                        "verb": "POST"
                    },
                    {
                        "next-available": "2012-10-05T03:47:15Z",
                        "remaining": 60,
                        "unit": "MINUTE",
                        "value": 60,
                        "verb": "DELETE"
                    }
                ],
                "regex": "/{suburi}",
                "uri": "/{suburi}"
            }
        ]
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/limits'
</code></pre>
</div>


### <a id="Servers"></a>4.4.5 Servers


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A list of servers. Each server contains IDs,
                names, and links -- other attributes are omitted. </p>
        



#### <a id="listServers"></a>4.4.5.1 List Servers
#### GET v1.1/{tenant_id}/servers


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Lists IDs, names, and links associated with the account.
                The list of servers returned can be filtered using query parameters described below.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>image</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filter the list of servers returned by image.</p>
</li>
<li><p><em>flavor</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filter the list of servers returned by flavor.</p>
</li>
<li><p><em>name</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filter the list of servers returned by display name.</p>
</li>
<li><p><em>status</em> - csapi:ServerStatus</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filter the list of servers returned by server status. See <a href="#ServerStates"> Server Status Values </a> .</p>
</li>
<li><p><em>changes-since</em> - xsd:dateTime</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of servers returned to those that have changed since the <em>changes-since</em> time. See <a href="#Polling"> Efficient Polling with the <em>Changes-Since</em> Parameter </a> .</p>
</li>
<li><p><em>marker</em> - csapi:UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The UUID of the last item in the previous list. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
<li><p><em>limit</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Sets the page size to <em>limit</em>. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;servers xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;server id="233693" name="server-name-2"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233693" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233693" rel="bookmark"/&gt;
    &lt;/server&gt;
    &lt;server id="233691" name="server-name-1"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233691" rel="bookmark"/&gt;
    &lt;/server&gt;
&lt;/servers&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "servers": [
        {
            "id": 233693,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233693",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233693",
                    "rel": "bookmark"
                }
            ],
            "name": "server-name-2",
            "uuid": "f632dbea-e9bc-4c71-a893-6bdc3696a5ca"
        },
        {
            "id": 233691,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233691",
                    "rel": "bookmark"
                }
            ],
            "name": "server-name-1",
            "uuid": "d1d5e151-2fed-4522-9e94-aae0ef3d5db0"
        }
    ]
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers?status=ACTIVE&amp;image=120&amp;flavor=100&amp;name=server-name'
</code></pre>
</div>


#### <a id="createServer"></a>4.4.5.2 Create Server
#### POST v1.1/{tenant_id}/servers


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> 
                Creates a new server with the specified parameters. The number of servers that can
                be created is limited by the user's instances, cores and ram quotas.(See 
        <a href="#Limits">
            Limits
        </a>
          .) 
                Returns an error if at least
                <code>min_count</code> servers can't be created. Otherwise, creates a number of servers
                eqaul to the minimum of the number of servers allowed by the user's quota and <code>max_count</code>.
                If multiple servers are created, they are all created with the same value for the remaining parameters.
                In particular, this means that all the server will have the same display name.
                (See 
        <a href="#serverNames">
            Server Names
        </a>
          .)
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>flavorRef</em> (required) - csapi:ID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID of the flavor to be used when creating the server</p>
</li>
<li><p><em>imageRef</em> (required) - csapi:ID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID of the image from which to boot the server </p>
</li>
<li><p><em>name</em> (required) - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The name of the server.</p>
</li>
<li><p><em>config_drive</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Creates an ephemeral drive on the server which is formatted with a fat-32 filesystem. Metadata, networks and keys are written to files in the filesystem. (See <a href="#ConfigurationDrive"> Configuration Drive </a> .)</p>
</li>
<li><p><em>key_name</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Assigns the public key of the named keypair to the server. </p>
</li>
<li><p><em>metadata</em> - csapi:Metadata</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Metadata key and value pairs. The maximum size of the metadata key and value is 255 bytes each.</p>
</li>
<li><p><em>min_count</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The minimum number of servers to create. Defaults to 1 if not specified. An error is returned if at least <code>min_count</code> servers can not be created. </p>
</li>
<li><p><em>max_count</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The maximum number of servers to create. Defaults to <code>min_count</code> if not specified. The number of servers created will be the minimum of the number of servers allowed by the user's quota and <code>max_count</code>. </p>
</li>
<li><p><em>personality</em> - csapi:Personality</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">File path and contents to inject into the server at launch. The maximum size of the file path data is 255 bytes. The maxPersonality limit restricts the number of files that can be injected. The maxPersonalitySize limit restricts the maximum number of bytes for the decoded file contents. (See <a href="#FileInjection"> File Injection </a> .) </p>
</li>
<li><p><em>security_groups</em> - csapi:list_of_strings</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A list of names of security groups that are to be associated with the server. If no names are specified, the server is associated with the "default" security group. </p>
</li>
<li><p><em>user_data</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Arbitrary string of user supplied data that is provided to the server as EC2 metadata. Must be Base64 encoded. (See <a href="#EC2Metadata"> EC2 Metadata </a> .)</p>
</li>
<li><p><em>password</em> - None</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Not supported. </p>
</li>
<li><p><em>accessIPv4</em> - None</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Not supported</p>
</li>
<li><p><em>accessIPv6</em> - None</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Not supported</p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;server config_drive="True" flavorRef="100" imageRef="120" key_name="key.pub" max_count="1" min_count="1" name="server-name-2" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                        
    &lt;security_groups&gt;
        
                                
        &lt;security_group name="security-group"/&gt;
        
                        
    &lt;/security_groups&gt;
    
                        
    &lt;metadata&gt;
        
                                
        &lt;meta key="key-2" value="value-2"/&gt;
        
                                
        &lt;meta key="key-1" value="value-1"/&gt;
        
                        
    &lt;/metadata&gt;
    
            
&lt;/server&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "server": {
        "config_drive": true,
        "flavorRef": "100",
        "imageRef": "120",
        "key_name": "key.pub",
        "max_count": 1,
        "metadata": {
            "key-1": "value-1",
            "key-2": "value-2"
        },
        "min_count": 1,
        "name": "server-name-1",
        "security_groups": [
            {
                "name": "security-group"
            }
        ]
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 202

**Response Headers**

<ul>
<li><p><em>Location</em> (required) - xsd:anyURI</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Full URL to a server created by the service.</p>
</li>
</ul>
XML

<div>
<pre><code>&lt;server accessIPv4="" accessIPv6="" adminPass="2eb56Qh2uVAuC7ub" created="2012-11-01T03:58:01Z" hostId="" id="294393" name="server-name-2" status="BUILD(scheduling)" tenantId="36991859863737" updated="2012-11-01T03:58:01Z" userId="13311562627589" uuid="44823245-b322-4ad0-9cf3-c3c84fd4cbec" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/294393" rel="self"/&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/294393" rel="bookmark"/&gt;
    &lt;image id="120"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/&gt;
    &lt;/image&gt;
    &lt;flavor id="100"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;metadata&gt;
        &lt;meta key="key-2"&gt;
            
        &lt;/meta&gt;
        &lt;meta key="key-1"&gt;
            
        &lt;/meta&gt;
    &lt;/metadata&gt;
    &lt;addresses/&gt;
    &lt;security_groups&gt;
        &lt;security_group id="12091" name="default"&gt;
            &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/12091" rel="bookmark"/&gt;
        &lt;/security_group&gt;
    &lt;/security_groups&gt;
&lt;/server&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "badRequest": {
        "code": 400,
        "message": "Security group security-group not found for project 36991859863737."
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_056c1b46b85d28f0f30c5de0be445b999e49efb465886f3193637f6b00c33bd4" -d '{"server": {"name": "server-name-1", "imageRef": "120", "key_name": "key.pub", "min_count": 1, "flavorRef": "100", "max_count": 1, "config_drive": true, "security_groups": [{"name": "security-group"}], "metadata": {"key-2": "value-2", "key-1": "value-1"}}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers'
</code></pre>
</div>


#### <a id="listDetailServers"></a>4.4.5.3 List Servers Detail
#### GET v1.1/{tenant_id}/servers/detail


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> 
                Lists details for servers associated with the account. The list of servers returned can be filtered
                using the query parameters described below.          
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>image</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filter the list of servers returned by image.</p>
</li>
<li><p><em>flavor</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filter the list of servers returned by flavor.</p>
</li>
<li><p><em>name</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filter the list of servers returned by display name.</p>
</li>
<li><p><em>status</em> - csapi:ServerStatus</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filter the list of servers returned by server status. See <a href="#ServerStates"> Server Status Values </a> .</p>
</li>
<li><p><em>changes-since</em> - xsd:dateTime</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of servers returned to those that have changed since the <em>changes-since</em> time. See <a href="#Polling"> Efficient Polling with the <em>Changes-Since</em> Parameter </a> .</p>
</li>
<li><p><em>marker</em> - csapi:UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The UUID of the last item in the previous list. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
<li><p><em>limit</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Sets the page size to <em>limit</em>. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;servers xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;server accessIPv4="" accessIPv6="" created="2012-11-01T03:58:01Z" hostId="763e09f51afed6e9a38e2c0e385e49fd8fbd7111a957574f3081540a" id="294393" name="server-name-2" progress="100" status="ACTIVE" tenantId="36991859863737" updated="2012-11-01T03:58:18Z" userId="13311562627589" uuid="44823245-b322-4ad0-9cf3-c3c84fd4cbec"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/294393" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/294393" rel="bookmark"/&gt;
        &lt;image id="120"&gt;
            &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/&gt;
        &lt;/image&gt;
        &lt;flavor id="100"&gt;
            &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/&gt;
        &lt;/flavor&gt;
        &lt;metadata&gt;
            &lt;meta key="key-2"&gt;
                
            &lt;/meta&gt;
            &lt;meta key="key-1"&gt;
                
            &lt;/meta&gt;
        &lt;/metadata&gt;
        &lt;addresses&gt;
            &lt;network id="private"&gt;
                &lt;ip addr="10.2.0.27" version="4"/&gt;
                &lt;ip addr="15.185.225.248" version="4"/&gt;
            &lt;/network&gt;
        &lt;/addresses&gt;
        &lt;security_groups&gt;
            &lt;security_group id="12091" name="default"&gt;
                &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/12091" rel="bookmark"/&gt;
            &lt;/security_group&gt;
        &lt;/security_groups&gt;
    &lt;/server&gt;
&lt;/servers&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "servers": [
        {
            "accessIPv4": "",
            "accessIPv6": "",
            "addresses": {
                "private": [
                    {
                        "addr": "10.2.0.27",
                        "version": 4
                    },
                    {
                        "addr": "15.185.225.248",
                        "version": 4
                    }
                ]
            },
            "config_drive": "",
            "created": "2012-11-01T03:58:01Z",
            "flavor": {
                "id": "100",
                "links": [
                    {
                        "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100",
                        "rel": "bookmark"
                    }
                ]
            },
            "hostId": "763e09f51afed6e9a38e2c0e385e49fd8fbd7111a957574f3081540a",
            "id": 294393,
            "image": {
                "id": "120",
                "links": [
                    {
                        "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120",
                        "rel": "bookmark"
                    }
                ]
            },
            "key_name": "key.pub",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/294393",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/294393",
                    "rel": "bookmark"
                }
            ],
            "metadata": {
                "key-1": "",
                "key-2": ""
            },
            "name": "server-name-2",
            "progress": 100,
            "security_groups": [
                {
                    "id": 12091,
                    "links": [
                        {
                            "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/12091",
                            "rel": "bookmark"
                        }
                    ],
                    "name": "default"
                }
            ],
            "status": "ACTIVE",
            "tenant_id": "36991859863737",
            "updated": "2012-11-01T03:58:18Z",
            "user_id": "13311562627589",
            "uuid": "44823245-b322-4ad0-9cf3-c3c84fd4cbec"
        }
    ]
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_056c1b46b85d28f0f30c5de0be445b999e49efb465886f3193637f6b00c33bd4" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/detail?status=ACTIVE&amp;image=120&amp;flavor=100&amp;name=server-name'
</code></pre>
</div>


### <a id="Server"></a>4.4.6 Server


#### <a id="getServer"></a>4.4.6.1 Get Server Details
#### GET v1.1/{tenant_id}/servers/{server_id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Lists details for the specified server. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;server accessIPv4="" accessIPv6="" created="2012-11-01T03:58:01Z" hostId="763e09f51afed6e9a38e2c0e385e49fd8fbd7111a957574f3081540a" id="294393" name="server-name-2" progress="100" status="ACTIVE" tenantId="36991859863737" updated="2012-11-01T03:58:18Z" userId="13311562627589" uuid="44823245-b322-4ad0-9cf3-c3c84fd4cbec" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/294393" rel="self"/&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/294393" rel="bookmark"/&gt;
    &lt;image id="120"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/&gt;
    &lt;/image&gt;
    &lt;flavor id="100"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;metadata&gt;
        &lt;meta key="key-2"&gt;
            
        &lt;/meta&gt;
        &lt;meta key="key-1"&gt;
            
        &lt;/meta&gt;
    &lt;/metadata&gt;
    &lt;addresses&gt;
        &lt;network id="private"&gt;
            &lt;ip addr="10.2.0.27" version="4"/&gt;
            &lt;ip addr="15.185.225.248" version="4"/&gt;
        &lt;/network&gt;
    &lt;/addresses&gt;
    &lt;security_groups&gt;
        &lt;security_group id="12091" name="default"&gt;
            &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/12091" rel="bookmark"/&gt;
        &lt;/security_group&gt;
    &lt;/security_groups&gt;
&lt;/server&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "server": {
        "accessIPv4": "",
        "accessIPv6": "",
        "addresses": {
            "private": [
                {
                    "addr": "10.2.0.27",
                    "version": 4
                },
                {
                    "addr": "15.185.225.248",
                    "version": 4
                }
            ]
        },
        "config_drive": "",
        "created": "2012-11-01T03:58:01Z",
        "flavor": {
            "id": "100",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100",
                    "rel": "bookmark"
                }
            ]
        },
        "hostId": "763e09f51afed6e9a38e2c0e385e49fd8fbd7111a957574f3081540a",
        "id": 294393,
        "image": {
            "id": "120",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120",
                    "rel": "bookmark"
                }
            ]
        },
        "key_name": "key.pub",
        "links": [
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/294393",
                "rel": "self"
            },
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/294393",
                "rel": "bookmark"
            }
        ],
        "metadata": {
            "key-1": "",
            "key-2": ""
        },
        "name": "server-name-2",
        "progress": 100,
        "security_groups": [
            {
                "id": 12091,
                "links": [
                    {
                        "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/12091",
                        "rel": "bookmark"
                    }
                ],
                "name": "default"
            }
        ],
        "status": "ACTIVE",
        "tenant_id": "36991859863737",
        "updated": "2012-11-01T03:58:18Z",
        "user_id": "13311562627589",
        "uuid": "44823245-b322-4ad0-9cf3-c3c84fd4cbec"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_056c1b46b85d28f0f30c5de0be445b999e49efb465886f3193637f6b00c33bd4" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/294393'
</code></pre>
</div>


#### <a id="updateServer"></a>4.4.6.2 Update Server Name
#### PUT v1.1/{tenant_id}/servers/{server_id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Updates the display name for the specified server. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> (required) - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The new display name of the server. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;server xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;name&gt;new-server-name-2&lt;/name&gt;
    
            
&lt;/server&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "server": {
        "name": "new-server-name-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;server accessIPv4="" accessIPv6="" created="2012-10-02T23:24:20Z" hostId="2ddccc8dc2fb1461a6df1fc8e624db7578e688f52c6ac4929d5b235a" id="233069" name="new-server-name-2" progress="100" status="ACTIVE" tenantId="36991859863737" updated="2012-10-03T05:36:28Z" userId="13311562627589" uuid="cda05bcd-89d3-4c1b-bd6c-df6b3f11c14f" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069" rel="self"/&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233069" rel="bookmark"/&gt;
    &lt;image id="120"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/&gt;
    &lt;/image&gt;
    &lt;flavor id="100"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;metadata&gt;
        &lt;meta key="key-2"&gt;
            value-2
        &lt;/meta&gt;
        &lt;meta key="key-1"&gt;
            value-1
        &lt;/meta&gt;
    &lt;/metadata&gt;
    &lt;addresses&gt;
        &lt;network id="private"&gt;
            &lt;ip addr="10.2.90.2" version="4"/&gt;
            &lt;ip addr="15.185.227.39" version="4"/&gt;
        &lt;/network&gt;
    &lt;/addresses&gt;
    &lt;security_groups&gt;
        &lt;security_group id="14703" name="security-group"&gt;
            &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/14703" rel="bookmark"/&gt;
        &lt;/security_group&gt;
    &lt;/security_groups&gt;
&lt;/server&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "server": {
        "accessIPv4": "",
        "accessIPv6": "",
        "addresses": {
            "private": [
                {
                    "addr": "10.2.90.2",
                    "version": 4
                },
                {
                    "addr": "15.185.227.39",
                    "version": 4
                }
            ]
        },
        "config_drive": "1",
        "created": "2012-10-02T23:24:20Z",
        "flavor": {
            "id": "100",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100",
                    "rel": "bookmark"
                }
            ]
        },
        "hostId": "2ddccc8dc2fb1461a6df1fc8e624db7578e688f52c6ac4929d5b235a",
        "id": 233069,
        "image": {
            "id": "120",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120",
                    "rel": "bookmark"
                }
            ]
        },
        "key_name": "key.pub",
        "links": [
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069",
                "rel": "self"
            },
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233069",
                "rel": "bookmark"
            }
        ],
        "metadata": {
            "key-1": "value-1",
            "key-2": "value-2"
        },
        "name": "new-server-name-1",
        "progress": 100,
        "security_groups": [
            {
                "id": 14703,
                "links": [
                    {
                        "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/14703",
                        "rel": "bookmark"
                    }
                ],
                "name": "security-group"
            }
        ],
        "status": "ACTIVE",
        "tenant_id": "36991859863737",
        "updated": "2012-10-03T05:36:27Z",
        "user_id": "13311562627589",
        "uuid": "cda05bcd-89d3-4c1b-bd6c-df6b3f11c14f"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"server": {"name": "new-server-name-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069'
</code></pre>
</div>


#### <a id="deleteServer"></a>4.4.6.3 Delete Server
#### DELETE v1.1/{tenant_id}/servers/{server_id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Terminates the specified server. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 204

######Example(s)

<div>
<pre><code>curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069'
</code></pre>
</div>


### <a id="ServerAction"></a>4.4.7 Server Action


#### <a id="rebootServer"></a>4.4.7.1 Reboot Server
#### POST v1.1/{tenant_id}/servers/{server_id}/action


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Reboots the specified server. Specify the
                    <code>reboot</code> action in the request body. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>type</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Specifies <em>SOFT</em> or <em>HARD</em> reboot. A <em>SOFT</em> reboot signals the operating system to restart, which allows for graceful shutdown of all processes. A <em>HARD</em> reboot is equivalent to power cycling the server. The default is a <em>SOFT</em> reboot. </p>
<p>Legal values are:<ul>
<li><em>SOFT</em>  - Signal the operating system to restart.
</li>
<li><em>HARD</em>  - Restart the server. Equivalent to power cycling the server.
</li>
</ul></p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;reboot type="SOFT" xmlns="http://docs.openstack.org/compute/api/v1.1"/&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "reboot": {
        "type": "SOFT"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 202

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"reboot": {"type": "SOFT"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/action'
</code></pre>
</div>


#### <a id="rebuildServer"></a>4.4.7.2 Rebuild Server
#### POST v1.1/{tenant_id}/servers/{server_id}/action


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Rebuilds the specified server. Specify the
                    <code>rebuild</code> action in the request body. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The name for the new server. </p>
</li>
<li><p><em>imageRef</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A reference to the image which is to be booted. </p>
</li>
<li><p><em>metadata</em> - csapi:Metadata</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Metadata key and value pairs. The maximum size of the metadata key and value is 255 bytes each. (See <a href="#ServerMetadata"> Server Metadata </a> .</p>
</li>
<li><p><em>personality</em> - csapi:Personality</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">File path and contents to inject into the rebuilt server. The maximum size of the file path data is 255 bytes. The maxPersonality limit restricts the number of files that can be injected. The maxPersonalitySize limit restricts the maximum number of bytes for the decoded file contents. (See <a href="#FileInjection"> File Injection </a> .) </p>
</li>
<li><p><em>password</em> - None</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Not supported. </p>
</li>
<li><p><em>accessIPv4</em> - None</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Not supported</p>
</li>
<li><p><em>accessIPv6</em> - None</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Not supported</p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;rebuild imageRef="120" name="server-name-2" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;metadata&gt;
        
                    
        &lt;meta key="key-1"&gt;value-1&lt;/meta&gt;
        
                
    &lt;/metadata&gt;
    
            
&lt;/rebuild&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "rebuild": {
        "imageRef": 120,
        "metadata": {
            "key-1": "value-1"
        },
        "name": "server-name-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 202

**Response Headers**

<ul>
<li><p><em>Location</em> (required) - xsd:anyURI</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Specific URL of the server you want to rebuild. </p>
</li>
</ul>
XML

<div>
<pre><code>&lt;server accessIPv4="" accessIPv6="" adminPass="JAQ7ZQHYeoZQcc6V" created="2012-10-03T05:25:28Z" hostId="d30bd4bdb4cd3cdb87c7b4b8b5d9d3bbedf06878821c8338b4ddb474" id="233693" name="server-name-2" status="ACTIVE(rebuilding)" tenantId="36991859863737" updated="2012-10-23T15:56:56Z" userId="13311562627589" uuid="f632dbea-e9bc-4c71-a893-6bdc3696a5ca" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233693" rel="self"/&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233693" rel="bookmark"/&gt;
    &lt;image id="120"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/&gt;
    &lt;/image&gt;
    &lt;flavor id="100"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;metadata&gt;
        &lt;meta key="key-1"&gt;
            value-1
        &lt;/meta&gt;
    &lt;/metadata&gt;
    &lt;addresses&gt;
        &lt;network id="private"&gt;
            &lt;ip addr="10.2.90.88" version="4"/&gt;
            &lt;ip addr="15.185.229.18" version="4"/&gt;
        &lt;/network&gt;
    &lt;/addresses&gt;
    &lt;security_groups&gt;
        &lt;security_group id="12091" name="default"&gt;
            &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/12091" rel="bookmark"/&gt;
        &lt;/security_group&gt;
    &lt;/security_groups&gt;
&lt;/server&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "server": {
        "accessIPv4": "",
        "accessIPv6": "",
        "addresses": {
            "private": [
                {
                    "addr": "10.2.90.87",
                    "version": 4
                },
                {
                    "addr": "15.185.228.245",
                    "version": 4
                }
            ]
        },
        "adminPass": "fvm5PpDqWvgqEbpJ",
        "config_drive": "1",
        "created": "2012-10-03T05:25:25Z",
        "flavor": {
            "id": "100",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100",
                    "rel": "bookmark"
                }
            ]
        },
        "hostId": "1164541596facce55e8c0572e5f248dba31243d83471e77e62d1722e",
        "id": 233691,
        "image": {
            "id": "120",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120",
                    "rel": "bookmark"
                }
            ]
        },
        "key_name": "key.pub",
        "links": [
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691",
                "rel": "self"
            },
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233691",
                "rel": "bookmark"
            }
        ],
        "metadata": {
            "key-1": "value-1"
        },
        "name": "server-name-1",
        "status": "ACTIVE(rebuilding)",
        "tenant_id": "36991859863737",
        "updated": "2012-10-23T15:56:55Z",
        "user_id": "13311562627589",
        "uuid": "d1d5e151-2fed-4522-9e94-aae0ef3d5db0"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_e733642e6e1e0eabea392c76ca4228a9adb63fce719b351f8c925d8caaa37ecc" -d '{"rebuild": {"name": "server-name-1", "imageRef": 120, "metadata": {"key-1": "value-1"}}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'
</code></pre>
</div>


#### <a id="createImage"></a>4.4.7.3 Create Image
#### POST v1.1/{tenant_id}/servers/{server_id}/action


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Creates a new image. Specify the
                    <code>createImage</code> action in the request body. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>metadata</em> - csapi:Metadata</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Metadata key and value pairs. The maximum size of the metadata key and value is 255 bytes each. (See <a href="#ImageMetadata"> Image Metadata </a> .</p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;createImage name="image-1" xmlns="http://docs.openstack.org/compute/api/v1.1"/&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "createImage": {
        "metadata": {
            "key-1": "value-1",
            "key-2": "value-2"
        },
        "name": "image-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 202

**Response Headers**

<ul>
<li><p><em>Location</em> (required) - xsd:anyURI</p>
</li>
</ul>
######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_9b8591392fee0485651d33b11b71178e2b189cfda73bb9fa8eeb9a62411e40cd" -d '{"createImage": {"name": "image-1", "metadata": {"key-2": "value-2", "key-1": "value-1"}}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'
</code></pre>
</div>


#### <a id="getConsoleOutput"></a>4.4.7.4 Get Console Output.
#### POST v1.1/{tenant_id}/servers/{server_id}/action


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">
                Get the console output for a server instance.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server id. This parameter can be an integer id or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>length</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Number of lines to fetch from end of console log. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;os-getConsoleOutput&gt;
    
                
    &lt;length&gt;50&lt;/length&gt;
    
            
&lt;/os-getConsoleOutput&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "os-getConsoleOutput": {
        "length": 50
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;output&gt;
    +-----------------+

K ]


done

Generation complete.

ec2: 

ec2: #############################################################

ec2: -----BEGIN SSH HOST KEY FINGERPRINTS-----

ec2: 1024 aa:65:72:c4:14:21:c0:55:f5:ca:d9:5c:6d:c4:0a:9a  root@server-name-1 (DSA)

ec2: 256 09:ac:c1:16:17:c7:95:d1:d3:c6:08:3f:62:09:41:e0  root@server-name-1 (ECDSA)

ec2: 2048 bb:e5:83:0c:33:68:ce:41:54:71:2a:bb:a1:f4:7f:02  root@server-name-1 (RSA)

ec2: -----END SSH HOST KEY FINGERPRINTS-----

ec2: #############################################################

-----BEGIN SSH HOST KEY KEYS-----

ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNTQhRzXVzfKlI17lvUCp8siJ6xmelvFZpHCfIl70ttZKkuogxSGiKA/CiQyMFuF6m1JS8fodt4KbtxqEnX3ik4= root@server-name-1

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8l9I1q9IlGg7hnXSRFUyeT8Ui8jbbVdHQi586WPraS6QzBsQaTljtlWSVRAiFqyzKXTwVwuAU/R23qzBpRTNMK+ACOBkvgraKHRz9YiyS7py7acz3bSq7cnncv2TWTgHZlSLMaye0ggGOsoa7GAwX2Tx2iKtd9mYgWVxv9MfAyx1SbUiMMteZsC65GmRrYOCq3N6ZjpMwfqkHxClKwdBjZbfbCypUDJ1XkqaWMhu/gb/70AWmkfu1lVBZQrWywFzv5qb8dGeuSvMkP1813+vyjnjXtLHG1iNJgbR6TbtlN2IiQtZhA+fmhXRtRVxuD+Knh7fzT0XK6eeh2/HyabnP root@server-name-1

-----END SSH HOST KEY KEYS-----

cloud-init boot finished at Wed, 03 Oct 2012 05:26:53 +0000. Up 61.47 seconds


&lt;/output&gt;
K ]


Generating locales...


  en_US.UTF-8...  * Stopping System V runlevel compatibility
K ]


 * Stopping save kernel messages
K ]


 * Starting crash report submission daemon
K ]


 * Starting CPU interrupts balancing daemon
K ]


 * Starting save kernel messages
K ]


 * Starting ACPI daemon
K ]


 * Starting regular background program processing daemon
K ]


 * Starting deferred execution scheduler
K ]


 * Starting automatic crash report generation
K ]


 * Starting System V runlevel compatibility
K ]


landscape-client is not configured, please run landscape-config.


 * Stopping System V initialisation compatibility
K ]


Skipping profile in /etc/apparmor.d/disable: usr.sbin.rsyslogd


 * Starting AppArmor profiles       

Generating public/private ecdsa key pair.


Your identification has been saved in /etc/ssh/ssh_host_ecdsa_key.


Your public key has been saved in /etc/ssh/ssh_host_ecdsa_key.pub.


The key fingerprint is:


09:ac:c1:16:17:c7:95:d1:d3:c6:08:3f:62:09:41:e0 root@server-name-1


The key's randomart image is:


+--[ECDSA  256]---+


|    . +==o+= +   |


|   . = ....o+ +  |


|    + E   + oo   |


|   . o . o . .   |


|    .   S        |


|                 |


|                 |


|                 |


|                 |


+-----------------+


 * Starting system logging daemon
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "output": "+-----------------+\r\r\nGenerating public/private ecdsa key pair.\r\r\nYour identification has been saved in /etc/ssh/ssh_host_ecdsa_key.\r\r\nYour public key has been saved in /etc/ssh/ssh_host_ecdsa_key.pub.\r\r\nThe key fingerprint is:\r\r\n09:ac:c1:16:17:c7:95:d1:d3:c6:08:3f:62:09:41:e0 root@server-name-1\r\r\nThe key's randomart image is:\r\r\n+--[ECDSA  256]---+\r\r\n|    . +==o+= +   |\r\r\n|   . = ....o+ +  |\r\r\n|    + E   + oo   |\r\r\n|   . o . o . .   |\r\r\n|    .   S        |\r\r\n|                 |\r\r\n|                 |\r\r\n|                 |\r\r\n|                 |\r\r\n+-----------------+\r\r\n * Starting system logging daemon\u001b[74G[ OK ]\r\r\nSkipping profile in /etc/apparmor.d/disable: usr.sbin.rsyslogd\r\r\n * Starting AppArmor profiles       \u001b[80G \r\u001b[74G[ OK ]\r\r\nlandscape-client is not configured, please run landscape-config.\r\r\n * Stopping System V initialisation compatibility\u001b[74G[ OK ]\r\r\n * Starting System V runlevel compatibility\u001b[74G[ OK ]\r\r\n * Starting automatic crash report generation\u001b[74G[ OK ]\r\r\n * Starting deferred execution scheduler\u001b[74G[ OK ]\r\r\n * Starting regular background program processing daemon\u001b[74G[ OK ]\r\r\n * Starting ACPI daemon\u001b[74G[ OK ]\r\r\n * Starting save kernel messages\u001b[74G[ OK ]\r\r\n * Starting CPU interrupts balancing daemon\u001b[74G[ OK ]\r\r\n * Starting crash report submission daemon\u001b[74G[ OK ]\r\r\n * Stopping save kernel messages\u001b[74G[ OK ]\r\r\nGenerating locales...\r\r\n  en_US.UTF-8...  * Stopping System V runlevel compatibility\u001b[74G[ OK ]\r\r\ndone\r\nGeneration complete.\r\nec2: \r\nec2: #############################################################\r\nec2: -----BEGIN SSH HOST KEY FINGERPRINTS-----\r\nec2: 1024 aa:65:72:c4:14:21:c0:55:f5:ca:d9:5c:6d:c4:0a:9a  root@server-name-1 (DSA)\r\nec2: 256 09:ac:c1:16:17:c7:95:d1:d3:c6:08:3f:62:09:41:e0  root@server-name-1 (ECDSA)\r\nec2: 2048 bb:e5:83:0c:33:68:ce:41:54:71:2a:bb:a1:f4:7f:02  root@server-name-1 (RSA)\r\nec2: -----END SSH HOST KEY FINGERPRINTS-----\r\nec2: #############################################################\r\n-----BEGIN SSH HOST KEY KEYS-----\r\necdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNTQhRzXVzfKlI17lvUCp8siJ6xmelvFZpHCfIl70ttZKkuogxSGiKA/CiQyMFuF6m1JS8fodt4KbtxqEnX3ik4= root@server-name-1\r\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8l9I1q9IlGg7hnXSRFUyeT8Ui8jbbVdHQi586WPraS6QzBsQaTljtlWSVRAiFqyzKXTwVwuAU/R23qzBpRTNMK+ACOBkvgraKHRz9YiyS7py7acz3bSq7cnncv2TWTgHZlSLMaye0ggGOsoa7GAwX2Tx2iKtd9mYgWVxv9MfAyx1SbUiMMteZsC65GmRrYOCq3N6ZjpMwfqkHxClKwdBjZbfbCypUDJ1XkqaWMhu/gb/70AWmkfu1lVBZQrWywFzv5qb8dGeuSvMkP1813+vyjnjXtLHG1iNJgbR6TbtlN2IiQtZhA+fmhXRtRVxuD+Knh7fzT0XK6eeh2/HyabnP root@server-name-1\r\n-----END SSH HOST KEY KEYS-----\r\ncloud-init boot finished at Wed, 03 Oct 2012 05:26:53 +0000. Up 61.47 seconds\r\n"
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" -d '{"os-getConsoleOutput": {"length": 50}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'
</code></pre>
</div>


#### <a id="addFloatingIp"></a>4.4.7.5 Add Floating Ip
#### POST v1.1/{tenant_id}/servers/{server_id}/action


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> 
                Adds the specified floating IP to the server. The floating IP must have been previously allocated
                with <em>Allocate Floating Ip</em>.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>address</em> (required) - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The address to add to the server. This address must have been previously allocated with <em>Allocate Floating Ip</em>. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;addFloatingIp xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;address&gt;
        15.185.230.99
    &lt;/address&gt;
    
            
&lt;/addFloatingIp&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "addFloatingIp": {
        "address": "15.185.230.113"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 202

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_7aed0967e43782329ed5a40536f0d88203b23ecc1a6ea4c09338986b5193b9ab" -d '{"addFloatingIp": {"address": "15.185.230.113"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'
</code></pre>
</div>


#### <a id="removeFloatingIp"></a>4.4.7.6 Remove Floating Ip
#### POST v1.1/{tenant_id}/servers/{server_id}/action


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">
                Removes the specified floating IP from the server. Only floating IPs which have been explicitly
                added to the server using <em>Add Floating Ip</em> can be removed.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>address</em> (required) - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The address to be removed from the server. This address must have previously been added to the server using <em>Add Floating Ip</em> </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;removeFloatingIp xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;address&gt;
        15.185.230.99
    &lt;/address&gt;
    
            
&lt;/removeFloatingIp&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "removeFloatingIp": {
        "address": "15.185.230.113"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 202

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_7aed0967e43782329ed5a40536f0d88203b23ecc1a6ea4c09338986b5193b9ab" -d '{"removeFloatingIp": {"address": "15.185.230.113"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'
</code></pre>
</div>


#### <a id="addSecurityGroup"></a>4.4.7.7 Add Security Group
#### POST v1.1/{tenant_id}/servers/{server_id}/action


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> 
                Adds a security group to the list of security groups that are associated with the server.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> (required) - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The name of the security group to add.</p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;addSecurityGroup xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;name&gt;security-group-2&lt;/name&gt;
    
            
&lt;/addSecurityGroup&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "addSecurityGroup": {
        "name": "security-group-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 202

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_320eb8cc5998143e6e9fcf0e8fcaecaa8d161f1ec03f18b8de31e1b48b24f280" -d '{"addSecurityGroup": {"name": "security-group-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'
</code></pre>
</div>


#### <a id="removeSecurityGroup"></a>4.4.7.8 Remove Security Group
#### POST v1.1/{tenant_id}/servers/{server_id}/action


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">
                Removes a security group from the list of security groups that are associated with the server. 
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> (required) - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The name of the security group to remove.</p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;removeSecurityGroup xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;name&gt;security-group-2&lt;/name&gt;
    
            
&lt;/removeSecurityGroup&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "removeSecurityGroup": {
        "name": "security-group-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 202

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_320eb8cc5998143e6e9fcf0e8fcaecaa8d161f1ec03f18b8de31e1b48b24f280" -d '{"removeSecurityGroup": {"name": "security-group-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'
</code></pre>
</div>


### <a id="ServerMetadata"></a>4.4.8 Server Metadata


#### <a id="ServerMetadata_listMetadata"></a>4.4.8.1 List Metadata
#### GET v1.1/{tenant_id}/servers/{server_id}/metadata


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Lists metadata associated with the resource.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;metadata xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;&lt;meta key="key-2"&gt;value-2&lt;/meta&gt;&lt;meta key="key-1"&gt;value-1&lt;/meta&gt;&lt;/metadata&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "metadata": {
        "key-1": "value-1",
        "key-2": "value-2"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/metadata'
</code></pre>
</div>


#### <a id="ServerMetadata_updateMetadata"></a>4.4.8.2 Update Metadata
#### POST v1.1/{tenant_id}/servers/{server_id}/metadata


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Updates resource metadata. Updates will replace
                existing metadata items with the same key. Items not explicitly mentioned in the
                request will not be modified. An overLimit (<errorcode>413</errorcode>) fault may be
                thrown if the operation causes the maximum number of metadata items to be exceeded.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>metadata</em> - csapi:Metadata</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A set of key/value pairs. These pair replace any existing key/value pairs in the resources metadata with matching keys. Any key/value pairs in the parameter with keys that do not occur in the existing resource metadata are added to the resources metadata. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;metadata xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;meta key="key-1"&gt;value-1&lt;/meta&gt;
    
                
    &lt;meta key="key-2"&gt;value-2&lt;/meta&gt;
    
            
&lt;/metadata&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "metadata": {
        "key-1": "value-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;metadata xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;&lt;meta key="key-2"&gt;value-2&lt;/meta&gt;&lt;meta key="key-1"&gt;value-1&lt;/meta&gt;&lt;/metadata&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "metadata": {
        "key-1": "value-1"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"metadata": {"key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/metadata'
</code></pre>
</div>


#### <a id="ServerMetadata_setMetadata"></a>4.4.8.3 Create or Replace Metadata
#### PUT v1.1/{tenant_id}/servers/{server_id}/metadata


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The metadata items set on the resource are those
                specified on the requests. Existing metadata items are replaced with the ones
                provided in the request. Metadata items, set previously, but not specified in the
                request are removed. </p>
            


<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> An overLimit (<errorcode>413</errorcode>) fault
                may be thrown if the maximum number of metadata items is exceeded. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>metadata</em> - csapi:Metadata</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A set of key/value pairs. These pair replace any existing key/value pairs in the resources metadata with matching keys. Any key/value pairs in the parameter with keys that do not occur in the existing resource metadata are added to the resources metadata. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;metadata xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;meta key="key-1"&gt;value-1&lt;/meta&gt;
    
                
    &lt;meta key="key-2"&gt;value-2&lt;/meta&gt;
    
            
&lt;/metadata&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "metadata": {
        "key-1": "value-1",
        "key-2": "value-2"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;metadata xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;&lt;meta key="key-2"&gt;value-2&lt;/meta&gt;&lt;meta key="key-1"&gt;value-1&lt;/meta&gt;&lt;/metadata&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "metadata": {
        "key-1": "value-1",
        "key-2": "value-2"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"metadata": {"key-2": "value-2", "key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/metadata'
</code></pre>
</div>


### <a id="ServerMetadataItem"></a>4.4.9 Server Metadata Item


#### <a id="ServerMetadataItem_getMetadataItem"></a>4.4.9.1 Get Metadata Item
#### GET v1.1/{tenant_id}/servers/{server_id}/metadata/{key}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Retrieves a single metadata item by key. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;value-1&lt;/meta&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "meta": {
        "key-1": "value-1"
    }
}</code></pre>
</div>


#### <a id="ServerMetadataItem_setMetadataItem"></a>4.4.9.2 Create or Update Metadata Item
#### PUT v1.1/{tenant_id}/servers/{server_id}/metadata/{key}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Sets a metadata item by its key. An overLimit
                    (<errorcode>413</errorcode>) fault may be thrown if the operation causes the
                maximum number of metadata items to be exceeded. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;value-1&lt;/meta&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "meta": {
        "key-1": "value-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;value-1&lt;/meta&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "meta": {
        "key-1": "value-1"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"meta": {"key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/metadata/key-1'
</code></pre>
</div>


#### <a id="ServerMetadataItem_deleteMetadataItem"></a>4.4.9.3 Delete Metadata Item
#### DELETE v1.1/{tenant_id}/servers/{server_id}/metadata/{key}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Deletes a metadata item. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 204

######Example(s)

<div>
<pre><code>curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/metadata/key-1'
</code></pre>
</div>


### <a id="Images"></a>4.4.10 Images


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A list of images. Each image contains IDs,
                names, and links -- other attributes are omitted. </p>
        



#### <a id="listImages"></a>4.4.10.1 List Images
#### GET v1.1/{tenant_id}/images


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Lists IDs, names, and links for images
                available to the account. Query parameters can be used to filter the list of images.</p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>server</em> - xsd:anyURI</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of images returned by server. The <em>server</em> parameter specifies the server to filter by in URL format using the servers UUID.</p>
</li>
<li><p><em>name</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of images returned by image <em>name</em>.</p>
</li>
<li><p><em>status</em> - csapi:ImageStatus</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Filters the list of images returned by image <em>status</em>. Possible values for the status attribute include: UNKNOWN, ACTIVE, SAVING, ERROR, and DELETED. Images with an ACTIVE status can be used to boot a server. In-flight images will have the status attribute set to SAVING.</p>
</li>
<li><p><em>type</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Filters the list of images returned by image type. Currently the only allowable value of type is SNAPSHOT which will return a list of all the images that were created with the server action Create Image. </p>
<p>Legal values are:<ul>
<li><em>SNAPSHOT</em>  - Return only images that were created by the server action Create Server.
</li>
</ul></p>
</li>
<li><p><em>changes-since</em> - xsd:dateTime</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of images returned to those that have changed since the <em>changes-since</em> time. See <a href="#Polling"> Efficient Polling with the <em>Changes-Since</em> Parameter </a> .</p>
</li>
<li><p><em>marker</em> - csapi:UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The UUID of the last item in the previous list. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
<li><p><em>limit</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Sets the page size to <em>limit</em>. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;images xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;image id="34971" name="CentOS 5.8 Server 64-bit 20120828"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/34971" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/34971" rel="bookmark"/&gt;
    &lt;/image&gt;
    &lt;image id="120" name="Ubuntu Precise 12.04 LTS Server 64-bit 20120424"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/120" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/&gt;
    &lt;/image&gt;
&lt;/images&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "images": [
       {
            "id": "34971",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/34971",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/34971",
                    "rel": "bookmark"
                }
            ],
            "name": "CentOS 5.8 Server 64-bit 20120828"
        },
        {
            "id": "120",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/120",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120",
                    "rel": "bookmark"
                }
            ],
            "name": "Ubuntu Precise 12.04 LTS Server 64-bit 20120424"
        }
    ]
}
</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images'
</code></pre>
</div>


#### <a id="listDetailImages"></a>4.4.10.2 List Images Detail
#### GET v1.1/{tenant_id}/images/detail


            

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>server</em> - xsd:anyURI</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of images returned by server. The <em>server</em> parameter specifies the server to filter by in URL format using the servers UUID.</p>
</li>
<li><p><em>name</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of images returned by image <em>name</em>.</p>
</li>
<li><p><em>status</em> - csapi:ImageStatus</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Filters the list of images returned by image <em>status</em>. Possible values for the status attribute include: UNKNOWN, ACTIVE, SAVING, ERROR, and DELETED. Images with an ACTIVE status can be used to boot a server. In-flight images will have the status attribute set to SAVING.</p>
</li>
<li><p><em>type</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Filters the list of images returned by image type. Currently the only allowable value of type is SNAPSHOT which will return a list of all the images that were created with the server action Create Image. </p>
<p>Legal values are:<ul>
<li><em>SNAPSHOT</em>  - Return only images that were created by the server action Create Server.
</li>
</ul></p>
</li>
<li><p><em>changes-since</em> - xsd:dateTime</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of images returned to those that have changed since the <em>changes-since</em> time. See <a href="#Polling"> Efficient Polling with the <em>Changes-Since</em> Parameter </a> .</p>
</li>
<li><p><em>marker</em> - csapi:UUID</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The UUID of the last item in the previous list. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
<li><p><em>limit</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Sets the page size to <em>limit</em>. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;images xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;image created="2012-09-04T16:45:17Z" id="34971" name="CentOS 5.8 Server 64-bit 20120828" progress="100" status="ACTIVE" updated="2012-09-04T16:45:22Z"&gt;
        &lt;metadata&gt;
            &lt;meta key="hp_image_type"&gt;
                disk
            &lt;/meta&gt;
            &lt;meta key="image_location"&gt;
                local
            &lt;/meta&gt;
            &lt;meta key="image_state"&gt;
                available
            &lt;/meta&gt;
            &lt;meta key="project_id"&gt;
                None
            &lt;/meta&gt;
            &lt;meta key="hp_md_version"&gt;
                1
            &lt;/meta&gt;
            &lt;meta key="min_ram"&gt;
                0
            &lt;/meta&gt;
            &lt;meta key="hp_image_id"&gt;
                e66bad1137c6d519fc5c6fb175e45b71
            &lt;/meta&gt;
            &lt;meta key="owner"&gt;
                None
            &lt;/meta&gt;
            &lt;meta key="hp_image_builddate"&gt;
                20120828
            &lt;/meta&gt;
            &lt;meta key="architecture"&gt;
                x86_64
            &lt;/meta&gt;
            &lt;meta key="min_disk"&gt;
                0
            &lt;/meta&gt;
            &lt;meta key="hp_image_version"&gt;
                20120828
            &lt;/meta&gt;
        &lt;/metadata&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/34971" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/34971" rel="bookmark"/&gt;
    &lt;/image&gt;
    &lt;image created="2012-05-07T04:54:46Z" id="120" name="Ubuntu Precise 12.04 LTS Server 64-bit 20120424" progress="100" status="ACTIVE" updated="2012-05-07T04:54:51Z"&gt;
        &lt;metadata&gt;
            &lt;meta key="hp_image_type"&gt;
                disk
            &lt;/meta&gt;
            &lt;meta key="image_location"&gt;
                local
            &lt;/meta&gt;
            &lt;meta key="image_state"&gt;
                available
            &lt;/meta&gt;
            &lt;meta key="project_id"&gt;
                None
            &lt;/meta&gt;
            &lt;meta key="hp_md_version"&gt;
                1
            &lt;/meta&gt;
            &lt;meta key="min_ram"&gt;
                0
            &lt;/meta&gt;
            &lt;meta key="hp_image_id"&gt;
                df4256e6c361380cb7613c74130feca9
            &lt;/meta&gt;
            &lt;meta key="owner"&gt;
                None
            &lt;/meta&gt;
            &lt;meta key="hp_image_builddate"&gt;
                20120424
            &lt;/meta&gt;
            &lt;meta key="architecture"&gt;
                amd64
            &lt;/meta&gt;
            &lt;meta key="min_disk"&gt;
                0
            &lt;/meta&gt;
            &lt;meta key="hp_image_version"&gt;
                20120424
            &lt;/meta&gt;
        &lt;/metadata&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/120" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/&gt;
    &lt;/image&gt;
&lt;/images&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "images": [
        {
            "created": "2012-09-04T16:45:17Z",
            "id": "34971",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/34971",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/34971",
                    "rel": "bookmark"
                }
            ],
            "metadata": {
                "architecture": "x86_64",
                "hp_image_builddate": "20120828",
                "hp_image_id": "e66bad1137c6d519fc5c6fb175e45b71",
                "hp_image_type": "disk",
                "hp_image_version": "20120828",
                "hp_md_version": "1",
                "image_location": "local",
                "image_state": "available",
                "min_disk": 0,
                "min_ram": 0,
                "owner": null,
                "project_id": "None"
            },
            "name": "CentOS 5.8 Server 64-bit 20120828",
            "progress": 100,
            "status": "ACTIVE",
            "updated": "2012-09-04T16:45:22Z"
        },
        {
            "created": "2012-05-07T04:54:46Z",
            "id": "120",
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/120",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120",
                    "rel": "bookmark"
                }
            ],
            "metadata": {
                "architecture": "amd64",
                "hp_image_builddate": "20120424",
                "hp_image_id": "df4256e6c361380cb7613c74130feca9",
                "hp_image_type": "disk",
                "hp_image_version": "20120424",
                "hp_md_version": "1",
                "image_location": "local",
                "image_state": "available",
                "min_disk": 0,
                "min_ram": 0,
                "owner": null,
                "project_id": "None"
            },
            "name": "Ubuntu Precise 12.04 LTS Server 64-bit 20120424",
            "progress": 100,
            "status": "ACTIVE",
            "updated": "2012-05-07T04:54:51Z"
        }
    ]
}
</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/detail'
</code></pre>
</div>


### <a id="Image"></a>4.4.11 Image


#### <a id="getImage"></a>4.4.11.1 Get Image Details
#### GET v1.1/{tenant_id}/images/{image_id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Returns detailed informatin about the specified image. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Image ID. This ID is local to an Availability Zone</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;image created="2012-10-03T04:46:42Z" id="40747" name="image-1" progress="100" status="ACTIVE" updated="2012-10-03T04:48:25Z" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;metadata&gt;
        &lt;meta key="owner"&gt;
            36991859863737
        &lt;/meta&gt;
        &lt;meta key="min_disk"&gt;
            0
        &lt;/meta&gt;
        &lt;meta key="min_ram"&gt;
            0
        &lt;/meta&gt;
        &lt;meta key="key_1"&gt;
            value-1,value-1,value-1,value-1,value-1
        &lt;/meta&gt;
        &lt;meta key="key_2"&gt;
            value-2
        &lt;/meta&gt;
    &lt;/metadata&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747" rel="self"/&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/40747" rel="bookmark"/&gt;
&lt;/image&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "image": {
        "created": "2012-10-03T04:46:42Z",
        "id": "40747",
        "links": [
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747",
                "rel": "self"
            },
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/40747",
                "rel": "bookmark"
            }
        ],
        "metadata": {
            "key_1": "value-1,value-1,value-1,value-1,value-1",
            "key_2": "value-2",
            "min_disk": "0",
            "min_ram": "0",
            "owner": "36991859863737"
        },
        "name": "image-1",
        "progress": 100,
        "status": "ACTIVE",
        "updated": "2012-10-03T04:48:25Z"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747'
</code></pre>
</div>


#### <a id="deleteImage"></a>4.4.11.2 Delete Image
#### DELETE v1.1/{tenant_id}/images/{image_id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Deletes the specified image. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Image ID. This ID is local to an Availability Zone</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 204

######Example(s)

<div>
<pre><code>curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40737'
</code></pre>
</div>


### <a id="ImageMetadata"></a>4.4.12 Image Metadata


#### <a id="ImageMetadata_listMetadata"></a>4.4.12.1 List Metadata
#### GET v1.1/{tenant_id}/images/{image_id}/metadata


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Lists metadata associated with the resource.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Image ID. This ID is local to an Availability Zone</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;metadata xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;&lt;meta key="key-2"&gt;value-2&lt;/meta&gt;&lt;meta key="key-1"&gt;value-1&lt;/meta&gt;&lt;/metadata&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "metadata": {
        "key-1": "value-1",
        "key-2": "value-2"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747/metadata'
</code></pre>
</div>


#### <a id="ImageMetadata_updateMetadata"></a>4.4.12.2 Update Metadata
#### POST v1.1/{tenant_id}/images/{image_id}/metadata


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Updates resource metadata. Updates will replace
                existing metadata items with the same key. Items not explicitly mentioned in the
                request will not be modified. An overLimit (<errorcode>413</errorcode>) fault may be
                thrown if the operation causes the maximum number of metadata items to be exceeded.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Image ID. This ID is local to an Availability Zone</p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>metadata</em> - csapi:Metadata</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A set of key/value pairs. These pair replace any existing key/value pairs in the resources metadata with matching keys. Any key/value pairs in the parameter with keys that do not occur in the existing resource metadata are added to the resources metadata. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;metadata xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;meta key="key-1"&gt;value-1&lt;/meta&gt;
    
                
    &lt;meta key="key-2"&gt;value-2&lt;/meta&gt;
    
            
&lt;/metadata&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "metadata": {
        "key-1": "value-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;metadata xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;&lt;meta key="key-2"&gt;value-2&lt;/meta&gt;&lt;meta key="key-1"&gt;value-1&lt;/meta&gt;&lt;/metadata&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "metadata": {
        "key-1": "value-1"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" -d '{"metadata": {"key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/30161/metadata'
</code></pre>
</div>


#### <a id="ImageMetadata_setMetadata"></a>4.4.12.3 Create or Replace Metadata
#### PUT v1.1/{tenant_id}/images/{image_id}/metadata


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The metadata items set on the resource are those
                specified on the requests. Existing metadata items are replaced with the ones
                provided in the request. Metadata items, set previously, but not specified in the
                request are removed. </p>
            


<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> An overLimit (<errorcode>413</errorcode>) fault
                may be thrown if the maximum number of metadata items is exceeded. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Image ID. This ID is local to an Availability Zone</p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>metadata</em> - csapi:Metadata</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A set of key/value pairs. These pair replace any existing key/value pairs in the resources metadata with matching keys. Any key/value pairs in the parameter with keys that do not occur in the existing resource metadata are added to the resources metadata. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;metadata xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;meta key="key-1"&gt;value-1&lt;/meta&gt;
    
                
    &lt;meta key="key-2"&gt;value-2&lt;/meta&gt;
    
            
&lt;/metadata&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "metadata": {
        "key-1": "value-1",
        "key-2": "value-2"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;metadata xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;&lt;meta key="key-2"&gt;value-2&lt;/meta&gt;&lt;meta key="key-1"&gt;value-1&lt;/meta&gt;&lt;/metadata&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "metadata": {
        "key-1": "value-1",
        "key-2": "value-2"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" -d '{"metadata": {"key-2": "value-2", "key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747/metadata'
</code></pre>
</div>


### <a id="ImageMetadataItem"></a>4.4.13 Image Metadata Item


#### <a id="ImageMetadataItem_getMetadataItem"></a>4.4.13.1 Get Metadata Item
#### GET v1.1/{tenant_id}/images/{image_id}/metadata/{key}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Retrieves a single metadata item by key. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Image ID. This ID is local to an Availability Zone</p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;value-1&lt;/meta&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "meta": {
        "key-1": "value-1"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747/metadata/key_1'
</code></pre>
</div>


#### <a id="ImageMetadataItem_setMetadataItem"></a>4.4.13.2 Create or Update Metadata Item
#### PUT v1.1/{tenant_id}/images/{image_id}/metadata/{key}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Sets a metadata item by its key. An overLimit
                    (<errorcode>413</errorcode>) fault may be thrown if the operation causes the
                maximum number of metadata items to be exceeded. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Image ID. This ID is local to an Availability Zone</p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;value-1&lt;/meta&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "meta": {
        "key-1": "value-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;value-1&lt;/meta&gt;</code></pre>
</div>

JSON

<div>
<pre><code>{
    "meta": {
        "key-1": "value-1"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"meta": {"key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747/metadata/key-1'
</code></pre>
</div>


#### <a id="ImageMetadataItem_deleteMetadataItem"></a>4.4.13.3 Delete Metadata Item
#### DELETE v1.1/{tenant_id}/images/{image_id}/metadata/{key}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Deletes a metadata item. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Image ID. This ID is local to an Availability Zone</p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 204

######Example(s)

<div>
<pre><code>curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_e733642e6e1e0eabea392c76ca4228a9adb63fce719b351f8c925d8caaa37ecc" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747/metadata/key_1'
</code></pre>
</div>


### <a id="Flavors"></a>4.4.14 Flavors


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> A list of flavors. Each flavor contains IDs,
                names, and links -- other attributes are omitted. </p>
        



#### <a id="listFlavors"></a>4.4.14.1 List Flavors
#### GET v1.1/{tenant_id}/flavors


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Lists IDs, names, and links for available
                flavors. 
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>minDisk</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of flavors returned to include only those with at least <em>minDisk</em> gigabytes of disk storage.</p>
</li>
<li><p><em>minRam</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of flavors returned to include only those with at least <em>minRam</em> megabytes of RAM.</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;flavors xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;flavor id="100" name="standard.xsmall"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/100" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;flavor id="101" name="standard.small"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/101" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/101" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;flavor id="105" name="standard.2xlarge"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/105" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/105" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;flavor id="103" name="standard.large"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/103" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/103" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;flavor id="102" name="standard.medium"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/102" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/102" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;flavor id="104" name="standard.xlarge"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/104" rel="bookmark"/&gt;
    &lt;/flavor&gt;
&lt;/flavors&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "flavors": [
        {
            "id": 100,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/100",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.xsmall"
        },
        {
            "id": 101,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/101",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/101",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.small"
        },
        {
            "id": 105,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/105",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/105",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.2xlarge"
        },
        {
            "id": 103,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/103",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/103",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.large"
        },
        {
            "id": 102,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/102",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/102",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.medium"
        },
        {
            "id": 104,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/104",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.xlarge"
        }
    ]
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors'
</code></pre>
</div>


#### <a id="listDetailFlavors"></a>4.4.14.2 List Flavors Detail
#### GET v1.1/{tenant_id}/flavors/detail


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Lists all details for available flavors. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>minDisk</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of flavors returned to include only those with at least <em>minDisk</em> gigabytes of disk storage.</p>
</li>
<li><p><em>minRam</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Filters the list of flavors returned to include only those with at least <em>minRam</em> megabytes of RAM.</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;flavors xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;flavor id="100" name="standard.xsmall"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/100" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;flavor id="101" name="standard.small"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/101" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/101" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;flavor id="105" name="standard.2xlarge"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/105" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/105" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;flavor id="103" name="standard.large"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/103" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/103" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;flavor id="102" name="standard.medium"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/102" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/102" rel="bookmark"/&gt;
    &lt;/flavor&gt;
    &lt;flavor id="104" name="standard.xlarge"&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104" rel="self"/&gt;
        &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/104" rel="bookmark"/&gt;
    &lt;/flavor&gt;
&lt;/flavors&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "flavors": [
        {
            "id": 100,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/100",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.xsmall"
        },
        {
            "id": 101,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/101",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/101",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.small"
        },
        {
            "id": 105,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/105",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/105",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.2xlarge"
        },
        {
            "id": 103,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/103",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/103",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.large"
        },
        {
            "id": 102,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/102",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/102",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.medium"
        },
        {
            "id": 104,
            "links": [
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104",
                    "rel": "self"
                },
                {
                    "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/104",
                    "rel": "bookmark"
                }
            ],
            "name": "standard.xlarge"
        }
    ]
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors'
</code></pre>
</div>


### <a id="Flavor"></a>4.4.15 Flavor


#### <a id="getFlavor"></a>4.4.15.1 Get Flavor Details
#### GET v1.1/{tenant_id}/flavors/{flavor_id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Lists details for the specified flavor. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>flavor_id</em> - xsd.int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Flavor ID. This ID is local to the Availability Zone. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

<div>
<pre><code>&lt;flavor disk="480" id="104" name="standard.xlarge" ram="16384" rxtx_cap="0" rxtx_quota="0" swap="0" vcpus="4" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104" rel="self"/&gt;
    &lt;atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/104" rel="bookmark"/&gt;
&lt;/flavor&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "flavor": {
        "disk": 480,
        "id": 104,
        "links": [
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104",
                "rel": "self"
            },
            {
                "href": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/104",
                "rel": "bookmark"
            }
        ],
        "name": "standard.xlarge",
        "ram": 16384,
        "rxtx_cap": 0,
        "rxtx_quota": 0,
        "swap": 0,
        "vcpus": 4
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104'
</code></pre>
</div>


### <a id="floating-ips"></a>4.4.16 Floating Ips


#### <a id="listFloatingIPs"></a>4.4.16.1 List Floating IPs
#### GET v1.1/{tenant_id}/os-floating-ips


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Lists floating IP addresses associated with the
                tenant or account.</p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

JSON

<div>
<pre><code>{
    "floating_ips": [
        {
            "fixed_ip": null,
            "id": 980,
            "instance_id": null,
            "ip": "15.185.227.211"
        },
        {
            "fixed_ip": null,
            "id": 1146,
            "instance_id": null,
            "ip": "15.185.228.121"
        }
    ]
}</code></pre>
</div>

XML

<div>
<pre><code>&lt;floating_ips xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;floating_ip&gt;
        &lt;instance_id&gt;
            None
        &lt;/instance_id&gt;
        &lt;ip&gt;
            15.185.227.211
        &lt;/ip&gt;
        &lt;fixed_ip&gt;
            None
        &lt;/fixed_ip&gt;
        &lt;id&gt;
            980
        &lt;/id&gt;
    &lt;/floating_ip&gt;
    &lt;floating_ip&gt;
        &lt;instance_id&gt;
            None
        &lt;/instance_id&gt;
        &lt;ip&gt;
            15.185.228.121
        &lt;/ip&gt;
        &lt;fixed_ip&gt;
            None
        &lt;/fixed_ip&gt;
        &lt;id&gt;
            1146
        &lt;/id&gt;
    &lt;/floating_ip&gt;
&lt;/floating_ips&gt;
</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-floating-ips'
</code></pre>
</div>


#### <a id="allocateFloatingIP"></a>4.4.16.2 Allocate Floating IP
#### POST v1.1/{tenant_id}/os-floating-ips


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Allocate a new floating IP address to a tenant
                or account.</p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

JSON

<div>
<pre><code>{
    "floating_ip": {
        "fixed_ip": null,
        "id": 980,
        "instance_id": null,
        "ip": "15.185.227.211"
    }
}</code></pre>
</div>

XML

<div>
<pre><code>&lt;floating_ip xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;instance_id&gt;
        None
    &lt;/instance_id&gt;
    &lt;ip&gt;
        15.185.228.121
    &lt;/ip&gt;
    &lt;fixed_ip&gt;
        None
    &lt;/fixed_ip&gt;
    &lt;id&gt;
        1146
    &lt;/id&gt;
&lt;/floating_ip&gt;
</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"pool": "pool-name"}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-floating-ips'
</code></pre>
</div>


### <a id="floating-ip"></a>4.4.17 Floating IP


#### <a id="getFloatingIP"></a>4.4.17.1 Get Floating Ip
#### GET v1.1/{tenant_id}/os-floating-ips/{id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Get information about the specified floating
                IP.</p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>id</em> (required) - None</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The unique identifier associated with allocated floating IP address. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;floating_ip xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;instance_id&gt;
        None
    &lt;/instance_id&gt;
    &lt;ip&gt;
        15.185.228.121
    &lt;/ip&gt;
    &lt;fixed_ip&gt;
        None
    &lt;/fixed_ip&gt;
    &lt;id&gt;
        1146
    &lt;/id&gt;
&lt;/floating_ip&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "floating_ip": {
        "fixed_ip": null,
        "id": 1146,
        "instance_id": null,
        "ip": "15.185.228.121"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-floating-ips/1146'
</code></pre>
</div>


#### <a id="deallocateFloatingIP"></a>4.4.17.2 Deallocate Floating IP
#### DELETE v1.1/{tenant_id}/os-floating-ips/{id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Deallocates the floating IP address associated
                with floating_IP_address_ID.</p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>id</em> (required) - None</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The unique identifier associated with allocated floating IP address. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 202

######Example(s)

<div>
<pre><code>curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_320eb8cc5998143e6e9fcf0e8fcaecaa8d161f1ec03f18b8de31e1b48b24f280" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-floating-ips/1677'
</code></pre>
</div>


### <a id="os-keypairs"></a>4.4.18 Keypairs


#### <a id="listKeypairs"></a>4.4.18.1 List Keypairs
#### GET v1.1/{tenant_id}/os-keypairs


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Lists keypairs associated with the tenant or
                account. Returns the name, public key and fingerprint of each keypair associated
                with the account. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;keypairs xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;keypair&gt;
        &lt;keypair&gt;
            &lt;public_key&gt;
                ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRhFDIz1RJDgUW2tTRTZpJpbJyQbrUy586balui6Hj3g5I0Qogw42SRXr4EpM8S26M28OsfI3nfxPXQnJz41oUxutBrxaOo0wySinWE7imaDL7i4YE7pj8X3tPTDNzmmPI/VWheS97GwZcTdl3sI/wy4Fm/DOqU/DhpxmgfhKyOuhI65dNRglJN1RqQ6jc8i2egqAU5ZvDL1D9lBYjsKwwFtQXRU80DncbPdVtAITeR9X4CGsHKqTSAMbELfa4NZyX0y3AgYvJq9DpK1ySc5Y0f+iTuqvQvdsB69uTB8/n24ThV9GpiguashYlrWKcBKIxNcpEdg+Tla0zOPVro16x roland.hochmuth@hp.com
            &lt;/public_key&gt;
            &lt;name&gt;
                hochmuth.pub
            &lt;/name&gt;
            &lt;fingerprint&gt;
                57:64:ca:c3:83:25:69:19:03:6f:d2:66:83:d6:6e:20
            &lt;/fingerprint&gt;
        &lt;/keypair&gt;
    &lt;/keypair&gt;
    &lt;keypair&gt;
        &lt;keypair&gt;
            &lt;public_key&gt;
                ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRhFDIz1RJDgUW2tTRTZpJpbJyQbrUy586balui6Hj3g5I0Qogw42SRXr4EpM8S26M28OsfI3nfxPXQnJz41oUxutBrxaOo0wySinWE7imaDL7i4YE7pj8X3tPTDNzmmPI/VWheS97GwZcTdl3sI/wy4Fm/DOqU/DhpxmgfhKyOuhI65dNRglJN1RqQ6jc8i2egqAU5ZvDL1D9lBYjsKwwFtQXRU80DncbPdVtAITeR9X4CGsHKqTSAMbELfa4NZyX0y3AgYvJq9DpK1ySc5Y0f+iTuqvQvdsB69uTB8/n24ThV9GpiguashYlrWKcBKIxNcpEdg+Tla0zOPVro16x roland.hochmuth@hp.com

            &lt;/public_key&gt;
            &lt;name&gt;
                key.pub
            &lt;/name&gt;
            &lt;fingerprint&gt;
                57:64:ca:c3:83:25:69:19:03:6f:d2:66:83:d6:6e:20
            &lt;/fingerprint&gt;
        &lt;/keypair&gt;
    &lt;/keypair&gt;
    &lt;keypair&gt;
        &lt;keypair&gt;
            &lt;public_key&gt;
                ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjoclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSrnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2w== 

            &lt;/public_key&gt;
            &lt;name&gt;
                keypair-1
            &lt;/name&gt;
            &lt;fingerprint&gt;
                d3:e3:5f:26:dc:30:fc:04:57:91:ba:c0:1c:f8:8d:cd
            &lt;/fingerprint&gt;
        &lt;/keypair&gt;
    &lt;/keypair&gt;
    &lt;keypair&gt;
        &lt;keypair&gt;
            &lt;public_key&gt;
                ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDZcOCJGRF2REub4+j5Y6LnF7Lk4xyvpdeqAEZYRJe8lC0YOhkF9PxOAQnSgRuAvcmFiff9E1Dt9yLCSlU40zRClLEMwchG4S51y4JI/mbMwppWKYxgPnIa9rHSIccEtZbhBU1MkwpUHeRcZE+b60y5xXiYSmVacmtwDZ89qf6TvQ== 

            &lt;/public_key&gt;
            &lt;name&gt;
                keypair-2
            &lt;/name&gt;
            &lt;fingerprint&gt;
                76:e3:b7:ca:95:91:fb:86:f7:fe:5d:d4:11:4d:77:65
            &lt;/fingerprint&gt;
        &lt;/keypair&gt;
    &lt;/keypair&gt;
&lt;/keypairs&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "keypairs": [
        {
            "keypair": {
                "fingerprint": "57:64:ca:c3:83:25:69:19:03:6f:d2:66:83:d6:6e:20",
                "name": "hochmuth.pub",
                "public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRhFDIz1RJDgUW2tTRTZpJpbJyQbrUy586balui6Hj3g5I0Qogw42SRXr4EpM8S26M28OsfI3nfxPXQnJz41oUxutBrxaOo0wySinWE7imaDL7i4YE7pj8X3tPTDNzmmPI/VWheS97GwZcTdl3sI/wy4Fm/DOqU/DhpxmgfhKyOuhI65dNRglJN1RqQ6jc8i2egqAU5ZvDL1D9lBYjsKwwFtQXRU80DncbPdVtAITeR9X4CGsHKqTSAMbELfa4NZyX0y3AgYvJq9DpK1ySc5Y0f+iTuqvQvdsB69uTB8/n24ThV9GpiguashYlrWKcBKIxNcpEdg+Tla0zOPVro16x roland.hochmuth@hp.com"
            }
        },
        {
            "keypair": {
                "fingerprint": "57:64:ca:c3:83:25:69:19:03:6f:d2:66:83:d6:6e:20",
                "name": "key.pub",
                "public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRhFDIz1RJDgUW2tTRTZpJpbJyQbrUy586balui6Hj3g5I0Qogw42SRXr4EpM8S26M28OsfI3nfxPXQnJz41oUxutBrxaOo0wySinWE7imaDL7i4YE7pj8X3tPTDNzmmPI/VWheS97GwZcTdl3sI/wy4Fm/DOqU/DhpxmgfhKyOuhI65dNRglJN1RqQ6jc8i2egqAU5ZvDL1D9lBYjsKwwFtQXRU80DncbPdVtAITeR9X4CGsHKqTSAMbELfa4NZyX0y3AgYvJq9DpK1ySc5Y0f+iTuqvQvdsB69uTB8/n24ThV9GpiguashYlrWKcBKIxNcpEdg+Tla0zOPVro16x roland.hochmuth@hp.com\n"
            }
        },
        {
            "keypair": {
                "fingerprint": "d3:e3:5f:26:dc:30:fc:04:57:91:ba:c0:1c:f8:8d:cd",
                "name": "keypair-1",
                "public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjoclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSrnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2w== \n"
            }
        },
        {
            "keypair": {
                "fingerprint": "76:e3:b7:ca:95:91:fb:86:f7:fe:5d:d4:11:4d:77:65",
                "name": "keypair-2",
                "public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDZcOCJGRF2REub4+j5Y6LnF7Lk4xyvpdeqAEZYRJe8lC0YOhkF9PxOAQnSgRuAvcmFiff9E1Dt9yLCSlU40zRClLEMwchG4S51y4JI/mbMwppWKYxgPnIa9rHSIccEtZbhBU1MkwpUHeRcZE+b60y5xXiYSmVacmtwDZ89qf6TvQ== \n"
            }
        }
    ]
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-keypairs'
</code></pre>
</div>


#### <a id="createKeypair"></a>4.4.18.2 Create Keypair
#### POST v1.1/{tenant_id}/os-keypairs


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Generate or import a keypair. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> (required) - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The <em>name</em> to be associated with the keypair. </p>
</li>
<li><p><em>public_key</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The ssh <em>public_key</em> to import. If not provided, a keypair will be generated and both the public and private keys are returned to the user. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;keypair&gt;
    
                
    &lt;name&gt;keypair-2&lt;/name&gt;
    
            
&lt;/keypair&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "keypair": {
        "name": "keypair-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;keypair xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;public_key&gt;
        ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDZcOCJGRF2REub4+j5Y6LnF7Lk4xyvpdeqAEZYRJe8lC0YOhkF9PxOAQnSgRuAvcmFiff9E1Dt9yLCSlU40zRClLEMwchG4S51y4JI/mbMwppWKYxgPnIa9rHSIccEtZbhBU1MkwpUHeRcZE+b60y5xXiYSmVacmtwDZ89qf6TvQ== 

    &lt;/public_key&gt;
    &lt;private_key&gt;
        -----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQDZcOCJGRF2REub4+j5Y6LnF7Lk4xyvpdeqAEZYRJe8lC0YOhkF
9PxOAQnSgRuAvcmFiff9E1Dt9yLCSlU40zRClLEMwchG4S51y4JI/mbMwppWKYxg
PnIa9rHSIccEtZbhBU1MkwpUHeRcZE+b60y5xXiYSmVacmtwDZ89qf6TvQIDAQAB
AoGACJA2d4/CLUsxQxltsmynHLzFMdhz58L7RFmwa4eABlA7mmmnVKG6UgQec+jb
wW04A4dUeeYJ2OVTvB0bUBqZQzdpHDb0wAu+y/LiQJ1cIvpLhXF7NSCmqjfLPHYQ
KQEeTEaixl6gBenrgenPW+t2QDKsyL3mAnUU+9yYiWAJDg0CQQD1BWWgkp4t8Hk/
l4JViymp4FCY9Vyp6h4uzO9Q7kKQiJk2ApeJHlShlw7VLaJJ/wJhj2P2881CaYPs
zn5LcBR3AkEA4y8cqLOgHvlhQJ1ceC6fYkX/6TKtGo10ptHqhczZbQj8CbUiNAmA
iFxlVRToyUI+lrI2vOdAHFMpXiwZ3qmqawJBANsqGa5Yl26mI/5Syn0z/m96Ov2m
s101EgxwuTvd8uKPnOPny54V6EOl99mNeRXRKVMUzKjviNF3yk5+og9eUJ8CQFwT
wifV9bXYGUSZAttq+gpYmKopceNrJbZfKhBkwFLi61P76ArzNvcNi7x6Jwc7JCbr
wCe8Ck3wnrmeYjXOylUCQQDqwdYfAlkoWjxtJ8GfxmFteIQOUVopoLS4opRTNafw
Naws/HNm7BwTeXRI+XgnFaIB+yxVMmzmh0/qRVEPEC/P
-----END RSA PRIVATE KEY-----

    &lt;/private_key&gt;
    &lt;user_id&gt;
        13311562627589
    &lt;/user_id&gt;
    &lt;name&gt;
        keypair-2
    &lt;/name&gt;
    &lt;fingerprint&gt;
        76:e3:b7:ca:95:91:fb:86:f7:fe:5d:d4:11:4d:77:65
    &lt;/fingerprint&gt;
&lt;/keypair&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "keypair": {
        "fingerprint": "d3:e3:5f:26:dc:30:fc:04:57:91:ba:c0:1c:f8:8d:cd",
        "name": "keypair-1",
        "private_key": "-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjo\nclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSr\nnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2wIDAQAB\nAoGAae+pgF8mWFKXliZ8Xv128BusfNAnuvEuOehFbWoqrdsr5q1a5ZUnte6TDq5A\nKFctoMA8GzkI9up2YrAp9cJOc+qYwNakMq1IQ/psxH7uga3Ey8aa3sTjUFK+rxMW\nZF5swcatcKiu7TzEgg5vcmfQr4r+547cihhWBKApEknt56ECQQDPEOq+aYhtthzg\ngisuYsOlB4bUpLTJUNZDLeO9UM7R5sIELblmOIfvoyqCY8bU4ZiPvMdFfkcajCva\nk51TIjcFAkEAxznWHyUfJEud5k2nJ8UUIAzDFv4YQEL25halw8tkl6bXxqnQ1Z44\njTVDAdsaIi9fVz8/0hQYDBlks41g6XZ6XwJBAK5uadGNxUfmqdzWytmAiZ9z/7kS\nJtmQJ27gMYFBmXhpE/fBLPVXmevdX+oHc2/Ru1sahCOehPdwLWEsCNQHdqECQGEg\nulp+z5rzXqzcKOVDuNcTQb2g7ZPO0e5FFlXJgGZLCiGpws2SkMGPOPbbqfcGn3W6\nuVOjRkIH00eSYrAPegMCQBpXlXHyLLNzmvnqQtSuC+efX90wcvsVPd1ytT7EHTSX\nv4gpK7hK3EyKStTsaADbYNjlh/mrMU2Q8Zlu7ybUI2Q=\n-----END RSA PRIVATE KEY-----\n",
        "public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjoclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSrnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2w== \n",
        "user_id": "13311562627589"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"keypair": {"name": "keypair-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-keypairs'
</code></pre>
</div>


### <a id="Unknown"></a>4.4.19 Keypair


#### <a id="getKeypair"></a>4.4.19.1 Get Keypair
#### GET v1.1/{tenant_id}/os-keypairs/{keypair_name}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Get the public key and fingerprint for the
                specified keypair. </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>keypair_name</em> (required) - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The name associated with a keypair. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;keypair xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;public_key&gt;
        ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjoclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSrnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2w== 

    &lt;/public_key&gt;
    &lt;name&gt;
        keypair-1
    &lt;/name&gt;
    &lt;fingerprint&gt;
        d3:e3:5f:26:dc:30:fc:04:57:91:ba:c0:1c:f8:8d:cd
    &lt;/fingerprint&gt;
&lt;/keypair&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "keypair": {
        "fingerprint": "d3:e3:5f:26:dc:30:fc:04:57:91:ba:c0:1c:f8:8d:cd",
        "name": "keypair-1",
        "public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjoclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSrnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2w== \n"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-keypairs/keypair-1'
</code></pre>
</div>


#### <a id="deleteKeypair"></a>4.4.19.2 Delete Keypair
#### DELETE v1.1/{tenant_id}/os-keypairs/{keypair_name}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Delete the specified keypair.</p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>keypair_name</em> (required) - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The name associated with a keypair. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 202

######Example(s)

<div>
<pre><code>curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-keypairs/keypair-1'
</code></pre>
</div>


### <a id="security_groups"></a>4.4.20 Security Groups


#### <a id="listSecGroups"></a>4.4.20.1 List Security Groups
#### GET v1.1/{tenant_id}/os-security-groups


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">List security groups.</p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;security_groups xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;security_group id="12091" name="default" tenant_id="36991859863737"&gt;
        &lt;rules&gt;
            &lt;rule id="31701" parent_group_id="12091"&gt;
                &lt;from_port&gt;
                    22
                &lt;/from_port&gt;
                &lt;group/&gt;
                &lt;ip_protocol&gt;
                    tcp
                &lt;/ip_protocol&gt;
                &lt;to_port&gt;
                    22
                &lt;/to_port&gt;
                &lt;ip_range&gt;
                    &lt;cidr&gt;
                        0.0.0.0/0
                    &lt;/cidr&gt;
                &lt;/ip_range&gt;
            &lt;/rule&gt;
            &lt;rule id="31703" parent_group_id="12091"&gt;
                &lt;from_port&gt;
                    -1
                &lt;/from_port&gt;
                &lt;group/&gt;
                &lt;ip_protocol&gt;
                    icmp
                &lt;/ip_protocol&gt;
                &lt;to_port&gt;
                    -1
                &lt;/to_port&gt;
                &lt;ip_range&gt;
                    &lt;cidr&gt;
                        0.0.0.0/0
                    &lt;/cidr&gt;
                &lt;/ip_range&gt;
            &lt;/rule&gt;
            &lt;rule id="31705" parent_group_id="12091"&gt;
                &lt;from_port&gt;
                    None
                &lt;/from_port&gt;
                &lt;group&gt;
                    &lt;tenant_id&gt;
                        36991859863737
                    &lt;/tenant_id&gt;
                    &lt;name&gt;
                        default
                    &lt;/name&gt;
                &lt;/group&gt;
                &lt;ip_protocol&gt;
                    None
                &lt;/ip_protocol&gt;
                &lt;to_port&gt;
                    None
                &lt;/to_port&gt;
                &lt;ip_range/&gt;
            &lt;/rule&gt;
        &lt;/rules&gt;
        &lt;description&gt;
            default
        &lt;/description&gt;
    &lt;/security_group&gt;
    &lt;security_group id="14703" name="security-group" tenant_id="36991859863737"&gt;
        &lt;rules/&gt;
        &lt;description&gt;
            A security group
        &lt;/description&gt;
    &lt;/security_group&gt;
    &lt;security_group id="17753" name="security-group-1" tenant_id="36991859863737"&gt;
        &lt;rules/&gt;
        &lt;description&gt;
            Security group 1
        &lt;/description&gt;
    &lt;/security_group&gt;
    &lt;security_group id="17755" name="security-group-2" tenant_id="36991859863737"&gt;
        &lt;rules/&gt;
        &lt;description&gt;
            Security group 2
        &lt;/description&gt;
    &lt;/security_group&gt;
&lt;/security_groups&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "security_groups": [
        {
            "description": "default",
            "id": 12091,
            "name": "default",
            "rules": [
                {
                    "from_port": 22,
                    "group": {},
                    "id": 31701,
                    "ip_protocol": "tcp",
                    "ip_range": {
                        "cidr": "0.0.0.0/0"
                    },
                    "parent_group_id": 12091,
                    "to_port": 22
                },
                {
                    "from_port": -1,
                    "group": {},
                    "id": 31703,
                    "ip_protocol": "icmp",
                    "ip_range": {
                        "cidr": "0.0.0.0/0"
                    },
                    "parent_group_id": 12091,
                    "to_port": -1
                },
                {
                    "from_port": null,
                    "group": {
                        "name": "default",
                        "tenant_id": "36991859863737"
                    },
                    "id": 31705,
                    "ip_protocol": null,
                    "ip_range": {},
                    "parent_group_id": 12091,
                    "to_port": null
                }
            ],
            "tenant_id": "36991859863737"
        },
        {
            "description": "A security group",
            "id": 14703,
            "name": "security-group",
            "rules": [],
            "tenant_id": "36991859863737"
        },
        {
            "description": "Security group 1",
            "id": 17753,
            "name": "security-group-1",
            "rules": [],
            "tenant_id": "36991859863737"
        },
        {
            "description": "Security group 2",
            "id": 17755,
            "name": "security-group-2",
            "rules": [],
            "tenant_id": "36991859863737"
        }
    ]
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups'
</code></pre>
</div>


#### <a id="createSecGroup"></a>4.4.20.2 Create Security Group
#### POST v1.1/{tenant_id}/os-security-groups


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">
                Create a new security group.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Name of the security group. </p>
</li>
<li><p><em>description</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Description of the security group. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;security_group name="security-group-2"&gt;
    
                
    &lt;description&gt;
                    Security group 2
                &lt;/description&gt;
    
            
&lt;/security_group&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "security_group": {
        "description": "Security group 1",
        "name": "security-group-1"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;security_group id="17755" name="security-group-2" tenant_id="36991859863737" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;rules/&gt;
    &lt;description&gt;
        Security group 2
    &lt;/description&gt;
&lt;/security_group&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "security_group": {
        "description": "Security group 1",
        "id": 17753,
        "name": "security-group-1",
        "rules": [],
        "tenant_id": "36991859863737"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"security_group": {"name": "security-group-1", "description": "Security group 1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups'
</code></pre>
</div>


### <a id="security_group"></a>4.4.21 Security group


#### <a id="getSecGroup"></a>4.4.21.1 Get Security Group
#### GET v1.1/{tenant_id}/os-security-groups/{security_group_id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">
                Get specified security group.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>security_group_id</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The unique identifier of the security group. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;security_group id="17965" name="security-group-1" tenant_id="36991859863737" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;rules&gt;
        &lt;rule id="42941" parent_group_id="17965"&gt;
            &lt;from_port&gt;
                80
            &lt;/from_port&gt;
            &lt;group/&gt;
            &lt;ip_protocol&gt;
                tcp
            &lt;/ip_protocol&gt;
            &lt;to_port&gt;
                8080
            &lt;/to_port&gt;
            &lt;ip_range&gt;
                &lt;cidr&gt;
                    0.0.0.0/0
                &lt;/cidr&gt;
            &lt;/ip_range&gt;
        &lt;/rule&gt;
    &lt;/rules&gt;
    &lt;description&gt;
        Security group 1
    &lt;/description&gt;
&lt;/security_group&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "security_group": {
        "description": "Security group 1",
        "id": 17965,
        "name": "security-group-1",
        "rules": [
            {
                "from_port": 80,
                "group": {},
                "id": 42941,
                "ip_protocol": "tcp",
                "ip_range": {
                    "cidr": "0.0.0.0/0"
                },
                "parent_group_id": 17965,
                "to_port": 8080
            }
        ],
        "tenant_id": "36991859863737"
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_9b8591392fee0485651d33b11b71178e2b189cfda73bb9fa8eeb9a62411e40cd" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/17965'
</code></pre>
</div>


#### <a id="deleteSecGroup"></a>4.4.21.2 Delete Security Group
#### DELETE v1.1/{tenant_id}/os-security-groups/{security_group_id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">Delete a security group.</p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>security_group_id</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The unique identifier of the security group. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 202

######Example(s)

<div>
<pre><code>curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/17865'
</code></pre>
</div>


### <a id="security_group_rules"></a>4.4.22 Security Group Rules


#### <a id="createSecGroupRule"></a>4.4.22.1 Create Security Group Rule
#### POST v1.1/{tenant_id}/os-security-group-rules


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">
                Create a security group rule. Security group rules specify the traffic that is allowed
                through to the server. For a packet to be delivered, it must meet all the criteria established by the
                rule.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>parent_group_id</em> (required) - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> ID of the security group to which this rule will belong. </p>
</li>
<li><p><em>ip_protocol</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Packets using <em>ip_protocol</em> are delivered to the server. If <em>ip_protocol</em> is specified, then <em>from_port</em> and <em>to_port</em> must also be specified. If <em>ip_protocol</em> is omitted, traffic is delivered without regard to protocol. </p>
<p>Legal values are:<ul>
<li><em>TCP</em> 
</li>
<li><em>UDP</em> 
</li>
<li><em>ICMP</em> 
</li>
</ul></p>
</li>
<li><p><em>from_port</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> For TCP and UDP packets, traffic to ports between <em>from_port</em> and <em>to_port</em> are delivered to the server. <em>from_port</em> must be &gt;= <em>to_port</em>. For ICMP packets, <em>from_port</em> specifies the ICMP type of the packets that will be accepted. If <em>from_port</em> is specified, then <em>to_port</em> and <em>ip_protocol</em> must also be specified. </p>
</li>
<li><p><em>to_port</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> For TCP and UDP packets, traffic to ports between <em>from_port</em> and <em>to_port</em> are delivered to the server. <em>from_port</em> must be &gt;= <em>to_port</em>. For ICMP packets, <em>from_port</em> specifies the ICMP type of the packets that will be accepted. If <em>from_port</em> is specified, then <em>to_port</em> and <em>ip_protocol</em> must also be specified. </p>
</li>
<li><p><em>cidr</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Traffic from source with an IP address in the range specified by <em>cidr</em> will be accepted. Exactly one of <em>cidr</em> and <em>group_id</em> must be specified. </p>
</li>
<li><p><em>group_id</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> Traffic from all servers associated with the security group specified by <em>group_id</em> will be accepted. Exactly one of <em>cidr</em> and <em>group_id</em> must be specified. </p>
</li>
</ul>
######Request

XML

<div>
<pre><code>&lt;?xml version="1.0" ?&gt;
&lt;security_group_rule xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    
                
    &lt;parent_group_id&gt;17963&lt;/parent_group_id&gt;
    
                
    &lt;from_port&gt;80&lt;/from_port&gt;
    
                
    &lt;ip_protocol&gt;tcp&lt;/ip_protocol&gt;
    
                
    &lt;to_port&gt;8080&lt;/to_port&gt;
    
                
    &lt;cidr&gt;0.0.0.0/0&lt;/cidr&gt;
    
            
&lt;/security_group_rule&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "security_group_rule": {
        "cidr": "0.0.0.0/0",
        "from_port": "80",
        "ip_protocol": "tcp",
        "parent_group_id": "17965",
        "to_port": "8080"
    }
}</code></pre>
</div>

######Response

**Status Code(s)** 200

XML

<div>
<pre><code>&lt;security_group_rule id="45003" parent_group_id="17963" xmlns="http://docs.openstack.org/compute/api/v1.1"&gt;
    &lt;from_port&gt;
        80
    &lt;/from_port&gt;
    &lt;group/&gt;
    &lt;ip_protocol&gt;
        tcp
    &lt;/ip_protocol&gt;
    &lt;to_port&gt;
        8080
    &lt;/to_port&gt;
    &lt;ip_range&gt;
        &lt;cidr&gt;
            0.0.0.0/0
        &lt;/cidr&gt;
    &lt;/ip_range&gt;
&lt;/security_group_rule&gt;
</code></pre>
</div>

JSON

<div>
<pre><code>{
    "security_group_rule": {
        "from_port": 80,
        "group": {},
        "id": 45001,
        "ip_protocol": "tcp",
        "ip_range": {
            "cidr": "0.0.0.0/0"
        },
        "parent_group_id": 17965,
        "to_port": 8080
    }
}</code></pre>
</div>

######Example(s)

<div>
<pre><code>curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_320eb8cc5998143e6e9fcf0e8fcaecaa8d161f1ec03f18b8de31e1b48b24f280" -d '{"security_group_rule": {"to_port": "8080", "cidr": "0.0.0.0/0", "from_port": "80", "parent_group_id": "17965", "ip_protocol": "tcp"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-group-rules'
</code></pre>
</div>


### <a id="security_group_rule"></a>4.4.23 Security Group Rule


#### <a id="deleteSecGroupRule"></a>4.4.23.1 Delete Security Group Rule
#### DELETE v1.1/{tenant_id}/os-security-group-rules/{security_group_rule_id}


            

<p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">
              Delete security group rule.
            </p>
            


**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom">The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>security_group_rule_id</em> - xsd:int</p><p xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:db="http://docbook.org/ns/docbook" xmlns:csapi="http://docs.openstack.org/compute/api/v2" xmlns:xsdxt="http://docs.rackspacecloud.com/xsd-ext/v1.0" xmlns:hpcloud="http://hpcloud.com/ns/apispec/v1.0" xmlns:common="http://docs.openstack.org/common/api/v1.0" xmlns:wadl="http://wadl.dev.java.net/2009/02" xmlns:atom="http://www.w3.org/2005/Atom"> The unique identifier of the security group rule. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 202

######Example(s)

<div>
<pre><code>curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/17865'
</code></pre>
</div>



# 5. Additional References

1. [OpenStack API Documentation](http://api.openstack.org)
2. [OpenStack Compute Developer Guide - API v2](http://docs.openstack.org/api/openstack-compute/2/content/)

# 6. Glossary

**Server:** A server is a a virtual machine instance within HP Cloud Compute. See [Servers](#Servers).

**Flavor:** A set of attributes which describe the resources available to a server. See [Flavors](#Flavors).

**Image:** The contents of a disk. See [Images](#Images).

**Reboot:** Restart a server. See [Reboot Server](#rebootServer)

**Rebuild:** Reinitialize an existing server specifying a new image from which the server is to be booted. See [Rebuild Server](#rebuildServer).

**Resize:** Change the flavor of an existing image. This operation is not supported by HP Cloud Compute.
