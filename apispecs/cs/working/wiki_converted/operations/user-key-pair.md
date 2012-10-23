---
title : User Key Pair Operations

---

### **Get User Key Pairs **

Verb

URI

Description

**GET** 

**[HPKeystoneExtensionBaseURI]/keypairs**

Get user key pairs

#### **Detailed Description**

*Allows reading a list of all* *key pairs for the specified user. This
API supports pagination through 'limit' and 'marker' usage.*

#### **Response Codes**

HTTP Status Code

Description

Comments

200

OK

The operation was successful

401

Unauthorized

The caller does not have the privilege required to perform the
operation.

403

Forbidden

 

413

Over limit

 

400

Bad request

The request for the operation is not well formed or missing the required
parameters.

500

Identity Fault

The server encountered a problem while processing the request.

503

Service unavailable

The server is unavailable to process the request.

#### **Header Values**

*No additional header values present.*

#### **Query String Values**

*Parameter*

*Required*

*Description*

*domainId*

*false*

* Domain identifier.*

*export*

*false*

* Export key pair. One of {true,false}. Default is false.*

*keypairId*

*false*

* Key pair identifier.*

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

*userId*

*false*

* User identifier to select key pairs for a specific user. Defaults to
authenticated user if not specified.*

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

#### **Request and Response schema,  XML Schema Definition **

*No request body is required. The response body contains a keyPairs
object.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)

[keyPair.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyPair.xsd)

#### **Example(s)**

##### XML Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e815f48e4b0459717485fba
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=722C26794D3645C09A23DD2902FF61C9; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 797
Date: Tue, 27 Sep 2011 05:53:19 GMT

<keyPairs xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <keyPair keyPairId="3K3A3FJSC9YRX5LVJCES" userId="00000000003002" domainId="00000000001001" status="active" validFrom="2011-09-26T22:03:37.000-07:00" validTo="2021-09-23T22:03:37.000-07:00">
      <publicKeyAlgorithm>RSA</publicKeyAlgorithm>
      <publicKeyLength>1024</publicKeyLength>
   </keyPair>
   <keyPair keyPairId="R9AR1E3DTZAPP1GMRT2V" userId="00000000003002" domainId="00000000001001" status="active" validFrom="2011-09-26T22:06:33.000-07:00" validTo="2021-09-23T22:06:33.000-07:00">
      <publicKeyAlgorithm>DSA</publicKeyAlgorithm>
      <publicKeyLength>1024</publicKeyLength>
   </keyPair>
</keyPairs>
~~~

##### JSON Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e9caa84e4b0ea896133e05e
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### JSON Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 5172
Date: Mon, 17 Oct 2011 22:22:49 GMT

