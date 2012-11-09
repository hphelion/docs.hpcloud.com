# User Certificate

User Certificate Operations.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## Get User Certificates
#### GET [HPKeystoneExtensionBaseURI]/certificates
*Privilege Level: SA, DA, SS* 

Allows reading a selected list of certificates. This API supports pagination through 'limit' and 'marker' usage.

**Request Data**

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional)} - string - the resource Id of the last item in the previous list
* *domainId* (Optional) - string -  Domain identifier.
* *export* (Optional)} - string - Export the certificate. One of {true,false}. Default is false.
* *issuerName* (Optional) - string -  Name of certificate issuer of the desired certificate(s). Must be specified if serial number also specified.
* *serialNumber* (Optional) - string - The serial number of the desired certificate. The issuer name must be specified with the serial number.
* *status* (Optional) - string -  Certificate status. One of {active, inactive, expired, revoked, deleted, purged}.
* *subjectKeyId* (Optional) - string -  Subject key identifier for the certificate.
* *userId* (Optional) - string -  User identifier to select keys for a specific user. If not specified then defaults to userId of current requester.

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7bdbcee4b0600fec3d2a4d
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e6eb9b9e4b0100a2619f0c5
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

Optional:

Request With issue name and serial number and :

JSON

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates?issuerName=ABC&serialNumber=DEF HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7bdbcee4b0600fec3d2a4d
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates?issuerName=ABC&serialNumber=DEF HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e6eb9b9e4b0100a2619f0c5
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2126
Date: Fri, 23 Sep 2011 01:15:26 GMT
 
{
  "certificates" : {
    "anies" : null,
    "certificate" : [ {
      "certificateFile" : null,
      "privateKeyFile" : null,
      "anies" : null,
      "domainId" : "00000000001001",
      "enhancedKeyUsage" : "Client Authentication",
      "issuerName" : "CN=Joe Test3",
      "keyUsage" : "Digital Signature",
      "otherAttributes" : {
      },
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "serialNumber" : "129b61ef",
      "signatureAlgorithm" : "SHA1WithRSA",
      "status" : "active",
      "subject" : "CN=Joe Test3",
      "subjectKeyId" : "2d27a3be750e799388031b21c1d642098de87850",
      "userId" : "00000000003002",
      "validFrom" : 1316740409000,
      "validTo" : 1632100409000
    }, {
      "certificateFile" : null,
      "privateKeyFile" : null,
      "anies" : null,
      "domainId" : "00000000001001",
      "enhancedKeyUsage" : "Client Authentication",
      "issuerName" : "CN=Joe Test2",
      "keyUsage" : "Digital Signature",
      "otherAttributes" : {
      },
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "serialNumber" : "0a5b1864",
      "signatureAlgorithm" : "SHA1WithRSA",
      "status" : "active",
      "subject" : "CN=Joe Test2",
      "subjectKeyId" : "6e585a12b0e92273c1e5df5bc186788bb0fb9df6",
      "userId" : "00000000003002",
      "validFrom" : 1316740386000,
      "validTo" : 1632100386000
    }, {
      "certificateFile" : null,
      "privateKeyFile" : null,
      "anies" : null,
      "domainId" : "00000000001001",
      "enhancedKeyUsage" : "Client Authentication",
      "issuerName" : "CN=Joe Test1",
      "keyUsage" : "Digital Signature",
      "otherAttributes" : {
      },
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "serialNumber" : "5669954f",
      "signatureAlgorithm" : "SHA1WithRSA",
      "status" : "active",
      "subject" : "CN=Joe Test1",
      "subjectKeyId" : "c6e111d159b94a90d241b71e506e61ee30e89d20",
      "userId" : "00000000003002",
      "validFrom" : 1316740274000,
      "validTo" : 1632100274000
    } ],
    "otherAttributes" : {
    }
  }
}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=22C73786BCA16F376A779B25CE384EE9; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 1111
Date: Tue, 13 Sep 2011 02:03:40 GMT
 
<certificates xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <certificate userId="000000003002" domainId="000000001001" issuerName="CN=Joe Test" serialNumber="16c13be6" subject="CN=Joe Test" subjectKeyId="326dd2ab79ddc98cf4620b7df0f557501fdd3dd4" status="active" validFrom="2011-09-12T18:32:03.000-07:00" validTo="2021-09-09T18:32:03.000-07:00" signatureAlgorithm="SHA1WithRSA" publicKeyAlgorithm="RSA" publicKeyLength="1024" keyUsage="Digital Signature" enhancedKeyUsage="Client Authentication"/>
   <certificate userId="000000003002" domainId="000000001001" issuerName="CN=Joe Test" serialNumber="1239dac6" subject="CN=Joe Test" subjectKeyId="504744e8c29d8bf417c01e8fb6c779a23749cf80" status="active" validFrom="2011-09-12T18:34:42.000-07:00" validTo="2021-09-09T18:34:42.000-07:00" signatureAlgorithm="SHA1WithRSA" publicKeyAlgorithm="RSA" publicKeyLength="1024" keyUsage="Digital Signature" enhancedKeyUsage="Client Authentication"/>
