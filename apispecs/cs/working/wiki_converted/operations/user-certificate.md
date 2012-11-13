---
title : User Certificate Operations

---

### **Get User Certificates**

Verb

URI

Description

**GET** 

**[HPKeystoneExtensionBaseURI]/certificates**

Get user certificates

#### **Detailed Description**

*Allows reading a selected list of certificates. This API supports
pagination through 'limit' and 'marker' usage.*

#### **Normal Response Codes**

**200** (OK)

#### Error Response Codes

*HTTP Status Code*

*Reason(s)*

***400**** (Bad Request) *

*Malformed request in URI or request body*

***401**** **(Unauthorized)   *

*The caller does not have the privilege required to perform the
operation.  *

***403**** **(Forbidden) **   *

*Disabled or suspended user making the request*

***500**** (Internal Server Error)*

*The server encountered a problem while processing the request.  *

***503**** **(Service Unavailable)   *

*The server is unavailable to process the request.  *

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

**'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters").

*Parameter*

*Required*

*Description*

*domainId*

*false*

* Domain identifier.*

*export*

*false*

* Export the certificate. One of {true,false}. Default is false.*

*issuerName*

*false*

* * *Name of certificate issuer of the desired certificate(s). Must be
specified if serial number also specified.*

*limit*

*false*

* *

*marker*

*false*

* marker value should be  *{subjectpublickeyid}

*serialNumber*

*false*

* The serial number of the desired certificate. The issuer name must be
specified with the serial number.*

*status*

*false*

* Certificate status. One of {active, inactive, expired, revoked,
deleted, purged}*

*subjectKeyId*

*false*

* Subject key identifier for the certificate.*

*userId*

*false*

* User identifier to select keys for a specific user. If not specified
then defaults to userId of current requester.*

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

*No request body is required. The response body contains a certificates
object.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[certificate.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/certificate.xsd)

#### **Example(s)**

##### XML Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e6eb9b9e4b0100a2619f0c5
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
Set-Cookie: JSESSIONID=22C73786BCA16F376A779B25CE384EE9; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 1111
Date: Tue, 13 Sep 2011 02:03:40 GMT

<certificates xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <certificate userId="000000003002" domainId="000000001001" issuerName="CN=Joe Test" serialNumber="16c13be6" subject="CN=Joe Test" subjectKeyId="326dd2ab79ddc98cf4620b7df0f557501fdd3dd4" status="active" validFrom="2011-09-12T18:32:03.000-07:00" validTo="2021-09-09T18:32:03.000-07:00" signatureAlgorithm="SHA1WithRSA" publicKeyAlgorithm="RSA" publicKeyLength="1024" keyUsage="Digital Signature" enhancedKeyUsage="Client Authentication"/>
   <certificate userId="000000003002" domainId="000000001001" issuerName="CN=Joe Test" serialNumber="1239dac6" subject="CN=Joe Test" subjectKeyId="504744e8c29d8bf417c01e8fb6c779a23749cf80" status="active" validFrom="2011-09-12T18:34:42.000-07:00" validTo="2021-09-09T18:34:42.000-07:00" signatureAlgorithm="SHA1WithRSA" publicKeyAlgorithm="RSA" publicKeyLength="1024" keyUsage="Digital Signature" enhancedKeyUsage="Client Authentication"/>
</certificates>
~~~

##### JSON Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7bdbcee4b0600fec3d2a4d
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
~~~

### **Import User Certificate(s)**

Verb

URI

Description

**PUT** 

**[HPKeystoneExtensionBaseURI]/certificates**

Import user certificate(s)

#### **Detailed Description**

*Import user certificate(s). The operation requires a request body
containing the user certificate(s) and the user identifier.*

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

*HTTP Status Code*

*Reason(s)*

***400**** (Bad Request)   *

*Malformed request in URI or request body   *

***401**** **(Unauthorized)   *

*The caller does not have the privilege required to perform the
operation.  *

***403**** **(Forbidden) **   *

*Disabled or suspended user making the request*

***500**** (Internal Server Error)*

*The server encountered a problem while processing the request.  *

***503**** **(Service Unavailable)   *

*The server is unavailable to process the request.  *

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*No additional query string required.*

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

*The request body contains a certificates object with the certificates
to be imported. The response body contains a certificates object with
the resulting certificates.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[certificate.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/certificate.xsd)

#### **Example(s)**

##### XML Request

~~~
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
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
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
~~~

##### JSON Response

~~~
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
~~~

### **Get User Certificate **

Verb

URI

Description

**GET** 

**[HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber}**

Get user certificate

#### **Detailed Description**

*Get a specified user certificate. **The issuer name {issuerName} and
serial number {serialNumber} are required in the URI.*

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

*HTTP Status Code*

*Reason(s)*

***400**** (Bad Request)   *

*Malformed request in URI or request body   *

***401**** **(Unauthorized)   *

*The caller does not have the privilege required to perform the
operation.  *

***403**** **(Forbidden) **   *

*Disabled or suspended user making the request*

***500**** (Internal Server Error)*