{
  "keyPairs" : {
    "anies" : null,
    "keyPair" : [ {
      "publicKeyAlgorithm" : "DSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638472194,
      "domainId" : "00000000001001",
      "keyPairId" : "XPYXH98W782MYNPWRKR5",
      "otherAttributes" : {
      },
      "status" : "deleted",
      "userId" : "00000000003002",
      "validFrom" : 1318638472000,
      "validTo" : 1633998472000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638836077,
      "domainId" : "00000000001001",
      "keyPairId" : "74HVY65RF5WTPS3KWUNB",
      "otherAttributes" : {
      },
      "status" : "deleted",
      "userId" : "00000000003002",
      "validFrom" : 1318638836000,
      "validTo" : 1633998836000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638458948,
      "domainId" : "00000000001001",
      "keyPairId" : "DFMVNXR7DY2E2N5XGJZ3",
      "otherAttributes" : {
      },
      "status" : "deleted",
      "userId" : "00000000003002",
      "validFrom" : 1318638458000,
      "validTo" : 1633998458000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638806673,
      "domainId" : "00000000001001",
      "keyPairId" : "7VS9SZCGNF1EEM62GJPF",
      "otherAttributes" : {
      },
      "status" : "deleted",
      "userId" : "00000000003002",
      "validFrom" : 1318638806000,
      "validTo" : 1633998806000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638821162,
      "domainId" : "00000000001001",
      "keyPairId" : "KZAZ6T5ETSBBD1Z3JWCY",
      "otherAttributes" : {
      },
      "status" : "deleted",
      "userId" : "00000000003002",
      "validFrom" : 1318638821000,
      "validTo" : 1633998821000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638851494,
      "domainId" : "00000000001001",
      "keyPairId" : "LMK91XLGN7VLWC59UKPD",
      "otherAttributes" : {
      },
      "status" : "deleted",
      "userId" : "00000000003002",
      "validFrom" : 1318638851000,
      "validTo" : 1633998851000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638748395,
      "domainId" : "00000000001001",
      "keyPairId" : "ALCJDAL4LR93B63YB6D8",
      "otherAttributes" : {
      },
      "status" : "deleted",
      "userId" : "00000000003002",
      "validFrom" : 1318638748000,
      "validTo" : 1633998748000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638486502,
      "domainId" : "00000000001001",
      "keyPairId" : "AF6ZHPL3ZLCVMC3HT3KX",
      "otherAttributes" : {
      },
      "status" : "deleted",
      "userId" : "00000000003002",
      "validFrom" : 1318638486000,
      "validTo" : 1633998486000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638708446,
      "domainId" : "00000000001001",
      "keyPairId" : "CM328S1UQGKBA1NBA2F8M8E25PH7AN04",
      "otherAttributes" : {
      },
      "status" : "deleted",
      "userId" : "00000000003002",
      "validFrom" : 1318638708000,
      "validTo" : 1350174708000
    }, {
      "publicKeyAlgorithm" : "DSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638708454,
      "domainId" : "00000000001001",
      "keyPairId" : "44LB7S0CNMSM9EA3VAHBU22R2O3H09PT",
      "otherAttributes" : {
      },
      "status" : "deleted",
      "userId" : "00000000003002",
      "validFrom" : 1318638708000,
      "validTo" : 1350174708000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318638866340,
      "domainId" : "00000000001001",
      "keyPairId" : "NY2JZ58MAWKGF6ZL4ETY",
      "otherAttributes" : {
      },
      "status" : "inactive",
      "userId" : "00000000003002",
      "validFrom" : 1318638866000,
      "validTo" : 1633998866000
    }, {
      "publicKeyAlgorithm" : "DSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : null,
      "privateKeyFile" : null,
      "createdOn" : 1318870262630,
      "domainId" : "00000000001001",
      "keyPairId" : "ZZPADZV9LPZCLZJ1GDEK",
      "otherAttributes" : {
      },
      "status" : "active",
      "userId" : "00000000003002",
      "validFrom" : 1318870262000,
      "validTo" : 1634230262000
    } ],
    "otherAttributes" : {
    }
  }
}
~~~

### **Import User Key Pair(s) **

Verb

URI

Description

**PUT** 

**[HPKeystoneExtensionBaseURI]/keypairs**

Import user key pair(s)

#### **Detailed Description**

*Import user key pair(s). The operation requires a request body
containing the key pair(s).*

#### **Response Codes**

HTTP Status Code

Description

Comments

200

OK

The operation was successful.

400

Bad request

The request for the operation is not well formed or missing the required
parameters.

401

Unauthorized

The caller does not have the privilege required to perform the
operation.

403

Forbidden

 

500

Identity fault

The server encountered a problem while processing the request.

503

Service unavailable

The server is unavailable to process the request.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*No additional query string values.*

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

#### **Request and Response schema,  XML Schema Definition **

*The request body contains a keyPairs object with the key pairs to be
imported. The userId attribute and publicKeyFile, publicKeyAlgorithm
elements are required in each keyPair object specified in the request
body.  All other attributes and elements of each keyPair object are
optional. The response body contains a keyPairs object with the
resulting key pairs.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[keyPair.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyPair.xsd)

#### **Example(s)**

##### XML Request

