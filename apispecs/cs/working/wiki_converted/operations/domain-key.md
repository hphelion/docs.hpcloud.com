---  
title : Domain Key Operations

---  

  ------------ ------------------------------------------------------------------------------------------ -------------------------------------- ---
  **GET** \    *[csbu:HPKeystoneExtensionBaseURI]/domains/keys?domainId={domainId}&status={status}*       Get a list of domain keys               
  **POST** \   *[csbu:HPKeystoneExtensionBaseURI]domains/keys/rotate?domainId={domainId}&keyId={keyId}*   Rotate (create a new encryption key)    
  **POST**     *[csbu:HPKeystoneExtensionBaseURI]/domains/keys/{keyId}/revoke*                            Revoke an existing encryption key       
  **DELETE**   *[csbu:HPKeystoneExtensionBaseURI]/domains/keys/{keyId}*                                   Delete an existing encryption key       
  ------------ ------------------------------------------------------------------------------------------ -------------------------------------- ---

### **Get Domain Keys **

Verb

URI

Description

GET 

[csbu:HPKeystoneExtensionBaseURI]/domains/keys

Get domain keys

#### **Detailed Description**

*Allows reading a list of* *keys for the public or specified domain.
This API supports pagination through 'limit' and 'marker' usage. The
returned list may be filtered to allow only those* *tenant keys which
the caller has access to. The operation does not require a request
body.*

#### **Response Codes**

HTTP Status Code

Description

Comments (this column will be removed after implementation)

200

OK


203

Partial


401

Unauthorized


403

Forbidden


413

Over limit


400

Bad request


500

Identity fault


503

Service unavailable


#### **Header Values**

*No additional header values present.*

#### **Query String Values**

*Parameter*

*Required*

*Description*

*limit*

*false*

* *

*marker*

*false*

* *

*status*

*false*

* Key status. One of {invalid, active, inactive, expired, revoked,
deleted, purged}*

*domainId*

*false*

* Domain identifier. Defaults to public if not specified.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes in WADL

XML

Yes

JSON

Yes

gzip

 No

#### **Example(s)**

##### XML Request

~~~
GET /v1.0/domains HTTP/1.1
Host: localhost:9999
user-agent: Python-httplib2/$Rev$
content-type: application/xml
accept-encoding: gzip, deflate
accept: application/xml
x-auth-token: 12f72670-0aad-40ab-b971-9bc54e47a5f1
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Content-Type: application/xml; charset=UTF-8
Content-Length: 216
Date: Mon, 11 Jul 2011 17:16:30 GMT
~~~

##### JSON Request

~~~
GET /v1.0/domains HTTP/1.1
Host: localhost:9999
Content-Length: 2
user-agent: Python-httplib2/$Rev$
content-type: application/json
accept-encoding: gzip, deflate
x-auth-token: 12f72670-0aad-40ab-b971-9bc54e47a5f1
~~~

##### JSON Response

~~~
HTTP/1.1 200 OK
Content-Type: application/json; charset=UTF-8
Content-Length: 356
Date: Mon, 11 Jul 2011 17:16:25 GMT
~~~

### **Rotate Key **

Verb

URI

Description

POST 

[csbu:HPKeystoneExtensionBaseURI]/domains/keys/rotate}

Rotate key

#### **Detailed Description**

*Rotate a* *key for the specified domain or public if not specified. The
operation takes an optional request body containing a key specification
for the replacement key.*

#### **Response Codes**

HTTP Status Code

Description

Comments (this column will be removed after implementation)

200

OK


203

Partial


401

Unauthorized


403

Forbidden


413

Over limit


400

Bad request


500

Identity fault


503

Service unavailable


#### **Header Values**

*No additional header values present.*

#### **Query String Values**

*Parameter*

*Required*

*Description*

*algorithm*

*false*

* The algorithm of the new key supported by the hardware security
module. Defaults to AES*

*keyId*

*false*

* Key identifier.*

*keyLength*

*false*

* The size of the cryptographic key. Defaults to 128 bits.*

*domainId*

*false*

* Domain identifier. Defaults to public if not specified.*

*prefix*

*false*

* A prefix for a new name of the encryption key. Defaults to PUBLIC*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes in WADL

XML

Yes

JSON

Yes

gzip

 No

#### **Example(s)**

##### XML Request

~~~
GET /v1.0/domains HTTP/1.1
Host: localhost:9999
user-agent: Python-httplib2/$Rev$
content-type: application/xml
accept-encoding: gzip, deflate
accept: application/xml
x-auth-token: 12f72670-0aad-40ab-b971-9bc54e47a5f1
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Content-Type: application/xml; charset=UTF-8
Content-Length: 216
Date: Mon, 11 Jul 2011 17:16:30 GMT
~~~

##### JSON Request

