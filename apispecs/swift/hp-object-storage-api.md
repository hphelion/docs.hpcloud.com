---
layout: page
permalink: /api/object-storage/
title: HP Cloud Object Storage API
description: "HP Cloud Object Storage API Specifications"
keywords: "swift, object storage"
product: object-storage 

---

# HP Cloud Object Storage API Specification


## 1. Overview

HP Cloud Object Storage is an affordable, redundant, scalable, and
dynamic storage service. The core storage system is designed to
provide a safe, secure, network accessible
way to store data. You can store an unlimited quantity of files and each
file can be as large as 5GB.  With segmented objects,
you can upload and store objects of virtually any size.

HP Cloud Object Storage allows you to store and retrieve files and
content via a simple Web Service Representational State Transfer (ReST)
interface. 

### 1.1 API Maturity Level

This section describes the maturity level of the functions and features described in this document.

#### 1.1.1 Maturity Level Definitions

The maturity levels are as follows:

* Beta. The functions and features are available publically. While HP expects the feature to operate as
advertised, we do not offer a Service Level Agreement (SLA) for the service or feature.

* Release to General Availability (GA). At this level of maturity, all features and functions are expected to operate
as advertised. In particular, there is a Service Level Agreement (SLA) defined and in place.

#### 1.1.2 Maturity Level

Except as noted below, this is the maturity level of this API:

**Maturity Level**: HP Cloud Storage is General Availability (GA).

**Version API Status**: CURRENT

### 1.1.3 Container Synchronization

The container synchronization feature has the following maturity level:

**Maturity Level**: Public Beta.

**Version API Status**: BETA



## 2. Architectural View