~~~
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e823bdce4b0bf3036ce86c9
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 1968

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<keyPairs xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
<keyPair keyPairId="MTUL5V3139RYT99F1001" userId="00000000003002" domainId="00000000001001" status="inactive" validFrom="2011-09-27T09:09:15.000-07:00" validTo="2021-09-24T09:09:15.000-07:00">
<publicKeyAlgorithm>DSA</publicKeyAlgorithm>
<publicKeyLength>1024</publicKeyLength>
<publicKeyFile><format>BASE64_DER</format>
<data>-----BEGIN PUBLIC KEY-----
MIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9E
AMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f
6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv
8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtc
NrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwky
jMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/h
WuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAfLUsxMrUOcOSHUy3JcrniVknVQSh
ONIldkdIOZqQqNIRT2XfqIYR8JwPW+cBYHC8cjCl4OQes/wt02Q4uIrk7yLVAweQ
HqLl6Ia1s+cbSNr+86Z6cSRbEo8b+92t2s0S5OizdY5zKshUgCEJYmv578MqQ0H2
MG8BkyMjXk6iR7g=
-----END PUBLIC KEY-----</data>
</publicKeyFile>
</keyPair>
<keyPair keyPairId="58H6P29VJMA6RDSM1002" userId="00000000003002" domainId="00000000001001" status="inactive" validFrom="2011-09-27T11:00:08.000-07:00" validTo="2021-09-24T11:00:08.000-07:00" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <publicKeyAlgorithm>RSA</publicKeyAlgorithm>
   <publicKeyLength>1024</publicKeyLength>
   <publicKeyFile>
      <format>BASE64_DER</format>
      <data>-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCrd/fkVlLavFyaPIa+O1xX8zwV
cR6e0cLUyQMC0bWmgnYKzetP5AGDPbRz+4p4PVakDipL9s9CALeWFogamWT3dPIC
GVxPilqqGZCU9VyId6XmPVFJsmaccB0Q9yzH4dMwmhV3DUseP6oSLL5pTI7zqU3b
gjlzWp9ke59+CMHw2QIDAQAB
-----END PUBLIC KEY-----</data>
   </publicKeyFile>
</keyPair>
</keyPairs>
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=46752770BB3B0070A228B023738391B9; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 1867
Date: Tue, 27 Sep 2011 21:11:35 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<keyPairs xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <keyPair keyPairId="MTUL5V3139RYT99F1001" userId="00000000003002" domainId="00000000001001" status="inactive" validFrom="2011-09-27T09:09:15.000-07:00" validTo="2021-09-24T09:09:15.000-07:00">
      <publicKeyAlgorithm>DSA</publicKeyAlgorithm>
      <publicKeyLength>1024</publicKeyLength>
      <publicKeyFile>
         <format>BASE64_DER</format>
         <data>-----BEGIN PUBLIC KEY-----
MIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9E
AMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f
6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv
8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtc
NrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwky
jMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/h
WuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAfLUsxMrUOcOSHUy3JcrniVknVQSh
ONIldkdIOZqQqNIRT2XfqIYR8JwPW+cBYHC8cjCl4OQes/wt02Q4uIrk7yLVAweQ
HqLl6Ia1s+cbSNr+86Z6cSRbEo8b+92t2s0S5OizdY5zKshUgCEJYmv578MqQ0H2
MG8BkyMjXk6iR7g=
-----END PUBLIC KEY-----</data>
      </publicKeyFile>
   </keyPair>
   <keyPair keyPairId="58H6P29VJMA6RDSM1002" userId="00000000003002" domainId="00000000001001" status="inactive" validFrom="2011-09-27T11:00:08.000-07:00" validTo="2021-09-24T11:00:08.000-07:00">
      <publicKeyAlgorithm>RSA</publicKeyAlgorithm>
      <publicKeyLength>1024</publicKeyLength>
      <publicKeyFile>
         <format>BASE64_DER</format>
         <data>-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCrd/fkVlLavFyaPIa+O1xX8zwV
