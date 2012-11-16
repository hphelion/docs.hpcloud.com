---
layout: page
title: HP Cloud Object Storage API
title_section: The API specifications for HP Cloud Object Storage service.
description: "HP Cloud Object Storage API Specifications"
group: apispec

---
{% include JB/setup %}

1.0 Overview

HP Cloud Object Storage is an affordable, redundant, scalable, and
dynamic storage service. The core storage system is designed to
provide a safe, secure, network accessible
way to store data. You can store an unlimited quantity of files and each
file can be as large as 5 gigabytes, plus with large object creation,
you can upload and store objects of virtually any size.

HP Cloud Object Storage allows users to store and retrieve files and
content via a simple Web Service (ReST: Representational State Transfer)
interface. 

## API Maturity Level

**Maturity Level**: HP Cloud Storage is General Availability (GA).

**Version API Status**: Current

2. Architectural View

The HP Cloud Object Storage API is implemented as a set of ReSTful web
services. All authentication and container/object operations can be
performed with standard HTTP calls. See the [Wikipedia
article](http://en.wikipedia.org/wiki/REST) for more information about
ReST.

## 2.1 Resources

The HP Cloud Storage API allows the management of the following resources:

* Account
* Container
* Object

### 2.x.x <a id="account_resource"></a>HP Cloud Storage Accounts

The account is the top level resource in the hierarcy. An account is assigned when you activate HP Cloud Object Storage.
There is a one-to-one relationship between an account and the _tenant_. In fact, for most users, the HP Cloud Storage account and tenand _Id_ are the same.

If you subscribed to the HP Cloud Beta program, your HP Cloud Storage account name may start with "AUTH_", followed by a long number. This makes
no difference to how you use the API. In all cases, you should use the endpoint from the service catalog that the HP Cloud Identity Service supplies when authenticating yourself.  

There is more about [tenants and accounts](#tenants_account) later in this document. 
There is more about using the [HP Cloud Identity Service](#getting_tokens) later in this document.

### 2.x.x <a id="container_resource">HP Cloud Storage Containers

A container provides a way for you to organise your objects. 
You can pick any name that is meaningful to you. 
However, see [Container and Object Naming](#naming) for restrictions on container names.

### 2.x.x <a id="object_resource"></a>HP Cloud Storage Objects

An object provides a way for you to store an arbitrary blob of data. 
This may be a document, image, video, backup file and anything else required by your application.
You can pick any name that is meaningful to you. However, see [Container and Object Naming](#naming) for restrictions on object names.

Objects have a size limit of 5 gigabytes.  However, objects larger
than 5GB can be segmented and then concatenated together so that you can
upload 5GB segments and download a single concatenated object. You can
work with the segments and manifests directly with HTTP requests. 

In addition, to storing the content of an object, you may also associate meta-data with an object. 

While the primary organisational structure in HP Cloud Object Storage is the container, you may use object names as a way to
further organise your data. A common usage of this is to include a delimiter character such as slash ('/') character in the object name. For example, "vacation/pic1.jpg". If this object is stored in a container called "photos", the URI for the object would include "photos/vacation/pic1.jpg". While this appears to allow hierarchies similar to a file system's directory structure, it is important to understand that there is no such hierarchy in HP Cloud Object Storage.
For example, if you simply created a container called "photos" and then created an object called "vacation/pic1.jpg",
you cannot access "photos/vacation" -- there is no such object in the system. 
For more, see [Pseudo-Hierarchical Folders/Directories](#pseudo_hierachies).

## 2.xx <a id="#naming"><a/>Container and Object Naming

Container and object names should be properly URL-encoded prior to
interacting with the ReST interface (the language APIs handle URL
encoding/decoding) and the container and object names must be UTF-8
encoded. You must check the length restrictions against the URL-encoded
string.

Container names must not contain the slash ('/'), double-quote ('"'), less-than ('\<') or
greater-than ('\>') characters.
The container name length is limited to 256 bytes.

Object names must not contain the double-quote ('"'), less-than ('\<') or
grater-than ('\>') characters.
The object name length is limited to 1024 bytes.

Although you use URL-encoding to specify the URI of a container or object, when the API returns names (as in, listing a container), the displayed names are not URL-encoded (i.e., they are the original names).

## 2.xx Consistency

TBS

### 2.x.x <a id="creation_guarantees"></a>Creation Guantees

When you create a container of object, the HP Cloud Object Storage system creates several copies of the container or object.
The PUT operation makes sure that the container or object is written to disk drives before returning a success code.
However, it does not wait for all disk drive operations to complete -- as soon as there are two copies known to have been
successfully written to disk, the operation can complete. Subsequent copies are written in the background after the
API has returned to you.

## 2.xx Success and Error Handling

### 2.x.x <a id="http_codes"></a>HTTP Status Codes

409 Conflict - You are not allowed to perform the requested operation. For example, you cannot delete a container that contains objects.

## 2.xx Arbitrary Limits

The following constraints apply to the ReST API's HTTP requests:

-   Maximum number of HTTP headers per request: 90

-   Maximum length of all HTTP headers: 4096 bytes

-   Maximum length per HTTP request line: 8192 bytes

-   Maximum length of HTTP request: 5 gigabytes

-   Maximum length of container name: 256 bytes

-   Maximum length of object name: 1024 bytes

## 2.xx Authentication and Access Controls

### 2.xx.x Overview

The HP Cloud Object Storage system provides a number of ways to control who can access and change data in an account, container or object. 
Authenication services are provided by the [HP Cloud Identity Service](https://docs.hpcloud.com/identity). You use this serice to manage
your passwords and access keys. HP Cloud Object Storage interacts with the Identity Service to verify who you are.

In conjunction with the HP Cloud Identity Service, the HP CLoud Object Storage service provides a number of ways to control access to the system as follows:

* Authentication tokens. Using the HP Cloud Identity Service API, you can authenticate yourself for a specific tenant. The HP Cloud Identity Service returns a token. In subsequent operations, you include this token in the X-Auth-Token request header. The value of the token is used to identify you. If you are associated with the tenant, you now have full acccess to the HP Cloud Object Storage _account__. See [Using Authentication Tokens](#using_tokens) for more information.

* General Access Control Lists (ACLs). You can apply an ACL as meta-data on a container. This allows you to make the container and it's objects world readable or writtable. See [General Access Control Lists](#general_acls) for more information.

* Cross-tenant Access Control Lists (ACLs). This allows you to make the container and its objects readable or writeable by specific users. See [Cross-tenant Access Control Lists](#cross_tenant_acls) for more information.

* Temporary URLs. This allows you to create a URL that encodes the Access Key information needed to get or put an object. The resulting URL contains enough information to allow it to be used without reference the HP Cloud Identity Service. Speficically, since it does not require you to use the X-Auth-Token request header, making it suitable for embedding in HTML pages and usuable by ordinary browsers. The URL has an expiry date, hence the URL is temporary. See [Temporary URLs](#temp_url) for more information.

* FormPOST. This is similar in concept to Temporary URLs except the encoding is done in a HTML form. This makes it possible to upload objects directly
using a standard web browser. See [FormPOST](#formpost) for more information.

* Signature Based Authentication. This allows a client to use HP Cloud Identity Service _Access Keys_ to "sign" the URL and headers of a request. Since the client has the Access Keys, it does not need to refer to the HP Cloud Identity Service to authenticate itself. Instead, a valid signature in the request allows HP Cloud Obkect Storage to authenticate the request and identify the user. See [Signature Based Authentication](#signature_auth)
 
### 2.xx.x <a id="using_tokens"></a>Using Authentication Tokens

TBS -- new stuff -- esp

* Admin role
* Scoped for the tenant/account
* Unscoped
* Scoped to a different tenant

### 2.xx.x <a id="general_acls"></a>General Access Control Lists

TBS -- from the legacy document

### 2.xx.x <a id="cross_tenant_acls"></a>Cross-tenant Access Control Lists

TBS -- from the legacy document

### 2.xx.x <a id="temp_url"></a>Temporary URLs

TBS -- from the legacy document

### 2.xx.x <a id="formpost"></a>FormPOST

TBS -- from the lagacy document

### 2.xx.x <a id="signature_auth">Signature Based Authentication

TBS -- from the legacy document

## 2.xx <a id="pagination"></a>Retrieving large number of container or object names

When doing a GET request against an account or container, the service returns a maximum of 10,000 names per request. To
retrieve subsequent names, you must make another request with
a *marker* parameter. The marker indicates where the last list left off;
the system returns  names greater than this marker, up to
10,000 again. Note that the marker value should be URL-encoded prior
to sending the HTTP request.

If 10,000 is larger than desired, a *limit* parameter may be given.

If the number of  names returned equals the limit given (or
10,000 if no limit is given), it can be assumed there are more
names to be listed. If the  name list is exactly divisible by
the limit, the last request has no content.

For example, let's use a listing of five names

      apples
      bananas
      kiwis
      oranges
      pears
                        

We'll use a limit of two to show how things work:

      GET /v1/123456789101234?limit=2

      apples
      bananas
                        

Since two items were received, you can assume there are more
names to list, so you make another request with a marker of the last
item returned:

      GET /v1/123456789101234?limit=2&marker=bananas
     
      kiwis
      oranges
                        

Again, two items are returned; there may be more:

      GET /<api version>/123456789101234?limit=2&marker=oranges
      
      pears
                        

With this one-item response we received less than the limit number of names, indicating that this is the end of the list.

## 2.xx <a id="pseudo_hierachies"></a>Pseudo-Hierarchical Folders/Directories/


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

## 2.xx <a id="conditional_get"></a>Conditional GET of objects                  

You can perform conditional GET requests of an object by using certain HTTP
headers as documented in [RFC 2616](http://www.ietf.org/rfc/rfc2616.txt](http://www.ietf.org/rfc/rfc2616.txt). 
HP Cloud Object Storage supports thefollowing headers:

* If-Match
* If-None-Match
* If-Modified-Since
* If-Unmodified-Since

## 2.xx <a id="range_request"></a>Retrieving a portion of object data

It is also possible to fetch a portion of an object's data using the HTTP _Range_
header. At this time, HP Cloud Object Storage does not support the full
specification for _Range_ but basic support is provided. 

HP Cloud Object
Storage only allows a single range that includes OFFSET and/or LENGTH.
We support a sub-set of _Range_ and do not adhere to the full RFC-2616
specification. We support specifying OFFSET-LENGTH where either OFFSET
or LENGTH can be optional (not both at the same time). 

The following examples show the supported forms of the header:

* `Range: bytes=-5` - last five bytes of the object

* `Range: bytes=10-15` - the five bytes after a 10-byte offset

* `Range: bytes=32-` - all data after the first 32 bytes of the object

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

      PUT /v1/1234567891234/test_container_1/test_obj_1 HTTP/1.1
      X-Auth-Token: HPAuth_1234
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

      PUT /v1/<account>/<container>/<object> HTTP/1.1
      X-Auth-Token: HPAuth: 1234
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
      X-Auth-Token: HPAuth_1234
      Content-Length: 0
      X-Object-Meta-PIN: 1234
      X-Object-Manifest: container/object/segments
                      

      [...]
                        

The response's Content-Type for a GET or `HEAD` on the manifest is the
same as the Content-Type set during the PUT request that created the
manifest. You can easily change the Content-Type by reissuing the PUT
request.

2.xx <a id="transfer_encoding_request"></a>Chunked Transfer Encoding

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
                      

## 2.xx <a id="content_encoding_header">Enabling File Compression with the Content-Encoding Header


The Content-Encoding header allows a file to be compressed without
losing the identity of the underlying media type of the file, for
example, a video.

In the example, the content-encoding header is assigned with an
attachment type that indicates how the file should be downloaded:

      PUT /v1/1234567891234/test_container_1/test_obj_1
      X-Auth-Token: HPAuth_1234
      Content-Type: video/mp4
      Content-Encoding: gzip
           

## 2.xx <a id="content_disposition_header"></a>Enabling Browser Bypass with the Content-Disposition Header

When an object is assigned the Content-Disposition header you can
override a browser's default behavior for a file so that the downloader
saves the file rather than displaying it using default browser settings.

In the example, the content-encoding header is assigned with an
attachment type that indicates how the file should be downloaded.

      PUT /v1/1234567891234/test_container_1/test_obj_1
      X-Auth-Token: HPAuth_1234
      Content-Type: image/tiff
      Content-Disposition: attachment; filename=platmap.tif

## 2.xx Notable Differences from OpenStack


The HP Cloud Object Storage API is an implementation of OpenStack Object
Storage, but there are some differences to be aware of:

* HP Cloud Services Object Storage naming conventions are slightly
    more restrictive than those described in the OpenStack documentation
    referenced here. Specifically, containers and object names may not
    contain the following characters:
    -   double-quote: "
    -   greater-than: \>
    -   less-than: \<

* Cross-tenant ACLs are only supported by HP Cloud Object Storage

* General ACLs do not support specifying a username or hostname.

* Temorary URLs do not use the X-Account-Meta-Temp-URL-Key meta-data to store the secret key. Instead we use the HP Cloud Identity Services _Access Keys_.

* FormPOST --- TBS DITO

#  3. Account-level View

## 3.1 Tenants and HP Cloud Storage accounts
{#tenants_accounts}

## 3.2 Regions

## 3.3 Service Catalog

Like all HP Cloud Service offerings, authentication for CDN is achieved
through the Identity Service, which returns an `X-Auth-Token` that is
used for subsequent requests to individual services.

For additional details on the Identity Service, please refer to
[https://docs.hpcloud.com/identity](https://docs.hpcloud.com/identity).

The service is exposed in the service catalog, as shown in the following fragment:

```
{
   service catalog fragment here
}
```


# 4. REST API Specifications

## 4.1 Service API Operations

**Host US West Region**: https://region-a.geo-1.objects.hpcloudsvc.com

**Host US East Region**: https://region-b.geo-1.objects.hpcloudsvc.com

**BaseURI**: {Host}/v1/{account}


| Resource  | Operation                   | HTTP Method | Path                   | JSON/XML?         | Privilege Level |
| :-------  | :-------------------------- | :---------- | :--------------------- | :---------------- | :-------------  |
| [Account](#account_resource)     | List containers             | GET         | /v1/{account}                      | Y/Y         | Admin           |
| [Account](#account_resource)     | Retrieve account metadata   | GET         | /v1/{account}                      | n/a         | Admin           |
| [Container](#container_resource) | List objects                | GET         | /v1/{account}/{container}          | Y/Y         | Admin           |
| [Container](#container_resource) | Retrieve container metadata | HEAD        | /v1/{account}/{container}          | n/a         | Admin           |
| [Container](#container_resource) | Create/Update container     | PUT         | /v1/{account}/{container}          | n/a         | Admin           |
| [Container](#container_resource) | Delete container            | DELETE      | /v1/{account}/{container}          | n/a         | Admin           |
| [Object](#object_resource)       | Retrieve object             | GET         | /v1/{account}/{container}/{object} | n/a         | Admin           |
| [Object](#object_resource)       | Retrieve object metadata    | HEAD        | /v1/{account}/{container}/{object} | n/a         | Admin           |
| [Object](#object_resource)       | Create/Update Object        | PUT         | /v1/{account}/{container}/{object} | n/a         | Admin           |
| [Object](#object_resource)       | Chunked transfer encoding   | PUT         | /v1/{account}/{container}/{object} | n/a         | Admin           |
| [Object](#object_resource)       | Update object metadata      | POST        | /v1/{account}/{container}/{object} | n/a         | Admin           |
| [Object](#object_resource)       | Delete object               | DELETE      | /v1/{account}/{container}/{object} | n/a         | Admin           |



## 4.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

Many operations accept request headers. This section provides an overview of each request header. Consult the specific operation to determine if the header applies to the operation and any other notes that are of interest.

### 4.2.1 <a id="accept_request"></a>Accept

Where applicable, this determines how the response body is formated. For example, you can use this to list the objects in a container as:
* text (text/plain)
* JSON (application/json)
* XML (text/xml, application/xml)
* HTML (text/html, application/html).


### 4.2.2 <a id="content_length_request"></a>Content-Length

Where applicable, this is the length in bytes of the body of the request.

### 4.2.3 <a id="content_type_request"></a>Content-Type       

Where applicable, this indicates the MIME type of an object.

When applied to object resources, the Content-Type request header is optional. If not specified, HP Cloud Storage will attempt to identify the content type and assign a MIME type. If this fails, the type is set to application/octet-stream. If you specify a value in the request header, when you next do a HEAD or GET operation on the object, the Content-Type response header is set to the specified value.

### 4.2.4 <a id="x_auth_token_request"></a>X-Auth-Token

When specified, this identifies the user making the request. In addition, if this token is being used by a user with Admin privilege level, the token must be scoped to the tenant associated with the account. If no token is specified, the request will fail unless tyou have been granted access to the resource by some other mechansim such as ACLs. See REF_NEEDED_HERE for more information about tokens.

### 4.2.x <a id="x_container_meta_request"></a>X-Container-Meta-{name}

This allows you to set custom meta data on a container using a header name with a prefix of X-Container-Meta-. After this prefix, you can
pick any name meaningful to you. For example, X-Container-Meta-Reviewed could be used indicate that the contents
of a container had been reviewed.

Any valid UTF-8 http header value is allowed for metadata, however we
recommend that you URL-encode any non-ASCII values

When updating the custom meta data of a container, you must specifiy *all* of the meta data in the request. For example, if you plan to use X-Container-Meta-One and X-Container-Meta_Two, both must be specified in a single request. If you did two requests, one setting X-Container-Meta-One and the second setting X-Container-Meta-Two, when you later do a HEAD operations, only X-Container-Meta-Two would exist.


## 4.3 Common Response Headers

### 4.3.x <a id="last_modified_response"></a>Last-Modified

This is the date and time that the container or object was created or the last time that the meta data was changed.

### 4.3.1 <a id="content_length_response">Content-Length

When the response includes a body, this indicates the length of the body in bytes.

### 4.3.2 <a id="content_type_response">Content-Type

When the response includes a body, this indicates the MIME type of the response.

### 4.3.x <a id="x_container_meta_response"></a>X-Container-Meta-{name}

This contains the value of X-Container-Meta-{name} meta data that was previously set on a container, where {name} is
an arbitrary name meaningful to you.

### 4.3.x <a id="x_account_object_count_response"></a>X-Account-Object-Count

The total number of objects in all containers associated with the account.

### 4.3.x <a id="x_account_bytes_used_response"></a>X-Account-Bytes-Used

The total size in bytes of all objects in all containers assicated with the account.

### 4.3.x <a id="x_account_container_count_response"></a>X-Account-Container-Count

The number of containers in the account
















## 4.4 Service API Operation Details

### 4.4.1 Account ###

#### 4.4.1. <a id="account_get"></a>List Account ####
#### GET /v1/{<account}

This operation returns a listing of the containers in the designed account.

**Request Data**

The path specifies the account.

**URL Parameters**

By default up to 10,000 names are returned. To retrieve more or fewer names, use the *limit* and *marker* query parameters.
See [Retrieving large number of container or object names](#pagination) for more information.

* *limit* - (Optional) - Number - For an integet value of _N_, limits the number of results to at most _N_ values.

* *marker* - (Optional) - String - Given a string value _x_, return container names greater in value than the specified marker.

* *format* - (optional) - String - Specify either `json` or `xml` to return the respective serialized response.
You may alternativly specify the required type in the *Accept* request header.
      
                          
**Data Parameters**

This operation does not require a request body.

**Success Response**

On success, the response body contains a list of the containers.
A 204 (No Content) HTTP return code is passed back if the account
has no containers.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

The following response headers are returned:

* [X-Account-Object-Count](#x_account_object_count_response)
* [X-Account-Bytes-Used](#x_account_bytes_used_response)
* [X-Account-Container-Count](#x_account_container_count_response)

A list of containers is returned in the response body. With JSON and XML formats, you can also see the number (count)
and size (bytes) of all objects in the listed container.

Text/Plain                         


      test_container_1  
      test_container_2   

JSON


      [
          {"name":"test_container_1", "count":2, "bytes":78},
          {"name":"test_container_2", "count":1, "bytes":17}  
      ]   
                          

XML
                          

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

**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**

```
curl -i -H 'X-Auth-Token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/48828782005874
HTTP/1.1 200 OK
X-Account-Object-Count: 21280
X-Account-Bytes-Used: 3044371826
X-Account-Container-Count: 2
Content-Length: 439867
Content-Type: text/plain; charset=utf-8
Date: Fri, 16 Nov 2012 11:18:45 GMT

test_container_1
test_container_2

```

**Additional Notes**



### 4.4.2 <a id="account_head"></a>Retrieve Account Metadata
### HEAD /v1/{account}

This operation gets the meta data associated with the account.

**Request Data**

The path specifies the account.

**URL Parameters**

None
      
                          
**Data Parameters**

This operation cannot contain a request body.

**Success Response**

On success the response headers are populated. 

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

The following response headers are returned:

* [X-Account-Object-Count](#x_account_object_count_response)
* [X-Account-Bytes-Used](#x_account_bytes_used_response)
* [X-Account-Container-Count](#x_account_container_count_response)


**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**

```
curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/48828782005874 -X HEAD
HTTP/1.1 200 OK
X-Account-Object-Count: 21280
X-Account-Bytes-Used: 3044371826
X-Account-Container-Count: 2
Content-Length: 0

```

**Additional Notes**

































                          
### 4.x.x. <a id="account_put"></a>Update Account Meta Data

TBS

## 4.4 Container

### 4.4.x.x <a id="container_put"></a>Create/Update Container
### PUT /v1/{account}/{container}

This operation creates a container or updates the meta data associated with an existing container. 
You are free to a pick container name that is meaningful to you.
See [Container and Object Naming](#naming) for restrictions on container names.

You can set custom meta data on a container using a header name with a prefix of X-Container-Meta-. After this prefix, you can
pick any name meaningful to you. For example, X-Container-Meta-Reviewed could be used indicate that the contents
of a container had been reviewed.

Any valid UTF-8 http header value is allowed for metadata, however we
recommend that you URL-encode any non-ASCII values

When updating the custom meta data of a container, you must specifiy *all* of the meta data in the request. For example, if you plan to use X-Container-Meta-One and X-Container-Meta_Two, both must be specified in a single request. If you did two requests, one setting X-Container-Meta-One and the second setting X-Container-Meta-Two, when you later do a HEAD operations, only X-Container-Meta-Two would exist.

You don't need to check if a container already exists before doing the PUT operation because the operation is idempotent (i.e., it will create a new container
or update an existing container as appropriate). 

**Request Data**

The path specifies the account and the name of the container to create.

**URL Parameters**

None  
                          
**Data Parameters**

This operation does not require a request body.

**Success Response**

On success, the container is created. See [Creation Guantees](#creation_guarantees) for more information.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

A description of the HTTP Status Code.

**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**

```
curl -i -H 'X-Auth-Token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/48828782005874/test_container_1 -H 'x-container-meta-one: one' -X PUT
HTTP/1.1 201 Created
Content-Length: 18
Content-Type: text/html; charset=UTF-8
X-Trans-Id: tx637b78d521264774867355b2262c4d4a
Date: Fri, 16 Nov 2012 14:10:20 GMT

201 Created

```

**Additional Notes**























#### 4.4.x.x <a id="container_get"></a>List Objects in a Container
#### GET /v1/{account}/{container}                  

Retrieve a list of objects stored in a container.

**Request Data**

The path specifies the account and container name.

The following request headers apply to this operation.

* [Accept](#accept_request) - Optional - Specifies the format for listing the names. Alternatvly use the *format* paramater.
* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token


**URL Parameters**

By default up to 10,000 names are returned. To retrieve more or fewer names, use the *limit* and *marker* query parameters.
See [Retrieving large number of container or object names](#pagination) for more information.

By default, the names of all objects are returned. You can control which names are retrieved using the *prefix*, *path* and *delimiter* query paramaters.
See [Pseudo-Hierarchical Folders/Directories](#pseudo_hierachies) for more information.

The following query parameters are available:

* *limit* - (Optional) - Number - For an integet value of _N_, limits the number of results to at most _N_ values.

* *marker* - (Optional) - String - Given a string value _x_, return container names greater in value than the specified marker.

* *format* - (optional) - String - Specify either `json` or `xml` to return the respective serialized response. You may alternativly specify the required type in the *Accept* request header.

* *prefix* - (Optional) - String - For a string value *x*, causes the results to be limited to object names beginning with the substring *x*.

* *path* - (Optional) - String - For a string value *x*, return the object names nested in the pseudo path (assuming preconditions are met).

* *delimiter* - (Optional) - String - For a character *c*, return all the object names nested in the container (without the need for the directory marker objects).

**Data Parameters**

This operation does not require a request body.

**Success Response**

If the container contains objects, 200 (OK) is returned. If there are no objects in the container, 204 (No Content) is returned.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

If there are objects, their names are returned in the response body in the requested format. The JSON and XML formats
list additional data about each object as follows:
* hash - The MD5 checksum for the contents on the object
* bytes -- The size in bytes of the object
* content_type - The MIME type of the object
* last_modified - The date and time the object was created or the time at which the object meta data was last updated. 

Text/Plain

      test_obj_1
      test_obj_2

JSON

    [
       {
         "name": "test_obj_1",
         "hash": "4281c348eaf83e70ddce0e07221c3d28",
         "bytes": 14,
         "content_type": "application/octet-stream",
         "last_modified": "2009-02-03T05:26:32.612278"
       },
       {
         "name": "test_obj_2",
         "hash": "b039efe731ad111bc1b0ef221c3849d0",
         "bytes": 64,
         "content_type": "application/octet-stream",
         "last_modified": "2009-02-03T05:26:32.612278"
       }
     ]

XML

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
      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**

```
curl -i -H 'X-Auth-Token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/48828782005874/test_container_1 -XGET
HTTP/1.1 200 OK
X-Container-Object-Count: 2
X-Container-Meta-One: one
X-Container-Bytes-Used: 378
Content-Length: 28
Content-Type: text/plain; charset=utf-8

test_object_1
test_object_2


```

**Additional Notes**
















#### 4.4.x.x <a id="container_get"></a>Retrieve the Meta Data of a Container
#### HEAD /v1/{account}/{container}                  

Retrieve the meta data of a container.

**Request Data**

The path specifies the account and container name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token


**URL Parameters**

None.

**Data Parameters**

This operation does not require a request body.

**Success Response**

The meta data is returned in the response headers.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

The following response headers are returned:

* [X-Container-Object-Count](#x_container_object_count_response)
* [X-Container-Meta-{name}](#x_container_meta_response)
* [X-Container-Bytes-Used](#x_container_bytes_used)
      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**

```
curl -i -H 'X-Auth-Token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/48828782005874/test_container_1 -XHEAD
HTTP/1.1 200 OK
X-Container-Object-Count: 2
X-Container-Meta-One: one
X-Container-Bytes-Used: 378
Content-Length: 0

```

**Additional Notes**


















                     
#### 4.4.x.x <a id="container_delete"></a>Delete a Container
#### GET /v1/{account}/{container}                  

Delete a container.

You cannot delete a container if it has any objects in it.

**Request Data**

The path specifies the account and container name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token

**URL Parameters**

None.

**Data Parameters**

This operation does not require a request body.

**Success Response**

The container is deleted.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

None
      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**

```
curl -i -H 'X-Auth-Token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/48828782005874/test_container_1 -XGET
HTTP/1.1 200 OK
X-Container-Object-Count: 2
X-Container-Meta-One: one
X-Container-Bytes-Used: 378
Content-Length: 28
Content-Type: text/plain; charset=utf-8

test_object_1
test_object_2


```

**Additional Notes**
















      
                        




















                        
## 4.x Object



### 4.x.x <a id="object_get"></a>Retrieve Object
### GET /v1/{account}/{container}/{object}
---------------

Retrieve the contents of an object.

In its simplest form, the GET operation returns the object contents in the response body
and retrieves the object's meta data and places the names and values into response headers.
However, you there are additional capabilities:

* You can perform conditional GET requests by using certain HTTP
headers as documented in [RFC 2616](http://www.ietf.org/rfc/rfc2616.txt](http://www.ietf.org/rfc/rfc2616.txt).
See [Conditional GET of objects](#conditional_get) for more information.

* It is also possible to fetch a portion of data using basic support of the HTTP [Range](#range_request)
header.

* If the object name is the name of an object manifest, the operation concatinates all the segments into one stream.

**Request Data**

The path specifies the account, container name and object name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [If-Match](#conditional_get) - Optional - See [Conditional GET of objects](#conditional_get) for more information.
* [If-None-Match](#conditional_get) - Optional - See [Conditional GET of objects](#conditional_get) for more information.
* [If-Modified-Since](#conditional_get) - Optional - See [Conditional GET of objects](#conditional_get) for more information.
* [If-Unmodified-Since](#conditional_get) - Optional - See [Conditional GET of objects](#conditional_get) for more information.
* [Range](#range_request) - Optional - See [Retrieving a portion of object data](#range_request) for more information.

**URL Parameters**

None.

**Data Parameters**

This operation does not require a request body.

**Success Response**

The object contents is returned in the response body and meta data is returned in the response headers.
Since the HTTP Succes code is written to the response stream before the response body and headers
are returned, it is possible that you will see a 200 Success code is seen even though the the transfer of headers
or body had a failure. You should check that the length of the actual body is the same as the
[Content_Length](#content_length_response) response header. Ideally, you should also
perform an MD5 checksum over the response body and compare with the [ETag](#etag_response) response header.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

The following response headers are returned:

* [Last-Modified](#last_modified_response)
* [Content_Length](#content_length_response)
* [Content_Type](#content_type_response)
* [ETag](#etag_response)
* [Content_Encoding](#content_encoding_header)
* [Content_Disposition](#content_disposition_header)

      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**

```
curl -i -H 'X-Auth-Token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/48828782005874/test_container_1/test_obj_1 -XGET
HTTP/1.1 200 OK
Last-Modified: Fri, 16 Nov 2012 15:34:56 GMT
ETag: 4281c348eaf83e70ddce0e07221c3d28
Content_Length: 
Content_Type: text/plain
Content-Length: 12

Hello World!

```

**Additional Notes**










### 4.x.x <a id="object_put"></a>Create/Update Object
### PUT /v1/{account}/{container}/{object}
---------------

Creates an object.




**Request Data**

The path specifies the account, container name and object name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [If-Match](#conditional_get) - Optional - See [Conditional GET of objects](#conditional_get) for more information.
* [If-None-Match](#conditional_get) - Optional - See [Conditional GET of objects](#conditional_get) for more information.
* [If-Modified-Since](#conditional_get) - Optional - See [Conditional GET of objects](#conditional_get) for more information.
* [If-Unmodified-Since](#conditional_get) - Optional - See [Conditional GET of objects](#conditional_get) for more information.
* [Range](#range_request) - Optional - See [Retrieving a portion of object data](#range_request) for more information.

**URL Parameters**

None.

**Data Parameters**

This operation does not require a request body.

**Success Response**

The object contents is returned in the response body and meta data is returned in the response headers.
Since the HTTP Succes code is written to the response stream before the response body and headers
are returned, it is possible that you will see a 200 Success code is seen even though the the transfer of headers
or body had a failure. You should check that the length of the actual body is the same as the
[Content_Length](#content_length_response) response header. Ideally, you should also
perform an MD5 checksum over the response body and compare with the [ETag](#etag_response) response header.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

The following response headers are returned:

* [Last-Modified](#last_modified_response)
* [Content_Length](#content_length_response)
* [Content_Type](#content_type_response)
* [ETag](#etag_response)
* [Content_Encoding](#content_encoding_header)
* [Content_Disposition](#content_disposition_header)

      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**

```
curl -i -H 'X-Auth-Token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/48828782005874/test_container_1/test_obj_1 -XGET
HTTP/1.1 200 OK
Last-Modified: Fri, 16 Nov 2012 15:34:56 GMT
ETag: 4281c348eaf83e70ddce0e07221c3d28
Content_Length: 
Content_Type: text/plain
Content-Length: 12

Hello World!

```

**Additional Notes**
                        

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

                


                

