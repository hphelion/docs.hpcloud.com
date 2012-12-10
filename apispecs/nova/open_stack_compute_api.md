---
layout: page
title: HP Cloud Compute Service API Reference
permalink: /api/compute/
description: This document describes the HP Cloud Compute Service. HP Cloud Compute is based on OpenStack Nova.
keywords: Compute, Nova, OpenStack

---

# HP Cloud Compute Service API Reference

**Date:**  November 28, 2012
**Document Version:** 1.0


# 1. Overview # {#Section1_}

This document describes the HP Cloud Compute Service. HP Cloud Compute is based on OpenStack Nova.

## 1.1 API Maturity Level ## {#Section1_1}

**Maturity Level**: HP Cloud Compute is currently in General Availability.

**Version API Status**: The HP Cloud Compute Service is based on OpenStack Nova v1.1 The OpenStack v1.0  Nova API is deprecated.

# 2. HP Cloud Compute Service # {#Section2_}

The HP Cloud Compute Service provides a scalable compute infrastructure on which users can run applications.
## 2.1 Servers ## {#Server}
A Server (also sometimes referred to as an instance) is the fundamental resource provided by HP Cloud Compute. A Server is a virtual machine capable of running a variety of operating system *image*s. The HP Cloud Compute API provided operations that allow users to control the life cycle of a server. The current status of a server is reported by the API as its *state*.  Characteristics of the server, such memory, amount of disk space, and number of CPUs are determined by the server's *flavor* which is specified at the time the server is created. A server is referred to by its *name*. Metadata can be associated with a server and accessed in a number of ways as described in the section [Personalizing a server](#Personalizing). These concepts are described further in the sections below.

### 2.1.1 Server Operations ### {#Section2_1_1}

The APIs support a number of operations that can be performed on servers. These include:

+ [Create Server](#createServer) - Create one or more VM instances.
+ [Update Server](#updateServer) - Allows update of editable attributes (display name) of an instance.
+ [Delete server](#deleteServer) - Terminates a server.
+ [Reboot Server](#rebootServer) - Reboots a server.
+ [Rebuild Server](#rebuildServer) - Restarts a server with a new image.
+ [Create Image](#createImage) - Create a snapshot of the server

For a complete list of server operations, see section 4.1, [Service API Operations](#ServiceAPIOperations).

The following operations are part of the OpenStack Nova V1.1 API, but are not supported by HP Cloud Compute: Change Administrator Password, Resize Server, Confirm Resized Server, Revert Resized Server

### 2.1.2 Flavors ### {#Flavors}
A flavor determines the primary characteristics of a server. It includes the amount of memory to be allocated to the server, the size of the disk to be created for ephemeral storage and the number of VCPUs to be allocated.
Flavors can be listed using the nova client flavor-list command as shown below. Also see the [List Flavors](#listFlavors) API method. 

    $ nova flavor-list
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
    

### 2.1.3 Server States ### {#ServerStates}
The state of a server is maintained in two values: the VM State and the Task State. The VM State is the state of the server as maintained by Nova.  The possible values for VM State are `ACTIVE, BUILD, REBUILD, STOPPED, MIGRATING, RESIZING, PAUSED, SUSPENDED, RESCUE, ERROR` and `DELETED`. A server is running when it is in the `ACTIVE` state. The Task State is essentially a sub-state of the VM State. The status of a server as returned by the Create Server and Get Server Details API is a combination of the VM State and the Task State.

The following shows the sequence of states that a newly created server goes through when a user invokes Create Server. The Task state is shown following the VM state in parentheses.

1. Create Server called
2. Nova-api creates database entry for new instance and sets state to `BUILD(scheduling)`.
3. The Nova scheduler selects compute a node on which to run the VM and sends it a request to create the VM.
4. The compute node sets state to `BUILD(networking)` and sets up networking.
5. The compute server sets the state to `BUILD(block_device_mapping)` and sets up volumes.
6. The compute server sets the state to `BUILD(spawning)` and calls the hypervisor to create the VM.
7. The VM starts and the state changes to `ACTIVE`.

The output of the nova list and nova show commands include the server status as shown below. The displayed server status includes the VM State and Task State described above. Note that the "Name" of the server shown by the commands is the "display name" of the instance as described in the [Server Names](#serverNames). 

    $ nova list
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
    | name            | webserver                                                |
    | private network | 10.4.134.153, 15.185.103.98                              |
    | progress        | 100                                                      |
    | security_groups | default                                                  |
    | status          | ACTIVE                                                   |
    | tenant_id       | 11692683195772                                           |
    | updated         | 2012-05-09T16:34:01Z                                     |
    | user_id         | 28187593996363                                           |
    | uuid            | abe5e3b6-fa6d-40d5-a9ba-c97db1b3db36                     |
    +-----------------+----------------------------------------------------------+
    

The [List Servers Detail](#listDetailServers) and [Get Server Details](#getServer) API operations include server status in the information they return.


### 2.1.4 Server Names ### {#serverNames}
There are four different ways to refer to a server using the OpenStack native API:

1. The Server is assigned an *id* when it is created. This is an integer and is guaranteed to be unique within the Availability Zone in which the server was created.
2. When it is created the server is also given a [UUID](http://en.wikipedia.org/wiki/Universally_unique_identifier) . With a high degree of confidence, this identifier will be unique across all Availability Zones.
3. The Server must also be given a "display name" when it is created using the OpenStack API. This is done by including the name in the request to create the server.  Note that the display name can be any string which includes an alphabetic character. This requirement prevents the display name from having the syntax of an *id*. The display names of all active servers are also required to be unique. (The exception to this rule is servers which are created with a single call to [Create Server](#createServer) specifying a value of *max_count* greater than 1. All servers created by a single call to [Create Server](#createServer) have the same display name.)
Servers which are created with the management console are automatically assigned display names of the form Server-&lt;time&gt;-az-1-region-a-geo-1 where time is the time in seconds since the Epoch on which the server was created (e.g., Server-1339537527-az-1-region-a-geo-1). This name is generated by the management console.
It is not possible to provide a display name for an instance when instances are created using the EC2 RunInstances API. When an instance is created with the RunInstances API, the server will be given a default display name of "Server &lt;id&gt;" where &lt;id&gt; is the id assigned to the server (see 1. above).
4. The EC2 API and euca2ools refer to instances using names which are an 8 digit hex value preceded by 'i-'. The hex value is the the server's id (number 1 above) with leading zeros. For example, the server with id 20 is displayed as i-00000014 by euca-describe-instanaces.

The first three of these values are reported in the output of the nova show command (see the sample output above).
The server's *id* and UUID are assigned to the server when it is created. These identifiers cannot be changed. The server's display name can be altered using the [Update Server](#updateServer) API operation.

The OpenStack API operations require that the server be identified using either its *id* or its UUID. The server's display name cannot be used in API operations. (Other than in the [Update Server](#updateServer) request mentioned above which is used to change the display name).

Nova client supports the use of the display name in commands, but this is not recommended as it may cause confusion when a display name is also a UUID.

### 2.1.5 Personalizing a server ### {#Personalizing}
A number of mechanisms exist which allow a user to retrieve information about a server and to associate meta-data with the server.

#### 2.1.5.1 Server Metadata #### {#ServerMetadata}

A server can have metadata in the form of key/value pairs. The initial value of a servers metadata is provided as a parameter to [Create Server](#createServer). Metadata provided when the server is created is available as a json object in the image's root filesystem at /meta.js. If the server has a [Configuration Drive](#ConfigurationDrive), the metadata will be in the file /meta.js at the root of the file system on the configuration drive. A server's metadata can also be retrieved and updated using the [Server Metadata](#ServerMetadata) and [Server Metadata Item](#ServerMetadataItem) resources. Updates to a server's metadata are only available using subsequent calls to [Server List Metadata](#ServerMetadata_listMetadata) and [Server Get Metadata Item](#ServerMetadataItem_getMetadataItem).

#### 2.1.5.2 EC2 Metadata #### {#EC2Metadata}
A server can retrieve system defined metadata by querying the interface `http://169.254.169.254/latest/metadata`. This interface is only available on a server and returns the available meta-data as shown below.

    ubuntu@nserver:~$ curl http://169.254.169.254/latest/meta-data
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
    

To get information about a specific meta-data item, just append the item to the url. For example, to get the server's hostname, use the URL `http://169.254.169.254/latest/meta-data/hostname`. Some meta-data is multivalued and is accessed by appending the path to the value desired to the URL. The example below gets public key `0` in the OpenSSH format.

    ubuntu@nserver:~$ curl http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key
    ssh-rsa AAAAB3 ... V1W4pVYcTTw==

It is also possible to provide additional meta-data at the time the server is created by supplying a Base64 encoded string as the *user_data* parameter to [Create Server](#createServer). This string can be retrieved using the URL `http://169.254.169.254/latest/meta-data/user-data`. All linux public images in the HP Cloud contain a package called CloudInit which can be used for early initialization of the instance from *user_data*.

#### 2.1.5.3 CloudInit #### {#Section2_1_5_3}
[CloudInit](https://help.ubuntu.com/community/CloudInit) is a set of scripts that are run when an image boots. These scripts are provided by an Ubuntu package that is installed  in the public Linux images provided by HP Cloud. (CloudInit is not supported for Windows images.) The scripts are controlled by a configuration which is described in [cloud-config](http://bazaar.launchpad.net/~cloud-init-dev/cloud-init/trunk/view/head:/doc/examples/cloud-config.txt). The configuration is the result of a merge of information from multiple sources including config files stored in the image, configuration parameters on the kernel command line, configuration information provided by Nova and configuration information provided by the user when creating the instance. In the HP Cloud, the latter two sources of information come from the EC2 metadata service which provides information, such as the hostname, determined by the environment along with *user_data* specified by the user at the time an instance is created.

The scripts that are run by CloudInit perform a number of different tasks including:

+ setting a default locale
+ setting hostname
+ generating ssh private keys
+ adding ssh keys to user's .ssh/authorized_keys so they can log in
+ setting up ephemeral mount points

As mentioned above, the behavior of CloudInit is determined by its configuration.  By default, it sets the locale to `en\_US.UTF-8`, sets the hostname to the value returned by the HP Cloud Compute EC2 metadata service, generates random ssh host keys, adds public-keys obtained from EC2 metadata to the ubuntu user's authorized keys and to root's authorized keys, and mounts `ephemeral0` on /mnt. The public-keys provided by EC2Metadata are just the public keys associated with the keypair(s) provided as a parameter to [Create Server](#createServer). Note that CloudInit is one of two mechanisms that add these ssh keys to authorized\_keys for the user root. The other is injection of the public key for a keypair whose name is provided as the *key_name* argument to [Create Server](#createServer). These mechanisms are independent of each other.

One of the tasks that CloudInit performs is to run user provided scripts when an instance is booted. These scripts are provided by the user at the time the instance is booted using the *user_data* argument to [Create Server](#createServer). For more information on the format of user_data see the [CloudInit - Community Ubuntu Documentation](https://help.ubuntu.com/community/CloudInit).

#### 2.1.5.4 File Injection #### {#FileInjection}
The [Create Server](#createServer) API has a parameter named *personality* which allows the specification of files to be injected into an image. For each file to be injected the file path in the root filesystem of the server being created is specified along with the base64 encoded contents of the file. The following json object is a the body of a Create Server request which includes a file to be injected.

    {
        "server" : {
            "name" : "new-server-test",
            "imageRef" : 5579,
            "flavorRef" : 100,
            "metadata" : {
                "My Server Name" : "Apache1"
            },
            "personality" : [.fotw
                {
                    "path" : "/etc/banner.txt",
                    "contents" : "ICAgICAgDQoiQSBjbG91ZCBkb2VzIG5vdCBrbm93IHdoeSBp dCBtb3ZlcyBpbiBqdXN0IHN1Y2ggYSBkaXJlY3Rpb24gYW5k IGF0IHN1Y2ggYSBzcGVlZC4uLkl0IGZlZWxzIGFuIGltcHVs c2lvbi4uLnRoaXMgaXMgdGhlIHBsYWNlIHRvIGdvIG5vdy4g QnV0IHRoZSBza3kga25vd3MgdGhlIHJlYXNvbnMgYW5kIHRo ZSBwYXR0ZXJucyBiZWhpbmQgYWxsIGNsb3VkcywgYW5kIHlv dSB3aWxsIGtub3csIHRvbywgd2hlbiB5b3UgbGlmdCB5b3Vy c2VsZiBoaWdoIGVub3VnaCB0byBzZWUgYmV5b25kIGhvcml6 b25zLiINCg0KLVJpY2hhcmQgQmFjaA=="
                } 
            ] 
        }
    }

The path must specify a directory in the root file system - otherwise the file will be ignored. For example, files cannot be injected in /tmp for the images provided by HP as /tmp is not in the root filesystem in these images. If a [Configuration Drive](#ConfigurationDrive) is created when the server is created, the path is relative to the file system on the configuration drive, rather than the root file system.

The *maxPersonality* quota limits the number of files which can be injected into a servers file system. The maximum size of the decoded file contents is restricted by the *maxPersonalitySize* quota.
The maximum length of the file path is limited to 255 bytes.

File injection is not supported for Windows images.

#### 2.1.5.5 Configuration Drive #### {#ConfigurationDrive}

A configuration drive is a disk contains a FAT filesystem with configuration data that is accessible to a server. The configuration drive is created at the same time the server is created by specifying the [Create Server](#createServer) parameter *config_drive* with a value of true. This will cause a configuration drive to be created and items that are normally injected into the root filesystem of the newly created server are injected into the configuration drive instead. The items that are written to the configuration drive are:

+ server metadata
+ injected file data
+ the user's ssh public key

The server metadata is just the metadata that is provided as the value *metadata* parameter to [Create Server](#createServer). The injected file data is provided as the *personality* parameter to [Create Server](#createServer). The user's public key is specified using the *key_name* parameter to [Create Server](#createServer). These values are normally injected into the servers root file system when it is created. When a configuration drive is specified, they are injected into the filesystem on the configuration drive instead. Note that it is still possible to login to a server created in this manner as long as the server image includes CloudInit, since CloudInit will properly initialize authorized\_keys with the user's public ssh\_key independently of the injection of this value into the image that takes place when the server is created.

It is also possible to provide an imageRef as the value of the *config_drive* parameter. However, this is not useful in the HP Cloud environment as all images are either HP publicly available images or snapshots, neither of which can be usefully used as a configuration drive.

Note that the configuration drive is an API extension in later versions of OpenStack Nova.

The configuration drive is not supported for servers running Windows images.

### 2.1.6 Images ### {#Images}
Servers are booted from disk images which are specified at the time the server is created. There are three different types of disk images: machine images, kernel images and ramdisk images. The machine image contains the root file system for the image. The kernel image is that image that is loaded when the server is launched and the ramdisk contains drivers used to boot the server. The latter two image types are optional. The machine image is always required, but the kernel and ramdisk may or may not be required depending on how the images were built.

The listing below shows the output of `nova image-list`. For kernel and ramdisk images, the image type is given in parentheses after the full image name for images provided by HP. Machine images do not include the image type in the image's name. Any image that is marked as `(deprecated)' should not be used.

    
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
    

Images may be public or private. Public images are provided by HP and are available to all users. Private images are created by taking a snapshot of the root file system of a running server using the [Create Image](#createImage) API method. Images have an attribute which distinguishes public images provided by HP from private images (snapshots) created by the user. A user can access all the public images and any private images he owns.

#### 2.1.6.1 Snapshots #### {#Section2_1_6_1}

Image snapshots are copies of the (virtual) disk partition containing the root file system that can be created from a running VM using [Create Image](#createImage). A snapshot is linked to the same kernel and ramdisk as the image which was originally booted on the VM.  In the listing above, foo100-snap and foo-snap are snapshots created by the user.

#### 2.1.6.2 Image Metadata #### {#ImageMetadata}
Images can have metadata in the form of key/value pairs. This metadata can be queried and modified using operations of the [Image Metadata](#ImageMetadata) and [Image Metadata Item](#ImageMetadataItem) resources.

## 2.2 Volumes ## {#Section2_2}
Nova volumes are persistent virtual images that can be attached to servers (similar to Amazon Elastic Block Store (EBS)). When attached to a server, the volume appears as a disk device on which a file system can be created. See XXX for more information on volumes.

## 2.3 Network ## {#Section2_3}

### 2.3.1 Network Model ### {#NetworkModel}

Each server gets both an internal and an external IPv4 address at the time it's created. 
Internal addresses are allocated in the 10.0.0.0/8 address range and can be used by other servers in the same Availability Zone to communicate with the server. All communication with and between servers takes place across a private network. This network is referred to as the "private" network in responses to HP Cloud Compute API operations. Broadcast and multicast between servers is not supported. Internal addresses are sometimes referred to as "fixed IPs".

External addresses in the 15.0.0.0/8 address range provide access to servers from the internet. 
A single external address is automatically assigned to each server when it is created. Servers can also be assigned one or more additional external addresses after being created. These addresses are referred to as "floating IPs" and are attached to a server using the [Add Floating Ip](#addFloatingIp) method. Floating IPs assigned to servers in this way must be allocated using [Allocate Floating Ip](#allocateFloatingIP). The total number of floating IPs that can be allocated to a project is limited by a per tenant quota. This quota can be retrieved using [List Limits](#listLimits).

Each server has a single (virtual) nic to which the server's internal address is bound using dhcp. External addresses are mapped to internal addresses using Network Address Translation. API operations which list the addresses by which a server may be accessed list both the internal and external addresses as belonging to the "private" network mentioned above.

### 2.3.2 Security Groups ### {#securityGroups}
Access to servers is controlled by security groups which are a collection of rules about which sources, protocols and ports a server can receive traffic from. No traffic can be received by a server unless a security group rule explicitly allows it.

The HP Cloud Compute service creates the default security group shown below when an account is activated.

    $ nova secgroup-list-rules default
    +-------------+-----------+---------+-----------+--------------+
    | IP Protocol | From Port | To Port |  IP Range | Source Group |
    +-------------+-----------+---------+-----------+--------------+
    | icmp        | -1        | -1      | 0.0.0.0/0 |              |
    | tcp         | 22        | 22      | 0.0.0.0/0 |              |
    | tcp         | 80        | 80      | 0.0.0.0/0 |              |
    | tcp         | 443       | 443     | 0.0.0.0/0 |              |
    | icmp        | -1        | -1      |           | default      |
    | tcp         | 1         | 65535   |           | default      |
    | udp         | 1         | 65535   |           | default      |
    +-------------+-----------+---------+-----------+--------------+
    

The first four rules of this default security group allow ssh, http, https and ping from all sources. Note in particular, that the IP range 0.0.0.0/0 means these rules apply to traffic from all sources. The remaining three rules allow tcp and udp on all ports, and ping from any server in the `default` security group.

Additional security groups can be created for a tenant using [Create Security Group](#createSecGroup). A security group can be associated with a server when the server is created by including its name in the list of security groups provided as the *security_groups* parameter of [Create Server](#createServer). If no security group is specified at the time a server is created, the server is associated with the default security group. You can also add/remove security groups to/from a server after it has been created using the server actions [Add Security Group](#addSecurityGroup) and [Remove Security Group](#removeSecurityGroup).

Additional rules can be added to a security group using [Create Security Group Rule](#createSecGroupRule). As shown in the example above, the source address for traffic can be specified as either a CIDR or as any server associated with a security group. (In the example above, the security group that is specified is the default security group itself.) Traffic within a security group is not automatically enabled. If you want to allow ports (or all traffic) within a given security group, you can create a rule using the same source and destination group as is done in the default security group created at account activation.

Any change to a security groups rules take immediate effect for any server associated with the group when the change is made. Changes will also applied to any server subsequently associated with the security group containing the rule.

When a security group is deleted it is effectively removed from all servers with which it was previously associated. If access to a server was previously allowed by one of the rules in the deleted security group, and no other security group associated with the server allows similar access, it will no longer be possible to access the server. For example, if the deleted security group allowed ping access (icmp) to the server from a particular source, and none of the rules in the remaining security groups associated with the server allow icmp from the same source, then it will no longer be possible to ping the server from that source.

## 2.4 Tenants ## {#Tenants}

A tenant has access to a collection of resources uniquely associated with the tenant.  Resources that are associated with a tenant include:

+ Server instances
+ Networks (in HP Cloud Compute there is a single network associated with all tenants)
+ Security Groups
+ Images
+ Users

All resources are uniquely allocated in an Availability Zone. However, the tenant may have resources in multiple Availability Zones. To access resources within a given Availability Zone, the API endpoints for that Availability Zone (as listed in the [Service Catalog](#ServiceCatalog) returned by the Identity Service) must be used.

Users are created separately from tenants; a given user can be associated with no tenants or with one or more tenants.

# 3. General API Information # {#Section3_}

## 3.1  Authorization ## {#Authorization}

Access to HP Cloud Compute is controlled on a per tenant basis. All HP Cloud Compute API operations have a `tenantId` parameter which identifies the particular collection of resources the user will be accessing. (See [Tenants](#Tenants).) In order to perform an API operation, the user must first obtain an authorization token scoped to the particular tenant he will be accessing. This authorization process is described in [HP Cloud Identity Service Overview](https://docs.hpcloud.com/identity). The token obtained must be included in the `X-Auth-Token` header of any subsequent HP Cloud Compute API request. Tokens are valid for a limited period of time (on the order of 24 hours). When the token expires, subsequent attempts to access the API will return authorization failures and a new token must be obtained to continue using the API.

## 3.2 Regions and Availability Zones ## {#Section3_2}

In order to access HP Cloud Compute, the user must specify the endpoint for one of the HP Cloud Availability Zones (AZs). Availability Zones provide separate fault domains for HP Cloud. Failures in one AZ should not affect any resources in another AZ. Highly available applications will therefore deploy resources in more than one AZ.

Availability Zones are further clustered into regions and geographies. HP Cloud Compute is currently available in a single region (`region-a`) in a single geography (`geo-1`). The set of endpoints that a tenant can access are returned in a Service Catalog when the user calls the Identity Service to get a token.

## 3.3  Service Catalog ## {#ServiceCatalog}

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

## 3.4 Request/Response Types ## {#Section3_4}

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

    POST /v1.1/11692683195772/servers HTTP/1.1
    Host: az-1.region-a.geo-1.compute.hpcloudsvc.com
    X-Auth-Token: HPAuth_a8df744befe0a7c0e759f0601f53226af35f3f6f44c55d9b3a3c0337e7664ac2
    Content-Type: application/json
    Accept: application/xml
    Content-Length: 63

    {"server":{"name":"webserver","imageRef":5579,"flavorRef":100}}

Example Response with Headers - XML

    HTTP/1.1 202 Accepted
    Content-Length: 1224
    Content-Type: application/xml; charset=UTF-8
    Date: Thu, 25 Oct 2012 22:37:13 GMT

    <server accessIPv4="" accessIPv6="" adminPass="4QAx7M8MrXVmXZSL" created="2012-10-25T22:37:13Z" hostId="" id="467571" name="webserver" status="BUILD(scheduling)" tenantId="11692683195772" updated="2012-10-25T22:37:13Z" userId="28187593996363" uuid="e5ac3d3c-cda3-4106-b60a-0a29b382fda2" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
	<atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/11692683195772/servers/467571" rel="self"/>
	<atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/11692683195772/servers/467571" rel="bookmark"/>
	<image id="5579">
	    <atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/11692683195772/images/5579" rel="bookmark"/>
	</image>
	<flavor id="100">
	    <atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/11692683195772/flavors/100" rel="bookmark"/>
	</flavor>
	<addresses/>
	<security_groups>
	    <security_group id="9143" name="default">
		<atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/11692683195772/os-security-groups/9143" rel="bookmark"/>
	    </security_group>
	</security_groups>
    </server>

Notice, in the above example, that the content type is set to
application/json but it asks for an application/xml response with the
`Accept` header. The same result could be achieved by adding an .xml extension to the request URI as shown below.

Example Request with .xml Extension - JSON

    POST /v1.1/11692683195772/servers.xml HTTP/1.1
    User-Agent: curl/7.21.3 (x86_64-pc-linux-gnu) libcurl/7.21.3 OpenSSL/0.9.8o zlib/1.2.3.4 libidn/1.18
    Host: az-1.region-a.geo-1.compute.hpcloudsvc.com
    Accept: */*
    X-Auth-Token: HPAuth_a8df744befe0a7c0e759f0601f53226af35f3f6f44c55d9b3a3c0337e7664ac2
    Content-Type: application/json
    Content-Length: 62
    
    {"server":{"name":"dbserver","imageRef":5579,"flavorRef":100}}
    

## 3.5 Links and References ## {#Section3_5}

Responses to several API operations include links which refer to HP Cloud Compute resources. For example, here is the response to a call on the [Get Server](#getServer) method.

List Servers (limit=1) Response: XML

    <servers xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <server id="488379" name="web 1">
            <atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/11692683195772/servers/488379" rel="self"/>
            <atom:link href="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/11692683195772/servers/488379" rel="bookmark"/>
        </server>
    </servers>


List Servers (limit=1) Response: JSON

    {
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
    }

The link elements in the response give references to the resource, in this case a server, which include the full URI of the server. This URI could be used at a later time to perform some server action (for example, to reboot the server) and capture both the AZ and the id of the server withing the AZ.

## 3.6 Paginated Collections ## {#Pagination}

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

## 3.7 Efficient Polling with the Changes-Since Parameter ## {#Polling}

The REST API allows you to poll for the status of certain operations by
performing a GET on various elements. Rather than re-downloading and
re-parsing the full status at each polling interval, your REST client
may use the `changes-since` parameter to check for changes since a
previous request. The `changes-since` time is specified as an [ISO
8601](http://en.wikipedia.org/wiki/ISO_8601) dateTime
(2011-01-24T17:08Z). The form for the timestamp is CCYY-MM-DDThh:mm:ss.
An optional time zone may be written in by appending the form [+|-]hh:mm
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

## 3.8 Limits ## {#Limits}

### 3.8.1 Absolute Limits ### {#Section3_8_1}

Limits are established for the following resources on a per tenant basis:

+ metadata_items: number of metadata items allowed per instance
+ instances: the maximum number of VM instances that can be created for the tenant
+ injected_file_content_bytes: the maximum size of an injected file
+ injected_files: the number of injected files that can be specified when a new VM instance is created
+ volumes: the number of volumes which can be created
+ gigabytes: the maximum total size of all volumes associated with the project
+ cores: the maximum of the total number of cores for project VM instances
+ ram: the maximum number of megabytes of instance RAM for the project
+ floating_ip: the maximum number of floating ips that can be assigned to the project

The limits are applied per AZ. [List Limits](#listLimits) can be used to retrieve the current value of these limits within an AZ for a tenant.

### 3.8.2 Rate Limits ### {#Section3_8_2}

In order to ensure fair sharing of cloud resources, limits are placed on the rate at which an individual tenant can make requests to the HP Cloud Compute API servers. The rate limits are specified in terms of HTTP verbs (GET, PUT, POST, DELETE) and are further qualified by URL. Stricter limits are place on operations that can affect servers than on queries. This allows users to monitor the status of the environment while guaranteeing equitable sharing of resources. The rate limits are applied per tenant and apply to API calls using both the EC2 and OSAPI interfaces. Rate limiting is enforced per AZ - a tenant has a separate allowance in each AZ.

[List Limits](#listLimits) can be used to retrieve the current value of these limits within an AZ for a tenant.

## 3.9 Versions ## {#Section3_9}

The HP Cloud Compute Service is based on OpenStack Nova v1.1 The OpenStack v1.0  Nova API is deprecated.

## 3.10 Extensions ## {#Section3_10}

The OpenStack Compute API is extensible. Extensions serve two purposes: They allow the introduction of new features in the API without requiring a version change and they allow the introduction of vendor specific niche functionality. Applications can programmatically determine what extensions are available by using the [List Extensions](#listExtensions) and [Get Extension](#getExtension) API methods. HP Cloud Compute supports the following extensions:

+ os-keypairs
+ os-volumes
+ os-console-output
+ security_groups
+ os-floating-ips
+ hp-bootable-volumes
+ hp-volume-backup

The resources and methods of these extensions are described in section 4.1, [ServiceAPIOperations](#ServiceAPIOperations).


## 3.11 Faults ## {#Section3_11}

When an error occurs at request time, the system will return an HTTP
error response code denoting the type of error. The system will also
return additional information about the fault in the body of the
response.

Fault Response: XML

    <?xml version="1.0" encoding="UTF-8"?>
    <cloudServersFault
        xmlns="http://docs.openstack.org/compute/api/v1.1"
        code="500">
    <message>Fault!</message>
    <details>Error Details...</details>
    </computeFault>

Fault Response: JSON

    {
        "cloudServersFault" : {
            "code" : 500,
            "message" : "Fault!",
            "details" : "Error Details..." 
        }
    }

The error code is returned in the body of the response for convenience.
The message section returns a human-readable message that is appropriate
for display to the end user. The details section is optional and may
contain information - for example, a stack trace-to assist in tracking
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

    <itemNotFound code="404" 
        xmlns="http://docs.openstack.org/compute/api/v1.1">
        <message>
            The resource could not be found.
        </message>
    </itemNotFound>
    

Fault Response, Item Not Found: JSON

    {"itemNotFound": 
    	{"message": "The resource could not be found.", 
    	"code": 404}}
    

The OverLimit fault is generated when any limit threshold is
exceeded. When an OverLimit fault occurs, the time in seconds after which another request is allowed in returned in the `Retry-After` response header. An explanation of why the request was rejected is returned in the `details` attribute of the response.

Fault Response, Over Limit: XML

    <?xml version="1.0" encoding="UTF-8"?>
    <overLimit
        xmlns="http://docs.openstack.org/compute/api/v1.1"
        code="413"
      <message>"This request was rate-limited.</message>
      <details>Error Details...</details>
    </overLimit>
    

Fault Response, Over Limit: JSON

    {
        "overLimit" : {
            "code" : 413,
            "message" : "This request was rate-limited.",
            "details" : "Error Details...",
        }
    }


# 4. REST API Specifications # {#Section4_}

##<a id="ServiceAPIOperations"></a>4.1 Service API Operations

**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**Base URI**: [Host]/

**Admin URI**: N/A


## 4.1 HP Cloud Compute API Operations ## {#Section4_1}


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
| **Server Addresses** | [List Server Addresses](#listServerAddresses) | GET | v1.1/{tenant_id}/servers/{server_id}/ips | Y/Y |  |
|  | [List Addresses by Network](#listServerAddressesbyNetwork) | GET | v1.1/{tenant_id}/servers/{server_id}/ips/{network_id} | Y/Y |  |
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

## 4.2 Common Request Headers ## {#Section4_2}

*Http standard request headers*

**Accept** - Internet media types that are acceptable in the response. HP Cloud Compute supports the media types application/xml and application/json.

**Content-Length** - The length of the request body in octets (8-bit bytes).

**Content-Type** - The Internet media type of the request body. Used with POST and PUT requests. Must be either application/xml or application/json.

**Host** - The domain name of the server hosting HP Cloud Compute.

*Non-standard request headers*

**X-Auth-Token** - HP Cloud authorization token.

*Example*

    POST /v1.1/11692683195772/servers HTTP/1.1
    Host: az-1.region-a.geo-1.compute.hpcloudsvc.com
    Accept: */*
    X-Auth-Token: HPAuth_2895c13b1118e23d977f6a21aa176fd2bd8a10e04b74bd8e353216072968832a
    Content-Type: application/json
    Content-Length: 85

## 4.3 Common Response Headers ## {#Section4_3}

*Http standard response headers*

**Content-Length** - The length of the response body in octets (8-bit bytes).

**Content-Type** - Internet media type of the response body.

**Date** - The date and time that the response was sent.

*Non-standard response headers*

**Retry-After** - Number of seconds to wait before a retry will succeed. This header is included in the response to an operation which was rate limited.

*Example*

    HTTP/1.1 202 Accepted
    Content-Length: 1135
    Content-Type: application/json; charset=UTF-8
    Date: Tue, 30 Oct 2012 16:22:35 GMT


## 4.4 OpenStack API Operation Details ## {#Section4_4}
The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.

### 4.4.1 Versions ### {#version}

<p> A list of available API versions </p>


#### 4.4.1.1 Get Version Info #### {#versionDetails}
#### GET v1.1

<p> Returns detailed information about this
                specific version of the API. </p>

######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <version id="v1.1" status="CURRENT" updated="2011-01-21T11:33:21Z" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom"><media-types><media-type base="application/xml" type="application/vnd.openstack.compute-v1.1+xml"/><media-type base="application/json" type="application/vnd.openstack.compute-v1.1+json"/></media-types><atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" rel="self"/><atom:link href="http://docs.rackspacecloud.com/servers/api/v1.1/cs-devguide-20110125.pdf" rel="describedby" type="application/pdf"/><atom:link href="http://docs.rackspacecloud.com/servers/api/v1.1/application.wadl" rel="describedby" type="application/vnd.sun.wadl+xml"/></version>

JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_eeb52e2b3fad2151383af237af3ec107ceea775498c2dfc7e8087f26b3b819ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/'



### 4.4.2 Extensions ### {#extensions}

<p> A list of supported extensions. </p>


#### 4.4.2.1 List Extensions #### {#listExtensions}
#### GET v1.1/{tenant_id}/extensions

<p> Lists all available extensions. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <extensions xmlns:atom="http://www.w3.org/2005/Atom" xmlns="http://docs.openstack.org/compute/api/v1.1"><extension name="Keypairs" namespace="http://docs.openstack.org/ext/keypairs/api/v1.1" alias="os-keypairs" updated="2011-08-08T00:00:00+00:00"><description>Keypair Support</description></extension><extension name="Volumes" namespace="http://docs.openstack.org/ext/volumes/api/v1.1" alias="os-volumes" updated="2011-03-25T00:00:00+00:00"><description>Volumes support</description></extension><extension name="Console_output" namespace="http://docs.openstack.org/compute/ext/os-console-output/api/v1.1" alias="os-console-output" updated="2011-12-08T00:00:00+00:00"><description>Console log output support, with tailing ability.</description></extension><extension name="SecurityGroups" namespace="http://docs.openstack.org/ext/securitygroups/api/v1.1" alias="security_groups" updated="2011-07-21T00:00:00+00:00"><description>Security group support</description></extension><extension name="Floating_ips" namespace="http://docs.openstack.org/ext/floating_ips/api/v1.1" alias="os-floating-ips" updated="2011-06-16T00:00:00+00:00"><description>Floating IPs support</description></extension></extensions>

JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/extensions'



### 4.4.3 Extension ### {#extension}

<p> Extension </p>


#### 4.4.3.1 Get Extension #### {#getExtension}
#### GET v1.1/{tenant_id}/extensions/{alias}

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>alias</em> - xsd:string</p><p>An alias is a name for a pointer to a resource, such as a named extension.</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <extension xmlns:atom="http://www.w3.org/2005/Atom" xmlns="http://docs.openstack.org/compute/api/v1.1" name="Floating_ips" namespace="http://docs.openstack.org/ext/floating_ips/api/v1.1" alias="os-floating-ips" updated="2011-06-16T00:00:00+00:00"><description>Floating IPs support</description></extension>

JSON

    {
        "extension": {
            "alias": "os-floating-ips",
            "description": "Floating IPs support",
            "links": [],
            "name": "Floating_ips",
            "namespace": "http://docs.openstack.org/ext/floating_ips/api/v1.1",
            "updated": "2011-06-16T00:00:00+00:00"
        }
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/extensions/os-floating-ips'



### 4.4.4 Limits ### {#limits}

<p> Limits </p>


#### 4.4.4.1 List Limits #### {#listLimits}
#### GET v1.1/{tenant_id}/limits

<p> Returns current limits for the account. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <limits xmlns="http://docs.openstack.org/compute/api/v1.1">
        <rates>
            <rate regex="/{suburi}" uri="/{suburi}">
                <limit next-available="2012-10-05T03:47:16Z" remaining="2999" unit="MINUTE" value="3000" verb="GET"/>
                <limit next-available="2012-10-05T03:47:15Z" remaining="199" unit="MINUTE" value="200" verb="GET"/>
                <limit next-available="2012-10-05T03:47:15Z" remaining="10" unit="MINUTE" value="10" verb="PUT"/>
                <limit next-available="2012-10-05T03:47:15Z" remaining="40" unit="MINUTE" value="40" verb="POST"/>
                <limit next-available="2012-10-05T03:47:15Z" remaining="60" unit="MINUTE" value="60" verb="DELETE"/>
            </rate>
        </rates>
        <absolute>
            <limit name="maxServerMeta" value="50"/>
            <limit name="maxPersonality" value="5"/>
            <limit name="maxImageMeta" value="50"/>
            <limit name="maxPersonalitySize" value="10240"/>
            <limit name="maxSecurityGroupRules" value="20"/>
            <limit name="maxSecurityGroups" value="10"/>
            <limit name="maxTotalInstances" value="20"/>
            <limit name="maxTotalRAMSize" value="102400"/>
        </absolute>
    </limits>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/limits'



### 4.4.5 Servers ### {#Servers}

<p> A list of servers. Each server contains IDs,
                names, and links -- other attributes are omitted. </p>


#### 4.4.5.1 List Servers #### {#listServers}
#### GET v1.1/{tenant_id}/servers

<p> Lists IDs, names, and links associated with the account.
                The list of servers returned can be filtered using query parameters described below.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>image</em> - xsd:string</p><p>Filter the list of servers returned by image.</p>
</li>
<li><p><em>flavor</em> - xsd:integer</p><p>Filter the list of servers returned by flavor.</p>
</li>
<li><p><em>name</em> - xsd:string</p><p>Filter the list of servers returned by display name.</p>
</li>
<li><p><em>status</em> - csapi:ServerStatus</p><p>Filter the list of servers returned by server status. See <a href="#ServerStates"> Server Status Values </a> .</p>
</li>
<li><p><em>changes-since</em> - xsd:dateTime</p><p>Filters the list of servers returned to those that have changed since the <em>changes-since</em> time. See <a href="#Polling"> Efficient Polling with the <em>Changes-Since</em> Parameter </a> .</p>
</li>
<li><p><em>marker</em> - csapi:UUID</p><p>The UUID of the last item in the previous list. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
<li><p><em>limit</em> - xsd:int</p><p>Sets the page size to <em>limit</em>. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <servers xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <server id="233693" name="server-name-2">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233693" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233693" rel="bookmark"/>
        </server>
        <server id="233691" name="server-name-1">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233691" rel="bookmark"/>
        </server>
    </servers>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers?status=ACTIVE&image=120&flavor=100&name=server-name'



#### 4.4.5.2 Create Server #### {#createServer}
#### POST v1.1/{tenant_id}/servers

<p> 
                Creates a new server with the specified parameters. The number of servers that can
                be created is limited by the user's instances, cores and ram quotas.(See 
        <a href="#Limits">
            Limits
        </a>
          .) 
                Returns an error if at least
                <code>min_count</code> servers can't be created. Otherwise, creates a number of servers
                equal to the minimum of the number of servers allowed by the user's quota and <code>max_count</code>.
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
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>flavorRef</em> (required) - csapi:ID</p><p>The ID of the flavor to be used when creating the server</p>
</li>
<li><p><em>imageRef</em> (required) - csapi:ID</p><p>The ID of the image from which to boot the server </p>
</li>
<li><p><em>name</em> (required) - xsd:string</p><p>The name of the server.</p>
</li>
<li><p><em>config_drive</em> - xsd:boolean</p><p> If true, creates an ephemeral drive on the server which is formatted with a fat-32 filesystem. Metadata, networks and keys are written to files in the filesystem. (See <a href="#ConfigurationDrive"> Configuration Drive </a> .) Defaults to false. </p>
</li>
<li><p><em>key_name</em> - xsd:string</p><p> Assigns the public key of the named keypair to the server. </p>
</li>
<li><p><em>metadata</em> - csapi:Metadata</p><p>Metadata key and value pairs. The maximum size of the metadata key and value is 255 bytes each.</p>
</li>
<li><p><em>min_count</em> - xsd:integer</p><p> The minimum number of servers to create. Defaults to 1 if not specified. An error is returned if at least <code>min_count</code> servers can not be created. </p>
</li>
<li><p><em>max_count</em> - xsd:integer</p><p> The maximum number of servers to create. Defaults to <code>min_count</code> if not specified. The number of servers created will be the minimum of the number of servers allowed by the user's quota and <code>max_count</code>. </p>
</li>
<li><p><em>personality</em> - csapi:Personality</p><p>File path and contents to inject into the server at launch. The maximum size of the file path data is 255 bytes. The maxPersonality limit restricts the number of files that can be injected. The maxPersonalitySize limit restricts the maximum number of bytes for the decoded file contents. (See <a href="#FileInjection"> File Injection </a> .) </p>
</li>
<li><p><em>security_groups</em> - csapi:list_of_strings</p><p> A list of names of security groups that are to be associated with the server. If no names are specified, the server is associated with the "default" security group. </p>
</li>
<li><p><em>user_data</em> - xsd:string</p><p> Arbitrary string of user supplied data that is provided to the server as EC2 metadata. Must be Base64 encoded. (See <a href="#EC2Metadata"> EC2 Metadata </a> .)</p>
</li>
<li><p><em>password</em> - None</p><p> Not supported. </p>
</li>
<li><p><em>accessIPv4</em> - None</p><p>Not supported</p>
</li>
<li><p><em>accessIPv6</em> - None</p><p>Not supported</p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <server config_drive="True" flavorRef="100" imageRef="120" key_name="key.pub" max_count="1" min_count="1" name="server-name-2" xmlns="http://docs.openstack.org/compute/api/v1.1">
        <security_groups>
            <security_group name="security-group"/>
        </security_groups>
        <metadata>
            <meta key="key-2" value="value-2"/>
            <meta key="key-1" value="value-1"/>
        </metadata>
    </server>


JSON

    {
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
    }

######Response

**Status Code(s)** 202

**Response Headers**

<ul>
<li><p><em>Location</em> (required) - xsd:anyURI</p><p>Full URL to a server created by the service.</p>
</li>
</ul>
XML

    <server accessIPv4="" accessIPv6="" adminPass="2eb56Qh2uVAuC7ub" created="2012-11-01T03:58:01Z" hostId="" id="294393" name="server-name-2" status="BUILD(scheduling)" tenantId="36991859863737" updated="2012-11-01T03:58:01Z" userId="13311562627589" uuid="44823245-b322-4ad0-9cf3-c3c84fd4cbec" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/294393" rel="self"/>
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/294393" rel="bookmark"/>
        <image id="120">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/>
        </image>
        <flavor id="100">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/>
        </flavor>
        <metadata>
            <meta key="key-2">
            </meta>
            <meta key="key-1">
            </meta>
        </metadata>
        <addresses/>
        <security_groups>
            <security_group id="12091" name="default">
                <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/12091" rel="bookmark"/>
            </security_group>
        </security_groups>
    </server>


JSON

    {
        "badRequest": {
            "code": 400,
            "message": "Security group security-group not found for project 36991859863737."
        }
    }

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_056c1b46b85d28f0f30c5de0be445b999e49efb465886f3193637f6b00c33bd4" -d '{"server": {"name": "server-name-1", "imageRef": "120", "key_name": "key.pub", "min_count": 1, "flavorRef": "100", "max_count": 1, "config_drive": true, "security_groups": [{"name": "security-group"}], "metadata": {"key-2": "value-2", "key-1": "value-1"}}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers'



#### 4.4.5.3 List Servers Detail #### {#listDetailServers}
#### GET v1.1/{tenant_id}/servers/detail

<p> 
                Lists details for servers associated with the account. The list of servers returned can be filtered
                using the query parameters described below.          
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>image</em> - xsd:string</p><p>Filter the list of servers returned by image.</p>
</li>
<li><p><em>flavor</em> - xsd:integer</p><p>Filter the list of servers returned by flavor.</p>
</li>
<li><p><em>name</em> - xsd:string</p><p>Filter the list of servers returned by display name.</p>
</li>
<li><p><em>status</em> - csapi:ServerStatus</p><p>Filter the list of servers returned by server status. See <a href="#ServerStates"> Server Status Values </a> .</p>
</li>
<li><p><em>changes-since</em> - xsd:dateTime</p><p>Filters the list of servers returned to those that have changed since the <em>changes-since</em> time. See <a href="#Polling"> Efficient Polling with the <em>Changes-Since</em> Parameter </a> .</p>
</li>
<li><p><em>marker</em> - csapi:UUID</p><p>The UUID of the last item in the previous list. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
<li><p><em>limit</em> - xsd:int</p><p>Sets the page size to <em>limit</em>. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <servers xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <server accessIPv4="" accessIPv6="" created="2012-11-01T03:58:01Z" hostId="763e09f51afed6e9a38e2c0e385e49fd8fbd7111a957574f3081540a" id="294393" name="server-name-2" progress="100" status="ACTIVE" tenantId="36991859863737" updated="2012-11-01T03:58:18Z" userId="13311562627589" uuid="44823245-b322-4ad0-9cf3-c3c84fd4cbec">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/294393" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/294393" rel="bookmark"/>
            <image id="120">
                <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/>
            </image>
            <flavor id="100">
                <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/>
            </flavor>
            <metadata>
                <meta key="key-2">
                </meta>
                <meta key="key-1">
                </meta>
            </metadata>
            <addresses>
                <network id="private">
                    <ip addr="10.2.0.27" version="4"/>
                    <ip addr="15.185.225.248" version="4"/>
                </network>
            </addresses>
            <security_groups>
                <security_group id="12091" name="default">
                    <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/12091" rel="bookmark"/>
                </security_group>
            </security_groups>
        </server>
    </servers>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_056c1b46b85d28f0f30c5de0be445b999e49efb465886f3193637f6b00c33bd4" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/detail?status=ACTIVE&image=120&flavor=100&name=server-name'



### 4.4.6 Server ### {#Server}


#### 4.4.6.1 Get Server Details #### {#getServer}
#### GET v1.1/{tenant_id}/servers/{server_id}

<p> Lists details for the specified server. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <server accessIPv4="" accessIPv6="" created="2012-11-01T03:58:01Z" hostId="763e09f51afed6e9a38e2c0e385e49fd8fbd7111a957574f3081540a" id="294393" name="server-name-2" progress="100" status="ACTIVE" tenantId="36991859863737" updated="2012-11-01T03:58:18Z" userId="13311562627589" uuid="44823245-b322-4ad0-9cf3-c3c84fd4cbec" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/294393" rel="self"/>
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/294393" rel="bookmark"/>
        <image id="120">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/>
        </image>
        <flavor id="100">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/>
        </flavor>
        <metadata>
            <meta key="key-2">
            </meta>
            <meta key="key-1">
            </meta>
        </metadata>
        <addresses>
            <network id="private">
                <ip addr="10.2.0.27" version="4"/>
                <ip addr="15.185.225.248" version="4"/>
            </network>
        </addresses>
        <security_groups>
            <security_group id="12091" name="default">
                <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/12091" rel="bookmark"/>
            </security_group>
        </security_groups>
    </server>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_056c1b46b85d28f0f30c5de0be445b999e49efb465886f3193637f6b00c33bd4" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/294393'



#### 4.4.6.2 Update Server Name #### {#updateServer}
#### PUT v1.1/{tenant_id}/servers/{server_id}

<p> Updates the display name for the specified server. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> (required) - xsd:string</p><p> The new display name of the server. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <server xmlns="http://docs.openstack.org/compute/api/v1.1">
        <name>new-server-name-2</name>
    </server>


JSON

    {
        "server": {
            "name": "new-server-name-1"
        }
    }

######Response

**Status Code(s)** 200

XML

    <server accessIPv4="" accessIPv6="" created="2012-10-02T23:24:20Z" hostId="2ddccc8dc2fb1461a6df1fc8e624db7578e688f52c6ac4929d5b235a" id="233069" name="new-server-name-2" progress="100" status="ACTIVE" tenantId="36991859863737" updated="2012-10-03T05:36:28Z" userId="13311562627589" uuid="cda05bcd-89d3-4c1b-bd6c-df6b3f11c14f" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069" rel="self"/>
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233069" rel="bookmark"/>
        <image id="120">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/>
        </image>
        <flavor id="100">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/>
        </flavor>
        <metadata>
            <meta key="key-2">
                value-2
            </meta>
            <meta key="key-1">
                value-1
            </meta>
        </metadata>
        <addresses>
            <network id="private">
                <ip addr="10.2.90.2" version="4"/>
                <ip addr="15.185.227.39" version="4"/>
            </network>
        </addresses>
        <security_groups>
            <security_group id="14703" name="security-group">
                <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/14703" rel="bookmark"/>
            </security_group>
        </security_groups>
    </server>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"server": {"name": "new-server-name-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069'



#### 4.4.6.3 Delete Server #### {#deleteServer}
#### DELETE v1.1/{tenant_id}/servers/{server_id}

<p> Terminates the specified server. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 204

######Example(s)

    curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069'



### 4.4.7 Server Action ### {#ServerAction}


#### 4.4.7.1 Reboot Server #### {#rebootServer}
#### POST v1.1/{tenant_id}/servers/{server_id}/action

<p> Reboots the specified server. Specify the
                    <code>reboot</code> action in the request body. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>type</em> (required) - xsd:string</p><p> Specifies <em>SOFT</em> or <em>HARD</em> reboot. A <em>SOFT</em> reboot signals the operating system to restart, which allows for graceful shutdown of all processes. A <em>HARD</em> reboot is equivalent to power cycling the server. This parameter is ignored in HP Cloud Compute where a <em>HARD</em> reboot is always performed. </p>
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

    <?xml version="1.0" ?>
    <reboot type="SOFT" xmlns="http://docs.openstack.org/compute/api/v1.1"/>


JSON

    {
        "reboot": {
            "type": "SOFT"
        }
    }

######Response

**Status Code(s)** 202

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"reboot": {"type": "SOFT"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/action'



#### 4.4.7.2 Rebuild Server #### {#rebuildServer}
#### POST v1.1/{tenant_id}/servers/{server_id}/action

<p> Rebuilds the specified server by rebooting it from a
                specified image. Other attributes of the server, such as its network configuration
                are not changed. Servers running licensed images, such as windows, can only be rebuilt from
                the same image.
                To rebuild a server, specify the <code>rebuild</code> action in the request body.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> - xsd:string</p><p> The name for the new server. </p>
</li>
<li><p><em>imageRef</em> - xsd:int</p><p> A reference to the image which is to be booted. </p>
</li>
<li><p><em>metadata</em> - csapi:Metadata</p><p>Metadata key and value pairs. The maximum size of the metadata key and value is 255 bytes each. (See <a href="#ServerMetadata"> Server Metadata </a> .</p>
</li>
<li><p><em>personality</em> - csapi:Personality</p><p>File path and contents to inject into the rebuilt server. The maximum size of the file path data is 255 bytes. The maxPersonality limit restricts the number of files that can be injected. The maxPersonalitySize limit restricts the maximum number of bytes for the decoded file contents. (See <a href="#FileInjection"> File Injection </a> .) </p>
</li>
<li><p><em>password</em> - None</p><p> Not supported. </p>
</li>
<li><p><em>accessIPv4</em> - None</p><p>Not supported</p>
</li>
<li><p><em>accessIPv6</em> - None</p><p>Not supported</p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <rebuild imageRef="120" name="server-name-2" xmlns="http://docs.openstack.org/compute/api/v1.1">
        <metadata>
            <meta key="key-1">value-1</meta>
        </metadata>
    </rebuild>


JSON

    {
        "rebuild": {
            "imageRef": 120,
            "metadata": {
                "key-1": "value-1"
            },
            "name": "server-name-1"
        }
    }

######Response

**Status Code(s)** 202

**Response Headers**

<ul>
<li><p><em>Location</em> (required) - xsd:anyURI</p><p> Specific URL of the server you want to rebuild. </p>
</li>
</ul>
XML

    <server accessIPv4="" accessIPv6="" adminPass="JAQ7ZQHYeoZQcc6V" created="2012-10-03T05:25:28Z" hostId="d30bd4bdb4cd3cdb87c7b4b8b5d9d3bbedf06878821c8338b4ddb474" id="233693" name="server-name-2" status="ACTIVE(rebuilding)" tenantId="36991859863737" updated="2012-10-23T15:56:56Z" userId="13311562627589" uuid="f632dbea-e9bc-4c71-a893-6bdc3696a5ca" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233693" rel="self"/>
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/servers/233693" rel="bookmark"/>
        <image id="120">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/>
        </image>
        <flavor id="100">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/>
        </flavor>
        <metadata>
            <meta key="key-1">
                value-1
            </meta>
        </metadata>
        <addresses>
            <network id="private">
                <ip addr="10.2.90.88" version="4"/>
                <ip addr="15.185.229.18" version="4"/>
            </network>
        </addresses>
        <security_groups>
            <security_group id="12091" name="default">
                <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/12091" rel="bookmark"/>
            </security_group>
        </security_groups>
    </server>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_e733642e6e1e0eabea392c76ca4228a9adb63fce719b351f8c925d8caaa37ecc" -d '{"rebuild": {"name": "server-name-1", "imageRef": 120, "metadata": {"key-1": "value-1"}}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'



#### 4.4.7.3 Create Image #### {#createImage}
#### POST v1.1/{tenant_id}/servers/{server_id}/action

<p> Creates a new image. Specify the
                    <code>createImage</code> action in the request body. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>metadata</em> - csapi:Metadata</p><p>Metadata key and value pairs. The maximum size of the metadata key and value is 255 bytes each. (See <a href="#ImageMetadata"> Image Metadata </a> .</p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <createImage name="image-1" xmlns="http://docs.openstack.org/compute/api/v1.1"/>


JSON

    {
        "createImage": {
            "metadata": {
                "key-1": "value-1",
                "key-2": "value-2"
            },
            "name": "image-1"
        }
    }

######Response

**Status Code(s)** 202

**Response Headers**

<ul>
<li><p><em>Location</em> (required) - xsd:anyURI</p>
</li>
</ul>
######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_9b8591392fee0485651d33b11b71178e2b189cfda73bb9fa8eeb9a62411e40cd" -d '{"createImage": {"name": "image-1", "metadata": {"key-2": "value-2", "key-1": "value-1"}}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'



#### 4.4.7.4 Get Console Output. #### {#getConsoleOutput}
#### POST v1.1/{tenant_id}/servers/{server_id}/action

<p>
                Get the console output for a server instance.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server id. This parameter can be an integer id or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>length</em> - xsd:int</p><p> Number of lines to fetch from end of console log. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <os-getConsoleOutput>
        <length>
            50
        </length>
    </os-getConsoleOutput>


JSON

    {
        "os-getConsoleOutput": {
            "length": 50
        }
    }

######Response

**Status Code(s)** 200

XML

    <output>
        Begin: Loading essential drivers ... done.
    [    0.845263] udevd[79]: starting version 173
    Begin: Running /scripts/init-premount ... done.
    Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
    [    0.960487] FDC 0 is a S82078B
    Begin: Running /scripts/local-premount ... done.
    [    1.045440] EXT4-fs (vda1): INFO: recovery required on readonly filesystem
    [    1.046550] EXT4-fs (vda1): write access will be enabled during recovery
    [    1.128786] Refined TSC clocksource calibration: 2666.693 MHz.
    [    1.317845] EXT4-fs (vda1): recovery complete
    [    1.319330] EXT4-fs (vda1): mounted filesystem with ordered data mode. Opts: (null)
    Begin: Running /scripts/local-bottom ... done.
    done.
    Begin: Running /scripts/init-bottom ... done.
    [    3.147572] udevd[313]: starting version 173
    lxcmount stop/pre-start, process 228
    fsck from util-linux 2.19.1
    ephemeral0: recovering journal
    ephemeral0 has gone 186 days without being checked, check forced.
    cloud-init start-local running: Wed, 31 Oct 2012 03:59:50 +0000. up 5.98 seconds
    no instance data found in start-local
    ci-info: lo    : 1 127.0.0.1       255.0.0.0       
    ci-info: eth0  : 1 10.4.15.127     255.254.0.0     02:16:3e:58:ff:18
    ci-info: route-0: 0.0.0.0         10.4.0.1        0.0.0.0         eth0   UG
    ci-info: route-1: 10.4.0.0        0.0.0.0         255.254.0.0     eth0   U
    cloud-init start running: Wed, 31 Oct 2012 03:59:51 +0000. up 6.31 seconds
    found data source: DataSourceEc2
    mountall: Event failed
    Checking disk drives for errors. This may take several minutes.
    Press C to cancel all checks in progress
     * Stopping Handle applying cloud-config                                 [ OK ]
     * Starting AppArmor profiles                                            [ OK ]
    Checking for running unattended-upgrades: 
     * Stopping Failsafe Boot Delay                                          [ OK ]
     * Stopping System V initialisation compatibility                        [ OK ]
     * Starting System V runlevel compatibility                              [ OK ]
     * Stopping automatic crash report generation                            [fail]
     * Starting save kernel messages                                         [ OK ]
     * Starting regular background program processing daemon                 [ OK ]
     * Starting deferred execution scheduler                                 [ OK ]
     * Stopping save kernel messages                                         [ OK ]
     * Starting CPU interrupts balancing daemon                              [ OK ]
    landscape-client is not configured, please run landscape-config.
     * Stopping System V runlevel compatibility                              [ OK ]
     * Starting execute cloud user/final scripts                             [ OK ]
    mountall: Plymouth command failed
    mountall: Disconnected from Plymouth
    cloud-init boot finished at Wed, 31 Oct 2012 03:59:53 +0000. Up 8.90 seconds
    ephemeral0: 11/1310720 files (0.0% non-contiguous), 126322/5242880 blocks
    </output>


JSON

    {
        "output": "Begin: Loading essential drivers ... done.\r\n[    0.845263] udevd[79]: starting version 173\r\nBegin: Running /scripts/init-premount ... done.\r\nBegin: Mounting root file system ... Begin: Running /scripts/local-top ... done.\r\n[    0.960487] FDC 0 is a S82078B\r\nBegin: Running /scripts/local-premount ... done.\r\n[    1.045440] EXT4-fs (vda1): INFO: recovery required on readonly filesystem\r\n[    1.046550] EXT4-fs (vda1): write access will be enabled during recovery\r\n[    1.128786] Refined TSC clocksource calibration: 2666.693 MHz.\r\n[    1.317845] EXT4-fs (vda1): recovery complete\r\n[    1.319330] EXT4-fs (vda1): mounted filesystem with ordered data mode. Opts: (null)\r\nBegin: Running /scripts/local-bottom ... done.\r\ndone.\r\nBegin: Running /scripts/init-bottom ... done.\r\n[    3.147572] udevd[313]: starting version 173\r\nlxcmount stop/pre-start, process 228\r\r\nfsck from util-linux 2.19.1\r\r\nephemeral0: recovering journal\r\r\nephemeral0 has gone 186 days without being checked, check forced.\r\r\ncloud-init start-local running: Wed, 31 Oct 2012 03:59:50 +0000. up 5.98 seconds\r\r\nno instance data found in start-local\r\r\nci-info: lo    : 1 127.0.0.1       255.0.0.0       \r\r\nci-info: eth0  : 1 10.4.15.127     255.254.0.0     02:16:3e:58:ff:18\r\r\nci-info: route-0: 0.0.0.0         10.4.0.1        0.0.0.0         eth0   UG\r\r\nci-info: route-1: 10.4.0.0        0.0.0.0         255.254.0.0     eth0   U\r\r\ncloud-init start running: Wed, 31 Oct 2012 03:59:51 +0000. up 6.31 seconds\r\r\nfound data source: DataSourceEc2\r\r\nmountall: Event failed\r\r\nChecking disk drives for errors. This may take several minutes.\r\r\nPress C to cancel all checks in progress\r\r\n * Stopping Handle applying cloud-config\u001b[74G[ OK ]\r\r\n * Starting AppArmor profiles       \u001b[80G \r\u001b[74G[ OK ]\r\r\nChecking for running unattended-upgrades: \r\r\n * Stopping Failsafe Boot Delay\u001b[74G[ OK ]\r\r\n * Stopping System V initialisation compatibility\u001b[74G[ OK ]\r\r\n * Starting System V runlevel compatibility\u001b[74G[ OK ]\r\r\n * Stopping automatic crash report generation\u001b[74G[\u001b[31mfail\u001b[39;49m]\r\r\n * Starting save kernel messages\u001b[74G[ OK ]\r\r\n * Starting regular background program processing daemon\u001b[74G[ OK ]\r\r\n * Starting deferred execution scheduler\u001b[74G[ OK ]\r\r\n * Stopping save kernel messages\u001b[74G[ OK ]\r\r\n * Starting CPU interrupts balancing daemon\u001b[74G[ OK ]\r\r\nlandscape-client is not configured, please run landscape-config.\r\r\n * Stopping System V runlevel compatibility\u001b[74G[ OK ]\r\r\n * Starting execute cloud user/final scripts\u001b[74G[ OK ]\r\r\nmountall: Plymouth command failed\r\nmountall: Disconnected from Plymouth\r\ncloud-init boot finished at Wed, 31 Oct 2012 03:59:53 +0000. Up 8.90 seconds\r\nephemeral0: 11/1310720 files (0.0% non-contiguous), 126322/5242880 blocks\r\n"
    }

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1255eea3985e49c22607f104fcdd8812f34024705ae8899ee29c2c5acf4f0107" -d '{"os-getConsoleOutput": {"length": 50}}' 'https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/11692683195772/servers/330579/action'



#### 4.4.7.5 Add Floating Ip #### {#addFloatingIp}
#### POST v1.1/{tenant_id}/servers/{server_id}/action

<p> 
                Adds the specified floating IP to the server. The floating IP must have been previously allocated
                with <em>Allocate Floating Ip</em>.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>address</em> (required) - xsd:string</p><p> The address to add to the server. This address must have been previously allocated with <em>Allocate Floating Ip</em>. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <addFloatingIp xmlns="http://docs.openstack.org/compute/api/v1.1">
        <address>
            15.185.230.99
        </address>
    </addFloatingIp>


JSON

    {
        "addFloatingIp": {
            "address": "15.185.230.113"
        }
    }

######Response

**Status Code(s)** 202

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_7aed0967e43782329ed5a40536f0d88203b23ecc1a6ea4c09338986b5193b9ab" -d '{"addFloatingIp": {"address": "15.185.230.113"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'



#### 4.4.7.6 Remove Floating Ip #### {#removeFloatingIp}
#### POST v1.1/{tenant_id}/servers/{server_id}/action

<p>
                Removes the specified floating IP from the server. Only floating IPs which have been explicitly
                added to the server using <em>Add Floating Ip</em> can be removed.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>address</em> (required) - xsd:string</p><p> The address to be removed from the server. This address must have previously been added to the server using <em>Add Floating Ip</em> </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <removeFloatingIp xmlns="http://docs.openstack.org/compute/api/v1.1">
        <address>
            15.185.230.99
        </address>
    </removeFloatingIp>


JSON

    {
        "removeFloatingIp": {
            "address": "15.185.230.113"
        }
    }

######Response

**Status Code(s)** 202

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_7aed0967e43782329ed5a40536f0d88203b23ecc1a6ea4c09338986b5193b9ab" -d '{"removeFloatingIp": {"address": "15.185.230.113"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'



#### 4.4.7.7 Add Security Group #### {#addSecurityGroup}
#### POST v1.1/{tenant_id}/servers/{server_id}/action

<p> 
                Adds a security group to the list of security groups that are associated with the server.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> (required) - xsd:string</p><p>The name of the security group to add.</p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <addSecurityGroup xmlns="http://docs.openstack.org/compute/api/v1.1">
        <name>security-group-2</name>
    </addSecurityGroup>


JSON

    {
        "addSecurityGroup": {
            "name": "security-group-1"
        }
    }

######Response

**Status Code(s)** 202

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_320eb8cc5998143e6e9fcf0e8fcaecaa8d161f1ec03f18b8de31e1b48b24f280" -d '{"addSecurityGroup": {"name": "security-group-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'



#### 4.4.7.8 Remove Security Group #### {#removeSecurityGroup}
#### POST v1.1/{tenant_id}/servers/{server_id}/action

<p>
                Removes a security group from the list of security groups that are associated with the server. 
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> (required) - xsd:string</p><p>The name of the security group to remove.</p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <removeSecurityGroup xmlns="http://docs.openstack.org/compute/api/v1.1">
        <name>security-group-2</name>
    </removeSecurityGroup>


JSON

    {
        "removeSecurityGroup": {
            "name": "security-group-1"
        }
    }

######Response

**Status Code(s)** 202

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_320eb8cc5998143e6e9fcf0e8fcaecaa8d161f1ec03f18b8de31e1b48b24f280" -d '{"removeSecurityGroup": {"name": "security-group-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233691/action'



### 4.4.8 Server Metadata ### {#ServerMetadata}


#### 4.4.8.1 List Metadata #### {#ServerMetadata_listMetadata}
#### GET v1.1/{tenant_id}/servers/{server_id}/metadata

<p> Lists metadata associated with the resource.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <?xml version="1.0" encoding="UTF-8"?><metadata xmlns="http://docs.openstack.org/compute/api/v1.1"><meta key="key-2">value-2</meta><meta key="key-1">value-1</meta></metadata>

JSON

    {
        "metadata": {
            "key-1": "value-1",
            "key-2": "value-2"
        }
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/metadata'



#### 4.4.8.2 Update Metadata #### {#ServerMetadata_updateMetadata}
#### POST v1.1/{tenant_id}/servers/{server_id}/metadata

<p> Updates resource metadata. Updates will replace
                existing metadata items with the same key. Items not explicitly mentioned in the
                request will not be modified. An overLimit (<errorcode>413</errorcode>) fault may be
                thrown if the operation causes the maximum number of metadata items to be exceeded.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>metadata</em> - csapi:Metadata</p><p> A set of key/value pairs. These pair replace any existing key/value pairs in the resources metadata with matching keys. Any key/value pairs in the parameter with keys that do not occur in the existing resource metadata are added to the resources metadata. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <metadata xmlns="http://docs.openstack.org/compute/api/v1.1">
        <meta key="key-1">value-1</meta>
        <meta key="key-2">value-2</meta>
    </metadata>


JSON

    {
        "metadata": {
            "key-1": "value-1"
        }
    }

######Response

**Status Code(s)** 200

XML

    <?xml version="1.0" encoding="UTF-8"?><metadata xmlns="http://docs.openstack.org/compute/api/v1.1"><meta key="key-2">value-2</meta><meta key="key-1">value-1</meta></metadata>

JSON

    {
        "metadata": {
            "key-1": "value-1"
        }
    }

######Example(s)

    curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"metadata": {"key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/metadata'



#### 4.4.8.3 Create or Replace Metadata #### {#ServerMetadata_setMetadata}
#### PUT v1.1/{tenant_id}/servers/{server_id}/metadata

<p>The metadata items set on the resource are those
                specified on the requests. Existing metadata items are replaced with the ones
                provided in the request. Metadata items, set previously, but not specified in the
                request are removed. </p>

<p> An overLimit (<errorcode>413</errorcode>) fault
                may be thrown if the maximum number of metadata items is exceeded. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>metadata</em> - csapi:Metadata</p><p> A set of key/value pairs. These pair replace any existing key/value pairs in the resources metadata with matching keys. Any key/value pairs in the parameter with keys that do not occur in the existing resource metadata are added to the resources metadata. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <metadata xmlns="http://docs.openstack.org/compute/api/v1.1">
        <meta key="key-1">value-1</meta>
        <meta key="key-2">value-2</meta>
    </metadata>


JSON

    {
        "metadata": {
            "key-1": "value-1",
            "key-2": "value-2"
        }
    }

######Response

**Status Code(s)** 200

XML

    <?xml version="1.0" encoding="UTF-8"?><metadata xmlns="http://docs.openstack.org/compute/api/v1.1"><meta key="key-2">value-2</meta><meta key="key-1">value-1</meta></metadata>

JSON

    {
        "metadata": {
            "key-1": "value-1",
            "key-2": "value-2"
        }
    }

######Example(s)

    curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"metadata": {"key-2": "value-2", "key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/metadata'



### 4.4.9 Server Metadata Item ### {#ServerMetadataItem}


#### 4.4.9.1 Get Metadata Item #### {#ServerMetadataItem_getMetadataItem}
#### GET v1.1/{tenant_id}/servers/{server_id}/metadata/{key}

<p> Retrieves a single metadata item by key. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <?xml version="1.0" encoding="UTF-8"?><meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1">value-1</meta>

JSON

    {
        "meta": {
            "key-1": "value-1"
        }
    }


#### 4.4.9.2 Create or Update Metadata Item #### {#ServerMetadataItem_setMetadataItem}
#### PUT v1.1/{tenant_id}/servers/{server_id}/metadata/{key}

<p> Sets a metadata item by its key. An overLimit
                    (<errorcode>413</errorcode>) fault may be thrown if the operation causes the
                maximum number of metadata items to be exceeded. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1">value-1</meta>


JSON

    {
        "meta": {
            "key-1": "value-1"
        }
    }

######Response

**Status Code(s)** 200

XML

    <?xml version="1.0" encoding="UTF-8"?><meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1">value-1</meta>

JSON

    {
        "meta": {
            "key-1": "value-1"
        }
    }

######Example(s)

    curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"meta": {"key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/metadata/key-1'



#### 4.4.9.3 Delete Metadata Item #### {#ServerMetadataItem_deleteMetadataItem}
#### DELETE v1.1/{tenant_id}/servers/{server_id}/metadata/{key}

<p> Deletes a metadata item. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 204

######Example(s)

    curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/servers/233069/metadata/key-1'



### 4.4.10 Server Addresses ### {#ServerAddresses}

<p>
                                    A list of addresses associated with a server by network. All servers in 
                                    HP Cloud Compute are on the <em>private</em> network. (See 
        <a href="#NetworkModel">
            Network Model
        </a>
          .)
</p>


#### 4.4.10.1 List Server Addresses #### {#listServerAddresses}
#### GET v1.1/{tenant_id}/servers/{server_id}/ips

<p> Lists all server addresses by network. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <addresses xmlns="http://docs.openstack.org/compute/api/v1.1">
        <network id="private">
            <ip addr="10.4.15.127" version="4"/>
            <ip addr="15.185.99.229" version="4"/>
        </network>
    </addresses>


JSON

    {
        "addresses": {
            "private": [
                {
                    "addr": "10.4.15.127", 
                    "version": 4
                }, 
                {
                    "addr": "15.185.99.229", 
                    "version": 4
                }
            ]
        }
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_8734fa79bea983a8f20d0d8279d7b815da60ce70837547eb775f72cdae54ced6" 'https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/11692683195772/servers/330579/ips'



#### 4.4.10.2 List Addresses by Network #### {#listServerAddressesbyNetwork}
#### GET v1.1/{tenant_id}/servers/{server_id}/ips/{network_id}

<p> Lists server addresses for the specified network.
                All servers in HP Cloud Compute are on the <em>private</em> network. (See 
        <a href="#NetworkModel">
            Network Model
        </a>
          .)</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>server_id</em> - csapi:ID_or_UUID</p><p> Server ID. This parameter can be an integer ID or a UUID. In either case, the specified server must be in the addressed Availability Zone. </p>
</li>
<li><p><em>network_id</em> - xsd:string</p><p> Network ID. </p>
<p>Legal values are:<ul>
<li><em>private</em>  - This is the only network in HP Cloud Compute.
</li>
</ul></p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <network id="private" xmlns="http://docs.openstack.org/compute/api/v1.1">
        <ip addr="10.4.15.127" version="4"/>
        <ip addr="15.185.99.229" version="4"/>
    </network>


JSON

    {
        "private": [
            {
                "addr": "10.4.15.127", 
                "version": 4
            }, 
            {
                "addr": "15.185.99.229", 
                "version": 4
            }
        ]
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_8734fa79bea983a8f20d0d8279d7b815da60ce70837547eb775f72cdae54ced6" 'https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/11692683195772/servers/330579/ips/private'



### 4.4.11 Images ### {#Images}

<p> A list of images. Each image contains IDs,
                names, and links -- other attributes are omitted. </p>


#### 4.4.11.1 List Images #### {#listImages}
#### GET v1.1/{tenant_id}/images

<p> Lists IDs, names, and links for images
                available to the account. Query parameters can be used to filter the list of images.</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>server</em> - xsd:anyURI</p><p>Filters the list of images returned by server. The <em>server</em> parameter specifies the server to filter by in URL format using the servers UUID.</p>
</li>
<li><p><em>name</em> - xsd:string</p><p>Filters the list of images returned by image <em>name</em>.</p>
</li>
<li><p><em>status</em> - csapi:ImageStatus</p><p> Filters the list of images returned by image <em>status</em>. Possible values for the status attribute include: UNKNOWN, ACTIVE, SAVING, ERROR, and DELETED. Images with an ACTIVE status can be used to boot a server. In-flight images will have the status attribute set to SAVING.</p>
</li>
<li><p><em>type</em> - xsd:string</p><p> Filters the list of images returned by image type. Currently the only allowable value of type is SNAPSHOT which will return a list of all the images that were created with the server action Create Image. </p>
<p>Legal values are:<ul>
<li><em>SNAPSHOT</em>  - Return only images that were created by the server action Create Server.
</li>
</ul></p>
</li>
<li><p><em>changes-since</em> - xsd:dateTime</p><p>Filters the list of images returned to those that have changed since the <em>changes-since</em> time. See <a href="#Polling"> Efficient Polling with the <em>Changes-Since</em> Parameter </a> .</p>
</li>
<li><p><em>marker</em> - csapi:UUID</p><p>The UUID of the last item in the previous list. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
<li><p><em>limit</em> - xsd:int</p><p>Sets the page size to <em>limit</em>. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <images xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <image id="34971" name="CentOS 5.8 Server 64-bit 20120828">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/34971" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/34971" rel="bookmark"/>
        </image>
        <image id="120" name="Ubuntu Precise 12.04 LTS Server 64-bit 20120424">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/120" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/>
        </image>
    </images>


JSON

    {
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


######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images'



#### 4.4.11.2 List Images Detail #### {#listDetailImages}
#### GET v1.1/{tenant_id}/images/detail

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>server</em> - xsd:anyURI</p><p>Filters the list of images returned by server. The <em>server</em> parameter specifies the server to filter by in URL format using the servers UUID.</p>
</li>
<li><p><em>name</em> - xsd:string</p><p>Filters the list of images returned by image <em>name</em>.</p>
</li>
<li><p><em>status</em> - csapi:ImageStatus</p><p> Filters the list of images returned by image <em>status</em>. Possible values for the status attribute include: UNKNOWN, ACTIVE, SAVING, ERROR, and DELETED. Images with an ACTIVE status can be used to boot a server. In-flight images will have the status attribute set to SAVING.</p>
</li>
<li><p><em>type</em> - xsd:string</p><p> Filters the list of images returned by image type. Currently the only allowable value of type is SNAPSHOT which will return a list of all the images that were created with the server action Create Image. </p>
<p>Legal values are:<ul>
<li><em>SNAPSHOT</em>  - Return only images that were created by the server action Create Server.
</li>
</ul></p>
</li>
<li><p><em>changes-since</em> - xsd:dateTime</p><p>Filters the list of images returned to those that have changed since the <em>changes-since</em> time. See <a href="#Polling"> Efficient Polling with the <em>Changes-Since</em> Parameter </a> .</p>
</li>
<li><p><em>marker</em> - csapi:UUID</p><p>The UUID of the last item in the previous list. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
<li><p><em>limit</em> - xsd:int</p><p>Sets the page size to <em>limit</em>. See <a href="#Pagination"> Paginated Collections </a> .</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <images xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <image created="2012-09-04T16:45:17Z" id="34971" name="CentOS 5.8 Server 64-bit 20120828" progress="100" status="ACTIVE" updated="2012-09-04T16:45:22Z">
            <metadata>
                <meta key="hp_image_type">
                    disk
                </meta>
                <meta key="image_location">
                    local
                </meta>
                <meta key="image_state">
                    available
                </meta>
                <meta key="project_id">
                    None
                </meta>
                <meta key="hp_md_version">
                    1
                </meta>
                <meta key="min_ram">
                    0
                </meta>
                <meta key="hp_image_id">
                    e66bad1137c6d519fc5c6fb175e45b71
                </meta>
                <meta key="owner">
                    None
                </meta>
                <meta key="hp_image_builddate">
                    20120828
                </meta>
                <meta key="architecture">
                    x86_64
                </meta>
                <meta key="min_disk">
                    0
                </meta>
                <meta key="hp_image_version">
                    20120828
                </meta>
            </metadata>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/34971" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/34971" rel="bookmark"/>
        </image>
        <image created="2012-05-07T04:54:46Z" id="120" name="Ubuntu Precise 12.04 LTS Server 64-bit 20120424" progress="100" status="ACTIVE" updated="2012-05-07T04:54:51Z">
            <metadata>
                <meta key="hp_image_type">
                    disk
                </meta>
                <meta key="image_location">
                    local
                </meta>
                <meta key="image_state">
                    available
                </meta>
                <meta key="project_id">
                    None
                </meta>
                <meta key="hp_md_version">
                    1
                </meta>
                <meta key="min_ram">
                    0
                </meta>
                <meta key="hp_image_id">
                    df4256e6c361380cb7613c74130feca9
                </meta>
                <meta key="owner">
                    None
                </meta>
                <meta key="hp_image_builddate">
                    20120424
                </meta>
                <meta key="architecture">
                    amd64
                </meta>
                <meta key="min_disk">
                    0
                </meta>
                <meta key="hp_image_version">
                    20120424
                </meta>
            </metadata>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/120" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/120" rel="bookmark"/>
        </image>
    </images>


JSON

    {
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


######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/detail'



### 4.4.12 Image ### {#Image}


#### 4.4.12.1 Get Image Details #### {#getImage}
#### GET v1.1/{tenant_id}/images/{image_id}

<p> Returns detailed information about the specified image. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p> Image ID. This ID is local to an Availability Zone</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <image created="2012-10-03T04:46:42Z" id="40747" name="image-1" progress="100" status="ACTIVE" updated="2012-10-03T04:48:25Z" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <metadata>
            <meta key="owner">
                36991859863737
            </meta>
            <meta key="min_disk">
                0
            </meta>
            <meta key="min_ram">
                0
            </meta>
            <meta key="key_1">
                value-1,value-1,value-1,value-1,value-1
            </meta>
            <meta key="key_2">
                value-2
            </meta>
        </metadata>
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747" rel="self"/>
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/images/40747" rel="bookmark"/>
    </image>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747'



#### 4.4.12.2 Delete Image #### {#deleteImage}
#### DELETE v1.1/{tenant_id}/images/{image_id}

<p> Deletes the specified image. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p> Image ID. This ID is local to an Availability Zone</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 204

######Example(s)

    curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40737'



### 4.4.13 Image Metadata ### {#ImageMetadata}


#### 4.4.13.1 List Metadata #### {#ImageMetadata_listMetadata}
#### GET v1.1/{tenant_id}/images/{image_id}/metadata

<p> Lists metadata associated with the resource.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p> Image ID. This ID is local to an Availability Zone</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <?xml version="1.0" encoding="UTF-8"?><metadata xmlns="http://docs.openstack.org/compute/api/v1.1"><meta key="key-2">value-2</meta><meta key="key-1">value-1</meta></metadata>

JSON

    {
        "metadata": {
            "key-1": "value-1",
            "key-2": "value-2"
        }
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747/metadata'



#### 4.4.13.2 Update Metadata #### {#ImageMetadata_updateMetadata}
#### POST v1.1/{tenant_id}/images/{image_id}/metadata

<p> Updates resource metadata. Updates will replace
                existing metadata items with the same key. Items not explicitly mentioned in the
                request will not be modified. An overLimit (<errorcode>413</errorcode>) fault may be
                thrown if the operation causes the maximum number of metadata items to be exceeded.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p> Image ID. This ID is local to an Availability Zone</p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>metadata</em> - csapi:Metadata</p><p> A set of key/value pairs. These pair replace any existing key/value pairs in the resources metadata with matching keys. Any key/value pairs in the parameter with keys that do not occur in the existing resource metadata are added to the resources metadata. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <metadata xmlns="http://docs.openstack.org/compute/api/v1.1">
        <meta key="key-1">value-1</meta>
        <meta key="key-2">value-2</meta>
    </metadata>


JSON

    {
        "metadata": {
            "key-1": "value-1"
        }
    }

######Response

**Status Code(s)** 200

XML

    <?xml version="1.0" encoding="UTF-8"?><metadata xmlns="http://docs.openstack.org/compute/api/v1.1"><meta key="key-2">value-2</meta><meta key="key-1">value-1</meta></metadata>

JSON

    {
        "metadata": {
            "key-1": "value-1"
        }
    }

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" -d '{"metadata": {"key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/30161/metadata'



#### 4.4.13.3 Create or Replace Metadata #### {#ImageMetadata_setMetadata}
#### PUT v1.1/{tenant_id}/images/{image_id}/metadata

<p>The metadata items set on the resource are those
                specified on the requests. Existing metadata items are replaced with the ones
                provided in the request. Metadata items, set previously, but not specified in the
                request are removed. </p>

<p> An overLimit (<errorcode>413</errorcode>) fault
                may be thrown if the maximum number of metadata items is exceeded. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p> Image ID. This ID is local to an Availability Zone</p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>metadata</em> - csapi:Metadata</p><p> A set of key/value pairs. These pair replace any existing key/value pairs in the resources metadata with matching keys. Any key/value pairs in the parameter with keys that do not occur in the existing resource metadata are added to the resources metadata. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <metadata xmlns="http://docs.openstack.org/compute/api/v1.1">
        <meta key="key-1">value-1</meta>
        <meta key="key-2">value-2</meta>
    </metadata>


JSON

    {
        "metadata": {
            "key-1": "value-1",
            "key-2": "value-2"
        }
    }

######Response

**Status Code(s)** 200

XML

    <?xml version="1.0" encoding="UTF-8"?><metadata xmlns="http://docs.openstack.org/compute/api/v1.1"><meta key="key-2">value-2</meta><meta key="key-1">value-1</meta></metadata>

JSON

    {
        "metadata": {
            "key-1": "value-1",
            "key-2": "value-2"
        }
    }

######Example(s)

    curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" -d '{"metadata": {"key-2": "value-2", "key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747/metadata'



### 4.4.14 Image Metadata Item ### {#ImageMetadataItem}


#### 4.4.14.1 Get Metadata Item #### {#ImageMetadataItem_getMetadataItem}
#### GET v1.1/{tenant_id}/images/{image_id}/metadata/{key}

<p> Retrieves a single metadata item by key. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p> Image ID. This ID is local to an Availability Zone</p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <?xml version="1.0" encoding="UTF-8"?><meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1">value-1</meta>

JSON

    {
        "meta": {
            "key-1": "value-1"
        }
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_1d85b38ddcd884cd98f4591c4c1c5d08097f1422fb7d75f1e631e99ea5343f1a" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747/metadata/key_1'



#### 4.4.14.2 Create or Update Metadata Item #### {#ImageMetadataItem_setMetadataItem}
#### PUT v1.1/{tenant_id}/images/{image_id}/metadata/{key}

<p> Sets a metadata item by its key. An overLimit
                    (<errorcode>413</errorcode>) fault may be thrown if the operation causes the
                maximum number of metadata items to be exceeded. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p> Image ID. This ID is local to an Availability Zone</p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1">value-1</meta>


JSON

    {
        "meta": {
            "key-1": "value-1"
        }
    }

######Response

**Status Code(s)** 200

XML

    <?xml version="1.0" encoding="UTF-8"?><meta key="key-1" xmlns="http://docs.openstack.org/compute/api/v1.1">value-1</meta>

JSON

    {
        "meta": {
            "key-1": "value-1"
        }
    }

######Example(s)

    curl -i -X 'PUT'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"meta": {"key-1": "value-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747/metadata/key-1'



#### 4.4.14.3 Delete Metadata Item #### {#ImageMetadataItem_deleteMetadataItem}
#### DELETE v1.1/{tenant_id}/images/{image_id}/metadata/{key}

<p> Deletes a metadata item. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>image_id</em> - xsd:integer</p><p> Image ID. This ID is local to an Availability Zone</p>
</li>
<li><p><em>key</em> - csapi:MetadataKey</p><p> A string no longer than 255 characters. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 204

######Example(s)

    curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_e733642e6e1e0eabea392c76ca4228a9adb63fce719b351f8c925d8caaa37ecc" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/images/40747/metadata/key_1'



### 4.4.15 Flavors ### {#Flavors}

<p> A list of flavors. Each flavor contains IDs,
                names, and links -- other attributes are omitted. </p>


#### 4.4.15.1 List Flavors #### {#listFlavors}
#### GET v1.1/{tenant_id}/flavors

<p> Lists IDs, names, and links for available
                flavors. 
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>minDisk</em> - xsd:int</p><p>Filters the list of flavors returned to include only those with at least <em>minDisk</em> gigabytes of disk storage.</p>
</li>
<li><p><em>minRam</em> - xsd:int</p><p>Filters the list of flavors returned to include only those with at least <em>minRam</em> megabytes of RAM.</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <flavors xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <flavor id="100" name="standard.xsmall">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/100" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/>
        </flavor>
        <flavor id="101" name="standard.small">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/101" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/101" rel="bookmark"/>
        </flavor>
        <flavor id="105" name="standard.2xlarge">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/105" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/105" rel="bookmark"/>
        </flavor>
        <flavor id="103" name="standard.large">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/103" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/103" rel="bookmark"/>
        </flavor>
        <flavor id="102" name="standard.medium">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/102" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/102" rel="bookmark"/>
        </flavor>
        <flavor id="104" name="standard.xlarge">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/104" rel="bookmark"/>
        </flavor>
    </flavors>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors'



#### 4.4.15.2 List Flavors Detail #### {#listDetailFlavors}
#### GET v1.1/{tenant_id}/flavors/detail

<p> Lists all details for available flavors. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
</ul>
**Query Parameters**

<ul>
<li><p><em>minDisk</em> - xsd:int</p><p>Filters the list of flavors returned to include only those with at least <em>minDisk</em> gigabytes of disk storage.</p>
</li>
<li><p><em>minRam</em> - xsd:int</p><p>Filters the list of flavors returned to include only those with at least <em>minRam</em> megabytes of RAM.</p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <flavors xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <flavor id="100" name="standard.xsmall">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/100" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/100" rel="bookmark"/>
        </flavor>
        <flavor id="101" name="standard.small">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/101" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/101" rel="bookmark"/>
        </flavor>
        <flavor id="105" name="standard.2xlarge">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/105" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/105" rel="bookmark"/>
        </flavor>
        <flavor id="103" name="standard.large">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/103" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/103" rel="bookmark"/>
        </flavor>
        <flavor id="102" name="standard.medium">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/102" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/102" rel="bookmark"/>
        </flavor>
        <flavor id="104" name="standard.xlarge">
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104" rel="self"/>
            <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/104" rel="bookmark"/>
        </flavor>
    </flavors>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors'



### 4.4.16 Flavor ### {#Flavor}


#### 4.4.16.1 Get Flavor Details #### {#getFlavor}
#### GET v1.1/{tenant_id}/flavors/{flavor_id}

<p> Lists details for the specified flavor. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p> The tenantId. (See <a href="#Authorization"> Authorization </a> .) </p>
</li>
<li><p><em>flavor_id</em> - xsd.int</p><p> Flavor ID. This ID is local to the Availability Zone. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200, 203

XML

    <flavor disk="480" id="104" name="standard.xlarge" ram="16384" rxtx_cap="0" rxtx_quota="0" swap="0" vcpus="4" xmlns="http://docs.openstack.org/compute/api/v1.1" xmlns:atom="http://www.w3.org/2005/Atom">
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104" rel="self"/>
        <atom:link href="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/36991859863737/flavors/104" rel="bookmark"/>
    </flavor>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/flavors/104'



### 4.4.17 Floating Ips ### {#floating-ips}


#### 4.4.17.1 List Floating IPs #### {#listFloatingIPs}
#### GET v1.1/{tenant_id}/os-floating-ips

<p>Lists floating IP addresses associated with the
                tenant or account.</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

JSON

    {
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
    }

XML

    <floating_ips xmlns="http://docs.openstack.org/compute/api/v1.1">
        <floating_ip>
            <instance_id>
                None
            </instance_id>
            <ip>
                15.185.227.211
            </ip>
            <fixed_ip>
                None
            </fixed_ip>
            <id>
                980
            </id>
        </floating_ip>
        <floating_ip>
            <instance_id>
                None
            </instance_id>
            <ip>
                15.185.228.121
            </ip>
            <fixed_ip>
                None
            </fixed_ip>
            <id>
                1146
            </id>
        </floating_ip>
    </floating_ips>


######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-floating-ips'



#### 4.4.17.2 Allocate Floating IP #### {#allocateFloatingIP}
#### POST v1.1/{tenant_id}/os-floating-ips

<p>Allocate a new floating IP address to a tenant
                or account.</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

JSON

    {
        "floating_ip": {
            "fixed_ip": null,
            "id": 980,
            "instance_id": null,
            "ip": "15.185.227.211"
        }
    }

XML

    <floating_ip xmlns="http://docs.openstack.org/compute/api/v1.1">
        <instance_id>
            None
        </instance_id>
        <ip>
            15.185.228.121
        </ip>
        <fixed_ip>
            None
        </fixed_ip>
        <id>
            1146
        </id>
    </floating_ip>


######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"pool": "pool-name"}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-floating-ips'



### 4.4.18 Floating IP ### {#floating-ip}


#### 4.4.18.1 Get Floating Ip #### {#getFloatingIP}
#### GET v1.1/{tenant_id}/os-floating-ips/{id}

<p>Get information about the specified floating
                IP.</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>id</em> (required) - None</p><p> The unique identifier associated with allocated floating IP address. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

XML

    <floating_ip xmlns="http://docs.openstack.org/compute/api/v1.1">
        <instance_id>
            None
        </instance_id>
        <ip>
            15.185.228.121
        </ip>
        <fixed_ip>
            None
        </fixed_ip>
        <id>
            1146
        </id>
    </floating_ip>


JSON

    {
        "floating_ip": {
            "fixed_ip": null,
            "id": 1146,
            "instance_id": null,
            "ip": "15.185.228.121"
        }
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-floating-ips/1146'



#### 4.4.18.2 Deallocate Floating IP #### {#deallocateFloatingIP}
#### DELETE v1.1/{tenant_id}/os-floating-ips/{id}

<p>Deallocates the floating IP address associated
                with floating_IP_address_ID.</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>id</em> (required) - None</p><p> The unique identifier associated with allocated floating IP address. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 202

######Example(s)

    curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_320eb8cc5998143e6e9fcf0e8fcaecaa8d161f1ec03f18b8de31e1b48b24f280" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-floating-ips/1677'



### 4.4.19 Keypairs ### {#os-keypairs}


#### 4.4.19.1 List Keypairs #### {#listKeypairs}
#### GET v1.1/{tenant_id}/os-keypairs

<p>Lists keypairs associated with the tenant or
                account. Returns the name, public key and fingerprint of each keypair associated
                with the account. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

XML

    <keypairs xmlns="http://docs.openstack.org/compute/api/v1.1">
        <keypair>
            <keypair>
                <public_key>
                    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRhFDIz1RJDgUW2tTRTZpJpbJyQbrUy586balui6Hj3g5I0Qogw42SRXr4EpM8S26M28OsfI3nfxPXQnJz41oUxutBrxaOo0wySinWE7imaDL7i4YE7pj8X3tPTDNzmmPI/VWheS97GwZcTdl3sI/wy4Fm/DOqU/DhpxmgfhKyOuhI65dNRglJN1RqQ6jc8i2egqAU5ZvDL1D9lBYjsKwwFtQXRU80DncbPdVtAITeR9X4CGsHKqTSAMbELfa4NZyX0y3AgYvJq9DpK1ySc5Y0f+iTuqvQvdsB69uTB8/n24ThV9GpiguashYlrWKcBKIxNcpEdg+Tla0zOPVro16x roland.hochmuth@hp.com
                </public_key>
                <name>
                    hochmuth.pub
                </name>
                <fingerprint>
                    57:64:ca:c3:83:25:69:19:03:6f:d2:66:83:d6:6e:20
                </fingerprint>
            </keypair>
        </keypair>
        <keypair>
            <keypair>
                <public_key>
                    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRhFDIz1RJDgUW2tTRTZpJpbJyQbrUy586balui6Hj3g5I0Qogw42SRXr4EpM8S26M28OsfI3nfxPXQnJz41oUxutBrxaOo0wySinWE7imaDL7i4YE7pj8X3tPTDNzmmPI/VWheS97GwZcTdl3sI/wy4Fm/DOqU/DhpxmgfhKyOuhI65dNRglJN1RqQ6jc8i2egqAU5ZvDL1D9lBYjsKwwFtQXRU80DncbPdVtAITeR9X4CGsHKqTSAMbELfa4NZyX0y3AgYvJq9DpK1ySc5Y0f+iTuqvQvdsB69uTB8/n24ThV9GpiguashYlrWKcBKIxNcpEdg+Tla0zOPVro16x roland.hochmuth@hp.com
                </public_key>
                <name>
                    key.pub
                </name>
                <fingerprint>
                    57:64:ca:c3:83:25:69:19:03:6f:d2:66:83:d6:6e:20
                </fingerprint>
            </keypair>
        </keypair>
        <keypair>
            <keypair>
                <public_key>
                    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjoclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSrnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2w== 
                </public_key>
                <name>
                    keypair-1
                </name>
                <fingerprint>
                    d3:e3:5f:26:dc:30:fc:04:57:91:ba:c0:1c:f8:8d:cd
                </fingerprint>
            </keypair>
        </keypair>
        <keypair>
            <keypair>
                <public_key>
                    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDZcOCJGRF2REub4+j5Y6LnF7Lk4xyvpdeqAEZYRJe8lC0YOhkF9PxOAQnSgRuAvcmFiff9E1Dt9yLCSlU40zRClLEMwchG4S51y4JI/mbMwppWKYxgPnIa9rHSIccEtZbhBU1MkwpUHeRcZE+b60y5xXiYSmVacmtwDZ89qf6TvQ== 
                </public_key>
                <name>
                    keypair-2
                </name>
                <fingerprint>
                    76:e3:b7:ca:95:91:fb:86:f7:fe:5d:d4:11:4d:77:65
                </fingerprint>
            </keypair>
        </keypair>
    </keypairs>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-keypairs'



#### 4.4.19.2 Create Keypair #### {#createKeypair}
#### POST v1.1/{tenant_id}/os-keypairs

<p> Generate or import a keypair. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> (required) - xsd:string</p><p> The <em>name</em> to be associated with the keypair. </p>
</li>
<li><p><em>public_key</em> - xsd:string</p><p> The ssh <em>public_key</em> to import. If not provided, a keypair will be generated and both the public and private keys are returned to the user. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <keypair>
        <name>keypair-2</name>
    </keypair>


JSON

    {
        "keypair": {
            "name": "keypair-1"
        }
    }

######Response

**Status Code(s)** 200

XML

    <keypair xmlns="http://docs.openstack.org/compute/api/v1.1">
        <public_key>
            ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDZcOCJGRF2REub4+j5Y6LnF7Lk4xyvpdeqAEZYRJe8lC0YOhkF9PxOAQnSgRuAvcmFiff9E1Dt9yLCSlU40zRClLEMwchG4S51y4JI/mbMwppWKYxgPnIa9rHSIccEtZbhBU1MkwpUHeRcZE+b60y5xXiYSmVacmtwDZ89qf6TvQ== 
        </public_key>
        <private_key>
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
        </private_key>
        <user_id>
            13311562627589
        </user_id>
        <name>
            keypair-2
        </name>
        <fingerprint>
            76:e3:b7:ca:95:91:fb:86:f7:fe:5d:d4:11:4d:77:65
        </fingerprint>
    </keypair>


JSON

    {
        "keypair": {
            "fingerprint": "d3:e3:5f:26:dc:30:fc:04:57:91:ba:c0:1c:f8:8d:cd",
            "name": "keypair-1",
            "private_key": "-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjo\nclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSr\nnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2wIDAQAB\nAoGAae+pgF8mWFKXliZ8Xv128BusfNAnuvEuOehFbWoqrdsr5q1a5ZUnte6TDq5A\nKFctoMA8GzkI9up2YrAp9cJOc+qYwNakMq1IQ/psxH7uga3Ey8aa3sTjUFK+rxMW\nZF5swcatcKiu7TzEgg5vcmfQr4r+547cihhWBKApEknt56ECQQDPEOq+aYhtthzg\ngisuYsOlB4bUpLTJUNZDLeO9UM7R5sIELblmOIfvoyqCY8bU4ZiPvMdFfkcajCva\nk51TIjcFAkEAxznWHyUfJEud5k2nJ8UUIAzDFv4YQEL25halw8tkl6bXxqnQ1Z44\njTVDAdsaIi9fVz8/0hQYDBlks41g6XZ6XwJBAK5uadGNxUfmqdzWytmAiZ9z/7kS\nJtmQJ27gMYFBmXhpE/fBLPVXmevdX+oHc2/Ru1sahCOehPdwLWEsCNQHdqECQGEg\nulp+z5rzXqzcKOVDuNcTQb2g7ZPO0e5FFlXJgGZLCiGpws2SkMGPOPbbqfcGn3W6\nuVOjRkIH00eSYrAPegMCQBpXlXHyLLNzmvnqQtSuC+efX90wcvsVPd1ytT7EHTSX\nv4gpK7hK3EyKStTsaADbYNjlh/mrMU2Q8Zlu7ybUI2Q=\n-----END RSA PRIVATE KEY-----\n",
            "public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjoclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSrnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2w== \n",
            "user_id": "13311562627589"
        }
    }

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"keypair": {"name": "keypair-1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-keypairs'



### 4.4.20 Keypair ### {#Unknown}


#### 4.4.20.1 Get Keypair #### {#getKeypair}
#### GET v1.1/{tenant_id}/os-keypairs/{keypair_name}

<p> Get the public key and fingerprint for the
                specified keypair. </p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>keypair_name</em> (required) - xsd:string</p><p> The name associated with a keypair. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

XML

    <keypair xmlns="http://docs.openstack.org/compute/api/v1.1">
        <public_key>
            ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjoclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSrnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2w== 
        </public_key>
        <name>
            keypair-1
        </name>
        <fingerprint>
            d3:e3:5f:26:dc:30:fc:04:57:91:ba:c0:1c:f8:8d:cd
        </fingerprint>
    </keypair>


JSON

    {
        "keypair": {
            "fingerprint": "d3:e3:5f:26:dc:30:fc:04:57:91:ba:c0:1c:f8:8d:cd",
            "name": "keypair-1",
            "public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQChJO5vnbzIRU45LFdm5ohdFtIDQo1jPB1xSnWu2vJtyw5wGFjoclpuFLstPMRDixloNTh36ff3XnW6Nb4CTpm5Vwz0V6Im2q56vTbS246Lw0+3fDSrnmwFkuJ7rqI5AKZkN4zJg/iJdsuJ768K7yVzwMHP/FWy6bUdRZm5ETjM2w== \n"
        }
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-keypairs/keypair-1'



#### 4.4.20.2 Delete Keypair #### {#deleteKeypair}
#### DELETE v1.1/{tenant_id}/os-keypairs/{keypair_name}

<p>Delete the specified keypair.</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>keypair_name</em> (required) - xsd:string</p><p> The name associated with a keypair. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 202

######Example(s)

    curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-keypairs/keypair-1'



### 4.4.21 Security Groups ### {#security_groups}


#### 4.4.21.1 List Security Groups #### {#listSecGroups}
#### GET v1.1/{tenant_id}/os-security-groups

<p>List security groups.</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

XML

    <security_groups xmlns="http://docs.openstack.org/compute/api/v1.1">
        <security_group id="12091" name="default" tenant_id="36991859863737">
            <rules>
                <rule id="31701" parent_group_id="12091">
                    <from_port>
                        22
                    </from_port>
                    <group/>
                    <ip_protocol>
                        tcp
                    </ip_protocol>
                    <to_port>
                        22
                    </to_port>
                    <ip_range>
                        <cidr>
                            0.0.0.0/0
                        </cidr>
                    </ip_range>
                </rule>
                <rule id="31703" parent_group_id="12091">
                    <from_port>
                        -1
                    </from_port>
                    <group/>
                    <ip_protocol>
                        icmp
                    </ip_protocol>
                    <to_port>
                        -1
                    </to_port>
                    <ip_range>
                        <cidr>
                            0.0.0.0/0
                        </cidr>
                    </ip_range>
                </rule>
                <rule id="31705" parent_group_id="12091">
                    <from_port>
                        None
                    </from_port>
                    <group>
                        <tenant_id>
                            36991859863737
                        </tenant_id>
                        <name>
                            default
                        </name>
                    </group>
                    <ip_protocol>
                        None
                    </ip_protocol>
                    <to_port>
                        None
                    </to_port>
                    <ip_range/>
                </rule>
            </rules>
            <description>
                default
            </description>
        </security_group>
        <security_group id="14703" name="security-group" tenant_id="36991859863737">
            <rules/>
            <description>
                A security group
            </description>
        </security_group>
        <security_group id="17753" name="security-group-1" tenant_id="36991859863737">
            <rules/>
            <description>
                Security group 1
            </description>
        </security_group>
        <security_group id="17755" name="security-group-2" tenant_id="36991859863737">
            <rules/>
            <description>
                Security group 2
            </description>
        </security_group>
    </security_groups>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups'



#### 4.4.21.2 Create Security Group #### {#createSecGroup}
#### POST v1.1/{tenant_id}/os-security-groups

<p>
                Create a new security group.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>name</em> - xsd:string</p><p> Name of the security group. </p>
</li>
<li><p><em>description</em> - xsd:string</p><p> Description of the security group. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <security_group name="security-group-2">
        <description>
                        Security group 2
                    </description>
    </security_group>


JSON

    {
        "security_group": {
            "description": "Security group 1",
            "name": "security-group-1"
        }
    }

######Response

**Status Code(s)** 200

XML

    <security_group id="17755" name="security-group-2" tenant_id="36991859863737" xmlns="http://docs.openstack.org/compute/api/v1.1">
        <rules/>
        <description>
            Security group 2
        </description>
    </security_group>


JSON

    {
        "security_group": {
            "description": "Security group 1",
            "id": 17753,
            "name": "security-group-1",
            "rules": [],
            "tenant_id": "36991859863737"
        }
    }

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_405ff353aa9bcf6960b49860eb967acd25620fa33d01f732fb220dcd3c6298f1" -d '{"security_group": {"name": "security-group-1", "description": "Security group 1"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups'



### 4.4.22 Security group ### {#security_group}


#### 4.4.22.1 Get Security Group #### {#getSecGroup}
#### GET v1.1/{tenant_id}/os-security-groups/{security_group_id}

<p>
                Get specified security group.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>security_group_id</em> - xsd:int</p><p> The unique identifier of the security group. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 200

XML

    <security_group id="17965" name="security-group-1" tenant_id="36991859863737" xmlns="http://docs.openstack.org/compute/api/v1.1">
        <rules>
            <rule id="42941" parent_group_id="17965">
                <from_port>
                    80
                </from_port>
                <group/>
                <ip_protocol>
                    tcp
                </ip_protocol>
                <to_port>
                    8080
                </to_port>
                <ip_range>
                    <cidr>
                        0.0.0.0/0
                    </cidr>
                </ip_range>
            </rule>
        </rules>
        <description>
            Security group 1
        </description>
    </security_group>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'GET'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_9b8591392fee0485651d33b11b71178e2b189cfda73bb9fa8eeb9a62411e40cd" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/17965'



#### 4.4.22.2 Delete Security Group #### {#deleteSecGroup}
#### DELETE v1.1/{tenant_id}/os-security-groups/{security_group_id}

<p>Delete a security group.</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>security_group_id</em> - xsd:int</p><p> The unique identifier of the security group. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 202

######Example(s)

    curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_87a5a0711fd8f07b04c5784ffcf7c86316c3fb62d027ae3779f475f6d66c61ae" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-groups/17865'



### 4.4.23 Security Group Rules ### {#security_group_rules}


#### 4.4.23.1 Create Security Group Rule #### {#createSecGroupRule}
#### POST v1.1/{tenant_id}/os-security-group-rules

<p>
                Create a security group rule. Security group rules specify the traffic that is allowed
                through to the server. For a packet to be delivered, it must meet all the criteria established by the
                rule.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
</ul>
**Data Parameters**

<ul>
<li><p><em>parent_group_id</em> (required) - xsd:int</p><p> ID of the security group to which this rule will belong. </p>
</li>
<li><p><em>ip_protocol</em> - xsd:string</p><p> Packets using <em>ip_protocol</em> are delivered to the server. If <em>ip_protocol</em> is specified, then <em>from_port</em> and <em>to_port</em> must also be specified. If <em>ip_protocol</em> is omitted, traffic is delivered without regard to protocol. </p>
<p>Legal values are:<ul>
<li><em>TCP</em> 
</li>
<li><em>UDP</em> 
</li>
<li><em>ICMP</em> 
</li>
</ul></p>
</li>
<li><p><em>from_port</em> - xsd:int</p><p> For TCP and UDP packets, traffic to ports between <em>from_port</em> and <em>to_port</em> are delivered to the server. <em>from_port</em> must be &gt;= <em>to_port</em>. For ICMP packets, <em>from_port</em> specifies the ICMP type of the packets that will be accepted. If <em>from_port</em> is specified, then <em>to_port</em> and <em>ip_protocol</em> must also be specified. </p>
</li>
<li><p><em>to_port</em> - xsd:int</p><p> For TCP and UDP packets, traffic to ports between <em>from_port</em> and <em>to_port</em> are delivered to the server. <em>from_port</em> must be &gt;= <em>to_port</em>. For ICMP packets, <em>from_port</em> specifies the ICMP type of the packets that will be accepted. If <em>from_port</em> is specified, then <em>to_port</em> and <em>ip_protocol</em> must also be specified. </p>
</li>
<li><p><em>cidr</em> - xsd:string</p><p> Traffic from source with an IP address in the range specified by <em>cidr</em> will be accepted. Exactly one of <em>cidr</em> and <em>group_id</em> must be specified. </p>
</li>
<li><p><em>group_id</em> - xsd:int</p><p> Traffic from all servers associated with the security group specified by <em>group_id</em> will be accepted. Exactly one of <em>cidr</em> and <em>group_id</em> must be specified. </p>
</li>
</ul>
######Request

XML

    <?xml version="1.0" ?>
    <security_group_rule xmlns="http://docs.openstack.org/compute/api/v1.1">
        <parent_group_id>17963</parent_group_id>
        <from_port>80</from_port>
        <ip_protocol>tcp</ip_protocol>
        <to_port>8080</to_port>
        <cidr>0.0.0.0/0</cidr>
    </security_group_rule>


JSON

    {
        "security_group_rule": {
            "cidr": "0.0.0.0/0",
            "from_port": "80",
            "ip_protocol": "tcp",
            "parent_group_id": "17965",
            "to_port": "8080"
        }
    }

######Response

**Status Code(s)** 200

XML

    <security_group_rule id="45003" parent_group_id="17963" xmlns="http://docs.openstack.org/compute/api/v1.1">
        <from_port>
            80
        </from_port>
        <group/>
        <ip_protocol>
            tcp
        </ip_protocol>
        <to_port>
            8080
        </to_port>
        <ip_range>
            <cidr>
                0.0.0.0/0
            </cidr>
        </ip_range>
    </security_group_rule>


JSON

    {
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
    }

######Example(s)

    curl -i -X 'POST'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_320eb8cc5998143e6e9fcf0e8fcaecaa8d161f1ec03f18b8de31e1b48b24f280" -d '{"security_group_rule": {"to_port": "8080", "cidr": "0.0.0.0/0", "from_port": "80", "parent_group_id": "17965", "ip_protocol": "tcp"}}' 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-group-rules'



### 4.4.24 Security Group Rule ### {#security_group_rule}


#### 4.4.24.1 Delete Security Group Rule #### {#deleteSecGroupRule}
#### DELETE v1.1/{tenant_id}/os-security-group-rules/{security_group_rule_id}

<p>
              Delete security group rule.
</p>

**Template Parameters**

<ul>
<li><p><em>tenant_id</em> - xsd:string</p><p>The ID for the tenant or account in a multi-tenancy cloud. </p>
</li>
<li><p><em>security_group_rule_id</em> - xsd:int</p><p> The unique identifier of the security group rule. </p>
</li>
</ul>
######Request

This call does not require a request body

######Response

**Status Code(s)** 202

######Example(s)

    curl -i -X 'DELETE'  -H "Content-type: application/json" -H "X-Auth-Token: HPAuth_9b8591392fee0485651d33b11b71178e2b189cfda73bb9fa8eeb9a62411e40cd" 'https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/36991859863737/os-security-group-rules/42937'




# 5. Additional References # {#Section5_}

1. [OpenStack API Documentation](http://api.openstack.org)
2. [OpenStack Compute Developer Guide - API v2](http://docs.openstack.org/api/openstack-compute/2/content/)

# 6. Glossary # {#Section6_}

**Server:** A server is a a virtual machine instance within HP Cloud Compute. See [Servers](#Servers).

**Flavor:** A set of attributes which describe the resources available to a server. See [Flavors](#Flavors).

**Image:** The contents of a disk. See [Images](#Images).

**Reboot:** Restart a server. See [Reboot Server](#rebootServer)

**Rebuild:** Reinitialize an existing server specifying a new image from which the server is to be booted. See [Rebuild Server](#rebuildServer).

**Resize:** Change the flavor of an existing image. This operation is not supported by HP Cloud Compute.