cR6e0cLUyQMC0bWmgnYKzetP5AGDPbRz+4p4PVakDipL9s9CALeWFogamWT3dPIC
GVxPilqqGZCU9VyId6XmPVFJsmaccB0Q9yzH4dMwmhV3DUseP6oSLL5pTI7zqU3b
gjlzWp9ke59+CMHw2QIDAQAB
-----END PUBLIC KEY-----</data>
      </publicKeyFile>
   </keyPair>
</keyPairs>
~~~

##### JSON Request

~~~
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e9cb252e4b0ea896133e06c
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 2043

{
  "keyPairs" : {
    "anies" : null,
    "keyPair" : [ {
      "publicKeyAlgorithm" : "DSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : {
        "format" : "BASE64_DER",
        "data" : "-----BEGIN PUBLIC KEY-----\nMIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9E\nAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f\n6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv\n8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtc\nNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwky\njMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/h\nWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAPESoRxpdmkx3TtVgRqgRTRqkdFF\n4tz412CZ6/AtjjKAtfC24x0m2unrMTE6MymmJL977ENtrjoley9CEo9SN60wAxcE\nWWPKdfgNvZBTYabxde8X2O2fe+4WzkKT6eLzY+Bio1r/+ReUOZMrik7kU6gbj9Xg\nkNJhBhnTAeo2btLA\n-----END PUBLIC KEY-----",
        "anies" : null
      },
      "privateKeyFile" : null,
      "createdOn" : 1318638472194,
      "domainId" : "00000000001001",
      "keyPairId" : "XPYXH98W782MYNPWR998",
      "otherAttributes" : {
      },
      "status" : "inactive",
      "userId" : "00000000003002",
      "validFrom" : 1318638472000,
      "validTo" : 1633998472000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : {
        "format" : "BASE64_DER",
        "data" : "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAb6t2vuziv02d/C2arwfG4hS4\nTxhxTrz4skaAKCJ9Lhh1UDNzMrQR/Hrz37OnlPeQxuqWNMWWfaBNUNNrniXKcmax\nNQ51T9+i/xkKopldXye2rRloPJqAtqCyMNNkSGmrKOuCDZ4k5xBgHxWzZ2gmtysk\nM355ih/Ga2bwYrZcbQIDAQAB\n-----END PUBLIC KEY-----",
        "anies" : null
      },
      "privateKeyFile" : null,
      "createdOn" : 1318638836077,
      "domainId" : "00000000001001",
      "keyPairId" : "74HVY65RF5WTPS3KW999",
      "otherAttributes" : {
      },
      "status" : "inactive",
      "userId" : "00000000003002",
      "validFrom" : 1318638836000,
      "validTo" : 1633998836000
    }],
    "otherAttributes" : {
    }
  }
}
~~~

##### JSON Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2044
Date: Mon, 17 Oct 2011 22:55:36 GMT

{
  "keyPairs" : {
    "anies" : null,
    "keyPair" : [ {
      "publicKeyAlgorithm" : "DSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : {
        "format" : "BASE64_DER",
        "data" : "-----BEGIN PUBLIC KEY-----\nMIIBuDCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9E\nAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f\n6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv\n8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtc\nNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwky\njMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/h\nWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYUAAoGBAPESoRxpdmkx3TtVgRqgRTRqkdFF\n4tz412CZ6/AtjjKAtfC24x0m2unrMTE6MymmJL977ENtrjoley9CEo9SN60wAxcE\nWWPKdfgNvZBTYabxde8X2O2fe+4WzkKT6eLzY+Bio1r/+ReUOZMrik7kU6gbj9Xg\nkNJhBhnTAeo2btLA\n-----END PUBLIC KEY-----",
        "anies" : null
      },
      "privateKeyFile" : null,
      "createdOn" : 1318892134912,
      "domainId" : "00000000001001",
      "keyPairId" : "XPYXH98W782MYNPWR998",
      "otherAttributes" : {
      },
      "status" : "inactive",
      "userId" : "00000000003002",
      "validFrom" : 1318638472000,
      "validTo" : 1633998472000
    }, {
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "publicKeyFile" : {
        "format" : "BASE64_DER",
        "data" : "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAb6t2vuziv02d/C2arwfG4hS4\nTxhxTrz4skaAKCJ9Lhh1UDNzMrQR/Hrz37OnlPeQxuqWNMWWfaBNUNNrniXKcmax\nNQ51T9+i/xkKopldXye2rRloPJqAtqCyMNNkSGmrKOuCDZ4k5xBgHxWzZ2gmtysk\nM355ih/Ga2bwYrZcbQIDAQAB\n-----END PUBLIC KEY-----",
        "anies" : null
      },
      "privateKeyFile" : null,
      "createdOn" : 1318892134920,
      "domainId" : "00000000001001",
      "keyPairId" : "74HVY65RF5WTPS3KW999",
      "otherAttributes" : {
      },
      "status" : "inactive",
      "userId" : "00000000003002",
      "validFrom" : 1318638836000,
      "validTo" : 1633998836000
    } ],
    "otherAttributes" : {
    }
  }
}
~~~