</certificates>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :----------| :-----------| :---------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized |The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request|
| 500 | Internal Server Error | The server encountered a problem while processing the request. | 
| 503 | Service Unavailable | The server is unavailable to process the request.|

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates"
```

**Additional Notes**


## Delete User Certificate
#### DELETE [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} 	D
*Privilege Level: SA, DA, SS*

Delete a user certificate.The issuer name {issuerName} and serial number {serialNumber} are required in the URI.

**Request Data**


**URL Parameters**

* *issuerName*  - string -  Name of certificate issuer of the desired certificate(s). Must be specified if serial number also specified.
* *serialNumber*  - string - The serial number of the desired certificate. The issuer name must be specified with the serial number.

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test1/5669954f HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7bde38e4b0600fec3d2a54
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test/1239dac6 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e6edf2ee4b03cd3901e21e5
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

Optional:


**Success Response**

**Status Code**

204 (No Content)

**Response Data**

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=24830D918D66DC787E1510E8385F1623; Path=/v2.0; Secure
Date: Fri, 23 Sep 2011 01:22:57 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=AB5C4E673D143F25DE6EFC024E1A2ED9; Path=/v2.0; Secure
Date: Tue, 13 Sep 2011 04:45:19 GMT
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :----------| :-----------| :---------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized |The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request|
| 500 | Internal Server Error | The server encountered a problem while processing the request. | 
| 503 | Service Unavailable | The server is unavailable to process the request.|

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test1/5669954f" -XDELETE
```

**Additional Notes**


## Get User Certificate 
#### GET [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber}
*Privilege Level: SA, DA, SS*

Get a specified user certificate. The issuer name {issuerName} and serial number {serialNumber} are required in the URI.

**Request Data**

**URL Parameters**

* *issuerName*  - string -  Name of certificate issuer of the desired certificate(s). Must be specified if serial number also specified.
* *serialNumber*  - string - The serial number of the desired certificate. The issuer name must be specified with the serial number.
* *export* (Optional)} - string - Export the certificate. One of {true,false}. Default is false.

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test1/5669954f?export=true HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7bde38e4b0600fec3d2a54
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test/16c13be6?export=true HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e6eb9b9e4b0100a2619f0c5
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**


**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 1464
Date: Fri, 23 Sep 2011 01:18:09 GMT
 
{
  "certificate" : {
    "certificateFile" : {
      "format" : "BASE64_DER",
      "data" : "-----BEGIN CERTIFICATE-----\nMIIB6jCCAVOgAwIBAgIEVmmVTzANBgkqhkiG9w0BAQUFADAUMRIwEAYDVQQDEwlK\nb2UgVGVzdDEwHhcNMTEwOTIzMDExMTE0WhcNMjEwOTIwMDExMTE0WjAUMRIwEAYD\nVQQDEwlKb2UgVGVzdDEwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAJgSJZQ7\ntzs9AQyEn4raW4GCdVaUy5m1Slp83/LivR8IA8P9MRglLXcv3Ox7ngkb+wmt3ADU\n9naD9CF3P0jtfWKG7T8dlFmqOGGLdzqFACMK/sEMHW9/DALYxcL7tc89B8qGfmIo\nHHZRMJdNZe+Cf50nlowu5vZTSU43XWLxmQKHAgMBAAGjSTBHMB0GA1UdDgQWBBTG\n4RHRWblKkNJBtx5QbmHuMOidIDAWBgNVHSUBAf8EDDAKBggrBgEFBQcDAjAOBgNV\nHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQEFBQADgYEAHfq/6UmloYbJL+AGlekQJmmf\ntw1r5zGGh6wOq+hgcoo3n3X2tBnDns8Se6w7D7sG8bRpUKLuEHjV0xJJ8tQ5tYE9\n46jHTKXBL6nvnfdmnmoqOGEt9BXehEeBKryyC2aQ3paHVjtBQVFAxEktasN3DJt0\nJUSyod7hug+CauMVBVg=\n-----END CERTIFICATE-----",
      "anies" : null
    },
    "privateKeyFile" : null,
    "anies" : null,
    "domainId" : "00000000001001",
    "enhancedKeyUsage" : "Client Authentication",
    "issuerName" : "CN=Joe Test1",
    "keyUsage" : "Digital Signature",
    "otherAttributes" : {
    },
    "publicKeyAlgorithm" : "RSA",
    "publicKeyLength" : 1024,
    "serialNumber" : "5669954f",
    "signatureAlgorithm" : "SHA1WithRSA",
    "status" : "active",
    "subject" : "CN=Joe Test1",
    "subjectKeyId" : "c6e111d159b94a90d241b71e506e61ee30e89d20",
    "userId" : "00000000003002",
    "validFrom" : 1316740274000,
    "validTo" : 1632100274000
  }
}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=D6E0ACB36E5A7E5544EC274C209A5CA8; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 1454
Date: Tue, 13 Sep 2011 02:11:34 GMT
 
