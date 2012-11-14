---
layout: page
title: Block Storage API
title_section: The API specifications for HP Block Storage service.
description: "Block Storage API Specifications"
group: apispec

---
{% include JB/setup %}

Overview
========

HP Cloud Object Storage is an affordable, redundant, scalable, and
dynamic storage service offering. The core storage system is designed to
provide a safe, secure, automatically re-sizing and network accessible
way to store data. You can store an unlimited quantity of files and each
file can be as large as 5 gigabytes, plus with large object creation,
you can upload and store objects of virtually any size.

HP Cloud Object Storage allows users to store and retrieve files and
content via a simple Web Service (ReST: Representational State Transfer)
interface. There are also language-specific APIs that utilize the
ReSTful API but make it much easier for developers to integrate into
their applications.

For more details, please refer to the [object
storage](https://docs.hpcloud.com/object-storage) documentation.

Questions? Comments? Please let us know over at our
[forum](https://community.hpcloud.com/forum).

## API Maturity Level

**Maturity Level**: HP Cloud Storage is General Availability (GA).

**Version API Status**: Current

# Architectural View

The HP Cloud Object Storage API is implemented as a set of ReSTful web
services. All authentication and container/object operations can be
performed with standard HTTP calls. See the [Wikipedia
article](http://en.wikipedia.org/wiki/REST) for more information about
ReST.

The following constraints apply to the ReST API's HTTP requests:

-   Maximum number of HTTP headers per request: 90

-   Maximum length of all HTTP headers: 4096 bytes

-   Maximum length per HTTP request line: 8192 bytes

-   Maximum length of HTTP request: 5 gigabytes

-   Maximum length of container name: 256 bytes

-   Maximum length of object name: 1024 bytes

Container and object names should be properly URL-encoded prior to
interacting with the ReST interface (the language APIs handle URL
encoding/decoding) and the container and object names must be UTF-8
encoded. You must check the length restrictions against the URL-encoded
string.

Each ReST request against the HP Cloud Object Storage system requires
the inclusion of a specific authorization token HTTP header defined as
`X-Auth-Token`. Clients obtain this token, along with the HP Cloud
Object Storage URIs, by first using the Identity Service.

The ReST service identified with `X-Storage-Url` is used for managing
the data stored in the system. Example operations are creating
containers and uploading objects.

In the following sections, the purpose of each HTTP method depends on
the service the call is made against. For example, you can use a PUT
request against `X-Storage-Url` to create a container or upload an
object.

The language-specific APIs mask this system separation from the
programmer. They simply create a container and mark it *public* and it
handles calling out to the appropriate back-end services using the
appropriate ReST API.

Notable Differences from OpenStack
==================================

The HP Cloud Object Storage API is an implementation of OpenStack Object
Storage, but there are some differences to be aware of:

-   As noted in the Authentication section, HP Cloud Object Storage uses
    an OpenStack Keystone-based authentication mechanism. Not all
    OpenStack providers use this approach yet, but HP Cloud is among the
    early adopters of it.

-   HP Cloud Services Object Storage naming conventions are slightly
    more restrictive than those described in the OpenStack documentation
    referenced here. Specifically, containers and object names may not
    contain the following characters:

    -   single-quote: '

    -   double-quote: "

    -   back-tick: \`

    -   greater-than: \>

    -   less-than: \<

    -   slash: /

# Account-level View

## Tenants and HP Cloud Storage accounts

## Regions

## Service Catalog

Like all HP Cloud Service offerings, authentication for CDN is achieved
through the Identity Service, which returns an `X-Auth-Token` that is
used for subsequent requests to individual services.

For additional details on the Identity Service, please refer to
[https://docs.hpcloud.com/identity](https://docs.hpcloud.com/identity)


# REST API Specifications

## Service API Operations

**Host US West Region**: https://region-a.geo-1.objects.hpcloudsvc.com

**Host US East Region**: https://region-b.geo-1.objects.hpcloudsvc.com

**BaseURI**: {Host}/v1/{account}

## Table ##

| Resource  | Operation                   | HTTP Method | Path                   | JSON/XML?         | Privilege Level |
| :-------  | :-------------------------- | :---------- | :--------------------- | :---------------- | :-------------  |
| Account   | List containers             | GET         | /v1/account            | Y/Y               | Admin           |
| Account   | Retrieve account metadata   | GET         | /v1/account            | n/a               | Admin           |
| Container | List objects                | GET         | /v1/account/container  | Y/Y               | Admin           |
| Container | Retrieve container metadata | HEAD        | /v1/account/container  | n/a               | Admin           |
| Container | Create/update container     | PUT         | /v1/account/container  | n/a               | Admin           |
| Container | Delete container            | DELETE      | /v1/account/container  | n/a               | Admin           |
| Object    | Retrieve object             | GET         | /v1/account/container/object | n/a         | Admin           |
| Object    | Retrieve object metadata    | HEAD        | /v1/account/container/object | n/a         | Admin           |
| Object    | Create/Update Object        | PUT         | /v1/account/container/object | n/a         | Admin           |
| Object    | Chunked transfer encoding   | PUT         | /v1/account/container/object | n/a         | Admin           |
| Object    | Update object metadata      | POST        | /v1/account/container/object | n/a         | Admin           |
| Object    | Delete object               | DELETE      | /v1/account/container/object | n/a         | Admin           |



## 4.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

Many operations accept request headers. This section provides an overview of each request header. Consult the specific operation to determine if the header applies to the operation and any other notes that are of interest.

| Request Header Name | Description |
| :------------------ | :---------  |
| Accept              | Where applicable, this determines how the response body is formated. For example, you can use this to list the objects in a container as text (text/plain), JSON (application/json), XML (text/xml, application/xml) or HTML (text/html, application/html). |
| Content-Length      | Where applicable, this is the length in bytes of the body of the request |
| Content-Type        | Where applicable, this indicates the MIME type of an object. The Content-Type request header is optional. If not specified, HP Cloud Storage will attempt to identify the content type and assign a MIME type. If this fails, the type is set to application/octet-stream. If you specify a value in the request header, when you next do a HEAD or GET operation on the object, the Content-Type response header is set to the specified value.|
| X-Auth-Token        | When specified, this identifies the user making the request. In addition, if this token is being used by a user with Admin privilege level, the token must be scoped to the tenant associated with the account. If no token is specified, the request will fail unless tyou have been granted access to the resource by some other mechansim such as ACLs. See REF_NEEDED_HERE for more information about tokens. |


## 4.3 Common Response Headers

| Rersponse Header Name | Description |
| :-------------------- | :---------- |
| Content-Length        | When the response includes body, this indicates the length of the body in bytes. |
| Content-Type          | When the response includes a body, this indicates the MIME type of the response. |



API Operations for Storage Services
===================================

The following section describes the ReST API for interacting with the
storage component of HP Cloud Object Storage. All requests are directed
to the host and URL described in the `X-Storage-Url` HTTP header
obtained during successful authentication.

The following are some guidelines for the storage services:

-   Container names cannot exceed 256 bytes and cannot contain a '/'
    character

-   Object names cannot exceed 1024 bytes and have no character
    restrictions

-   Object and container names must be URL-encoded and UTF-8 encoded

Storage Account Services
========================

The following operations can be performed at the account level of the
URI. For example, the URI for the requests below must end with the HP
Cloud Object Storage account string:

      METHOD /v1/<account> HTTP/1.1
                    

List Containers
---------------

GET operations against the `X-Storage-Url` for an account are performed
to retrieve a list of existing storage containers ordered by name. The
following list describes the optional query parameters that are
supported with this request.

`limit`
:   For an integer value *n*, limits the number of results to at most
    *n* values.

`marker`
:   Given a string value *x*, return object names greater in value than
    the specified marker.

`format`
:   Specify either `json` or `xml` to return the respective serialized
    response.

At this time, a `prefix` query parameter is not supported at the account
level.

      GET /<api version>/<account> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                          

A list of containers is returned in the response body, one container per
line. A 204 (No Content) HTTP return code is passed back if the account
has no containers.

      HTTP/1.1 200 Ok
      Date: Thu, 07 Jun 2010 18:57:07 GMT
      Server: Apache
      Content-Type: text/plain; charset=UTF-8
      Content-Length: 32
                          

      images
      movies
      documents
      backups
                          

### Serialized List Output

If a `format=xml` or `format=json` argument is appended to the storage
account URL, the service serves extended container information
serialized in the chosen format. The sample responses below are
formatted for readability.

      GET /<api version>/<account>?format=json HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      Content-Length: 0
      X-Storage-Token: 182f9c0af0e828cfe3281767d29d19f4
                          

      HTTP/1.1 200 OK
      Date: Tue, 25 Nov 2008 19:39:13 GMT
      Server: Apache
      Content-Type: application/json; charset=utf-8
                          

~~~~ {.javascript}
  [
    {"name":"test_container_1", "count":2, "bytes":78},
    {"name":"test_container_2", "count":1, "bytes":17}
  ] 
                      
~~~~

      GET /<api version>/<account>?format=xml HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      Content-Length: 0
      X-Storage-Token: 182f9c0af0e828cfe3281767d29d19f4
                          

      HTTP/1.1 200 OK
      Date: Tue, 25 Nov 2008 19:42:35 GMT
      Server: Apache
      Content-Type: application/xml; charset=utf-8
                          

~~~~ {.xml}
  <?xml version="1.0" encoding="UTF-8"?>

  <account name="MichaelBarton">
    <container>
      <name>test_container_1</name>
      <count>2</count>
      <bytes>78</bytes>
    </container>
    <container>
      <name>test_container_2</name>
      <count>1</count>
      <bytes>17</bytes>
    </container>
  </account>
                      
~~~~

### List Large Number of Containers

The system returns a maximum of 10,000 container names per request. To
retrieve subsequent container names, you must make another request with
a 'marker' parameter. The marker indicates where the last list left off;
the system returns container names greater than this marker, up to
10,000 again. Note that the    marker    value should be URL-encoded prior
to sending the HTTP request.

If 10,000 is larger than desired, a 'limit' parameter may be given.

If the number of container names returned equals the limit given (or
10,000 if no limit is given), it can be assumed there are more container
names to be listed. If the container name list is exactly divisible by
the limit, the last request has no content.

For example, let's use a listing of five container names

      apples
      bananas
      kiwis
      oranges
      pears
                        

We'll use a limit of two to show how things work:

      GET /<api version>/<account>?limit=2
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

      apples
      bananas
                        

Since two items were received, you can assume there are more container
names to list, so you make another request with a marker of the last
item returned:

      GET /<api version>/<account>?limit=2&marker=bananas
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

      kiwis
      oranges
                        

Again, two items are returned; there may be more:

      GET /<api version>/<account>?limit=2&marker=oranges
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

      pears
                        

With this one-item response we received less than the limit number of
container names, indicating that this is the end of the list.

Retrieve Account Metadata
-------------------------

`HEAD` operations against an account are performed to retrieve the
number of containers and the total bytes stored in HP Cloud Object
Storage for the account. This information is returned in two custom
headers, `X-Account-Container-Count` and `X-Account-Bytes-Used`. Since
the storage system is designed to store large amounts of data, care
should be taken when representing the total bytes response as an
integer; when possible, convert it to a 64-bit unsigned integer if your
platform supports that primitive type.

      HEAD /<api version>/<account> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                          

The HTTP return code is 204 (No Content) if the request succeeds. A 401
(Unauthorized) is returned for an invalid account or access key.

      HTTP/1.1 204 No Content
      Date: Thu, 07 Jun 2010 18:57:07 GMT
      Server: Apache
      X-Account-Container-Count: 3
      X-Account-Bytes-Used: 323479
                          

Storage Container Services
==========================

This section documents the ReST operations that can be performed on
containers. All operations are valid HTTP request methods and resembles
this format:

      METHOD /v1/<account>/<container> HTTP/1.1
                    

List Objects
------------

GET operations against a storage container name are performed to
retrieve a list of objects stored in the container. Additionally, there
are a number of optional query parameters that can be used to refine the
list results.

A request with no query parameters returns the full list of object names
stored in the container, up to 10,000 names. Optionally specifying the
query parameters filters the full list and return a subset of objects.

`limit`
:   For an integer value *n*, limits the number of results to at most
    *n* values.

`marker`
:   Given a string value *x*, return object names greater in value than
    the specified marker.

`prefix`
:   For a string value *x*, causes the results to be limited to object
    names beginning with the substring *x*.

`format`
:   Specify either `json` or `xml` to return the respective serialized
    response.

`path`
:   For a string value *x*, return the object names nested in the pseudo
    path (assuming preconditions are met - see below).

`delimiter`
:   For a character *c*, return all the object names nested in the
    container (without the need for the directory marker objects).

<!-- -->

      GET /<api version>/<account>/<container>[?parm=value] HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

A list of objects is returned in the response body, one object name per
line. A 204 (No Content) HTTP return code is passed back if the
container is empty or does not exist for the specified account. If an
incorrect account is specified, the HTTP return code is 404 (Not Found).

      HTTP/1.1 200 Ok
      Date: Thu, 07 Jun 2010 18:50:19 GMT
      Server: Apache
      Content-Type: text/plain; charset=UTF-8
      Content-Length: 171
                        

      kate_beckinsale.jpg
      How To Win Friends And Influence People.pdf
      moms_birthday.jpg
      poodle_strut.mov
      Disturbed - Down With The Sickness.mp3
      army_of_darkness.avi
      the_mad.avi
                        

### Serialized List Output

If a `format=xml` or `format=json` argument is appended to the storage
account URL, the service serves extended object information serialized
in the chosen format. Other than the `?format=xml|json` parameter, it
returns the same status/errors codes. The sample responses below are
formatted for readability.

      GET /<api version>/<account>/<container>?format=json HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      Content-Length: 0
      X-Storage-Token: 182f9c0af0e828cfe3281767d29d19f4
                          

      HTTP/1.1 200 OK
      Date: Tue, 25 Nov 2008 19:39:13 GMT
      Server: Apache
      Content-Length: 387
      Content-Type: application/json; charset=utf-8
                        

~~~~ {.javascript}
 [
   {"name":"test_obj_1",
    "hash":"4281c348eaf83e70ddce0e07221c3d28",
    "bytes":14,
    "content_type":"application\/octet-stream",
    "last_modified":"2009-02-03T05:26:32.612278"},
   {"name":"test_obj_2",
    "hash":"b039efe731ad111bc1b0ef221c3849d0",
    "bytes":64,
    "content_type":"application\/octet-stream",
    "last_modified":"2009-02-03T05:26:32.612278"},
 ]
                    
~~~~

      GET /<api version>/<account>/<container>?format=xml HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Storage-Token: 182f9c0af0e828cfe3281767d29d19f4
                        

      HTTP/1.1 200 OK
      Date: Tue, 25 Nov 2008 19:42:35 GMT
      Server: Apache
      Content-Length: 643
      Content-Type: application/xml; charset=utf-8
                        

~~~~ {.xml}
  <?xml version="1.0" encoding="UTF-8"?>

  <container name="test_container_1">
    <object>
      <name>test_object_1</name>
      <hash>4281c348eaf83e70ddce0e07221c3d28</hash>
      <bytes>14</bytes>
      <content_type>application/octet-stream</content_type>
      <last_modified>2009-02-03T05:26:32.612278</last_modified>
    </object>
    <object>
      <name>test_object_2</name>
      <hash>b039efe731ad111bc1b0ef221c3849d0</hash>
      <bytes>64</bytes>
      <content_type>application/octet-stream</content_type>
      <last_modified>2009-02-03T05:26:32.612278</last_modified>
    </object>
  </container>
                    
~~~~

### List Large Number of Objects

The system returns a maximum of 10,000 object names per request. To
retrieve subsequent object names, another request must be made with a
'marker' parameter. The marker indicates where the last list left off
and the system returns object names greater than this marker, up to
10,000 again. Note that the    marker    value should be URL encoded prior
to sending the HTTP request.

If 10,000 is larger than desired, a 'limit' parameter may be given.

If the number of object names returned equals the limit given (or 10,000
if no limit is given), it can be assumed there are more object names to
be listed. If the container name list is exactly divisible by the limit,
the last request simply has no content.

For an example, let's use a listing of five object names:

      gala
      grannysmith
      honeycrisp
      jonagold
      reddelicious
                        

We'll use a limit of two to show how things work:

      GET /<api version>/<account>/<container>?limit=2
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

      gala
      grannysmith
                        

Since we received two items back, there are more object names to list.
So, you must make another request with a marker of the last item
returned:

      GET /<api version>/<account>/<container>?limit=2&marker=grannysmith
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

      honeycrisp
      jonagold
                        

Again two items are returned; there may be more:

      GET /<api version>/<account>/<container>?limit=2&marker=oranges
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

      reddelicious
                        

Now we received less than the limit number of container names,
indicating that we have the complete list.

### Pseudo-Hierarchical Folders/Directories

You can simulate a hierarchical structure in HP Cloud Object Storage by
following a few guidelines. Object names must contain the forward slash
character `/` as a path element separator and also create directory
marker objects; then they are able to traverse this nested structure
with the new *path* query parameter. This can best be illustrated by
example:

> **Note**
>
> For the purposes of this example, the container where the objects
> reside is called `backups`. All objects in this example start with a
> prefix of `photos` and should **NOT** be confused with the container
> name. In the example, the full URI of the `me.jpg` file would be
> <https://region-a.geo-1.objects.hpcloudsvc.com/v1/CF_xer7_343/backups/photos/me.jpg>

In the example, the following *real* objects are uploaded to the storage
system with names representing their full filesystem path:

      photos/animals/dogs/poodle.jpg
      photos/animals/dogs/terrier.jpg
      photos/animals/cats/persian.jpg
      photos/animals/cats/siamese.jpg
      photos/plants/fern.jpg
      photos/plants/rose.jpg
      photos/me.jpg
                        

To take advantage of this feature, the *directory marker* objects must
also be created to represent the appropriate directories. The following
additional objects need to be created. A good convention is to create
these as zero- or one-byte files with a Content-Type of
`application/directory`.

      photos/animals/dogs
      photos/animals/cats
      photos/animals
      photos/plants
      photos
                        

Now issuing a GET request against the container name coupled with the
`path` query parameter of the directory to list can traverse these
*directories*. Only the request line and results are depicted below
excluding other request/response headers.

      GET /v1/AccountString/backups?path=photos HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

      photos/animals
      photos/cats
      photos/me.jpg
                        

To traverse down into the `animals` directory, specify that path.

      GET /v1/AccountString/backups?path=photos/animals
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

      photos/animals/dogs
      photos/animals/cats
                        

By combining this `path` query parameter with the `format` query
parameter, users are able to easily distinguish between virtual
folders/directories by Content-Type and build interfaces that allow
traversal of the pseudo-nested structure.

You can also use a delimiter parameter to represent a nested directory
hierarchy without the need for the directory marker objects. You can use
any single character as a delimiter. The listings can return virtual
directories - they are virtual in that they don't actually represent
real objects. Like the directory markers, though, they have a
content-type of application/directory and be in a subdir section of json
and xml results.

If you have the following objects   photos/photo1, photos/photo2,
movieobject, videos/movieobj4   in a container, your delimiter parameter
query using slash (/) would give you photos, movieobject, videos.

    GET /v1/acct/container?delimiter=/
    Host: region-a.geo-1.objects.hpcloudsvc.com
    X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                  

Create Container
----------------

PUT operations against a storage container are used to create that
container.

Containers are storage compartments for your data. The URL encoded name
must be less than 256 bytes and cannot contain a forward slash '/'
character.

Containers can be assigned custom metadata by including additional HTTP
headers on the PUT request. The custom metadata is assigned to a
container via HTTP headers identified with the `X-Container-Meta-`
prefix.

      PUT /<api version>/<account>/<container> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

No content is returned. A status code of 201 (Created) indicates that
the container was created as requested. Container PUT requests are
idempotent and a code of 202 (Accepted) is returned when the container
already existed. If you request a PUT to a container with an
`X-Container-Meta-` prefix in the header, your GET/HEAD request
responses carry the metadata prefix from the container in subsequent
requests.

      HTTP/1.1 201 Created
      Date: Thu, 07 Jun 2007 18:50:19 GMT
      Server: Apache
      Content-Type: text/plain; charset=UTF-8
                        

Using custom container metadata, you can create information in the
header to effectively "tag" a container with metadata. The container
metadata restrictions are the same as object metadata, you can have 4096
bytes maximum overall metadata, 90 distinct metadata items at the most.
Each may have a 128 character name length with a 256 max value length
each. Any valid UTF-8 http header value is allowed for metadata, however
we recommend that you URL-encode any non-ASCII values using a "%"
symbol, followed by the two-digit hexadecimal representation of the
ISO-Latin code for the character.

      PUT /<api version>/<account>/<container> HTTP/1.1
      Host: storage.clouddrive.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
      X-Container-Meta-InspectedBy: JackWolf
                        

No content is returned. A status code of 201 (Created) indicates that
the container was created as requested. Container PUT requests are
idempotent and a code of 202 (Accepted) is returned when the container
already existed. If you request a PUT to a container with an
`X-Container-Meta-` prefix in the header, your GET/HEAD request
responses carry the metadata prefix from the container in subsequent
requests.

      HTTP/1.1 201 Created
      Date: Thu, 07 Jun 2010 18:50:19 GMT
      Server: Apache
      Content-Type: text/plain; charset=UTF-8
                        

Delete Container
----------------

DELETE operations against a storage container are used to permanently
remove that container. The container must be empty before it can be
deleted.

A `HEAD` request against the container can be used to determine if it
contains any objects.

      DELETE /<api version>/<account>/<container> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

*'Response '*

No content is returned. A status code of 204 (No Content) indicates
success, 404 (Not Found) is returned if the requested container was not
found, and a 409 (Conflict) if the container is not empty. No response
body is generated.

      HTTP/1.1 204 No Content
      Date: Thu, 07 Jun 2010 18:57:07 GMT
      Server: Apache
      Content-Length: 0
      Content-Type: text/plain; charset=UTF-8
                        

Retrieve Container Metadata
---------------------------

You use `HEAD` operations against a storage container to determine the
number of objects, and the total bytes of all objects stored in the
container. Since the storage system is designed to store large amounts
of data, you should care when representing the total bytes response as
an integer; when possible, convert it to a 64-bit unsigned integer if
your platform supports that primitive type.

      HEAD /<api version>/<account>/<container> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

The HTTP return code is 204 (No Content) if the container exists, and
404 (Not Found) if it does not. The object count and utilization are
returned in the `X-Container-Object-Count` and `X-Container-Bytes-Used`
headers respectively.

      HTTP/1.1 204 No Content
      Date: Wed, 11 Jul 2010 19:37:41 GMT
      Content-type: text/html
      X-Container-Object-Count: 7
      X-Container-Bytes-Used: 413
      X-Container-Meta-InspectedBy: JackWolf
                        

Storage Object Services
=======================

An object represents the data and any metadata for the files stored in
the system. Through the ReST interface, you can include metadata for an
object by adding custom HTTP headers to the request and the data payload
as the request body. Objects cannot exceed 5GB and must have names that
do not exceed 1024 bytes after URL encoding. However, objects larger
than 5GB can be segmented and then concatenated together so that you can
upload 5 GB segments and download a single concatenated object. You can
work with the segments and manifests directly with HTTP requests.

Retrieve Object
---------------

You can use GET operations against an object to retrieve the object's
data.

Note that you can perform conditional GET requests by using certain HTTP
headers as documented in RFC 2616. HP Cloud Object Storage supports the
following headers:

RFC 2616:
[http://www.ietf.org/rfc/rfc2616.txt](http://www.ietf.org/rfc/rfc2616.txt)

-   If-Match

-   If-None-Match

-   If-Modified-Since

-   If-Unmodified-Since

It is also possible to fetch a portion of data using the HTTP `Range`
header. At this time, HP Cloud Object Storage does not support the full
specification for `Range` but basic support is provided. HP Cloud Object
Storage only allows a single range that includes OFFSET and/or LENGTH.
We support a sub-set of `Range` and do not adhere to the full RFC-2616
specification. We support specifying OFFSET-LENGTH where either OFFSET
or LENGTH can be optional (not both at the same time). The following are
supported forms of the header:

-   `Range: bytes=-5` - last five bytes of the object

-   `Range: bytes=10-15` - the five bytes after a 10-byte offset

-   `Range: bytes=32-` - all data after the first 32 bytes of the object

<!-- -->

      GET /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

The object's data is returned in the response body. Object metadata is
returned as HTTP headers. A status of 200 (Ok) indicates success; status
404 (Not Found) is returned if no such object exists.

      HTTP/1.1 200 Ok
      Date: Wed, 11 Jul 2010 19:37:41 GMT
      Server: Apache
      Last-Modified: Fri, 12 Jun 2010 13:40:18 GMT
      ETag: b0dffe8254d152d8fd28f3c5e0404a10
      Content-type: text/html
      Content-Length: 512000
                        

      [ ... ]
                        

Create/Update Object
--------------------

PUT operations are used to write, or overwrite, an object's metadata and
content.

You can ensure end-to-end data integrity by including an MD5 checksum of
your object's data in the ETag header. You are not required to include
the ETag header, but it is recommended to ensure that the storage system
successfully stored your object's content.

The HTTP response includes the MD5 checksum of the data written to the
storage system. If you do not send the ETag in the request, you should
compare the value returned with your content's MD5 locally to perform
the end-to-end data validation on the client side. For segmented
objects, the ETag is the MD5 sum of the concatenated string of ETags for
each of the segments in the manifest, which only offers change detection
but not direct comparison.

You can assign custom metadata to objects by including additional HTTP
headers on the PUT request.

You can create the object with custom metadata via HTTP headers
identified with the `X-Object-Meta-` prefix.

      PUT /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
      ETag: 8a964ee2a5e88be344f36c22562a6486
      Content-Length: 512000
      X-Object-Meta-PIN: 1234
                        

      [ ... ]
                        

No response body is returned. A status code of 201 (Created) indicates a
successful write; status 412 (Length Required) denotes a missing
`Content-Length` or `Content-Type` header in the request. If the MD5
checksum of the data written to the storage system does NOT match the
(optionally) supplied ETag value, a 422 (Unprocessable Entity) response
is returned.

      HTTP/1.1 201 Created
      Date: Thu, 07 Jun 2010 18:57:07 GMT
      Server: Apache
      ETag: d9f5eb4bba4e2f2f046e54611bc8196b
      Content-Length: 0
      Content-Type: text/plain; charset=UTF-8
                        

### Large Object Creation

Objects that are larger than 5GB must be segmented prior to upload. You
then upload the segments like you would any other object and create a
manifest object telling HP Cloud Object Storage how to find the segments
of the large object. The segments remain individually addressable, but
retrieving the manifest object streams all the segments concatenated.
There is no limit to the number of segments that can be a part of a
single large object.

In order to ensure the download works correctly, you must upload all the
object segments to the same container and ensure each object name has a
common prefix where their names sort in the order they should be
concatenated. You also must create and upload a manifest file. The
manifest file is simply a zero-byte file with the extra
X-Object-Manifest: \<container\>/\<prefix\> header, where \<container\>
is the container the object segments are in and \<prefix\> is the common
prefix for all the segments.

It is best to upload all the segments first and then create or update
the manifest. With this method, the full object is not available for
downloading until the upload is complete. Also, you can upload a new set
of segments to a second location and then update the manifest to point
to this new location. During the upload of the new segments, the
original manifest is still available to download the first set of
segments.

      PUT /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: storage.clouddrive.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
      ETag: 8a964ee2a5e88be344f36c22562a6486
      Content-Length: 1
      X-Object-Meta-PIN: 1234
                      

      s
                        

No response body is returned. A status code of 201 (Created) indicates a
successful write; status 412 (Length Required) denotes a missing
`Content-Length` or `Content-Type` header in the request. If the MD5
checksum of the data written to the storage system does NOT match the
(optionally) supplied ETag value, a 422 (Unprocessable Entity) response
is returned.

You can continue uploading segments like this example shows, prior to
uploading the manifest.

      PUT /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: storage.clouddrive.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
      ETag: 8a964ee2a5e88be344f36c22562a6486
      Content-Length: 1
      X-Object-Meta-PIN: 1234
                      

      w
                        

Next, upload the manifest you created that indicates the container the
object segments reside within. Note that uploading additional segments
after the manifest is created causes the concatenated object to be that
much larger but you do not need to recreate the manifest file for
subsequent additional segments.

      PUT /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: storage.clouddrive.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
      Content-Length: 0
      X-Object-Meta-PIN: 1234
      X-Object-Manifest: container/object/segments
                      

      [...]
                        

The response's Content-Type for a GET or `HEAD` on the manifest is the
same as the Content-Type set during the PUT request that created the
manifest. You can easily change the Content-Type by reissuing the PUT
request.

### Chunked Transfer Encoding

Users can upload data without needing to know in advance the amount of
data to be uploaded. Users can do this by specifying an HTTP header of
`Transfer-Encoding:
              chunked` and not using a `Content-Length` header. A good
use of this feature would be doing a DB dump, piping the output through
gzip, then piping the data directly into HP Cloud Object Storage without
having to buffer the data to disk to compute the file size. If you
attempt to upload more that 5GB with this method, the server closes the
TCP/IP connection after 5GB and purge the customer data from the system.
You must take responsibility for ensuring the data they transfer is less
than 5GB or for splitting it into 5GB chunks, each in its own storage
object. If you have files that are larger than 5GB and still want to use
Object Storage, you can segment them prior to upload, upload them to the
same container, and then use a manifest file to allow downloading of a
concatenated object containing all the segmented objects, concatenated
as a single object.

      PUT /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
      Transfer-Encoding: chunked
      X-Object-Meta-PIN: 1234
                      

      19
      A bunch of data broken up
      D
       into chunks.
      0
                      

Enabling File Compression with the Content-Encoding Header
----------------------------------------------------------

The Content-Encoding header allows a file to be compressed without
losing the identity of the underlying media type of the file, for
example, a video.

In the example, the content-encoding header is assigned with an
attachment type that indicates how the file should be downloaded:

      PUT /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: storage.clouddrive.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
      Content-Type: video/mp4
      Content-Encoding: gzip
           

Enabling Browser Bypass with the Content-Disposition Header
-----------------------------------------------------------

When an object is assigned the Content-Disposition header you can
override a browser's default behavior for a file so that the downloader
saves the file rather than displaying it using default browser settings.

In the example, the content-encoding header is assigned with an
attachment type that indicates how the file should be downloaded.

      PUT /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: storage.clouddrive.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
      Content-Type: image/tiff
      Content-Disposition: attachment; filename=platmap.tif
                        

Copy Object
-----------

Suppose you upload a file with the wrong object name or content type, or
you needed to move some objects to another container. Without a
server-side copy feature, you would need to repeat uploading the same
content and then delete the existing object. With server-side object
copy, you can save the step of re-uploading the content and save the
associated bandwidth charges, if any were to apply.

There are two ways to copy an existing object to another object in HP
Cloud Object Storage. One way is to do a PUT to the new object (the
target) location, but add the    X-Copy-From    header to designate the
source of the data. The header value must be the container and object
name of the source object in the form of    /container/object   . Also, the
X-Copy-From PUT requests require a Content-Length header, even if it is
zero (0).

    PUT /<api version>/<account>/<container>/<destobject> HTTP/1.1
    Host: <storage URL>
    X-Auth-Token: <some-auth-token>
    X-Copy-From: /<container>/<sourceobject>
    Content-Length: 0                    

The second method is similar. Do a COPY to the existing object, and
include the    Destination    header to specify the target of the copy. The
header value is the container and new object name in the form of
   /container/object   . COPY /\<api
version\>/\<account\>/\<container\>/\<sourceobject\> HTTP/1.1 Host:
\<storage URL\> X-Auth-Token: \<some-auth-token\> Destination:
/\<container\>/\<destobject\>

With both of these methods, the destination container must exist before
attempting the copy. If you wanted to perform a move of the objects
rather than a copy, you would need to send a DELETE request to the old
object. A move simply becomes a COPY + DELETE. All metadata is preserved
during the object copy. Note that you can set metadata on the request to
copy the object (either the PUT or the COPY) and the metadata overwrites
any conflicting keys on the target (new) object. One interesting use
case is to copy an object to itself and set the content type to a new
value. This is the only way to change the content type of an existing
object.

Delete Object
-------------

You can use DELETE operations on an object to permanently remove that
object from the storage system (metadata and data).

Deleting an object is processed immediately at the time of the request.
Any subsequent GET, `HEAD`, POST, or DELETE operations return a 404 (Not
Found) error.

      DELETE /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

No response body is returned. A status code of 204 (No Content)
indicates success, status 404 (Not Found) is returned when the object
does not exist.

      HTTP/1.1 204 No Content
      Date: Thu, 07 Jun 2010 20:59:39 GMT
      Server: Apache
      Content-Type: text/plain; charset=UTF-8
                        

Retrieve Object Metadata
------------------------

`HEAD` operations on an object are used to retrieve object metadata and
other standard HTTP headers.

The only required header sent in the request is the authorization token.

      HEAD /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
                        

No response body is returned. Metadata is returned as HTTP headers. A
status code of 200 (OK) indicates success; status 404 (Not Found) is
returned when the object does not exist.

      HTTP/1.1 200 OK
      Date: Thu, 07 Jun 2010 20:59:39 GMT
      Server: Apache
      Last-Modified: Fri, 12 Jun 2010 13:40:18 GMT
      ETag: 8a964ee2a5e88be344f36c22562a6486
      Content-Length: 512000
      Content-Type: text/plain; charset=UTF-8
      X-Object-Meta-Meat: Bacon
      X-Object-Meta-Fruit: Bacon
      X-Object-Meta-Veggie: Bacon
      X-Object-Meta-Dairy: Bacon
                        

Update Object Metadata
----------------------

You can use POST operations against an object to set and overwrite
arbitrary key/value metadata. You cannot use the POST operation to
change any of the object's other headers such as `Content-Type`, `ETag`,
etc. It is not used to upload storage objects (see PUT).

Key names must be prefixed with `X-Object-Meta-`. A POST request deletes
all existing metadata added with a previous `PUT/POST`.

      POST /<api version>/<account>/<container>/<object> HTTP/1.1
      Host: region-a.geo-1.objects.hpcloudsvc.com
      X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
      X-Object-Meta-Fruit: Apple
      X-Object-Meta-Veggie: Carrot
                          

No response body is returned. A status code of 202 (Accepted) indicates
success; status 404 (Not Found) is returned when the requested object
does not exist.

      HTTP/1.1 202 Accepted
      Date: Thu, 07 Jun 2010 20:59:39 GMT
      Server: Apache
      Content-Length: 0
      Content-Type: text/plain; charset=UTF-8
                        
Troubleshooting and Examples
============================

This section introduces a command-line utility, cURL, and demonstrates
interacting with the ReST interfaces through that utility.

Using cURL
==========

cURL is a command-line tool which is available on most UNIX  -like
environments and Mac OS X   and can be downloaded for Windows  . For more
information on cURL, visit [http://curl.haxx.se/](http://curl.haxx.se/).

cURL allows you to transmit and receive HTTP requests and responses from
the command-line or from within a shell script. This makes it possible
to work with the ReST API directly without using one of the client APIs.

The following cURL command-line options will be used

`-X METHOD`
:   Specify the HTTP method to request (`HEAD`, GET, etc.)

`-i`
:   Dump HTTP response headers to stdout.

`-H HEADER`
:   Specify an HTTP header in the request.

Determining Storage Usage
=========================

You can send a `HEAD` request to the storage service to determine how
much data you have stored in the system and the number of containers you
are using. Use the `-X` switch to specify the correct HTTP method and
the `-i` to dump the HTTP response headers to terminal output (stdout).

                      


            

The HTTP request must include a header to specify the authentication
token. The HTTP headers in the response indicate the number of
containers in this storage account and the total bytes stored for the
entire account.

Listing and Creating Containers
===============================

The simplest operation for Object Storage is to simply list the
containers you have, which when you don't have any containers yet isn't
terribly exciting:


            

So, you take the X-Auth-Token obtained from the authentication
operation, pass it as a header value, execute the operation against the
URL obtained from the authentication operation, and force the GET verb
with the -X switch. What you get back tells you there aren't any
containers.

Next, let's create a container and then do the listing again:

                


                

Append the container name to the URL and force the PUT verb. That
creates a container, which we can now see when we do a listing:

                


                

You may have noticed the account metadata that comes back from the
listing call. As you'd guess, it tells you how many objects you have,
how much space you are using, and how many containers you are using.

Paging Lists of Containers
==========================

If you have a large number of containers, it is sometimes more
convenient to page through them than getting some big long list of them.
If I create more containers and then do a regular listing, here's what
it looks like with five containers:

                


            

Suppose I want a page size of 2, all I do is append a ""?limit=2"" to my
URL:

                


                

Not surprisingly, I only get two containers. To get the next page, you
tell the system which item you last saw with the "marker=" specifier:

                


                

Notice that I had to use \\& so that my bash shell didn't try to
interpret the & as wanting to run something in its own thread. With that
in place, you get the next page of items that appear after the marker.

Serialized Output
=================

In other situations, like if you are working on a language binding on
top of the ReST API, you might want more structured data back from the
method calls. By appending a "format=" and then choosing either json or
xml, you can get that structured data back you've been dreaming about.

                


            

                


                

The remainder of the examples in this document use the standard,
non-serialized output but all operations accept the format argument. You
might notice that when you use one of the formats, you get more
information about the containers. That's the per-container metadata,
which is covered in the next section.

Container Metadata and Deleting Containers
==========================================

You can get at container metadata directly simply by appending the name
of the container to a HEAD request:

                


            

Not very exciting without any objects in the container, but you get the
idea. While you cannot update or delete container metadata, you can
delete a container:

                


                

Then let's confirm the delete by listing the containers again:

                


                

Special Metadata: Container ACLs
================================

A particularly important metadata element for containers is
`X-Container-Read`, which establishes the ACL permissions on who can
read objects in the container. Prior to being set, the ACL logic default
to only be accessible to someone with a valid X-Auth-Token for the
account in question. Performing a simple listing of a container shows us
the absence of X-Container-Read in this default situation:

                


            

Now we'll set the X-Container-Read. For a full explanation of valid
values, see: http://swift.openstack.org/misc.html\#acls but for our
simple needs, we'll enable read access and listing access to anybody:

                


                

To see the metadata change, do a listing again:

                


                

The side effect of giving anybody read access is that any object in the
container is now accessible from a browser simply by entering the
X-Storage-URL used throughout the session and append the object name.
For example:

https://region-a.geo-1.objects.hpcloudsvc.com/v1/AUTH\_a23f73d2-abfb-4656-af94-32ddec35dab8/jerry/cereal.jpg

would be the URL of an object named "cereal.jpg" in the container
"jerry" that has been made publicly accessible using this method.

Creating Objects
================

Enough with containers already, let's start to upload some objects.
Suppose you had a local directory full of dog pictures:


            

In order to put one of them in a container called "dogs" with cURL,
you'd do this:

                


                

The object gets named whatever we append to the URL path beyond the
container name (JingleRocky.jpg in this case) and the -T switch lets us
name a file to push with the operation as the request body (also
JingleRocky.jpg in thie case, although they don't have to be the same).
We can confirm the upload by checking the container again:

                


                

Notice that the container metadata now reflects the number of objects
and the bytes match what we saw when we did the directory listing. After
uploading the other two similarly, we get a full object listing:

                


                

Paging Lists of Objects
=======================

Exactly like listing containers, objects can be listed in pages at a
time using markers to denote pages. From the previous example with 3
objects in the container "dogs", the list can be paged with the "limit"
query string variable:

                


                

And the second page fetched with:

                


                

Retrieve, Copy, and Delete Objects
==================================

Now we'll retrieve an object previously uploaded. First, we'll remove
the local copy:


                

Be sure not to use -i switch here since what we want is the raw data,
which we'll then pipe to a file:

                


                

Next, Object Storage provides a facility to copy objects from one
container to another entirely on the server side. To do this, you do a
PUT with the destination container and new object name while passing a
special X-Copy-From header and a Content-Length of zero:

                


                

Next, Object Storage provides a facility to copy objects from one
container to another entirely on the server side. To do this, you do a
PUT with the destination container and new object name while passing a
special X-Copy-From header and a Content-Length of zero:

                


                

To delete an object from its container, simply use the DELETE verb:

                


                

Confirming the deletion by doing a container listing:

                


                

Object Metadata
===============

Objects can have whatever metadata keys/values you choose. Simply POST
an HTTP Header to the object in the form of X-Object-Meta-\<key\>:
\<value\>. Like this:

                


                

And then read the object metadata with a HEAD on the object path:

                


                

Pseudo-Hierarchical Folders/Directories
=======================================

For the last section, we come to the most confusing concept in Object
Storage. In most storage systems, you have the ability to create custom
hierarchies of files so that you can better organize them. On its
surface, Object Storage only gives you one level of hierarchy in the
form of containers. However, it turns out that you can get creative with
naming your objects to give yourself the same effect as having
hierarchical containers.

Let's start with a fresh container without any objects in it:

                


                

Now list the new container:

                


                

Next, add an object but prefix the name with the hierarchy desired:

                


                

Do it again with a different object and prefix:

                


                

Now list the container, revealing the prefixes:

                


                

If you want to perform hierarchical listings, with the prefixes in
place, you can use the "path" query string variable:

                


                

If you wanted to see what prefixes were in place, you can use the
"delimiter" query string variable to distinguish prefix paths from
object names:

                


                

Using these in combination allows you to discover directories within a
particular path and then further drill down based on the results.