~~~
GET /v1.0/domains HTTP/1.1
Host: localhost:9999
Content-Length: 2
user-agent: Python-httplib2/$Rev$
content-type: application/json
accept-encoding: gzip, deflate
x-auth-token: 12f72670-0aad-40ab-b971-9bc54e47a5f1
~~~

##### JSON Response

~~~
HTTP/1.1 200 OK
Content-Type: application/json; charset=UTF-8
Content-Length: 356
Date: Mon, 11 Jul 2011 17:16:25 GMT
~~~

### **Revoke Key **

Verb

URI

Description

POST 

[csbu:HPKeystoneExtensionBaseURI]/domains/keys/{keyId}/revoke

Revoke key

#### **Detailed Description**

*Revoke an* *existing key for the specified domain or public if not
specified. The operation takes an optional request body containing a key
specification if the existing key is being replaced.*

#### **Response Codes**

HTTP Status Code

Description

Comments (this column will be removed after implementation)

200

OK


203

Partial


401

Unauthorized


403

Forbidden


413

Over limit


400

Bad request


500

Identity fault


503

Service unavailable


#### **Header Values**

*No additional header values present.*

#### **Query String Values**

*Parameter*

*Required*

*Description*

*algorithm*

*false*

* The algorithm of the new key supported by the hardware security
module. Defaults to AES*

*keyLength*

*false*

* The size of the cryptographic key. Defaults to 128 bits.*

*domainId*

*false*

* Domain identifier. Defaults to public if not specified.*

*prefix*

*false*

* A prefix for a new name of the encryption key. Defaults to PUBLIC*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes in WADL

XML

Yes

JSON

Yes

gzip

 No

#### **Example(s)**

##### XML Request

~~~
GET /v1.0/domains HTTP/1.1
Host: localhost:9999
user-agent: Python-httplib2/$Rev$
content-type: application/xml
accept-encoding: gzip, deflate
accept: application/xml
x-auth-token: 12f72670-0aad-40ab-b971-9bc54e47a5f1
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Content-Type: application/xml; charset=UTF-8
Content-Length: 216
Date: Mon, 11 Jul 2011 17:16:30 GMT
~~~

##### JSON Request

~~~
GET /v1.0/domains HTTP/1.1
Host: localhost:9999
Content-Length: 2
user-agent: Python-httplib2/$Rev$
content-type: application/json
accept-encoding: gzip, deflate
x-auth-token: 12f72670-0aad-40ab-b971-9bc54e47a5f1
~~~

##### JSON Response

~~~
HTTP/1.1 200 OK
Content-Type: application/json; charset=UTF-8
Content-Length: 356
Date: Mon, 11 Jul 2011 17:16:25 GMT
~~~

### **Delete Key **

Verb

URI

Description

DELETE 

[csbu:HPKeystoneExtensionBaseURI]/domains/keys/{keyId}

Delete key

#### **Detailed Description**

*Delete a domain* *key for the public or specified domain. The operation
takes an optional request body with the key specification for the
replacement key.*

#### **Response Codes**

HTTP Status Code

Description

Comments (this column will be removed after implementation)

200

OK


203

Partial


401

Unauthorized


403

Forbidden


413

Over limit


400

Bad request


500

Identity fault


503

Service unavailable


#### **Header Values**

*No additional header values present.*

#### **Query String Values**

*Parameter*

*Required*

*Description*

*algorithm*

*false*

* The algorithm of the new key supported by the hardware security
module. Defaults to AES*

*keyLength*

*false*

* The size of the cryptographic key. Defaults to 128 bits.*

*domainId*

*false*

* Domain identifier. Defaults to public if not specified.*

*prefix*

*false*

* A prefix for a new name of the encryption key. Defaults to PUBLIC*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes in WADL

XML

Yes

JSON

Yes

gzip

 No

#### **Example(s)**

##### XML Request

~~~
GET /v1.0/domains HTTP/1.1
Host: localhost:9999
user-agent: Python-httplib2/$Rev$
content-type: application/xml
accept-encoding: gzip, deflate
accept: application/xml
x-auth-token: 12f72670-0aad-40ab-b971-9bc54e47a5f1
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Content-Type: application/xml; charset=UTF-8
Content-Length: 216
Date: Mon, 11 Jul 2011 17:16:30 GMT
~~~

##### JSON Request

~~~
GET /v1.0/domains HTTP/1.1
Host: localhost:9999
Content-Length: 2
user-agent: Python-httplib2/$Rev$
content-type: application/json
accept-encoding: gzip, deflate
x-auth-token: 12f72670-0aad-40ab-b971-9bc54e47a5f1
~~~

##### JSON Response

~~~
HTTP/1.1 200 OK
Content-Type: application/json; charset=UTF-8
Content-Length: 356
Date: Mon, 11 Jul 2011 17:16:25 GMT
~~~