<certificate userId="000000003002" domainId="000000001001" issuerName="CN=Joe Test" serialNumber="16c13be6" subject="CN=Joe Test" subjectKeyId="326dd2ab79ddc98cf4620b7df0f557501fdd3dd4" status="active" validFrom="2011-09-12T18:32:03.000-07:00" validTo="2021-09-09T18:32:03.000-07:00" signatureAlgorithm="SHA1WithRSA" publicKeyAlgorithm="RSA" publicKeyLength="1024" keyUsage="Digital Signature" enhancedKeyUsage="Client Authentication" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <certificateFile>
      <format>BASE64_DER</format>
      <data>-----BEGIN CERTIFICATE-----
MIIB6DCCAVGgAwIBAgIEFsE75jANBgkqhkiG9w0BAQUFADATMREwDwYDVQQDEwhK
b2UgVGVzdDAeFw0xMTA5MTMwMTMyMDNaFw0yMTA5MTAwMTMyMDNaMBMxETAPBgNV
BAMTCEpvZSBUZXN0MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVK8TKPEeE
0CB+ExWtCauQxl3W/bmxdn380L0l7sLjZgbQ/a6Bgh5YQ852ZeWdXH+x6E3tn+Nm
lObyqBP1PqKrGgPaAhhcWzkzWkyQDYSrAAVuk704UzS2M5x2XPUlqoIQFLpQbnPu
oZXq05CVVWATUJJ7Eha7lUkpsUhBxHMToQIDAQABo0kwRzAdBgNVHQ4EFgQUMm3S
q3ndyYz0Ygt98PVXUB/dPdQwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDgYDVR0P
AQH/BAQDAgeAMA0GCSqGSIb3DQEBBQUAA4GBAF0ymDG4li+RYh5cSSiku1RJqGzM
SREwWl0UH7Gb7VCDgpOKGiqyNK5XFQz8yfsX37xrQrss/0EI4uUn8C6nd+FRq0MB
SSqsNMrMG/9uG9Wq3ZpwuFV2O9BAT3GHmrBuc1+7nl8JAhjabxnz18BL8JfEfvL7
QFtQ0IaeFZzVnhrD
-----END CERTIFICATE-----</data>
   </certificateFile>
</certificate>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :----------| :-----------| :---------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized |The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request|
| 500 | Internal Server Error | The server encountered a problem while processing the request. | 
| 503 | Service Unavailable | The server is unavailable to process the request.|

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test1/5669954f?export=true"
```

**Additional Notes**

## Create A User Certificate
#### POST [HPKeystoneExtensionBaseURI]/certificates
*Privilege Level: SA, DA, SS*

Create a user certificate. This method requires a request body. The user identifier and subject elements are required elements in the body.

**Request Data**


**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.
A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call requires a request body.

JSON

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/certificates HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e7bdbcee4b0600fec3d2a4d
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 114
 
{"certificate":{"userId":"00000000003002","domainId":"00000000001001","subject":"CN=Joe Test1","status":"active"}}
```