### **Get User Key Pair **

Verb

URI

Description

**GET** 

**[HPKeystoneExtensionBaseURI]/keypairs/{keypairId}**

Get user key pair

#### **Detailed Description**

*Get a specified user key pair.*

#### **Response Codes**

HTTP Status Code

Description

Comments

200

OK

The operation was successful.

400

Bad request

The request for the operation is not well formed or missing the required
parameters.

401

Unauthorized

The caller does not have the privilege required to perform the
operation.

403

Forbidden

 

404

Item not found

The requested item was not found.

500

Identity fault

The server encountered a problem while processing the request.

503

Service unavailable

The server is unavailable to process the request.

#### **Header Values**

*No additional header values present.*

#### **Query String Values**

*Parameter*

*Required*

*Description*

*export*

*false*

* Export key pair. One of {true,false}. Default is false.*

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

#### **Request and Response schema,  XML Schema Definition **

*No request body is required. The response body contains a keyPair
object.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[keyPair.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyPair.xsd)

#### **Example(s)**

##### XML Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/3K3A3FJSC9YRX5LVJCES?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e815f48e4b0459717485fba
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=DD727F06C56ED76708C62ADA5C0F0273; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 493
Date: Tue, 27 Sep 2011 05:56:44 GMT

<keyPair keyPairId="3K3A3FJSC9YRX5LVJCES" userId="00000000003002" domainId="00000000001001" status="active" validFrom="2011-09-26T22:03:37.000-07:00" validTo="2021-09-23T22:03:37.000-07:00" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <publicKeyAlgorithm>RSA</publicKeyAlgorithm>
   <publicKeyLength>1024</publicKeyLength>
</keyPair>
~~~

##### JSON Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/ZZPADZV9LPZCLZJ1GDEK?export=true HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e9caa84e4b0ea896133e05e
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### JSON Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 1146
Date: Mon, 17 Oct 2011 22:27:16 GMT

{"keyPair": {
   "publicKeyAlgorithm": "DSA",
   "publicKeyLength": 1024,
   "publicKeyFile":    {
      "format": "BASE64_DER",
      "data": "-----BEGIN PUBLIC KEY-----\nMIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9E\nAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f\n6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv\n8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtc\nNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwky\njMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/h\nWuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAZhoL6337/91YiivdlD729s2h2S2W\nqGUv8BZSX9JMT0HVYBmvAKdOC25BeeWyth+j7/9Q8GGDZJwJXjqhEt8PiSc+Msun\nR9Lwnm3QrrJH93BTtgV1EELdSB/kCKRSwqSc7aDVfPbl2TAGRMVYbAax87NpJfs5\nYwF0M3N+S/3ebsk=\n-----END PUBLIC KEY-----",
      "anies": null
   },
   "privateKeyFile": null,
   "createdOn": 1318870262630,
   "domainId": "00000000001001",
   "keyPairId": "ZZPADZV9LPZCLZJ1GDEK",
   "otherAttributes": {},
   "status": "active",
   "userId": "00000000003002",
   "validFrom": 1318870262000,
   "validTo": 1634230262000
}}
~~~

### **Create User Key Pair **

