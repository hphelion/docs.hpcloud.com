---
title: User Key Account Operations

---

  ------------ --------------------------------------------------------------------------- ----------------------------------------- ---------
  **GET** \    *[csbu:HPKeystoneExtensionBaseURI]/users/keyaccounts*                       Get a list of user key accounts           Private
                                                                                                                                     

  **POST** \   *[csbu:HPKeystoneExtensionBaseURI]/users/keyaccounts*                       Create a new user key account             Private
                                                                                                                                     

  **PUT** \    *[csbu:HPKeystoneExtensionBaseURI]/users/keyaccounts*                       Update an existing user key account       Private
                                                                                                                                     

  **PUT** \    *[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/keyaccounts/suspend*      Suspend an existing user key account      Private
                                                                                                                                     

  **PUT** \    *[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/keyaccounts/reactivate*   Reactivate a suspended user key account   Private
                                                                                                                                     

  **DELETE**   *[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/keyaccounts*              Delete an existing key account            Private

  **DELETE**   *[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/keyaccounts/purge*        Purge an existing key account             Private
  ------------ --------------------------------------------------------------------------- ----------------------------------------- ---------

### **Get User Key Accounts **

Verb

URI

Description

GET 

[csbu:HPKeystoneExtensionBaseURI]/users/keyaccounts

Get user key accounts

#### **Detailed Description**

*Allows reading a list of* *key accounts for the specified user and/or
domain. This API supports pagination through 'limit' and 'marker' usage.
The returned list may be filtered to allow only those* *domain key
accounts which the caller has access to. The operation does not require
a request body.*

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

*domainId*

*true (if userId not specified)*

* Domain identifier*

*limit*

*false*

* *

*marker*

*false*

* *

*status*

*false*

* Key account status. One of {active, inactive, suspended, revoked,
deleted, purged}*

*userId*

*true (if domainId not specified)*

* User identifier*

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

#### **Web Application Description Language (WADL) Definition of API**

*\<not yet available\>*

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

### **Create User Key Account **

Verb

URI

Description

POST 

[csbu:HPKeystoneExtensionBaseURI]/users/keyaccounts

Create user key account

#### **Detailed Description**

*Creates a new* *key account for the specified user and domain. The
operation takes an optional request body containing metadata for the new
key account.*

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

*activeKeysLimit*

*false*

* The maximum number of active keys per type per user account. This
limit applies to access keys, key pairs, and certificates
independently.*

*deletedKeysLimit*

*false*

* The maximum number of deleted keys per type per user account. This
limit applies to access keys, key pairs, and certificates
independently.*

*domainId*

*true*

* Domain Identfier*

*status*

*false*

* Key account status. One of {active, inactive}. Defaults to active*

*totalKeysLimit*

*false*

* The maximum number of keys per type per user account. This limit
applies to access keys, key pairs, and certificates independently.*

*userId*

*true*

* User identifier*

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

#### **Web Application Description Language (WADL) Definition of API**

*\<not yet available\>*

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

### **Update an existing User Key Account **

Verb

URI

Description

PUT 

[csbu:HPKeystoneExtensionBaseURI]/users/keyaccount

Update user key account

#### **Detailed Description**

*Updates an existing* *key account for specified user and domain. The
operation takes a request body containing key account metadata to be
updated.*

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

*activeKeysLimit*

*false*

* The maximum number of active keys per type per user account. This
limit applies to access keys, key pairs, and certificates
independently.*

*deletedKeysLimit*

*false*

* The maximum number of deleted keys per type per user account. This
limit applies to access keys, key pairs, and certificates
independently.*

*domainId*

*true*

* Domain Identfier*

*totalKeysLimit*

*false*

* The maximum number of keys per type per user account. This limit
applies to access keys, key pairs, and certificates independently.*

*userId*

*true*

* User identifier*

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

#### **Web Application Description Language (WADL) Definition of API**

*\<not yet available\>*

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

### **Suspend User Key Account **

Verb

URI

Description

PUT 

[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/keyaccount/suspend

Suspend user key account

#### **Detailed Description**

*Suspends a user* *key account. The operation does not require a request
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

#### **Web Application Description Language (WADL) Definition of API**

*\<not yet available\>*

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

### **Reactivate Key Account **

Verb

URI

Description

PUT 

[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/keyaccount/reactivate

Reactivate user key account

#### **Detailed Description**

*Reactivate a previously suspended* user *key account for the specified
domain. The operation does not require a request body.*

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

#### **Web Application Description Language (WADL) Definition of API**

*\<not yet available\>*

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

### **Delete User Key Account **

Verb

URI

Description

DELETE 

[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/keyaccount/delete

Delete user key account

#### **Detailed Description**

*Deletes and existing* *key account for the specified user. The
operation does not require a request body.*

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

#### **Web Application Description Language (WADL) Definition of API**

*\<not yet available\>*

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

### **Purge User Key Account **

Verb

URI

Description

DELETE 

[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/keyaccounts/purge

Purge user key account

#### **Detailed Description**

*Permanently deletes the user* *key account for specified user and all
user keys, keypairs, and certificates owned by this user. The operation
does not require a request body.*

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

#### **Web Application Description Language (WADL) Definition of API**

*\<not yet available\>*

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