XML

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/certificates HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e6eb252e4b0fa3a722f6bc9
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 215
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<certificate userId="000000003002" domainId="000000001001" subject="CN=Joe Test" status="active" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"/>
```

Optional:


**Success Response**

**Status Code**

201 - Created

**Response Data**

JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2470
Date: Fri, 23 Sep 2011 01:11:16 GMT
 
{
  "certificate" : {
    "certificateFile" : {
      "format" : "BASE64_DER",
      "data" : "-----BEGIN CERTIFICATE-----\nMIIB6jCCAVOgAwIBAgIEVmmVTzANBgkqhkiG9w0BAQUFADAUMRIwEAYDVQQDEwlK\nb2UgVGVzdDEwHhcNMTEwOTIzMDExMTE0WhcNMjEwOTIwMDExMTE0WjAUMRIwEAYD\nVQQDEwlKb2UgVGVzdDEwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAJgSJZQ7\ntzs9AQyEn4raW4GCdVaUy5m1Slp83/LivR8IA8P9MRglLXcv3Ox7ngkb+wmt3ADU\n9naD9CF3P0jtfWKG7T8dlFmqOGGLdzqFACMK/sEMHW9/DALYxcL7tc89B8qGfmIo\nHHZRMJdNZe+Cf50nlowu5vZTSU43XWLxmQKHAgMBAAGjSTBHMB0GA1UdDgQWBBTG\n4RHRWblKkNJBtx5QbmHuMOidIDAWBgNVHSUBAf8EDDAKBggrBgEFBQcDAjAOBgNV\nHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQEFBQADgYEAHfq/6UmloYbJL+AGlekQJmmf\ntw1r5zGGh6wOq+hgcoo3n3X2tBnDns8Se6w7D7sG8bRpUKLuEHjV0xJJ8tQ5tYE9\n46jHTKXBL6nvnfdmnmoqOGEt9BXehEeBKryyC2aQ3paHVjtBQVFAxEktasN3DJt0\nJUSyod7hug+CauMVBVg=\n-----END CERTIFICATE-----",
      "anies" : null
    },
    "privateKeyFile" : {
      "format" : "BASE64_PKCS8",
      "data" : "-----BEGIN PRIVATE KEY-----\nMIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAJgSJZQ7tzs9AQyE\nn4raW4GCdVaUy5m1Slp83/LivR8IA8P9MRglLXcv3Ox7ngkb+wmt3ADU9naD9CF3\nP0jtfWKG7T8dlFmqOGGLdzqFACMK/sEMHW9/DALYxcL7tc89B8qGfmIoHHZRMJdN\nZe+Cf50nlowu5vZTSU43XWLxmQKHAgMBAAECgYAU/Xw+Z7e074izh6LV8anryGwV\n1Vf9EW7/6nim9/EO1XZfmRUrtgX+i5a89ZssurX98geJ/ds/JJuP+vu7PzytJFj1\nNmCd0na7+I33UgcmWoYwyA9MuBvgmPuVrlvV53h9qGetZ4NECRgwZGjyGnAPCOOI\n12+IJDpXusYaiUG0gQJBAM42hDByPcKgi1Txm6xotvXcc+/4AhyFm3VLlcPjZGnk\nnCjE0NzTiG0m7wGillnLmxcRnCFAW21qzoVX3E06DyECQQC8yUAuOkV5jDi3Zqn/\nEN/IB6mWLDJ7Pf4zwjWKMCOHZV7nOV/2T1Z6BTNYHtr1ltFOMl3UP4yVxFna8qQm\nCKSnAkEAx2D0fHboefaJ4M5d6tuwEpVcz2cme3c+8LDtE+IXIz9zMQPiwbAQ1yBu\ntFEEN7vhrvNK1ueHvoonNcvWaCC7oQJBAJkpZaqbmBX+z1zsK+tGE2hD3zB49xPJ\nvdzcKXfNimWktpQ9lj9NKsmgQoGxts8c5v7cGgfC7xnqzUO3K7m3tW0CQQChn3RH\nPXB4P3eS67mm4BnVqYN9QoWFj00zHwMLUqqwmMxWAltrnv1e7IIvI3LJA86dQ9Ll\npeFn83bakcrjTrXT\n-----END PRIVATE KEY-----",
      "anies" : null
    },
    "anies" : null,
    "domainId" : "00000000001001",
    "enhancedKeyUsage" : "Client Authentication",
    "issuerName" : "CN=Joe Test1",
    "keyUsage" : "Digital Signature",
    "otherAttributes" : {
    },
    "publicKeyAlgorithm" : "RSA",
    "publicKeyLength" : 1024,
    "serialNumber" : "5669954f",
    "signatureAlgorithm" : "SHA1WithRSA",
    "status" : "active",
    "subject" : "CN=Joe Test1",
    "subjectKeyId" : "c6e111d159b94a90d241b71e506e61ee30e89d20",
    "userId" : "00000000003002",
    "validFrom" : 1316740274000,
    "validTo" : 1632100274000
  }
}
```

XML

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=85925B5A7D624BA854BDC6E2F1EDCA78; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 2440
Date: Tue, 13 Sep 2011 01:32:04 GMT
 
<certificate userId="000000003002" domainId="000000001001" issuerName="CN=Joe Test" serialNumber="16c13be6" subject="CN=Joe Test" subjectKeyId="326dd2ab79ddc98cf4620b7df0f557501fdd3dd4" status="active" validFrom="2011-09-12T18:32:03.000-07:00" validTo="2021-09-09T18:32:03.000-07:00" signatureAlgorithm="SHA1WithRSA" publicKeyAlgorithm="RSA" publicKeyLength="1024" keyUsage="Digital Signature" enhancedKeyUsage="Client Authentication" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <certificateFile>
      <format>BASE64_DER</format>
      <data>
-----BEGIN CERTIFICATE-----
MIIB6DCCAVGgAwIBAgIEFsE75jANBgkqhkiG9w0BAQUFADATMREwDwYDVQQDEwhK
b2UgVGVzdDAeFw0xMTA5MTMwMTMyMDNaFw0yMTA5MTAwMTMyMDNaMBMxETAPBgNV
BAMTCEpvZSBUZXN0MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVK8TKPEeE
0CB+ExWtCauQxl3W/bmxdn380L0l7sLjZgbQ/a6Bgh5YQ852ZeWdXH+x6E3tn+Nm
lObyqBP1PqKrGgPaAhhcWzkzWkyQDYSrAAVuk704UzS2M5x2XPUlqoIQFLpQbnPu
oZXq05CVVWATUJJ7Eha7lUkpsUhBxHMToQIDAQABo0kwRzAdBgNVHQ4EFgQUMm3S
q3ndyYz0Ygt98PVXUB/dPdQwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDgYDVR0P
AQH/BAQDAgeAMA0GCSqGSIb3DQEBBQUAA4GBAF0ymDG4li+RYh5cSSiku1RJqGzM
SREwWl0UH7Gb7VCDgpOKGiqyNK5XFQz8yfsX37xrQrss/0EI4uUn8C6nd+FRq0MB
SSqsNMrMG/9uG9Wq3ZpwuFV2O9BAT3GHmrBuc1+7nl8JAhjabxnz18BL8JfEfvL7
QFtQ0IaeFZzVnhrD
-----END CERTIFICATE-----
   </data>
   </certificateFile>
   <privateKeyFile>
      <format>BASE64_PKCS8</format>
      <data>