Verb

URI

Description

**POST** 

**[HPKeystoneExtensionBaseURI]/keypairs**

Create a user key pair

#### **Detailed Description**

*Create a user key pair. This operation requires a request body
containing at least the userId element to establish ownership of the key
pair. The other elements will be defaulted if not specified. See the
schema or the examples below for details.*

#### **Response Codes**

HTTP Status Code

Description

Comments

201

Created

The operation was successful. Item created

400

Bad request

The request for the operation is not well formed or missing the required
parameters.

401

Unauthorized

The caller does not have the privilege required to perform the
operation.

403

Forbidden

 

500

Identity fault

The server encountered a problem while processing the request.

503

Service unavailable

The server is unavailable to process the request.

#### **Header Values**

*No additional header values present.*

#### **Query String Values**

*No additional query string values.*

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

#### **Request and Response schema,  XML Schema Definition **

*The request body contains a keyPair object. The userId attribute of the
keyPair object is required. All other attributes and elements are
optional. The response body contains the created key pair including the
public key and private key.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[keyPair.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyPair.xsd)

#### **Example(s)**

##### XML Request

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e81f502e4b078454c0c31bf
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 286

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<keyPair userId="00000000003002" domainId="00000000001001" status="active" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
<publicKeyAlgorithm>DSA</publicKeyAlgorithm>
<publicKeyLength>1024</publicKeyLength>
</keyPair>
~~~

##### XML Response

~~~
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=E4698FCC45832765B206DC2CC4D094AC; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 1800
Date: Tue, 27 Sep 2011 16:09:16 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<keyPair keyPairId="MTUL5V3139RYT99FN9WX" userId="00000000003002" domainId="00000000001001" status="active" validFrom="2011-09-27T09:09:15.000-07:00" validTo="2021-09-24T09:09:15.000-07:00" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <publicKeyAlgorithm>DSA</publicKeyAlgorithm>
   <publicKeyLength>1024</publicKeyLength>
   <publicKeyFile>
      <format>BASE64_DER</format>
      <data>-----BEGIN PUBLIC KEY-----
MIIBtzCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdSPO9E
AMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVClpJ+f
6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith1yrv
8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7LvKtc
NrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3zwky
jMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImog9/h
WuWfBpKLZl6Ae1UlZAFMO/7PSSoDgYQAAoGAfLUsxMrUOcOSHUy3JcrniVknVQSh
ONIldkdIOZqQqNIRT2XfqIYR8JwPW+cBYHC8cjCl4OQes/wt02Q4uIrk7yLVAweQ
HqLl6Ia1s+cbSNr+86Z6cSRbEo8b+92t2s0S5OizdY5zKshUgCEJYmv578MqQ0H2
MG8BkyMjXk6iR7g=
-----END PUBLIC KEY-----</data>
   </publicKeyFile>
   <privateKeyFile>
      <format>BASE64_PKCS8</format>
      <data>-----BEGIN PRIVATE KEY-----
MIIBSwIBADCCASwGByqGSM44BAEwggEfAoGBAP1/U4EddRIpUt9KnC7s5Of2EbdS
PO9EAMMeP4C2USZpRV1AIlH7WT2NWPq/xfW6MPbLm1Vs14E7gB00b/JmYLdrmVCl
pJ+f6AR7ECLCT7up1/63xhv4O1fnxqimFQ8E+4P208UewwI1VBNaFpEy9nXzrith
1yrv8iIDGZ3RSAHHAhUAl2BQjxUjC8yykrmCouuEC/BYHPUCgYEA9+GghdabPd7L
vKtcNrhXuXmUr7v6OuqC+VdMCz0HgmdRWVeOutRZT+ZxBxCBgLRJFnEj6EwoFhO3
zwkyjMim4TwWeotUfI0o4KOuHiuzpnWRbqN/C/ohNWLx+2J6ASQ7zKTxvqhRkImo
g9/hWuWfBpKLZl6Ae1UlZAFMO/7PSSoEFgIUW9I1Vgai6mksIAdl1BpBtMOzL8Y=
-----END PRIVATE KEY-----</data>
   </privateKeyFile>