The HP Cloud Object Storage API is implemented as a set of ReSTful web
services. All account, container and object operations can be
performed with standard HTTP calls. See the [Wikipedia
article](http://en.wikipedia.org/wiki/REST) for more information about
ReST.

### 2.1 Resources

The HP Cloud Storage API allows the management of the following resources:

* [Account](#account_resource)
* [Container](#container_resource)
* [Object](#object_resource)

#### 2.1.1 HP Cloud Storage Accounts #### {#account_resource}

The account is the top level resource in the hierarchy. An account is assigned when you activate HP Cloud Object Storage.
There is a one-to-one relationship between an account and the _tenant_. In fact, for most users, the HP Cloud Storage account and tenant _Id_ are the same.

If you subscribed to the HP Cloud Beta program, your HP Cloud Storage account name may start with "AUTH_", followed by a long number. This makes
no difference to how you use the API. In all cases, you should use the endpoint from the service catalog that the HP Cloud Identity Service supplies when authenticating yourself.

You may set custome metadata on an account.

There is more about [tenants and accounts](#tenants_account) later in this document. 
There is more about using the [HP Cloud Identity Service](#getting_tokens) later in this document.


#### 2.1.2 HP Cloud Storage Containers #### {#container_resource}

A container provides a way for you to organize your objects. 
You can pick any name that is meaningful to you. 
However, see [Container and Object Naming](#naming) for restrictions on container names.

You may also set custom metadata on a container.

#### 2.1.3 HP Cloud Storage Objects #### {#object_resource}

An object provides a way for you to store an arbitrary blob of data. 
This may be a document, image, video, backup file or anything else required by your application.
You can pick any name that is meaningful to you. However, see [Container and Object Naming](#naming) for restrictions on object names.

Objects have a size limit of 5 gigabytes. However, objects larger
than 5GB can be segmented and then concatenated together so that you can
upload 5GB segments and download a single concatenated object of any size. You can
work with the segments and manifests directly with API requests. 

In addition to storing the content of an object, you may also associate metadata with an object. 

While the primary organizational structure in HP Cloud Object Storage is the container, you may use object names as a way to
further organize your data. A common usage of this is to include a delimiter character such as slash ('/') character in the object name.
For example, you could use `/vacation/pic1.jpg` as the name of an object.
If this object is stored in a container called `photos`, the URI for the object would be `/v1/{account}/photos/vacation/pic1.jpg`.

While this appears to allow hierarchies similar to a file system's directory structure, it is important to understand that there is 
no such hierarchy in HP Cloud Object Storage.
For example, if you simply created a container called `photos` and then created a single object called `vacation/pic1.jpg`,
you cannot access `/v1/12345678912345/photos/vacation/` -- there is no such object in the system. 
For more, see [Pseudo-Hierarchical Folders/Directories](#pseudo_hierarchies).

### 2.2 Container and Object Naming ### {#naming}

Container and object names should be properly URL-encoded prior to
interacting with the ReST interface (the language APIs handle URL
encoding/decoding) and the container and object names must be UTF-8
encoded. You must check the length restrictions against the URL-encoded
string.

Container names must not contain the slash ('/'), double-quote ('"'), less-than ('\<') or
greater-than ('\>') characters.
The container name length is limited to 256 bytes.

Object names must not contain the double-quote ('"'), less-than ('\<') or
greater-than ('\>') characters.
The object name length is limited to 1024 bytes.

Although you use URL-encoding to specify the URI of a container or object, when the API returns names (as in listing a container), the displayed names are not URL-encoded (i.e., they are the original names).

### 2.3 Consistency

The HP Cloud Object Storage service is based on OpenStack Swift. This provides an "eventual consistency" model. This means that when
you update the system in some way, you are not necessarily guaranteed to have the update propagated to all parts of the system
at once. This is a consequence of how the system operates. The HP Cloud Object Storage system comprises 100s of servers, uses
multiple copies of data and multiple availability zones to achieve very high scalability (in terms of objects stored) and very high availability for the data.
In such a design, consistency is traded off to achieve high scale and availability.

As the name implies, the eventual consistency means that after updates, the update will be *eventually* visible to all parts of the
system. In practice, you can rely on read-after-create consistency. That it, immediately after creating an object, you
will be able to read or access that object. However, if you replace an object with a new copy, there are situations where
the system might return the original object. This requires a specific sequence of server failures to end up in this
situation and is unlikely to occur very often.

A much more common inconsistency you may observe is that after you create, replace or delete an object, the container
may not be updated to list the object -- or may have the timestamp of an older object. So when you list the contents of
a container, it's possible the list contains objects that were deleted just
before you performed the list operation. Similarly, the [X-Account-Object-Count](#x_account_object_count_response) metadata may take
some time to update after objects are created or deleted.

As far as possible, you should design applications to account for such possible inconsistencies. 


### 2.4 Success and Error Handling

Handling a HTTP success code is straight forward - any of the 200, 201, 202 and 204 codes indicate a success. Once you see
this, you can assume the operation has completed and any expected response body or response headers are available
for use.

Handling failures is obviously more difficult. You need to examine the HTTP code to see how to respond. However, in many cases
you should not simply abandon the task, but consider retrying. In particular, the following HTTP error codes might be recoverable
as follows:

* 401 Unauthorized. This can mean that you are not authorized to perform an operation. However, it might also mean that
your [authentication token](#using_tokens) has expired. You should attempt to get a new token by contacting the
HP Cloud Identity Service (it's also worth retrying failures on the HP Cloud Identity service).

* 403 Forbidden. As with 401 Unauthorized, it is worth getting a new token before attempting to retry the operation.

* 404 Request Timeout. Please try the request again later.

* 429 Too Many Requests. The system is busy and is asking that you slow down the rate at which you make requests.
You should sleep or pause for a short period, and then attempt the operation again.

* 500 Internal Error. This is an unusual situation, but can occur if the system is being reconfigured. You should sleep or pause for a short period and retry the operation.
If the error persists, contact HP Cloud support.

* 503 Service Unavailable. This is an unusual situation, but can occur if the system is being reconfigured. You should sleep or pause for a short period and retry the operation.
If the error persists, contact HP Cloud support.

In addition, you may get socket errors such as connection refused or connection reset by peer. These can happen
either because of transient failures in the path between your client system and the HP Cloud system or because we are
reconfiguring the system. For example, when we install new software, we will perform a rolling restart of the software. This might break an individual operation.
We use load balancers, so your next attempt to perform the operation will be directed to a different server and will work.

In the above scenarios, it has been suggested that you retry operations. The suggestion is that you sleep for one second and then retry. If this fails, you
should sleep for a longer period before retrying. If after several retries (on the order of 5 attempts) your operation continues to fail, you can then
consider the failure as unrecoverable.


#### 2.4.1 HTTP Status Codes #### {#http_codes}

The following HTTP codes are used by HP Cloud Object Storage.

|Code      | Description    | Notes   |
|:-------- | :------------  | :------ |
|200 OK    | Standard response for successful requests. | The actual response will depend on the specific operation. The HTTP code is transferred before the body of a request, so you should check that the body has not been truncated by comparing with the [Content-Length](#content_length_response) and [ETag](#etag_response) response headers. |
|201 Created| Standard response for successful create of a container. Object creation always returns this code, even if an object of the same name already exists. In terms of how the service works, this is correct since you are creating a new copy of the object.| The actual response will depend on the specific operation. |
|202 Accepted | Standard response for successful updates to account, container or object. | The actual response will depend on the specific operation. |
|204 No Content | Standard response to HEAD operations. It is also the response when listing an account or container and there are no names in the list.| The response is in the response headers, there is no body in the response. The object HEAD response does not use this code. It uses 200 OK instead.|
|400 Bad Request | The request cannot be fulfilled due to bad syntax. | Check your code. |
|401 Unauthorized | This usually means that the [authorization token in X-Auth-Token](#using_tokens) is invalid (or missing). | If, the token was valid at some stage and you then get this error, it has probably expired and you simply need to get a new authorization token.|
|403 Forbidden | The request was a valid request, you do not have the appropriate access rights to the resource. | |
|404 Not Found | The requested resource (account, container or object) could not be found. | Generally, either the resource never existed or has been deleted in the meantime. |
|405 Method Not Allowed| A request was made of a resource using a request method not supported by that resource| Check your code. |
|409 Conflict |You are not allowed to perform the requested operation. | For example, you cannot delete a container that contains objects.|
|411 Length Required | A Content-Length request header was not specified. | Check your code. |
|412 Precondition Failed | The server does not meet one of the preconditions that the requester put on the request. | See [Conditional Get of Objects](#conditional_get) |
|413 Request Entity Too Large|The request is larger than the server is willing or able to process.| For objects, see [Large Object Creation](#large_objects) |
|414 Request-URI Too Long | The URI provided was too long for the server to process. | See [Arbitrary Limits](#uri_limits) |
|416 Requested Range Not Satisfiable | The client has asked for a portion of the file, but the server cannot supply that portion.| For example, if the client asked for a part of the file that lies beyond the end of the file.|
|418 I'm a teapot| Described in [RFC 2324](http://www.ietf.org/rfc/rfc2324.txt) | Please contact HP Cloud support if you get this error. |
|422 Unprocessable Entity | The MD5 checksum of an uploaded object body does not match the value supplied in the [ETag](#etag_request) request header. | This indicates that some form of corruption occurred in the transfer. Retry the operation. |
|429 Too Many Requests | The user has sent too many requests in a given amount of time. | Sleep for a short period and retry the operation. |
|431 Request Header Fields Too Large | Either an individual header field, or all the header fields collectively, are too large. | See [Arbitrary Limits](#uri_limits) |
|500 Internal Server Error | An unexpected internal error occurred. | Sleep for a short period and retry the operation. For persistent failure, contact HP Cloud support |
|503 Service Unavailable | An unexpected internal error occurred. | Sleep for a short period and retry the operation. For persistent failure, contact HP Cloud support |


### 2.5 Arbitrary Limits ### {#uri_limits}

The following constraints apply to the API's HTTP requests:

* Maximum number of HTTP headers per request: 90

* Maximum length of all HTTP headers: 4096 bytes

* Maximum length per HTTP request line: 8192 bytes

* Maximum length of HTTP request: 5 gigabytes

* Maximum length of container name: 256 bytes

* Maximum length of object name: 1024 bytes

### 2.6 Authentication and Access Controls

#### 2.6.1 Overview

The HP Cloud Object Storage system provides a number of ways to control who can access and change data in an account, container or object. 
Authentication services are provided by the [HP Cloud Identity Service](https://docs.hpcloud.com/identity). You use this service to manage
your passwords and access keys. HP Cloud Object Storage interacts with the Identity Service to verify who you are.

In conjunction with the HP Cloud Identity Service, the HP Cloud Object Storage service provides a number of ways to control access to the system as follows:

* Authentication tokens. Using the HP Cloud Identity Service API, you can authenticate yourself for a specific tenant. The HP Cloud Identity Service returns a token. In subsequent operations, you include this token in the X-Auth-Token request header. The value of the token is used to identify you. If you are associated with the tenant, you now have full access to the HP Cloud Object Storage account. See [Using Authentication Tokens](#using_tokens) for more information.

* General Access Control Lists (ACLs). You can apply an ACL as metadata on a container. This allows you to make the container and it's objects world readable or writable. See [General Access Control Lists](#general_acls) for more information.

* Cross-tenant Access Control Lists (ACLs). This allows you to make the container and its objects readable or writeable by specific users. See [Cross-tenant Access Control Lists](#cross_tenant_acls) for more information.

* Temporary URLs. This allows you to create a URL that encodes the Access Key information needed to get or put an object. The resulting URL contains enough information to allow it to be used without reference the HP Cloud Identity Service. Specifically, since it does not require you to use the X-Auth-Token request header it is suitable for embedding in HTML pages and useable by standard browsers. The URL has an expiry date, hence the URL is temporary. See [Temporary URLs](#temp_url) for more information.

* FormPOST. This is similar in concept to Temporary URLs except the encoding is done in a HTML form. This makes it possible to upload objects directly
using a standard web browser. See [FormPOST](#formpost) for more information.

* Signature Based Authentication. This allows a client to use HP Cloud Identity Service _Access Keys_ to "sign" the URL and headers of a request. Since the client has the Access Keys, it does not need to refer to the HP Cloud Identity Service to authenticate itself. Instead, a valid signature in the request allows HP Cloud Object Storage to authenticate the request and identify the user. See [Signature Based Authentication](#signature_auth)
 
#### 2.6.2 Using Authentication Tokens #### {#using_tokens}

The HP Cloud Object Storage service is not responsible for authenticating the identity of users. Instead, the HP Cloud Identity Service
is responsible for authentication and identity management. 

To identify that a request is issued on behalf of or by a user, the user first makes a request to the HP Cloud Identity Service.
In this request, the user gives their credentials and gets an authorization token in response.  In subsequent
requests to the HP Cloud Object Storage service, the authentication token is included in the request. The [X-Auth-Token](#x_auth_token_request)
request header is used by the API to include the token in the request.

With this authentication token, the HP Cloud Object Storage service can identify
the user and decide whether the user is allowed to perform the operation.

##### 2.6.2.1 Getting an authentication token.

To make a request to the HP Cloud Identity Service, you need:

* Your credentials
* Your tenant Id or tenant Name.

The credentials can either be:

* Username and password, i.e., the same username and password they would use to log into the HP Cloud Management Console

* Access Key ID and Access Key Secret. You can see your Access Keys on the *API Keys* section under you *Account* information in the HP Cloud Management Console.
Access Keys are more suitable for use in APIs because you can create them for use in a specific application. However, if you suspect that an application's Access Keys
have been compromised, you can delete the Access Key. This is more convenient that changing your password credentials. However, not all API bindings support Access Keys.

In addition, to credentials, you also specify a tenant -- either the Id or tenant Name. With your credentials and tenant, the HP Cloud Identity Service checks to see
whether you have activated the HP Cloud Object Storage service. If so, it returns an authentication token and the endpoints to all instances of the HP Cloud Object Storage service that you are activated for. See [Service Catalog](#service_catalog) for an example of how the authentication token and endpoints are returned.

There are legacy OpenStack Object Store APIs that used TempAuth or Swauth as their identity server. The HP Cloud Identity Service offers a compatible interface.
You use your username, password and tenant Id as shown in the following example. 
This example uses curl. 
The X-Storage-Url response header contains the HP Cloud Object Storage endpoint (including your account) and the X-Auth-Token response header contains your authentication token.

    curl -i https://region-a.geo-1.identity.hpcloudsvc.com:35357/auth/v1.0/ -X GET -H 'x-auth-user: 12345678912345:sally' -H 'x-auth-key: MyPassword'

    HTTP/1.1 200 OK
    X-Storage-Url: https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345
    X-Auth-Token: HPAuth_1234

The authentication that you receive is known as a "scoped" token, i.e., it is specific for the tenant and the HP Cloud Object Storage account associated with
the tenant.

##### 2.6.2.2 Admin Role

When a user has a scoped token (as explained earlier), the user has the *Admin* role for the associated HP Cloud Object Storage [account](#account_resource).
The Admin role allows full create, modify and read access to all containers, metadata and objects in the account.
If a user does not have Admin role for an account, they cannot create, modify or read any of the metadata or contents of data in the account unless
you provide access via other mechanisms such General Access Control Lists or Temporary URLs.

##### 2.6.2.3 Unscoped Tokens

If when requesting an authentication token you do not specify a tenant, or you specify a different tenant than the tenant associated with the [account](#account_resource), then the authentication token is not "scoped" for that account. This means that the user will not have the Admin role for the account and will
not be able to access the account metadata or data. However, this authentication token can be used to *identify* the username of the requesting user.
If [Cross-tenant Access Control Lists](#cross_tenant_acls) are used, that the user is allowed appropriate access to the container.


#### 2.6.3 General Access Control Lists #### {#general_acls}

Normally, only a user with Admin role can access a container and objects. This role
is associated with a tenant as is assigned when you activate a user for HP Cloud Object Storage. To indicate that you have the Admin role, users must
supply a X-Auth-Token in their requests. This is explained in 
[Using Authentication Tokens](#using_tokens).

However, sometimes you want to provide global read or write access
to a container. You can use the X-Container-Read and X-Container-Write container metadata to enable this. As the names imply, X-Container-Read allows read access and X-Container-Write enables write access.

The value in X-Container-Read and X-Container-Write is an access control list (ACL). There are two possible entry values:

* `.r:*` - this allows anybody to access the objects in the container
* `.rlistings` - this allows anybody to list the contents of a container

To allow anybody to both list objects in a container and access the objects, use both values separated by a ','. For example, if you want to
allow anybody complete read access to a container, set the X-Container-Read request header as follows:


    X-Container-Read: .r:*,.rlistings

> Note: the `.r` in the ACL value is named for 'referrer' -- not 'read'

> Note: the `*` in the ACL value is a literal `*`; it does not mean that user or hostnames can be specified in this piece of the ACL string.


#### 2.6.4 Cross-tenant Access Control Lists #### {#cross_tenant_acls}

In [General Access Control Lists](#general_acls) you could not
specify (or limit to) specific users. The Cross-tenant Access Control Lists
allow you to specify specific users.

Users of HP Cloud Object Storage can share containers with one another by providing a user name (or names) with the X-Container-Read and X-Container-Write container metadata. The ACL value provides access to both list the objects in the container as well as access to the individual objects in the container.

For example, to grant access to user Sally for read access you can set the X-Container-Read as follows:

    X-Container-Read: *:sally

To allow user Sally to also write to objects in a contains, you should also
set the X-Container-Write request header as follows:

    X-Container-Read: *:sally
    X-Container-Write: *:sally

If there are several users, use a comma separated list as shown in the following
example:

    X-Container-Read: *:sally,*:joe@hp.com

> Note: use the *username* in the ACL. In many cases, the username is the same as your email address. In this example, `joe@hp.com` is the user's username.

#### 2.6.5 Temporary URLs #### {#temp_url}

The TempURL feature allows the creation of URLs to provide temporary access to objects.
A website owner may wish to provide a link to download a large object in 
HP Cloud Object Storage, but the account has no public access. The website owner can generate a URL that will provide
GET access for a limited time to the resource.

When the web browser user clicks on the
link, the browser will download the object directly from HP Cloud Object Storage, obviating the need for the
website to act as a proxy for the request.

If the user were to share the link with all his friends, or accidentally post it on a forum, etc.
the direct access would be limited to the expiration time set when the website created the
link.

To create the URL, you need to know the following information:

* The Tenant ID. You see your Tenant ID by going to the API Keys section of the Management Console

* Access Key ID and Secret Key. You can see this information by going to the API Keys
section of the Management Console. If you have several Access Keys, you can pick any
one of them. However, if you subsequently deactivate or delete the Access Keys, the URL
will become useless.

* The HTTP method to allow (GET or PUT)

* The Unix timestamp the access should be allowed until. When this timestamp expires, the
URL cannot be used to access the object.

* The full path to the object.

##### 2.6.5.1 Supported Methods

TempURL is designed to support GET, PUT, and HEAD requests only. POST is expected to
be handled by [FormPost](#formpost)

##### 2.6.5.2 Differences Between HP Cloud Object Storage and OpenStack Swift TempURL Signature Generation

There are two differences between HP Cloud and OpenStack Swift TempURL signature
generation:

* OpenStack Swift Temporary URLs (TempURL) required the X-Account-Meta-Temp-URL-Key header be
set on the Swift account. In HP Cloud you do not need to do this. Instead we use Access Keys to provide similar functionality.

* HP Cloud Object Storage Temporary URLs require the user's Tenant ID and Access Key ID to be
prepended to the signature. OpenStack Swift does not.

##### 2.6.5.3 Creating Signatures

A signature is created using the following values concatenated together with a colon (":")
separating them:

* The Tenant ID

* The Access Key ID

* An HMAC-SHA1 (RFC 2104) signature. This is generated using:
  - The HTTP method to allow (GET or PUT)
  - The Unix timestamp the access should be allowed until
  - The full path to the object
  - The Secret Key

For example, here is code generating the signature for a GET, valid for the next 60 seconds,
on /v1/12345678912345/container/object:


    import hmac
    from hashlib import sha1
    from time import time
    method = 'GET'
    expires = int(time() + 60)
    path = '/v1/12345678912345/container/object'
    tenant_id = '12345678912345'
    access_key_id = 'GP54NNRN2TKBVWH449AG'
    secret_key = 'EHLzysK9S1QRWkwvVpVHsGZyM715OH4S2kJ'
    hmac_body = '%s\n%s\n%s' % (method, expires, path)
    sig = tenant_id + ':' + access_key_id + ':' + hmac.new(secret_key, hmac_body,
        sha1).hexdigest()

           
Be certain to use the full path, from the /v1/ onward. This example shows the most
common situation where the Tenant ID and the Object Storage account name are the
same. However, some Object Storage accounts are named with "AUTH_" at the start of the
name. You should use this name in your path. Put simply, the path should be the path you
normally use to access objects - there is no need to change or modify it in any way.

##### 2.6.5.4 Using Temporary URLs

Let's say the signature ends up equaling "12345678912345:GP54NNRN2TKBVWH449AG:da39a3ee5e6b4b0d3255bfef95601890afd80709" and expires ends up "1323479485". Then, for example, the website could provide a link to:

```
    https://swift-cluster.example.com/v1/12345678912345/container/object?temp_url_sig=12345678912345%3AGP54NNRN2TKBVWH449AG%3Ada39a3ee5e6b4b0d3255bfef95601890afd80709&temp_url_expires=1323479485
```
Any alteration of the resource path or query arguments will cause an "401 Unauthorized" error to be returned. Similarly, a PUT where GET was the allowed method will also fail. HEAD is allowed if GET or PUT is allowed.

#### 2.6.6 FormPOST #### {#formpost}

FormPost is designed to allow web browsers to upload (typically large) files directly into HP
Cloud Object Storage by using signature-based authentication.

FormPost middleware translates a browser form post into a regular HP Cloud Object
Storage object PUT.

The format of the form is shown in this example:

    <form action="{object-store-url}" method="POST"
                   enctype="multipart/form-data">
    <input type="hidden" name="redirect" value="{redirect-url}" />
    <input type="hidden" name="max_file_size" value="{bytes}" />
    <input type="hidden" name="max_file_count" value="{count}" />
    <input type="hidden" name="expires" value="{unix-timestamp}" />
    <input type="hidden" name="signature" value="{tenant_id:access_key_id:hmac}" />
    <input type="file" name="file1" />
    <input type="submit" />
    </form>

                
The object-store-url is the URL to the HP Cloud Object Storage destination, such as:
https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345678912345/container/object_prefix
            
The name of each file uploaded will be appended to the object-store-url given. So,
you can upload directly to the root of container with a url like:


    https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345678912345/container/

        
Optionally, you can include an object prefix to upload multiple files, such as:

    https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345678912345/container/{object_prefix}


> Note: The form method must be POST and the enctype must be set as
> multipart/form-data

To upload file(s) into sub-containers/sub-dirs with multipart form data mechanism, the path
must end with a backslash (/) , such as:

    https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345678912345/container/subcontainer1/subcontainer2/
        
The redirect attribute is the URL to redirect the browser to after the upload completes.
The URL will have status and message query parameters added to it, indicating the HTTP
status code for the upload (2xx is success) and a possible message for further information if
there was an error (such as "max_file_size exceeded").

The max_file_size attribute must be included and indicates the largest single file
upload that can be done, in bytes.

The max_file_count attribute must be included and indicates the maximum number
of files that can be uploaded with the form. Include additional `<input type="file"
name="filexx" />` attributes if desired.

The expires attribute is the Unix timestamp before which the form must be submitted
before it is invalidated.

User Tenant ID, Access Key ID, and Secret Key are required in order to create form
signature. Tenant ID must be prepend to Access Key ID in order to ensure the signer has
the proper permissions. You can see your Tenant and Access Keys in the API Keys section of
the HP Cloud Management Console.


#### 2.6.7 Signature Based Authentication #### {#signature_auth}

Signature based authentication provides an alternate way of authenticating your request. Normally, you obtain a token from the HP Cloud Identity service and include the token in the  X-Auth-Token header. With signature based authentication you use an Access Key to “sign” a request. The resulting signature is then included in the Authorization header (instead of X-Auth-Token).

##### 2.6.7.1 Creating a Signature for the Authorization Header

To create a signature you need a Tenant Id and Access Key. You can see your Tenant Id and Access Keys by accessing the API Keys section of the HP Cloud Management Console. You may create additional Access Keys. You may also delete Access Keys. This can be used if you suspect that an Access Key has been compromised. When you delete an Access Key, signature based authentication requests that were signed using the deleted Access Key will fail.

An Access Key has two parts – an Access Key ID and a Secret Key. As you can see below, the Access Key ID appears in the Authorization header. However, the Secret Key does not. Obviously, you should only reveal the Secret Key to trusted parties.

The value for the Authorization header is constructed as follows:

    Authorization = "HP" + " " + TenantID + ":" + AccessKeyId + ":" + Signature;
 
    Signature = Base64( HMAC-SHA1( SecretKey, UTF-8-Encoding-Of( StringToSign ) ) );
 
    StringToSign = HTTP-Verb + "\n" +
        Content-MD5 + "\n" +
        Content-Type + "\n" +
        Date + "\n" +
        CanonicalizedHeaders +
        CanonicalizedResource;
 
    CanonicalizedResource = (described below)
 
    CanonicalizedHeaders = (described below) 

The CanonicalizedResource is the path of the account, container or object you are accessing. However, you must observe some conventions in constructing the path used in the signing process. Specifically:

* The CanonicalizedResource must start with the same path as your HP Object Storage endpoint (i.e., to include the version and account). For example, if your service endpoint is `https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345`, your CanonicalizedResource  must start with `/v1/12345678912345`.

> Note: Some older accounts have a path such as `/v1/AUTH_96ca9388-b3df-4016-ad3b-ca05a917455d`. If so, use this full value. 

* The remaining path up to but not including a query is included in your CanonicalizedResource. For example, if your path is `/v1/12345678912345/images?prefix=snow`, then your CanonicalizedResource is `/v1/12345678912345/images`.

The CanonicalizedHeaders are constructed as follows:

1. The Content-Type and Content-MD5 are not included in the CanonicalizedHeaders and are skipped. However, their values are included in the StringToSign. If you plan to omit these headers from the request, the values of Content-Type, Date and Content-MD5 in the StringToSign must be set to the empty string.

2. Convert each HTTP header name to lower case. For example, X-Meta-Container-One becomes x-meta-container-one.

3.	If the header spans multiple lines, replace trailing whitespace (including newline) with a single space character.

4.	Trim any whitespace around the colon. For example, "x-meta-container-blah: &nbsp;&nbsp;&nbsp;&nbsp;blah" becomes "x-meta-container-blah:blah"

5.	Append a newline character to each header

6.	Sort the collection of headers in lexicographical order by header name.
 
7.	Concatenate the resulting list into a single string

> Note: You must include a [Date](#date_request) header in your request – and include it when constructing the CanonicalizedHeaders

##### 2.6.7.2 Using Signature Based Authentication

Here's an example of using signature based authentication in a request:

    GET /v1/12345678912345/images/January/snow.jpg HTTP/1.1
    Host: region-a.geo-1.objects.hpcloudsvc.com
    Date: Mon, 26 Mar 2007 19:37:58 +0000
    Authorization: HP 971350225483156:GP54NNRN2TKBVWH449AG:frJIUN8DYpKDtOLCwo//yllqDzg=


### 2.8 Retrieving large number of container or object names ### {#pagination}

When doing a GET request against an account or container, the service returns a maximum of 10,000 names per request. To
retrieve subsequent names, you must make another request with
a *marker* parameter. The marker indicates where the last list left off;
the system returns  names greater than this marker, up to
10,000 again. Note that the marker value should be URL-encoded prior
to sending the HTTP request.

If 10,000 is larger than desired, a *limit* parameter may be given.

If the number of names returned equals the limit given (or
10,000 if no limit is given), it can be assumed there are more
names to be listed. If the name list is exactly divisible by
the limit, the last request has no content.

For example, let's use a listing of five names

      apples
      bananas
      kiwis
      oranges
      pears
                        

We'll use a limit of two to show how things work:

      GET /v1/1234567891012345?limit=2

      apples
      bananas
                        

Since two items were received, you can assume there are more
names to list, so you make another request with a marker of the last
item returned:

      GET /v1/1234567891012345?limit=2&marker=bananas
     
      kiwis
      oranges
                        

Again, two items are returned; there may be more:

      GET /v1/1234567891012345?limit=2&marker=oranges
      
      pears
                        

With this one-item response we received less than the limit number of names, indicating that this is the end of the list.

### 2.9 Hierarchical Folders or Directories ### {#pseudo_hierarchies}

You can simulate a hierarchical structure in HP Cloud Object Storage by
following a few guidelines. Object names must contain a delimiter
character to indicate the hierarchical structure.

By default `GET /v1/{account}/{container}` returns all objects in the container. You can search for a subset of names
using query parameters. This allows you to "navigate" the hierarchical structure. There are techniques you can use
as follows:

* Use prefix/delimiter.  
The names of the objects contain the pseudo-hierarchical structure, but here are no real objects to represent a folder or
directory. To navigate, use the prefix and delimiter query parameters as explained below. 
By convention, the slash ('/') character is usually used.
For example, an object name could be `photos/2012/image-1.jpg`

* Use path.  
Create placeholder objects to represent folders or directories. The objects are also named to include the hierarchy.
For example, for an object called `photos/2012/image-1.jpg`, there would also be two placeholder  objects called `photos/` and
`photos/2012/`. To navigate, use the path query parameter as explained below.

While both achieve similar results, there are differences:

* With prefix/delimiter, you may use any delimiter character. For example you could use the colon character (':').
With path, you must use the slash ('/') character.

* With prefix/delimiter you do not need to manage (create/delete) placeholder objects

* Conversely, with prefix/delimiter, there is no way to represent an empty folder or directory.


#### 2.9.1 Using prefix and delimiter query parameters #### {#prefix_delimiter} 

To show how to construct and navigate through a hierarchy, we will use a container containing 7 objects.
In this example, we will use the slash ('/') character as the delimiter.

Here is a full listing of the container in plain text:

	GET /v1/12345678912345/test_container
	X-Container-Object-Count: 7
	
	dir1/obj1
	dir2/dir3/obj2
	dir2/dir3/obj3
	dir4/obj4
	dir4/obj5
	obj6
	obj7


Notice that there are 7 objects. The first object has a name of `dir1/obj1` -- not `obj1`, i.e., the name contains the hierarchical structure.

By adding the `format=json` query parameter, we can see the objects in more detail.

	GET /v1/12345678912345/test_container?format=json
	X-Container-Object-Count: 7

	[
	  {"name":"dir1/obj1","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:18:09.788760"},
	  {"name":"dir2/dir3/obj2","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:40:48.596260"},
	  {"name":"dir2/dir3/obj3","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:41:04.902890"},
	  {"name":"dir4/obj4","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:41:20.756000"},
	  {"name":"dir4/obj5","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:42:49.804350"},
	  {"name":"obj6","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:19:26.524310"},
	  {"name":"obj7","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:19:33.865370"}
	]


To list only the objects in the first "level" of our pseudo hierarchy, we can use the `delimiter=/` query parameter as follows:

	GET https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container?format=json&delimiter=/
	X-Container-Object-Count: 7

	[
	  {"subdir":"dir1/"},
	  {"subdir":"dir2/"},
	  {"subdir":"dir4/"},
	  {"name":"obj6","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:19:26.524310"},
	  {"name":"obj7","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:19:33.865370"}
	]


The effect of delimiter is to examine all object names up to the `/` character and to collapse all common or duplicate elements. Where common/duplicate name parts are found,
it uses the "subdir" JSON element. The same happens for XML. Notice that X-Container-Object-Count is still 7, even though there are only 5 names shown. The "subdir"
elements are *not* objects -- an attempt to `GET /v1/12345678912345/test_container/dir1/` would fail with `403 Not Found`.

To descend into one of the "directories", we use the `prefix` query parameter as follows. Note the shash ("/") at the end of the prefix:


	GET https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container?format=json&delimiter=/&prefix=dir2/
	X-Container-Object-Count: 7
	
	[
	  {"subdir":"dir2/dir3/"}
	]


Descending further, we add `dir3/` to the `prefix` as follows:

	GET https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container?format=json&delimiter=/&prefix=dir2/dir3
	X-Container-Object-Count: 7
	
	[
	  {"name":"dir2/dir3/obj2","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:40:48.596260"},
	  {"name":"dir2/dir3/obj3","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:41:04.902890"}
	]


#### 2.9.2 Using path query parameter

To use path effectively, we must create placeholder objects with the names of the folders or directories. By convention these are zero length
with a [Content-Type](#content_type_request) of `application/directory`. 

> Note: these objects must a have trailing `/` in their names, i.e., `dir1/`, not `dir1`.

If we do this for each of the "directories" in the [prefix/delimiter](#prefix_delimiter) example, and then
list the contents of the container, we get:

	GET https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container?format=json
	X-Container-Object-Count: 11

	[
	  {"name":"dir1/","hash":"d41d8cd98f00b204e9800998ecf8427e","bytes":0,"content_type":"application/directory", "last_modified":"2012-11-22T16:45:47.669580"},
	  {"name":"dir1/obj1","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:18:09.788760"},
	  {"name":"dir2/","hash":"d41d8cd98f00b204e9800998ecf8427e","bytes":0,"content_type":"application/directory", "last_modified":"2012-11-22T16:46:14.239280"},
	  {"name":"dir2/dir3/","hash":"d41d8cd98f00b204e9800998ecf8427e","bytes":0,"content_type":"application/directory", "last_modified":"2012-11-22T16:46:14.239280"},
	  {"name":"dir2/dir3/obj2","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:40:48.596260"},
	  {"name":"dir2/dir3/obj3","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:41:04.902890"},
	  {"name":"dir4/","hash":"d41d8cd98f00b204e9800998ecf8427e","bytes":0,"content_type":"application/directory", "last_modified":"2012-11-22T16:46:41.420930"},
	  {"name":"dir4/obj4","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:41:20.756000"},
	  {"name":"dir4/obj5","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:42:49.804350"},
	  {"name":"obj6","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:19:26.524310"},
	  {"name":"obj7","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:19:33.865370"}
	]


Now `dir1/`, `dir2/`, `dir2/dir3/`, and `dir4/` are real objects. The [X-Container-Object-Count](#x_container_object_count_response) response header now shows 10 objects in the system.

Here we query to top level of the container (where path is empty sting):

	GET https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container?format=json&path=
	X-Container-Object-Count: 11

	[
	  {"name":"dir1/","hash":"d41d8cd98f00b204e9800998ecf8427e","bytes":0,"content_type":"application/directory", "last_modified":"2012-11-22T16:45:47.669580"},
	  {"name":"dir2/","hash":"d41d8cd98f00b204e9800998ecf8427e","bytes":0,"content_type":"application/directory", "last_modified":"2012-11-22T16:45:47.669580"},
	  {"name":"dir4/","hash":"d41d8cd98f00b204e9800998ecf8427e","bytes":0,"content_type":"application/directory", "last_modified":"2012-11-22T16:46:41.420930"},
	  {"name":"obj6","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:19:26.524310"},
	  {"name":"obj7","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:19:33.865370"}
	]


Here we descend into `dir4/`:

	GET https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container?format=json&path=dir4
	X-Container-Object-Count: 10
	
	[
	  {"name":"dir4/obj4","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:41:20.756000"},
	  {"name":"dir4/obj5","hash":"b917968b8ad501a40af22c0bf4d83ee0","bytes":377,"content_type":"application/octet-stream", "last_modified":"2012-11-22T15:42:49.804350"}
	]


Notice that path was set to `dir4`. It could also have been set to `dir4/` -- the effect is the same.



### 2.10 Conditional GET of objects ### {#conditional_get}

You can perform conditional GET requests of an object by using certain HTTP
headers as documented in [RFC 2616](http://www.ietf.org/rfc/rfc2616.txt](http://www.ietf.org/rfc/rfc2616.txt). 
HP Cloud Object Storage supports the following headers:

* If-Match
* If-None-Match
* If-Modified-Since
* If-Unmodified-Since

### 2.11 Retrieving a portion of object data ### {#range_request}

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

### 2.12 Large Object Creation ### {#large_objects}

Objects that are larger than 5GB must be segmented prior to upload. You
upload the segments as individual objects and create a
manifest object telling HP Cloud Object Storage how to find the segments
of the large object. The segments remain individually addressable, but
retrieving the manifest object streams all the segments concatenated.
There is no limit to the number of segments that can be a part of a
single large object.

In order to ensure the download works correctly, you must upload all the
object segments to the same container and ensure each object name has a
common prefix where their names sort in the order they should be
concatenated. You also must create and upload a manifest object. The
manifest object is simply a zero length object with the extra
'X-Object-Manifest' request header. The value is the container
and prefix in this format: `{container}/{prefix}` , where `{container}`
is the container the object segments are in and `{prefix}` is the common
prefix for all the segments.

It is best to upload all the segments first and then create or update
the manifest. With this method, the full object is not available for
downloading until the upload is complete. Also, you can upload a new set
of segments to a second location and then update the manifest to point
to this new location. During the upload of the new segments, the
original manifest is still available to download the first set of
segments.

> Note: When you create an object manifest, the system does not check that
the object segments are already uploaded.


If you perform a GET or HEAD operation on the object manifest, 
the [Content-Length](#content_type_response) is the total length of
all object segments.

The following shows an example of uploading a segmented object called maps/world.jpg.
The object is in the `images` container. For illustrative purposes, the object
segments are stored in the `image-segments` container. The final operation is to download
the segmented object. Note the [Content-Length](#content_length_response) and [ETag](#etag_response)
response headers.



	$ curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/image-segments/world-seg-1 -X PUT -T world-seg.1
	HTTP/1.1 201 Created
	Content-Length: 100
	Content-Type: application/octet-stream
	Etag: 9eee6548e45382ffa8f93d574d35274f
	
	$ curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/image-segments/world-seg-2 -X PUT -T world-seg.2
	HTTP/1.1 201 Created
	Content-Length: 200
	Content-Type: application/octet-stream
	Etag: 318ea6d6a0aa0567246f2de90c470fcd
	
	$ curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/images/maps/world.jpg -X PUT -H 'content-length: 0' -H 'x-object-manifest: image-segments/world-seg-' -H 'content-type: image/jpeg'
	HTTP/1.1 201 Created
	
	$ curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/images/maps/world.jpg -X GET
	HTTP/1.1 200 OK
	X-Object-Manifest: image-segments/world-seg-
	Content-Type: image/jpeg
	Content-Length: 300
	ETag: "4e12eb0effb78728966205d154967a67"
	
	[ .. ]



> Note: the MD5 checksum in the [ETag](#etag_response) header is the MD5 checksum of the concatenated string of MD5 checksums/ETags
for each of the segments in the manifest - not the MD5 checksum of the content that was downloaded. Also the value is enclosed in double-quote characters.


### 2.13 Chunked Transfer Encoding ### {#transfer_encoding_request}

When you create an object, you normally specify the size of the content being uploaded
with the [Content-Length](#content_length_request) request header. Alternatively
you can use the Transfer-Encoding request header and set it to a value of `chunked`.

With Chunked Transfer Encoding, you do not need to know the total size of the object in
advance. Instead, you can start to transfer "chunks" of content. You need
to know the size of each chunk. To indicate that you have finished transferring
chunks, you specify a size of 0. 

If you attempt to upload more that 5GB with this method, the service closes the
TCP/IP connection after 5GB and purges the object from the system. For large
objects, use [object segments](#large_objects).

In the following example, the object is uploaded in two chunks. As you can see
the size is given before each chunk of data.
The size is expressed as the number of octets of the data expressed in hexadecimal.
The final chunk has a size of 0, indicating the end of content.

      PUT /v1/12345678912345/{container}/{object} HTTP/1.1
      Transfer-Encoding: chunked                     

      19
      A bunch of data broken up
      D
       into chunks.
      0

> Note: the chunk size only indicates the size of the chunk data. This does not include the trailing CRLF ("\r\n")
                      

### 2.14 Enabling File Compression with the Content-Encoding Header ### {#content_encoding_header}


The Content-Encoding header allows a file to be compressed without
losing the identity of the underlying media type of the file, for
example, a video.

In the example, the content-encoding header is assigned with an
attachment type that indicates how the file should be downloaded:


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1/vid -X PUT -T vid -H 'Content-Type: video/mp4' -H 'Content-Encoding: gzip'
	HTTP/1.1 201 Created
	ETag: 4281c348eaf83e70ddce0e07221c3d28

           

### 2.15 Enabling Browser Bypass with the Content-Disposition Header ###(#content_disposition_header)

When an object is assigned the Content-Disposition header you can
override a browser's default behavior for a file so that the downloader
saves the file rather than displaying it using default browser settings.

In the example, the content-encoding header is assigned with an
attachment type that indicates how the file should be downloaded.


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1/image.tif -X PUT -T image1.tif -H 'Content-Type: image/tiff' -H 'Content-Disposition: attachment; filename=image.tif'
	HTTP/1.1 201 Created
	ETag: 4281c348eaf83e70ddce0e07221c3d28


### 2.16 Container Synchronization

#### 2.16.1 Overview of Container Synchronization

Container Synchronization allows you to automatically synchronize the objects between containers in different HP Cloud Object Storage
instances/regions. The containers must be in different instances or regions. The containers do not need to be
in the same swift account i.e., users associated with two different tenants can share objects.

Container Synchronization works by making a copy of objects in a "source" container and sending the objects to a "destination" container.
The object is copied in such a way as to retain its metadata -- such as [Last-Modified](#last_modified_response) and any custom
metadata you may have on the object. If you delete an object in the source container, it is also deleted from the destination
container.

The synchronization is done as a background action. When you put an object into the source container, it will take some time
before it becomes visible in the destination container.
HP Cloud Storage Services will not necessarily copy objects in any particular order. Specifically, they
may be transferred in a different order to which they were created.

> Note: [Segmented objects](#large_objects) (objects larger than 5GB) will not work seemlessly with Container Synchronization.
If the manifest object is copied to the destination container before the object segments,
when you perform a GET operation on the manifest object, the system may fail to find some or
all of the object segments. If your manifest and object segments are in different containers, don't forget that both containers
must be synchonized and that the container name of the object segments must be the same on both source and destination.

You may operate on the destination container just like any other container -- adding or deleting objects -- including the
objects that are in the destination container because they were copied from the source container. To decide how to handle
object creation, replacement or deletion, the system uses timestamps to determine what to do. In general, the latest timestamp
"wins" i.e., if you create an object, replace it, delete it and the re-create it, the destination container will eventually
contain the most recently created object. However, if you also create and delete objects in the destination container,
you get some subtle behaviours as follows:

* If an object is copied to the destination container and then deleted, it remains deleted in the destination even though there is still a copy in the source container. Of course, if you modify the object (replace or change its metadata) in the source container, it will reappear in the destination again.
* The same applies to a replacement or metadata modification of an object in the destination container -- the object will remain as-is unless there is a replacement or modification in the source container.
* If you replace or modify metadata of an object in the destination container and then delete it in the source container, it is _not_ deleted from the destination. This is because your modified object has a later timestamp than the object you deleted at source.
* If you create an object in the source container and before the system has a chance to copy it to the destination, you also create an object of the same name in the destination, then the object in the destination is _not_ overwritten by the source container's object.

So far, the discussion has been about synchronizing between a source and destination container. What happens if you make the "destination" a "source" for another container? There are three situations:

* The new destination is yet another container. i.e., there is a chain of three containers
* The new destination is actually the original source container. This is two-way synchronization. In effect, objects placed into either container will be copied to the other container.
* Two or more source containers could copy data to a single destination


#### 2.16.2 Configuring Containers to Synchronize #### {#container_sync_request}

This section describes how to set up synchronization between a source and destination container. To set up a chain, or two-way synchronization, simply repeat the operation
for the new source and destination. To set up synchronization between containers you need to know or agree:

* The full pathname of the destination container  -- to include system name, account and container name (e.g., https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345987654321/dest)
* The full pathname of the source container  -- to include system name, account and container name (e.g., https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345987654321/src)
* Select and agree on a secret string -- in effect, this is a shared password. Only if both sides have the same password will the system synchronize containers. Obviously, you should keep this secret. If this becomes known to someone else, they could overwrite the contents of the destination container (but not copy the source container).

You then:

1. Set the following metadata on the source container:
  * X-Container-Sync-To. This is the full path name of the destination, e.g.  https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345987654321/dest
  * X-Container-Sync-Secret. This is the value of the shared secret value, e.g. "our-secret"

2. Set the following metadata on the destination container:
  * X-Container-Sync-Secret. This is the value of the shared secret value, e.g. "our-secret"

Notice that you do not need to tell the destination container the name of the source container.

Here is an example of setting up a simple one-way synchronization between two containers. In this example, we are setting up
synchronization between containers in two different tenants/accounts -- hence the authorization token is different. These commands are either run by two different people, or one 
person must have the credentials for both tenants. In a simpler scenario, where the containers are both in the same tenant, the authorization token would be the same.

Here, the source is set up:



	curl https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/src -H 'x-auth-token: HPAUTH_4321' -X PUT -H 'x-container-sync-to: https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345987654321/dest' -H 'x-container-sync-secret: our-secret'


Here, the destination is setup with a secret value:

	curl https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345987654321/dest -H 'x-auth-token: HPAUTH_1234' -X PUT -H 'x-container-sync-secret: our-secret'


The following example shows setting up two-way synchronization where the account and container names are the same on both systems.
Notice that the commands are nearly identical except for the "region-a" and "region-b" strings in the paths.


	curl https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/photos -H 'x-auth-token: HPAUTH_1234' -X PUT -H 'x-container-sync-to: https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345678912345/photos' -H 'x-container-sync-secret: my-secret'
	
	curl https://region-b.geo-1.objects.hpcloudsvc.com/v1/12345678912345/photos -H 'x-auth-token: HPAUTH_1234' -X PUT -H 'x-container-sync-to: https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/photos' -H 'x-container-sync-secret: my-secret'



### 2.17 Notable Differences from OpenStack


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

* Temporary URLs do not use the X-Account-Meta-Temp-URL-Key metadata to store the secret key. Instead we use the HP Cloud Identity Services _Access Keys_.
See [Temporary URLs](#temp_url) for more information.

* FormPOST. The key used in FormPOST uses the HP Cloud Identity Services _Access Keys_. 
See [FormPost](#formpost) for more information. 

* Signature Based Authentication. This is an alternative to the [X-Auth-Token](#x_auth_token_request) request header. 
See [Signature Based Authentication](#signature_auth) for more information.


##  3. Account-level View

### 3.1 Tenants and HP Cloud Storage accounts ### {#tenants_accounts}

There is a one-to-one relationship between an account and the _tenant_. In fact, for most users, the HP Cloud Storage account and tenant _Id_ are the same.

If you subscribed to the HP Cloud Beta program, your HP Cloud Storage account name may start with "AUTH_", followed by a long number. This makes
no difference to how you use the API.

### 3.2 Regions

HP Cloud Object Storage has the following service instances in these regions:

* region-a-geo-1 - US West

* region-b.geo-2 - US East

Each instance or region is a distinct storage entity. Each contains its own set of containers and
objects -- there is no shared data between the regions.

In each instance/region, HP Cloud Object Storage has servers physically located in multiple availability zones.
It also automatically keeps multiple copies of data in multiple availability zones.
The system transparently manages this for you -- you have a single endpoint through which
you access HP Cloud Object Storage services for an instance/region.

### 3.3 Service Catalog ### {#service_catalog}

The HP Cloud Identity Service is used to authenticate users. See [Using Authentication Tokens](#using_tokens)
for more information.

For additional details on the Identity Service, please refer to
[https://docs.hpcloud.com/identity](https://docs.hpcloud.com/identity).

The service is exposed in the service catalog, as shown in the following fragment. Note the
user has the Admin role and is activated for two instances of the HP Cloud
Object Storage service.


	{"access": {
	  "token": {
	    "expires": "2012-11-21T23:14:30.559Z",
	    "id": "HPAuth_1234",
	    "tenant": {
	      "id": "12345678912345",
	      "name": "sally"
	    }
	  },
	  "user": {
	    "id": "4321987654321",
	    "name": "sally",
	    "roles": [
	     .
	     .
	     .
	      {
	        "id": "00000000004022",
	        "serviceId": "110",
	        "name": "Admin",
	        "tenantId": "87135022548315"
	      },
	      .
	      .
	      .
	    ]
	  },
	  "serviceCatalog": [
	    .
	    .
	    .
	    {
	      "name": "Object Storage",
	      "type": "object-store",
	      "endpoints": [
	        {
	          "tenantId": "12345678912345",
	          "publicURL": "https:\/\/region-a.geo-1.objects.hpcloudsvc.com\/v1\/12345678912345",
	          "region": "region-a.geo-1",
	          "versionId": "1.0",
	          "versionInfo": "https:\/\/region-a.geo-1.objects.hpcloudsvc.com\/v1.0\/",
	          "versionList": "https:\/\/region-a.geo-1.objects.hpcloudsvc.com"
	        },
	        {
	          "tenantId": "1234567891234",
	          "publicURL": "https:\/\/region-b.geo-1.objects.hpcloudsvc.com:443\/v1\/12345678912345",
	          "region": "region-b.geo-1",
	          "versionId": "1",
	          "versionInfo": "https:\/\/region-b.geo-1.objects.hpcloudsvc.com:443\/v1\/",
	          "versionList": "https:\/\/region-b.geo-1.objects.hpcloudsvc.com:443"
	        }
	      ]
	    },
	    .
	    .
	    .



## 4. REST API Specifications

### 4.1 Service API Operations

**Host US West Region**: https://region-a.geo-1.objects.hpcloudsvc.com

**Host US East Region**: https://region-b.geo-1.objects.hpcloudsvc.com

**BaseURI**: {Host}/v1/{account}


| Resource                         | Operation                                      | HTTP Method | Path                               | JSON/XML?   | Privilege Level |
| :-------                         | :--------------------------                    | :---------- | :---------------------             | :--------   | :-------------  |
| [Account](#account_resource)     | [List containers](#account_get)                | GET         | /v1/{account}                      | Y/Y         | Admin |
| [Account](#account_resource)     | [Update account metadata](#account_post)       | POST        | /v1/{account}                      | n/a         | Admin |
| [Account](#account_resource)     | [Retrieve account metadata](#account_head)     | HEAD        | /v1/{account}                      | n/a         | Admin |
| [Container](#container_resource) | [List objects](#container_get)                 | GET         | /v1/{account}/{container}          | Y/Y         | Admin |
| [Container](#container_resource) | [Retrieve container metadata](#container_head) | HEAD        | /v1/{account}/{container}          | n/a         | Admin |
| [Container](#container_resource) | [Create/Update container](#container_put)      | PUT         | /v1/{account}/{container}          | n/a         | Admin |
| [Container](#container_resource) | [Update container metadata](#container_post)   | POST        | /v1/{account}/{container}          | n/a         | Admin |
| [Container](#container_resource) | [Delete container](#container_delete)          | DELETE      | /v1/{account}/{container}          | n/a         | Admin |
| [Object](#object_resource)       | [Retrieve object](#object_get)                 | GET         | /v1/{account}/{container}/{object} | n/a         | Admin |
| [Object](#object_resource)       | [Retrieve object metadata](#object_head)       | HEAD        | /v1/{account}/{container}/{object} | n/a         | Admin |
| [Object](#object_resource)       | [Create/Replace Object](#object_put)           | PUT         | /v1/{account}/{container}/{object} | n/a         | Admin |
| [Object](#object_resource)       | [Update object metadata](#object_post)         | POST        | /v1/{account}/{container}/{object} | n/a         | Admin |
| [Object](#object_resource)       | [Delete object](#object_delete)                | DELETE      | /v1/{account}/{container}/{object} | n/a         | Admin |



### 4.2 Common Request Headers

Many operations accept request headers. This section provides an overview of each request header. Consult the specific operation to determine if the header applies to the operation and any other notes that are of interest.

#### 4.2.1 Accept #### {#accept_request}

Where applicable, this determines how the response body is formatted. For example, you can use this to list the objects in a container as:
* text (text/plain)
* JSON (application/json)
* XML (text/xml, application/xml)


#### 4.2.2 Content-Length #### {#content_length_request}

Where applicable, this is the length in bytes of the body of the request.
For objects, you may use the [Transfer-Encoding](#transfer_encoding_request) instead of a Content-Length.

#### 4.2.3 Content-Type #### {#content_type_request}

Where applicable, this indicates the MIME type of an object.

When applied to object resources, the Content-Type request header is optional. If not specified, HP Cloud Storage will attempt to identify the content type and assign a MIME type. If this fails, the type is set to application/octet-stream. If you specify a value in the request header, when you next do a HEAD or GET operation on the object, the Content-Type response header is set to the specified value.

#### 4.2.4 Date #### {#date_request}

When specified, this is the date and time at which the operation request is made. The value should be expressed as shown in one of the following examples:

      Sun, 06 Nov 1994 08:49:37 +0000 ; RFC 2822
      Sun, 06 Nov 1994 08:49:37 GMT   ; RFC 822, updated by RFC 1123
      Sunday, 06-Nov-94 08:49:37 GMT  ; RFC 850, obsoleted by RFC 1036
      Sun Nov  6 08:49:37 1994        ; ANSI C's asctime() format

As you can see, the date and time is expressed in GMT or UTC time. The first example ("Sun, 06 Nov 1994 08:49:37 +0000") is the preferred format. However, HP Cloud Object Storage uses the second example ("Sun, 06 Nov 1994 08:49:37 GMT") when displaying dates.

#### 4.2.5 X-Auth-Token #### {#x_auth_token_request}

When specified, this identifies the user making the request. In addition, if this token is being used by a user with Admin privilege level, the token must be scoped to the tenant associated with the account. If no token is specified, the request will fail unless you have been granted access to the resource by some other mechanism such as ACLs. See [Using Authentication Tokens](#using_tokens) for more information about tokens.

#### 4.2.6 X-Container-Meta-{name} #### {#x_container_meta_request}

This allows you to set custom metadata on a container using a header name with a prefix of X-Container-Meta-. After this prefix, you can
pick any name meaningful to you. For example, X-Container-Meta-Reviewed could be used indicate that the contents
of a container had been reviewed.

Any valid UTF-8 http header value is allowed for metadata, however we
recommend that you URL-encode any non-ASCII values


#### 4.2.7 X-Container-Read #### {#x_container_read_request}

Sets the access control list (ACL) that grants read access to a container and its objects.

#### 4.2.8 X-Container-Write #### {#x_container_write_request}

Sets the access control list (ACL) that grants write access to a container and its objects.

#### 4.3.13 ETag #### {#etag_request}

HP Cloud Object Storage
does not use the Content-MD5 request header - use ETag as a request header instead.
Use this header to ensure that an upload of an object does not suffer from a data corruption. 

For objects smaller than 5GB and [manifest objects](#large_objects), this is the MD5 checksum of the request body.

Do not use this request header when uploading manifest objectsbecause the
system will dynamically create an ETag value when you download the manifast. See the [ETag](#etag_request) response header
and [Large Object Creation](#large_objects) for more information.

### 4.3 Common Response Headers

#### 4.3.1 Date #### {#date_response}

When supplied, the Date header is the time of the operation expressed in GMT (effectively UTC) as shown in the following example:
 
      HTTP/1.1 200 OK
      Date: Sun, 06 Nov 1994 08:49:37 GMT

#### 4.3.2 Last-Modified #### {#last_modified_response}

This is the date and time that the container or object was created or the last time that the metadata was changed.

#### 4.3.3 Content-Length #### {#content_length_response}

When the response includes a body, this indicates the length of the body in bytes.

> Note: For HEAD operations against an object, the Content-Length response header contains
the size of the object. Normally, in HTTP HEAD operations, the Content-Length would
be zero since no content is returned. This exception might confuse your client if it
waits for more content in the response.

#### 4.3.4 Content-Type #### {#content_type_response}

When the response includes a body, this indicates the MIME type of the response.
For listing operations (account/container), you can use the [Accept](#accept_request)
request header to request JSON or XML.
For a GET or HEAD against an object, the Content-Type is whatever value was set
when the object was uploaded.

#### 4.3.5 X-Container-Meta-{name} #### {#x_container_meta_response}

This contains the value of X-Container-Meta-{name} metadata that was previously set on a container, where {name} is
an arbitrary name meaningful to you.

#### 4.3.6 X-Account-Object-Count #### {#x_account_object_count_response}

The total number of objects in all containers associated with the account.

#### 4.3.7 X-Account-Bytes-Used #### {#x_account_bytes_used_response}

The total size in bytes of all objects in all containers associated with the account.

#### 4.3.8 X-Account-Container-Count #### {#x_account_container_count_response}

The number of containers in the account

#### 4.3.9 X-Container-Read #### {#x_container_read_response}

The access control list (ACL) that grants read access to a container and its objects.

#### 4.3.10 X-Container-Write #### {#x_container_write_request}

The access control list (ACL) that grants write access to a container and its objects.

#### 4.3.11 X-Container-Object-Count #### {#x_container_object_count_response}

The number of objects in the container.

#### 4.3.12 X-Container-Bytes-Used #### {#x_container_bytes_used}

The total number of bytes used by all objects in the container.

#### 4.3.13 ETag #### {#etag_response}

For objects smaller than 5GB and [manifest objects](#large_objects), this is the MD5 checksum of the response body.

For [manifest objects](#large_objects), this is the MD5 checksum of the concatenated string of MD5 checksums/ETags
for each of the segments in the manifest - not the MD5 checksum of the content that was downloaded. Also the value is enclosed in double-quote characters.















### 4.4 Service API Operation Details

#### 4.4.1 Account ###

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

##### 4.4.1.1 List Account##### {#account_get}
##### GET /v1/{account}

This operation returns a listing of the containers in the designed account.

**Request Data**

The path specifies the account.

**URL Parameters**

By default up to 10,000 names are returned. To retrieve more or fewer names, use the *limit* and *marker* query parameters.
See [Retrieving large number of container or object names](#pagination) for more information.

* *limit* - (Optional) - Number - For an integer value of _N_, limits the number of results to at most _N_ values.

* *marker* - (Optional) - String - Given a string value _x_, return container names greater in value than the specified marker.

* *format* - (optional) - String - Specify either `json` or `xml` to return the respective serialized response.
You may alternatively specify the required type in the *Accept* request header.
      
                          
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

     <account name="12345678912345">  
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


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345 -X GET
	
	HTTP/1.1 200 OK
	X-Account-Object-Count: 21280
	X-Account-Bytes-Used: 3044371826
	X-Account-Container-Count: 2
	Content-Length: 34
	Content-Type: text/plain; charset=utf-8
	Date: Fri, 16 Nov 2012 11:18:45 GMT
	
	test_container_1
	test_container_2



**Additional Notes**



























##### 4.4.1.2 Update Account Metadata ##### {#account_post}
##### POST /v1/{account}

This operation updates custom metadata on an account.

You can set custom metadata on an account using a request header name with a prefix of X-Account-Meta-. After this prefix, you can
pick any name meaningful to you. For example, X-Account-Meta-Reviewed could be used indicate that the contents
of an account had been reviewed.

Any valid UTF-8 http header value is allowed for metadata, however we
recommend that you URL-encode any non-ASCII values.

You only need to specify the metadata item you wish to set or change i.e., the POST
operation leaves existing X-Account-Meta-{name} metadata intact.

To remove a metadata item, use a request header name with a prefix of X-Remove-Account-Meta-. After this prefix, you give
the name of the item to remove. For example, X-Remove-Account-Meta-Reviewed would indicate that the "reviewed" metadata
should be deleted. The value field can be any value; however, there must be *some* value for the request to take effect.


**Request Data**

The path specifies the account.

**URL Parameters**

None.
      
**Data Parameters**

This operation does not require a request body.

The following request headers apply to this operation:


* [X-Account-Meta-{name}](#x_account_meta_request) - Optional - Specifies custom metadata for the container
* [X-Remove-Account-Meta-{name}](#x_remove_account_meta_request) - Optional - Specifies custom metadata to remove
* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)

**Success Response**

This operation does not return a response body.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

None

**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**


	curl -i -H 'X-Auth-Token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345 -H 'x-account-meta-one: 1' -H 'x-remove-account-meta-two: -' -X POST
	HTTP/1.1 204 No Content



**Additional Notes**





























##### 4.4.1.3 Retrieve Account Metadata ##### {#account_head}
##### HEAD /v1/{account}

This operation gets the metadata associated with the account.

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
* [X-Account-Meta-{name}](#x_account_meta_response)

**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345 -X HEAD
	HTTP/1.1 200 OK
	X-Account-Object-Count: 21280
	X-Account-Bytes-Used: 3044371826
	X-Account-Container-Count: 2
	Content-Length: 0


**Additional Notes**

































                          


#### 4.4.2 Container

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

##### 4.4.2.1 Create/Update Container ##### {#container_put}
##### PUT /v1/{account}/{container}

This operation creates a container or updates the metadata associated with an existing container. 
You are free to pick a container name that is meaningful to you.
See [Container and Object Naming](#naming) for restrictions on container names.

You don't need to check if a container already exists before doing the PUT operation because the operation is idempotent (i.e., it will create a new container
or update an existing container as appropriate). 

You can set custom metadata on a container using a header name with a prefix of X-Container-Meta-. After this prefix, you can
pick any name meaningful to you. For example, X-Container-Meta-Reviewed could be used indicate that the contents
of a container had been reviewed. You only need to specify the metadata item you wish to set or change i.e., the POST
operation leaves existing X-Account-Meta-{name} metadata intact.

Any valid UTF-8 http header value is allowed for metadata, however we
recommend that you URL-encode any non-ASCII values.

**Request Data**

The path specifies the account and the name of the container to create.

The following request headers apply to this operation:


* [X-Container-Meta-{name}](#x_container_meta_request) - Optional - Specifies custom metadata for the container
* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)
* [X-Container-Read](#x_container_read_request) - Optional - Sets an ACL that grants read access
* [X-Container-Write](#x_container_write) - Optional - Sets an ACL that grants write access
* [X-Container-Sync-To](#container_sync) - Optional - See [Container Synchronization](#container_sync)
* [X-Container-Sync-Secret](#container_sync) - Optional - See [Container Synchronization](#container_sync)

**URL Parameters**

None  
                          
**Data Parameters**

This operation does not require a request body.

**Success Response**

On success, the container is created. See [Creation Guarantees](#creation_guarantees) for more information.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

A description of the HTTP Status Code.

**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1 -H 'x-container-meta-one: one' -X PUT
	HTTP/1.1 201 Created



**Additional Notes**

















##### 4.4.2.2 Update Container Metadata ##### {#container_post}
##### POST /v1/{account}/{container}

This operation updates the metadata associated with an existing container. 

You can set custom metadata on a container using a header name with a prefix of X-Container-Meta-. After this prefix, you can
pick any name meaningful to you. For example, X-Container-Meta-Reviewed could be used indicate that the contents
of a container had been reviewed. You only need to specify the metadata item you wish to set or change i.e., the POST
operation leaves existing X-Account-Meta-{name} metadata intact.

Any valid UTF-8 http header value is allowed for metadata, however we
recommend that you URL-encode any non-ASCII values.

**Request Data**

The path specifies the account and the name of the container to create.

The following request headers apply to this operation:


* [X-Container-Meta-{name}](#x_container_meta_request) - Required - Specifies custom metadata for the container
* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)
* [X-Container-Read](#x_container_read_request) - Optional - Sets an ACL that grants read access
* [X-Container-Write](#x_container_write) - Optional - Sets an ACL that grants write access
* [X-Container-Sync-To](#container_sync) - Optional - See [Container Synchronization](#container_sync)
* [X-Container-Sync-Secret](#container_sync) - Optional - See [Container Synchronization](#container_sync)

**URL Parameters**

None  
                          
**Data Parameters**

This operation does not require a request body.

**Success Response**

On success, the container is updated.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

A description of the HTTP Status Code.

**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1 -H 'x-container-meta-one: one' -X POST
	HTTP/1.1 204 No Content


**Additional Notes**





























##### 4.4.2.3 List Objects in a Container ##### {#container_get}
##### GET /v1/{account}/{container}                  

Retrieve a list of objects stored in a container.

**Request Data**

The path specifies the account and container name.

The following request headers apply to this operation.

* [Accept](#accept_request) - Optional - Specifies the format for listing the names. Alternatively use the *format* parameter.
* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)


**URL Parameters**

By default up to 10,000 names are returned. To retrieve more or fewer names, use the *limit* and *marker* query parameters.
See [Retrieving large number of container or object names](#pagination) for more information.

By default, the names of all objects are returned. You can control which names are retrieved using the *prefix*, *delimiter* and *path* query parameters.
See [Pseudo-Hierarchical Folders or Directories](#pseudo_hierarchies) for more information.

The following query parameters are available:

* *limit* - (Optional) - Number - For an integer value of _N_, limits the number of results to at most _N_ values.

* *marker* - (Optional) - String - Given a string value _x_, return container names greater in value than the specified marker.

* *format* - (optional) - String - Specify either `json` or `xml` to return the respective serialized response. You may alternatively specify the required type in the *Accept* request header.

* *prefix* - (Optional) - String - For a string value *x*, causes the results to be limited to object names beginning with the substring *x*.

* *path* - (Optional) - String - For a string value *x*, return the object names nested in the pseudo path.

* *delimiter* - (Optional) - String - For a character *c*, return all the object names nested in the container (without the need for placeholder objects).

**Data Parameters**

This operation does not require a request body.

**Success Response**

If the container contains objects, their names are returned in the requested format in the response body. 
If there are no objects in the container, 204 (No Content) is returned.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

If there are objects, their names are returned in the response body in the requested format. The JSON and XML formats
list additional data about each object as follows:
* hash - The MD5 checksum for the contents on the object
* bytes -- The size in bytes of the object
* content_type - The MIME type of the object
* last_modified - The date and time the object was created or the time at which the object metadata was last updated. 

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


The following response headers are returned:

* [X-Container-Read](#x_container_read_response)
* [X-Container-Write](#x_container_write_response)
* [X-Container-Meta-{name}](#x_container_meta_response)
* [X-Container-Object-Count](#x_container_object_count_response)
* [X-Container-Bytes-Used](#x_container_bytes_used_response)
* [X-Container-Sync-To](#container_sync)
* [X-Container-Sync-Secret](#container_sync)

**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1 -X GET
	HTTP/1.1 200 OK
	X-Container-Object-Count: 2
	X-Container-Meta-One: one
	X-Container-Bytes-Used: 378
	Content-Length: 28
	Content-Type: text/plain; charset=utf-8
	
	test_object_1
	test_object_2


**Additional Notes**
















##### 4.4.2.4 Retrieve the Metadata of a Container ##### {#container_head}
##### HEAD /v1/{account}/{container}                  

Retrieve the metadata of a container.

**Request Data**

The path specifies the account and container name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)


**URL Parameters**

None.

**Data Parameters**

This operation does not require a request body.

**Success Response**

The metadata is returned in the response headers.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

The following response headers are returned:

* [X-Container-Object-Count](#x_container_object_count_response)
* [X-Container-Meta-{name}](#x_container_meta_response)
* [X-Container-Bytes-Used](#x_container_bytes_used)
* [X-Container-Sync-To](#container_sync)
* [X-Container-Sync-Secret](#container_sync)
      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1 -X HEAD
	HTTP/1.1 204 No Content
	X-Container-Object-Count: 2
	X-Container-Meta-One: one
	X-Container-Bytes-Used: 378


**Additional Notes**



















##### 4.4.2.5 Delete a Container ##### {#container_delete}
##### DELETE /v1/{account}/{container}                  

Delete a container.

You cannot delete a container if it has any objects in it.

**Request Data**

The path specifies the account and container name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)

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


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1 -X DELETE
	HTTP/1.1 204 No Content


**Additional Notes**
















      
                        




















                        
#### 4.4.3 Object

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

##### 4.4.3.1 Retrieve Object ##### {#object_get}
##### GET /v1/{account}/{container}/{object}

Retrieve the contents of an object.

In its simplest form, the GET operation returns the object contents in the response body
and retrieves the object's metadata and places the names and values into response headers.
However, you there are additional capabilities:

* You can perform conditional GET requests by using certain HTTP
headers as documented in [RFC 2616](http://www.ietf.org/rfc/rfc2616.txt](http://www.ietf.org/rfc/rfc2616.txt).
See [Conditional GET of objects](#conditional_get) for more information.

* It is also possible to fetch a portion of data using basic support of the HTTP [Range](#range_request)
header.

* If the object name is the name of an object manifest, the operation concatenates all the segments into one stream.
See [Large Object Creation](#large_object_creation) for more information.

**Request Data**

The path specifies the account, container name and object name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)
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

The object content is returned in the response body and metadata is returned in the response headers.
Since the HTTP Success code is written to the response stream before the response body and headers
are returned, it is possible that you will see a 200 Success code even though the transfer of headers
or body had a failure. You should check that the length of the actual body is the same as the
[Content-Length](#content_length_response) response header.

Ideally for objects of less than 5GB, you should also
perform an MD5 checksum over the response body and compare with the [ETag](#etag_response) response header.

For manifest objects (objects over 5GB) the ETag value is not the MD5 checksum of the body -- see [Large Object Creation](#large_objects)
for more information.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

The following response headers are returned:

* [Last-Modified](#last_modified_response)
* [Content_Length](#content_length_response)
* [Content_Type](#content_type_response)
* [ETag](#etag_response)
* [Content-Encoding](#content_encoding_header)
* [Content-Disposition](#content_disposition_header)
* [X-Object-Meta-{name}](#x_object_meta_response)

      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1/test_obj_1 -X GET
	HTTP/1.1 200 OK
	Last-Modified: Fri, 16 Nov 2012 15:34:56 GMT
	ETag: 4281c348eaf83e70ddce0e07221c3d28
	Content_Type: text/plain
	Content-Length: 12
	X-Object-Meta-Reviewed: Yes
	
	Hello World!


**Additional Notes**




















##### 4.4.3.2 Retrieve the Metadata of an Object ##### {#object_head}
##### HEAD /v1/{account}/{container}/{object}

Retrieve the metadata of an object.

**Request Data**

The path specifies the account, container name and object name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)

**URL Parameters**

None.

**Data Parameters**

This operation does not require a request body.

**Success Response**

The object metadata is returned in the response headers.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

The following response headers are returned. Note since this is a HEAD operation, the Content-Length
is not the length of the response body but is the size in bytes of the object content.

* [Last-Modified](#last_modified_response)
* [Content_Length](#content_length_response)
* [Content_Type](#content_type_response)
* [ETag](#etag_response)
* [Content-Encoding](#content_encoding_header)
* [Content-Disposition](#content_disposition_header)
* [X-Object-Meta-{name}](#x_object_meta_response)

      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1/test_obj_1 -X HEAD
	HTTP/1.1 200 OK
	Last-Modified: Fri, 16 Nov 2012 15:34:56 GMT
	ETag: 4281c348eaf83e70ddce0e07221c3d28
	Content_Type: text/plain
	Content-Length: 12
	X-Object-Meta-Reviewed: Yes


**Additional Notes**
















##### 4.4.3.3 Create/Replace Object ##### {#object_put}
##### PUT /v1/{account}/{container}/{object}

Creates an object with the supplied data content and metadata.

You also use this operation to update an existing object
(i.e. PUT to the same object name twice). You should think of this as replacing the
previous object's content and metadata.

In its simplest form, the PUT operation creates or replaces an existing object
with up to 5GB of data content. However, there are other features available as
follows:

* You can upload object content in chunks. This allows you to start an upload before you know the total
size of the object. You use the [Transfer-Encoding](#transfer_encoding_request) request header and omit the
[Content-Length](#content_length_request) request header.

* For objects greater than 5GB, you can upload a number of *object segments*. When all
segments are uploaded, you upload a *manifest object* telling HP Cloud Object Storage how to find the segments of the large object.
See [Large Object Creation](#large-object-creation) for more information.

* You can create [Pseudo-Hierarchical Folders or Directories](#pseudo_hierarchies). For a pseudo folder or directory,
a good practice is to create a zero-sized placeholder object with 
a [Content-Type](#content_type_request) of "application/directory".

* You can use the [Content-Encoding](#content_encoding_header) request header to indicate that
the object contents are compressed without losing the identity of the underlying media type of the file
as specified by the [Content-Type](#content_type_request) request header.

* You can override a browser's default behavior for a file so that the downloader saves the file rather
than displaying it using default browser settings by setting the [Content-Disposition](#content_disposition_header).

* You can ensure end-to-end data integrity by including an MD5 checksum of
your object's data in the ETag header. You are not required to include
the ETag header, but it is recommended to ensure that the storage system
successfully stored your object's content.
For [manifest objects](#large_file_creation), the ETag is the MD5 sum of the concatenated string of ETags for
each of the segments in the manifest.

* You can set custom metadata on an object using a header name with a prefix of [X-Object-Meta-](#x_object_meta_request). 
After this prefix, you can pick any name meaningful to you. For example, X-Object-Meta-Reviewed could be used indicate
that the contents of an object had been reviewed.
Any valid UTF-8 http header value is allowed for metadata, however we recommend that you URL-encode any non-ASCII values.

**Request Data**

The path specifies the account, container name and object name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)
* [Content-Length](#content_length_request) - Optional - The length in bytes of the request body. This is required unless you use the [Transfer-Encoding](#transfer_encoding_request) header.
* [Transfer-Encoding](#transfer_encoding_request) - Optional - Allows upload of an object in "chunks".
* [Content-Type](#content_type_request) - Optional - The MIME type of the object.
* [ETag](#etag_request) - Optional - The MD5 checksum of the request body
* [Content-Encoding](#content_encoding_header) - Optional - Indicate that the contents are compressed
* [Content-Disposition](#content_disposition_header) - Optional - Override default download behaviour of browsers
* [X-Object-Meta-{name}](#x_object_meta_request) - Optional - Sets custom metadata on the object
* [X-Object-Manifest](#large_objects) - Optional - Specifies that this object is an object manifest and "points" to the object segments.

**URL Parameters**

None.

**Data Parameters**

The request body is the contents (i.e., file) data of the object.

**Success Response**

The [ETag](#etag_response) response header contains the MD5 checksum of the data written to the
storage system. If you do not send the ETag as a request header, ideally you should
compare the value returned with your content's MD5 locally to perform
an end-to-end integrity check.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

No response body is returned. The following response headers are returned:

* [ETag](#etag_response)
      
**Error Response**

If an error occurs, the response body contains a description of the error.
If the MD5 checksum of the data written to the storage system does
NOT match the (optionally) supplied ETag value, a 422 (Unprocessable Entity) response is
returned.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**

	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1/dir1/ -X PUT -H 'content-type: application/directory' -H 'content-length: 0'
	HTTP/1.1 201 Created
	ETag: d41d8cd98f00b204e9800998ecf8427e
	
	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1/dir1/test_obj_1.gif -X PUT -T image1.gif
	HTTP/1.1 201 Created
	ETag: 4281c348eaf83e70ddce0e07221c3d28


**Additional Notes**
                        
































##### 4.4.3.4 Copy Object ##### {#object_copy}
##### PUT /v1/{account}/{target-container}/{target-object}
##### COPY /v1/{account}/{source-container}/{source-object}

Creates an object using another object as the source for the content and metadata.
Using an existing object means that the content is copied inside the HP Cloud Object Storage
service (i.e., at the server side). This means that the operation will be quicker because
you do not need to transfer the object contents over the public internet. In addition, you 
will not be charged for any network transfer of the object contents (however, you
may be charged for the operation itself).

The target container must exist before you perform the copy object operation.

All metadata is preserved during the object copy. If you specify metadata on the
request to copy the object (either the PUT or the COPY), the metadata overwrites
any conflicting keys on the target (new) object. 
 
You can pick any name that is meaningful to you. 
However, see [Container and Object Naming](#naming) for restrictions on container names.
In addition, the target and source object names may be the same name. This allows
you to change the metadata of individual items without having to specify the values of
all the other metadata items in the request.


**Request Data**

The path specifies the account, container name and object name of either the
source or target object as follows:

* PUT -- the container and object names are the name of the new object. The following request headers
must be set:
 - X-Copy-From - this designates the source of the data. The header value must be the container and object name of the source object in the form of "/{container}/{object}".
 - [Content-Length](#content_length_request) - this must be present and set to a value of zero (0).

* COPY -- the container and object names are the names of an existing object. The following
request header must be set:
  - Destination - this designates the target of the operation. The value must be the container and object name of the new (target) object in the form of "/{container}/{object}".

The following request headers apply to both PUT and COPY operations.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)
* [Content-Type](#content_type_request) - Optional - Specifies a new Content-Type for the new object
* [Content-Encoding](#content_encoding_header) - Optional - Indicate that the contents are compressed
* [Content-Disposition](#content_disposition_header) - Optional - Override default download behaviour of browsers
* [X-Object-Meta-{name}](#x_object_meta_request) - Optional - Sets custom metadata on an object

**URL Parameters**

None.

**Data Parameters**

This operation does not require a request body.

**Success Response**

On success, the object is created.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

No response body is returned. The following response headers are returned:

* [ETag](#etag_response)
* X-Copied-From - the name of the container/object used as source for the new object
* X-Copied-From-Last-Modified - the time and date that the source object was last updated
      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**


	$ curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/cont15/obj6' -X COPY -H 'destination: cont15/obj6-copy1'
	HTTP/1.1 201 Created
	Etag: b917968b8ad501a40af22c0bf4d83ee0
	X-Copied-From: cont15/obj6
	X-Copied-From-Last-Modified: Thu, 22 Nov 2012 15:19:26 GMT
	
	$ curl -i -H 'x-auth-token: HPAuth_1234' 'https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/cont15/obj6-copy2' -X PUT -H 'content-length: 0' -H 'x-copy-from: cont15/obj6'
	HTTP/1.1 201 Created
	Content-Type: text/html; charset=UTF-8
	Etag: b917968b8ad501a40af22c0bf4d83ee0
	X-Copied-From: cont15/obj6
	X-Copied-From-Last-Modified: Thu, 22 Nov 2012 15:19:26 GMT


**Additional Notes**

                        


                        






















##### 4.4.3.5 Delete an object ##### {#object_delete}
##### DELETE /v1/{account}/{container}/{object} 

Delete an object.

**Request Data**

The path specifies the account, container and object name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)

**URL Parameters**

None.

**Data Parameters**

This operation does not require a request body.

**Success Response**

The object is deleted.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

None
      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**


	curl -i -H 'x-auth-token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1/test_obj_1 -X DELETE
	HTTP/1.1 204 No Content


**Additional Notes**


                        




























##### 4.4.3.6 Update Object Metadata ##### {#object_post}
##### POST /v1/{account}/{container}/{object}

The POST operation is used in two modes:
* Updates the metadata of an object. This is the operation documented here.
* FormPOST. With specific query parameters, the POST operaiton allows you to 
upload files directly into HP
Cloud Object Storage by using signature-based authentication. See [FormPOST](#formpost) for more information about this mode.

You cannot use the POST operation to change any of the following metadata:

* [Content-Length](#content_length_request)
* [ETag](#etag_request)
* [Last-Modified](#last_modified_response)

To set custom metadata on an object use a header name with a prefix of [X-Object-Meta-](#x_object_meta_request). 
After this prefix, you can pick any name meaningful to you. For example, X-Object-Meta-Reviewed could be used indicate
that the contents of an object had been reviewed.
Any valid UTF-8 http header value is allowed for metadata, however we recommend that you URL-encode any non-ASCII values.

All existing  metadata, with the exception of [Content-Type](#content_type_request) is overwritten by the POST operation.
This means you must specify _all_ of the  metadata in the request. For example, if an object already has a Content-Encoding of gzip and 
you plan to also set X-Object-Meta-One, both must be specified in a single request. 
If you only set X-Container-Meta-One, when you later do a HEAD operation, only X-Container-Meta-One would exist -- in effect Content-Encoding is
lost. 

However, [Content-Type](#content_type_request) is unchanged (unless included in the request). You cannot use the
[Content-Length](#content_length_request) request header since the object content is not changed by this operation.

A POST operation with no metadata changes will cause *all* the metadata with the exception of [Content-Type](#content_type_request), [Content-Length](#content_length_request),
[ETag](#etag_response) and [Last-Modified](#last_modified_response) to be cleared.

An easier way to change object metadata is to use the [Copy Object](#object_copy) operation since it only changes metadata that you update 
in the request.

**Request Data**

The path specifies the account, container name and object name.

The following request headers apply to this operation.

* [X-Auth-Token](#x_auth_token_request) - Optional - Authentication token
* [Authorization](#signature_auth) - Optional - Use Signature Based Authentication instead of [X-Auth-Token](#x_auth_token_request)
* [Content-Type](#content_type_request) - Optional - The MIME type of the object
* [Content-Encoding](#content_encoding_header) - Optional - Indicate that the contents are compressed
* [Content-Disposition](#content_disposition_header) - Optional - Override default download behaviour of browsers
* [X-Container-Meta-{name}](#x_container_meta_request) - Optional - Sets custom metadata on the container

**URL Parameters**

Without query parameters, the operation operates as described in this section. With _signature_ and related options, the operation
behaves as described in [FormPost](#formpost)

**Data Parameters**

None.

**Success Response**

No response body is returned.

**Status Code**

See [HTTP Status Codes](#http_codes) for more information.

**Response Data**

No response body is returned.
      
**Error Response**

If an error occurs, the response body contains a description of the error.

**Status Response**

See [HTTP Status Codes](#http_codes) for more information.

**Curl Example**

	curl -i -H 'X-Auth-Token: HPAuth_1234' https://region-a.geo-1.objects.hpcloudsvc.com/v1/12345678912345/test_container_1/dir1 -X POST -H 'x-object-meta-reviewed: Yes'
	HTTP/1.1 202 Accepted


**Additional Notes**                     






                

