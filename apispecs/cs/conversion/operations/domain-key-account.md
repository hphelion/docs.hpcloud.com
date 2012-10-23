---  
title : Domain Key Account Operations

---  

  ------------ ------------------------------------------------------------------------------- ------------------------------------------- ---------
  **GET** \    *[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccounts*              Get a list of domain key accounts           Private
  **POST** \   *[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccounts*              Create a new domain key account             Private
  **PUT** \    *[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccounts*              Update an existing domain key account       Private
  **PUT** \    *[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccounts/suspend*      Suspend an existing domain key account      Private
  **PUT** \    *[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccounts/reactivate*   Reactivate a suspended domain key account   Private
  **DELETE**   *[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccount*s              Delete an existing key account              Private
  **DELETE**   *[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccounts/purge*        Purge an existing key account               Private
  ------------ ------------------------------------------------------------------------------- ------------------------------------------- ---------

### **Get Domain Key Accounts **

Verb

URI

Description

GET 

[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccounts

Get domain key accounts

#### **Detailed Description**

*Allows reading a list of* *key accounts for the specified domain. This
API supports pagination through 'limit' and 'marker' usage. The returned
list may be filtered to allow only those* *domain key accounts which the
caller has access to. The operation does not require a request body.*

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

* Key account status. One of {active, inactive, suspended, revoked,
deleted, purged}*

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

### **Create Domain Key Account **

Verb

URI

Description

POST 

[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccounts

Create domain key account

#### **Detailed Description**

*Creates a new* *key account for the specified domain. The operation
takes an optional request body containing metadata for the new key
account.*

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

*The maximum number of master encryption keys with an active status. *

*activeUserKeysLimit*

*false*

*The maximum number of active keys per type per user account. This limit
applies to access keys, key pairs, and certificates independently.*

*deletedAccountsLimit*

*false*

*The maximum number of user key accounts in the deleted state. Not
enforced yet. Deprecate.*

*deletedUserKeysLimit*

*false*

*The maximum number of deleted keys per type per user account. This
limit applies to access keys, key pairs, and certificates
independently.** *

*ownsMasterKey*

*false*

*When set to true it indicates that a domain owns its master encryption
key. If set to false tenant domain refers to a system domain key
account. Defaults to false. *

*status*

*false*

*The status of the domain key account to be created. One of {active,
inactive}. Defaults to active. *

*totalUserKeysLimit*

*false*

*The maximum number of keys per type per user key account. This limit
applies to access keys, key pairs, and certificates independently.*

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

### **Update an existing Domain Key Account **

Verb

URI

Description

PUT 

[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccount

Update domain key account

#### **Detailed Description**

*Updates an existing* *key account for specified domain. The operation
takes a request body containing key account metadata to be updated.*

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

*The maximum number of master encryption keys with an active status. *

*activeUserKeysLimit*

*false*

*The maximum number of active keys per type per user account. This limit
applies to access keys, key pairs, and certificates independently.*

*deletedAccountsLimit*

*false*

*The maximum number of user key accounts in the deleted state. Not
enforced yet. Deprecate.*

*deletedUserKeysLimit*

*false*

*The maximum number of deleted keys per type per user account. This
limit applies to access keys, key pairs, and certificates
independently.** *

*ownsMasterKey*

*false*

*When set to true it indicates that a domain owns its master encryption
key. If set to false tenant domain refers to a system domain key
account. Defaults to false. *

*totalUserKeysLimit*

*false*

*The maximum number of keys per type per user key account. This limit
applies to access keys, key pairs, and certificates independently.*

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

### **Suspend domain key account **

Verb

URI

Description

PUT 

[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccount/suspend

Suspend domain key account

#### **Detailed Description**

*Suspends a domain* *key account. The operation does not require a
request body.*

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

### **Reactivate key account **

Verb

URI

Description

PUT 

[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccount/reactivate

Reactivate domain key account

#### **Detailed Description**

*Reactivate a previously suspended* *key account for the specified
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

### **Delete Domain Key Account **

Verb

URI

Description

DELETE 

[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccount/delete

Delete domain key account

#### **Detailed Description**

*Deletes and existing* *key account for the specified domain. The
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

### **Purge Domain Key Account **

Verb

URI

Description

DELETE 

[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/keyaccounts/purge

Purge domain key account

#### **Detailed Description**

*Permanently deletes the domain* *key account for specified domain and
all user key accounts owned by this domain. The operation does not
require a request body.*

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