-----BEGIN PRIVATE KEY-----
MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAJUrxMo8R4TQIH4T
Fa0Jq5DGXdb9ubF2ffzQvSXuwuNmBtD9roGCHlhDznZl5Z1cf7HoTe2f42aU5vKo
E/U+oqsaA9oCGFxbOTNaTJANhKsABW6TvThTNLYznHZc9SWqghAUulBuc+6hlerT
kJVVYBNQknsSFruVSSmxSEHEcxOhAgMBAAECgYBKAsFMpcPGPY0hgE6M3/NjjUgZ
1yE+z0+LE/YE0AWZ1ZEkN/lRAEIWAO57B+t4u+APYPbpIx8sUkyTsJjWYRFLmV6L
hc/DzLPSPTSX/9vU9+Zb7p+yHvZMOxuOi7+d8niyEzI25oJJwTmlb+mpaqcdyoHF
LgZ5atJarCG5NOA8UQJBAMPuSlriFL8cCmTjWDCjkf9w0+1NoCkq6p0gi9o+ENwE
mVAfi3H00InAzcx2F24rBA7N7XLAHkCsO79rZb3OZSMCQQDC54M2ANMl5SzbB51L
q43vU/vDqeFs9LOsl94772hOtJo6opAjAIxh8DULRH3uop4PqsuJpJf3df5NF60l
JdprAkAXcQ4iW4RB7TftJCor/5X7KuOgM7Zi1oilbfxtixl3SXGSXYPQiYrdwFyf
Bs3811av8sFjBktYT4MCfvX4RJZjAkBvORxoeeoEqxaA24SIxRqXI879Znls6uuJ
p5S7kTBuEaQdp90nDE4QKbqrdmeDAau/dxD1uEa8gcogBk3ZcBOHAkA9NON4kWjr
UrgmZ//9rzCTqdxa/OdhN/YPgxnf4nYaLfx4NkVENkKDoCpTmsP/yui/Mz2QlG1T
/heuCxMDeN/5
-----END PRIVATE KEY-----
</data>
   </privateKeyFile>