</keyPair>
~~~

##### JSON Request

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e9caa84e4b0ea896133e05e
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 85

{"keyPair":{"userId":"00000000003002","domainId":"00000000001001","status":"active"}}
~~~

##### JSON Response

~~~
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 1764
Date: Mon, 17 Oct 2011 22:31:41 GMT

{
  "keyPair" : {
    "publicKeyAlgorithm" : "RSA",
    "publicKeyLength" : 1024,
    "publicKeyFile" : {
      "format" : "BASE64_DER",
      "data" : "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCGUsqlqZdV5A3aN6KaQc6z/knS\nNX4EMoKoaqmwa0rd/euqe5jpXA/PsFdSPAn7OW266DTqQOAaajHsJC4XejzPRBp+\nrJX450BELp8SQVnoi5CAcic2lufc9aCZdsU3jmh0dZRZ3Mwm+9eSiCp8ua4g82eO\n2tXVyYPJKwrEygkpKwIDAQAB\n-----END PUBLIC KEY-----",
      "anies" : null
    },
    "privateKeyFile" : {
      "format" : "BASE64_PKCS8",
      "data" : "-----BEGIN PRIVATE KEY-----\nMIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAIZSyqWpl1XkDdo3\noppBzrP+SdI1fgQygqhqqbBrSt3966p7mOlcD8+wV1I8Cfs5bbroNOpA4BpqMewk\nLhd6PM9EGn6slfjnQEQunxJBWeiLkIByJzaW59z1oJl2xTeOaHR1lFnczCb715KI\nKny5riDzZ47a1dXJg8krCsTKCSkrAgMBAAECgYARalCN1AQkBbJqFYaGe3vCSHjn\nwTm6b5YTIekoT3DggVh5vRahQudl5RYdOl2M7fA1KIAb0xd7NUONu08iih2yDasQ\nUs78lbHmSHkci2AaiMNQ8hprDgjDwo/NfF51kv1NNU8xKdDo7V2DaKfOceRFzZq0\nHgD2x6FbzN1+BhGOKQJBALsmLBAV2Y0yfkpGbDXM7Mza3maJo8SH0bCbCB8thsup\nVxmy9tiGrZZlC56VJEvxGcA9uxkDizj8zoXUbsU+xt0CQQC3vXWYF6fnGY3IKhmS\niThWQl73mXDxp10mALc1Tub6ZbAgH7zzCSpFaGFtgjYASnWfq5FksUb2HZuGDQDb\n+runAkBEWufjJCfmw5ePB3PEnsmq9RIgP4uaX8U+DRIFWTqPrpVKpKw2X9KNSPDa\nhjzQpAo0xhdNRpcWRHgmN3YSAyDdAkEAkIPJa/ifLNsict76AhE/aEkHnMLo3IiA\ncRV7A8itTyCP6JRN7vG0d6bjilgx1QS7gvxUfNgaMhWTb1nm5R5OXQJAJWhGkE7K\nGFYVG/o/f+W2ZHmDaY80Mw98poCEVqBrgUzMKHrDsjwC9goPJ18kCGOo+JeenDd9\ncvWsqi845kBBvQ==\n-----END PRIVATE KEY-----",
      "anies" : null
    },
    "createdOn" : 1318890700376,
    "domainId" : "00000000001001",
    "keyPairId" : "6616KAAUK6L9HJGUT6Z7",
    "otherAttributes" : {
    },
    "status" : "active",
    "userId" : "00000000003002",
    "validFrom" : 1318890700000,
    "validTo" : 1634250700000
  }
}
~~~

### **Update User Key Pair**

Verb

URI

Description

**PUT** 

**[HPKeystoneExtensionBaseURI]/keypairs/{keypairId}**

Update user key pair

#### **Detailed Description**

*Update a user key pair. This operation is used to udpate the key pair
status. See the schema or examples below for details.*

#### **Response Codes**

HTTP Status Code

Description

Comments

200

OK