*The server encountered a problem while processing the request.*

***503**** **(Service Unavailable)*

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*Parameter*

*Required*

*Description*

*export*

*false*

* Export the certificate. One of {true,false}. Default is false.*

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

#### 

#### **Open Issues**

None.

#### ***Preconditions & Default Behavior***

None.

#### **Request and Response schema,  XML Schema Definition **

*No request body is required. The response body contains a certificate
object.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[certificate.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/certificate.xsd)

#### **Example(s)**

##### XML Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test/16c13be6?export=true HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e6eb9b9e4b0100a2619f0c5
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
~~~

##### JSON Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test1/5669954f?export=true HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7bde38e4b0600fec3d2a54
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
~~~

### **Create A User Certificate**

Verb

URI

Description

**POST** 

**[HPKeystoneExtensionBaseURI]/certificates**

Create a user certificate

#### **Detailed Description**

*Create a user certificate. This method requires a request body. The
user identifier and subject elements are required elements in the body.*

#### **Normal Response Codes**

**201** (Created)

#### **Error Response Codes**

*HTTP Status Code*

*Reason(s)*

***400**** (Bad Request)   *

*Malformed request in URI or request body   *

***401**** **(Unauthorized)   *

*The caller does not have the privilege required to perform the
operation.  *

***403**** **(Forbidden) **   *

*Disabled or suspended user making the request*

***500**** (Internal Server Error)*

*The server encountered a problem while processing the request.  *

***503**** **(Service Unavailable)   *

*The server is unavailable to process the request.  *

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*No additional query string values.*

#### Request and Response Resource Representations

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

*The request body contains a certificate object. The userId and
subject attributes of the certificate object are required. All other
attributes and elements of the certificate object are optional. The
response body contains the created certificate object including the
certificate and the private key.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[certificate.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/certificate.xsd)

#### **Example(s)**

##### XML Request

~~~
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
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/certificates HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e7bdbcee4b0600fec3d2a4d
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 114

{"certificate":{"userId":"00000000003002","domainId":"00000000001001","subject":"CN=Joe Test1","status":"active"}}
~~~

##### JSON Response

~~~
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
~~~

### **Update User Certificate**

Verb

URI

Description

**PUT** 

**[HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber}**

Update user certificate

#### **Detailed Description**

*Update a user certificate. This method requires a request body
containing the status element of the certificate. **The issuer name
{issuerName} and serial number {serialNumber} are required in the URI.*

#### **Normal Response Codes**

**200 **(OK)

#### **Error Response Codes**

*HTTP Status Code*

*Reason(s)*

***400**** (Bad Request)   *

*Malformed request in URI or request body   *

***401**** **(Unauthorized)   *

*The caller does not have the privilege required to perform the
operation.  *

***403**** **(Forbidden) **   *

*Disabled or suspended user making the request*

***500**** (Internal Server Error)*

*The server encountered a problem while processing the request.  *

***503**** **(Service Unavailable)   *

*The server is unavailable to process the request.  *

Please refer to error response body for additional details.

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

*The request body contains a certificate object. The status attribute is
required in the certificate object. All other attributes and elements of
the certificate object are ignored. The response body contains the
updated certificate object. The certificate itself is not returned in
the updated certificate object.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[certificate.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/certificate.xsd)

#### **Example(s)**

##### XML Request

~~~
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
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
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
~~~

##### JSON Response

~~~
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
~~~

### **Delete User Certificate**

Verb

URI

Description

**DELETE** 

**[HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber}**

Delete user certificate

#### **Detailed Description**

*Delete a user certificate.**The issuer name {issuerName} and serial
number {serialNumber} are required in the URI.*

#### **Normal Response Codes**

**204 **(No Content)

#### **Error Response Codes**

*HTTP Status Code*

*Reason(s)*

***400**** (Bad Request)   *

*Malformed request in URI or request body   *

***401**** **(Unauthorized)   *

*The caller does not have the privilege required to perform the
operation.  *

***403**** **(Forbidden) **   *

*Disabled or suspended user making the request*

***500**** (Internal Server Error)*

*The server encountered a problem while processing the request.  *

***503**** **(Service Unavailable)   *

*The server is unavailable to process the request.  *

Please refer to error response body for additional details.

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

*No request body is required. No response body is returned if
successful.*

[keyFile.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/keyFile.xsd)
[certificate.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/certificate.xsd)

#### **Example(s)**

##### XML Request

~~~
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test/1239dac6 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e6edf2ee4b03cd3901e21e5
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
Set-Cookie: JSESSIONID=AB5C4E673D143F25DE6EFC024E1A2ED9; Path=/v2.0; Secure
Date: Tue, 13 Sep 2011 04:45:19 GMT
~~~

##### JSON Request

~~~
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test1/5669954f HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7bde38e4b0600fec3d2a54
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
Set-Cookie: JSESSIONID=24830D918D66DC787E1510E8385F1623; Path=/v2.0; Secure
Date: Fri, 23 Sep 2011 01:22:57 GMT
~~~