</certificate>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :----------| :-----------| :---------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized |The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request|
| 500 | Internal Server Error | The server encountered a problem while processing the request. | 
| 503 | Service Unavailable | The server is unavailable to process the request.|

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates" -XPOST -d "\{"certificate\":\{"userId\":\"00000000003002\",\"domainId\":\"00000000001001\",\"subject\":\"CN=Joe Test1\",\"status\":\"active\"}}"
```

**Additional Notes**


## Import User Certificate(s)
#### PUT [HPKeystoneExtensionBaseURI]/certificates
*Privilege Level: SA, DA, SS*

Import user certificate(s). The operation requires a request body containing the user certificate(s) and the user identifier.

**Request Data**

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

The request body contains a certificates object with the certificates to be imported.

JSON

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/certificates HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e7be9ede4b0600fec3d2a5c
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 1200
 
{
  "certificates" : {
    "certificate" : [ {
      "certificateFile" : {
        "format" : "BASE64_DER",
        "data" : "-----BEGIN CERTIFICATE-----MIICnTCCAgYCCQCtK5VR3g//XzANBgkqhkiG9w0BAQUFADCBkjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExEjAQBgNVBAcTCUN1cGVydGlubzELMAkGA1UEChMCSFAxFzAVBgNVBAsTDkNsb3VkIFNlcnZpY2VzMRMwEQYDVQQDEwpKb2UgSW1wb3J0MR8wHQYJKoZIhvcNAQkBFhBqb2VpbXBvcnRAaHAuY29tMB4XDTExMDkxMzE3MjQyNFoXDTEyMDkxMjE3MjQyNFowgZIxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlDdXBlcnRpbm8xCzAJBgNVBAoTAkhQMRcwFQYDVQQLEw5DbG91ZCBTZXJ2aWNlczETMBEGA1UEAxMKSm9lIEltcG9ydDEfMB0GCSqGSIb3DQEJARYQam9laW1wb3J0QGhwLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAqc+nJIhedmOXSMzSmNsAZY7ryOn6iagrqxHXV5oyNQR6500M30HkrG4GaQf72y3MygeW9VAeuOiZPo0WwqxEAJUKMjCjVCqFRsqO+9TKtqtp/4nM+OgK6mKaiu0A5YZj8xnvr2O0wW9tZ+WW+Jn1OPP5130g2QcnH5r9trIjJU8CAwEAATANBgkqhkiG9w0BAQUFAAOBgQA4bXilPBHgNeNCDyqcSWQjHeuTRpSmuvwbsp0YmhHsLE+DITxbphdfKkKHCXnRfv/CfbLTZw3uaQv+YUVMUgZDwt5Hx+Ncr8QAFjzp6udHufDWNR4xzzMkRD6wwaMcNenheyI0mxPM7KKLzqVNSa5JXSdRbkRSeaFbwBrG6tNZaA==-----END CERTIFICATE-----"
      },
      "domainId" : "00000000001001",
      "status" : "active",
      "userId" : "00000000003002"
    } ]
  }
}
```

XML

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/certificates HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e6fc007e4b054f105583c65
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 1261
 
<certificates xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
   <certificate userId="000000003002" domainId="000000001001" status="active">
      <certificateFile>
         <format>BASE64_DER</format>
         <data>-----BEGIN CERTIFICATE-----MIICnTCCAgYCCQCtK5VR3g//XzANBgkqhkiG9w0BAQUFADCBkjELMAkGA1UEBhMC
VVMxEzARBgNVBAgTCkNhbGlmb3JuaWExEjAQBgNVBAcTCUN1cGVydGlubzELMAkG
A1UEChMCSFAxFzAVBgNVBAsTDkNsb3VkIFNlcnZpY2VzMRMwEQYDVQQDEwpKb2Ug
SW1wb3J0MR8wHQYJKoZIhvcNAQkBFhBqb2VpbXBvcnRAaHAuY29tMB4XDTExMDkx
MzE3MjQyNFoXDTEyMDkxMjE3MjQyNFowgZIxCzAJBgNVBAYTAlVTMRMwEQYDVQQI
EwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlDdXBlcnRpbm8xCzAJBgNVBAoTAkhQMRcw
FQYDVQQLEw5DbG91ZCBTZXJ2aWNlczETMBEGA1UEAxMKSm9lIEltcG9ydDEfMB0G
CSqGSIb3DQEJARYQam9laW1wb3J0QGhwLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOB
jQAwgYkCgYEAqc+nJIhedmOXSMzSmNsAZY7ryOn6iagrqxHXV5oyNQR6500M30Hk
rG4GaQf72y3MygeW9VAeuOiZPo0WwqxEAJUKMjCjVCqFRsqO+9TKtqtp/4nM+OgK
6mKaiu0A5YZj8xnvr2O0wW9tZ+WW+Jn1OPP5130g2QcnH5r9trIjJU8CAwEAATAN
BgkqhkiG9w0BAQUFAAOBgQA4bXilPBHgNeNCDyqcSWQjHeuTRpSmuvwbsp0YmhHs
LE+DITxbphdfKkKHCXnRfv/CfbLTZw3uaQv+YUVMUgZDwt5Hx+Ncr8QAFjzp6udH
ufDWNR4xzzMkRD6wwaMcNenheyI0mxPM7KKLzqVNSa5JXSdRbkRSeaFbwBrG6tNZ
aA==-----END CERTIFICATE-----</data>
      </certificateFile>
   </certificate>
</certificates>
```

Optional:


**Success Response**

**Status Code**

200 - OK

**Response Data**


JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 1966
Date: Fri, 23 Sep 2011 02:12:53 GMT
 
{
  "certificates" : {
    "anies" : null,
    "certificate" : [ {
      "certificateFile" : {
        "format" : "BASE64_DER",
        "data" : "-----BEGIN CERTIFICATE-----MIICnTCCAgYCCQCtK5VR3g//XzANBgkqhkiG9w0BAQUFADCBkjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExEjAQBgNVBAcTCUN1cGVydGlubzELMAkGA1UEChMCSFAxFzAVBgNVBAsTDkNsb3VkIFNlcnZpY2VzMRMwEQYDVQQDEwpKb2UgSW1wb3J0MR8wHQYJKoZIhvcNAQkBFhBqb2VpbXBvcnRAaHAuY29tMB4XDTExMDkxMzE3MjQyNFoXDTEyMDkxMjE3MjQyNFowgZIxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlDdXBlcnRpbm8xCzAJBgNVBAoTAkhQMRcwFQYDVQQLEw5DbG91ZCBTZXJ2aWNlczETMBEGA1UEAxMKSm9lIEltcG9ydDEfMB0GCSqGSIb3DQEJARYQam9laW1wb3J0QGhwLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAqc+nJIhedmOXSMzSmNsAZY7ryOn6iagrqxHXV5oyNQR6500M30HkrG4GaQf72y3MygeW9VAeuOiZPo0WwqxEAJUKMjCjVCqFRsqO+9TKtqtp/4nM+OgK6mKaiu0A5YZj8xnvr2O0wW9tZ+WW+Jn1OPP5130g2QcnH5r9trIjJU8CAwEAATANBgkqhkiG9w0BAQUFAAOBgQA4bXilPBHgNeNCDyqcSWQjHeuTRpSmuvwbsp0YmhHsLE+DITxbphdfKkKHCXnRfv/CfbLTZw3uaQv+YUVMUgZDwt5Hx+Ncr8QAFjzp6udHufDWNR4xzzMkRD6wwaMcNenheyI0mxPM7KKLzqVNSa5JXSdRbkRSeaFbwBrG6tNZaA==-----END CERTIFICATE-----",
        "anies" : null
      },
      "privateKeyFile" : null,
      "anies" : null,
      "domainId" : "00000000001001",
      "enhancedKeyUsage" : "",
      "issuerName" : "EMAILADDRESS=joeimport@hp.com, CN=Joe Import, OU=Cloud Services, O=HP, L=Cupertino, ST=California, C=US",
      "keyUsage" : "",
      "otherAttributes" : {
      },
      "publicKeyAlgorithm" : "RSA",
      "publicKeyLength" : 1024,
      "serialNumber" : "00ad2b9551de0fff5f",
      "signatureAlgorithm" : "SHA1withRSA",
      "status" : "active",
      "subject" : "EMAILADDRESS=joeimport@hp.com, CN=Joe Import, OU=Cloud Services, O=HP, L=Cupertino, ST=California, C=US",
      "subjectKeyId" : "fd166f5e94c161e30b3526cb44071014462f6a99",
      "userId" : "00000000003002",
      "validFrom" : 1315934664000,
      "validTo" : 1347470664000
    } ],
    "otherAttributes" : {
    }
  }
}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=917382088936A5A3D96F4FAB7DD63CEF; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 1885
Date: Tue, 13 Sep 2011 20:42:49 GMT
 
<certificates xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <certificate userId="000000003002" domainId="000000001001" issuerName="EMAILADDRESS=joeimport@hp.com, CN=Joe Import, OU=Cloud Services, O=HP, L=Cupertino, ST=California, C=US" serialNumber="00ad2b9551de0fff5f" subject="EMAILADDRESS=joeimport@hp.com, CN=Joe Import, OU=Cloud Services, O=HP, L=Cupertino, ST=California, C=US" subjectKeyId="fd166f5e94c161e30b3526cb44071014462f6a99" status="active" validFrom="2011-09-13T10:24:24.000-07:00" validTo="2012-09-12T10:24:24.000-07:00" signatureAlgorithm="SHA1withRSA" publicKeyAlgorithm="RSA" publicKeyLength="1024" keyUsage="" enhancedKeyUsage="">
      <certificateFile>
         <format>BASE64_DER</format>
         <data>-----BEGIN CERTIFICATE-----MIICnTCCAgYCCQCtK5VR3g//XzANBgkqhkiG9w0BAQUFADCBkjELMAkGA1UEBhMC
VVMxEzARBgNVBAgTCkNhbGlmb3JuaWExEjAQBgNVBAcTCUN1cGVydGlubzELMAkG
A1UEChMCSFAxFzAVBgNVBAsTDkNsb3VkIFNlcnZpY2VzMRMwEQYDVQQDEwpKb2Ug
SW1wb3J0MR8wHQYJKoZIhvcNAQkBFhBqb2VpbXBvcnRAaHAuY29tMB4XDTExMDkx
MzE3MjQyNFoXDTEyMDkxMjE3MjQyNFowgZIxCzAJBgNVBAYTAlVTMRMwEQYDVQQI
EwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlDdXBlcnRpbm8xCzAJBgNVBAoTAkhQMRcw
FQYDVQQLEw5DbG91ZCBTZXJ2aWNlczETMBEGA1UEAxMKSm9lIEltcG9ydDEfMB0G
CSqGSIb3DQEJARYQam9laW1wb3J0QGhwLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOB
jQAwgYkCgYEAqc+nJIhedmOXSMzSmNsAZY7ryOn6iagrqxHXV5oyNQR6500M30Hk
rG4GaQf72y3MygeW9VAeuOiZPo0WwqxEAJUKMjCjVCqFRsqO+9TKtqtp/4nM+OgK
6mKaiu0A5YZj8xnvr2O0wW9tZ+WW+Jn1OPP5130g2QcnH5r9trIjJU8CAwEAATAN
BgkqhkiG9w0BAQUFAAOBgQA4bXilPBHgNeNCDyqcSWQjHeuTRpSmuvwbsp0YmhHs
LE+DITxbphdfKkKHCXnRfv/CfbLTZw3uaQv+YUVMUgZDwt5Hx+Ncr8QAFjzp6udH
ufDWNR4xzzMkRD6wwaMcNenheyI0mxPM7KKLzqVNSa5JXSdRbkRSeaFbwBrG6tNZ
aA==-----END CERTIFICATE-----</data>
      </certificateFile>
   </certificate>
</certificates>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :----------| :-----------| :---------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized |The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request|
| 500 | Internal Server Error | The server encountered a problem while processing the request. | 
| 503 | Service Unavailable | The server is unavailable to process the request.|

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates" -XPUT -d "{
  "certificates" : {
    "certificate" : [ {
      "certificateFile" : {
        "format" : "BASE64_DER",
        "data" : "-----BEGIN CERTIFICATE-----MIICnTCCAgYCCQCtK5VR3g//XzANBgkqhkiG9w0BAQUFADCBkjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExEjAQBgNVBAcTCUN1cGVydGlubzELMAkGA1UEChMCSFAxFzAVBgNVBAsTDkNsb3VkIFNlcnZpY2VzMRMwEQYDVQQDEwpKb2UgSW1wb3J0MR8wHQYJKoZIhvcNAQkBFhBqb2VpbXBvcnRAaHAuY29tMB4XDTExMDkxMzE3MjQyNFoXDTEyMDkxMjE3MjQyNFowgZIxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlDdXBlcnRpbm8xCzAJBgNVBAoTAkhQMRcwFQYDVQQLEw5DbG91ZCBTZXJ2aWNlczETMBEGA1UEAxMKSm9lIEltcG9ydDEfMB0GCSqGSIb3DQEJARYQam9laW1wb3J0QGhwLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAqc+nJIhedmOXSMzSmNsAZY7ryOn6iagrqxHXV5oyNQR6500M30HkrG4GaQf72y3MygeW9VAeuOiZPo0WwqxEAJUKMjCjVCqFRsqO+9TKtqtp/4nM+OgK6mKaiu0A5YZj8xnvr2O0wW9tZ+WW+Jn1OPP5130g2QcnH5r9trIjJU8CAwEAATANBgkqhkiG9w0BAQUFAAOBgQA4bXilPBHgNeNCDyqcSWQjHeuTRpSmuvwbsp0YmhHsLE+DITxbphdfKkKHCXnRfv/CfbLTZw3uaQv+YUVMUgZDwt5Hx+Ncr8QAFjzp6udHufDWNR4xzzMkRD6wwaMcNenheyI0mxPM7KKLzqVNSa5JXSdRbkRSeaFbwBrG6tNZaA==-----END CERTIFICATE-----"
      },
      "domainId" : "00000000001001",
      "status" : "active",
      "userId" : "00000000003002"
    } ]
  }
}"

```

**Additional Notes**

## Update User Certificate
#### PUT [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} 	
*Privilege Level: SA,DA,SS*

Update a user certificate. This method requires a request body containing the status element of the certificate. The issuer name {issuerName} and serial number {serialNumber} are required in the URI.

**Request Data**

**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

The request body contains a certificate object. The status attribute is required in the certificate object. All other attributes and elements of the certificate object are ignored.

JSON

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test2/0a5b1864 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e7bde38e4b0600fec3d2a54
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 53
 
{
  "certificate" : {
    "status" : "inactive"
  }
}
```

XML

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test/1239dac6 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e6ed517e4b03cd3901e21da
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 145
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<certificate xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" status="active"/>
```

Optional:


**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 656
Date: Fri, 23 Sep 2011 01:28:19 GMT
 
{
  "certificate" : {
    "certificateFile" : null,
    "privateKeyFile" : null,
    "anies" : null,
    "domainId" : "00000000001001",
    "enhancedKeyUsage" : "Client Authentication",
    "issuerName" : "CN=Joe Test2",
    "keyUsage" : "Digital Signature",
    "otherAttributes" : {
    },
    "publicKeyAlgorithm" : "RSA",
    "publicKeyLength" : 1024,
    "serialNumber" : "0a5b1864",
    "signatureAlgorithm" : "SHA1WithRSA",
    "status" : "inactive",
    "subject" : "CN=Joe Test2",
    "subjectKeyId" : "6e585a12b0e92273c1e5df5bc186788bb0fb9df6",
    "userId" : "00000000003002",
    "validFrom" : 1316740386000,
    "validTo" : 1632100386000
  }
}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=98315FFBCAEBB00C516B8A0BA5F4B06D; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 646
Date: Tue, 13 Sep 2011 03:59:59 GMT
 
<certificate userId="000000003002" domainId="000000001001" issuerName="CN=Joe Test" serialNumber="1239dac6" subject="CN=Joe Test" subjectKeyId="504744e8c29d8bf417c01e8fb6c779a23749cf80" status="active" validFrom="2011-09-12T18:34:42.000-07:00" validTo="2021-09-09T18:34:42.000-07:00" signatureAlgorithm="SHA1WithRSA" publicKeyAlgorithm="RSA" publicKeyLength="1024" keyUsage="Digital Signature" enhancedKeyUsage="Client Authentication" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom"/>
```

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :----------| :-----------| :---------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized |The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request|
| 500 | Internal Server Error | The server encountered a problem while processing the request. | 
| 503 | Service Unavailable | The server is unavailable to process the request.|

**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test/1239dac6" -XPUT -d '{"certificate": {"status": "inactive"} }'
```

**Additional Notes**