The operation was successful.

400

Bad request

The request for the operation is not well formed or missing the required
parameters.

401

Unauthorized

The caller does not have the privilege required to perform the
operation.

403

Forbidden

 

404

Item not found

The item to be updated was not found.

500

Identity fault

The server encountered a problem while processing the request.

503

Service unavailable

The server is unavailable to process the request.

#### **Header Values**

*No additional header values present.*

**Query String Values**

*No additional query string values.*

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

#### **Request and Response schema,  XML Schema Definition **

*The request body contains a keyPair object. The status attribute is
required in the keyPair object. All other attributes and elements are
ignored. The response body contains the updated keyPair object. The
publicKeyFile element is not returned in the response.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[keyPair.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyPair.xsd)

#### **Example(s)**

##### XML Request

~~~
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/3K3A3FJSC9YRX5LVJCES HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e81f502e4b078454c0c31bf
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 143

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<keyPair status="inactive" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"/>
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=7150037BA8D7F3DF5ABB470E2EB8EC5D; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 837
Date: Tue, 27 Sep 2011 16:17:04 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<keyPair keyPairId="3K3A3FJSC9YRX5LVJCES" userId="00000000003002" domainId="00000000001001" status="inactive" validFrom="2011-09-26T22:03:37.000-07:00" validTo="2021-09-23T22:03:37.000-07:00" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <publicKeyAlgorithm>RSA</publicKeyAlgorithm>
   <publicKeyLength>1024</publicKeyLength>
</keyPair>
~~~

##### JSON Request

~~~
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/NY2JZ58MAWKGF6ZL4ETY HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e9caa84e4b0ea896133e05e
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 47

{
  "keyPair" : {
    "status" : "active"
  }
}
~~~

##### JSON Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 408
Date: Mon, 17 Oct 2011 22:43:24 GMT

{
  "keyPair" : {
    "publicKeyAlgorithm" : "RSA",
    "publicKeyLength" : 1024,
    "publicKeyFile" : null,
    "privateKeyFile" : null,
    "createdOn" : 1318638866340,
    "domainId" : "00000000001001",
    "keyPairId" : "NY2JZ58MAWKGF6ZL4ETY",
    "otherAttributes" : {
    },
    "status" : "active",
    "userId" : "00000000003002",
    "validFrom" : 1318638866000,
    "validTo" : 1633998866000
  }
}
~~~

### **Delete User Key Pair**

Verb

URI

Description

**DELETE** 

**[HPKeystoneExtensionBaseURI]/keypairs/{keypairId}**

Delete user key pair

#### **Detailed Description**

*Delete a specified user key pair.*

#### **Response Codes**

HTTP Status Code

Description

Comments

204

No Content

The operation was successful.

400

Bad request

The request for the operation is not well formed or missing the required
parameters.

401

Unauthorized

The caller does not have the privilege required to perform the
operation.

403

Forbidden

 

404

Item not found

The item to be updated was not found.

500

Identity fault

The server encountered a problem while processing the request.

503

Service unavailable

The server is unavailable to process the request.

#### **Header Values**

*No additional header values present.*

#### **Path Variables**

*The key pair identifier (keypairId) is required in the URI.*

#### **Query String Values**

*No additional query string values.*

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

#### **Request and Response schema,  XML Schema Definition **

*No request body is required. No response body is returned if
successful.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[keyPair.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyPair.xsd)

#### **Example(s)**

##### XML Request

~~~
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/3K3A3FJSC9YRX5LVJCES HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e81f502e4b078454c0c31bf
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### XML Response

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=C1E6F9C41377350F6C6236CD0923BAC8; Path=/v2.0; Secure
Date: Tue, 27 Sep 2011 16:22:36 GMT
~~~

##### JSON Request

~~~
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/6616KAAUK6L9HJGUT6Z7 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e9caa84e4b0ea896133e05e
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### JSON Response

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=06BB563F31C6543DE13C39F82290764C; Path=/v2.0; Secure
Date: Mon, 17 Oct 2011 22:35:05 GMT
~~~
