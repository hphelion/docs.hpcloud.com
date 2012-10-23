---  
title : Endpoint Template Operations

---  

#### Get Endpoint Templates

Verb

URI

Description

**GET**

**[iaas:HPKeystoneExtensionBaseURI]/endpointTemplates?serviceName={ServiceName}**

Get a list of endpoint templates.

#### **Detailed Description**

*Get a list of endpoint templates. If serviceName is provided in query,
then endpoint templates specific to only that service are included in
response. In case of incorrect service name ( does not exist in system),
empty list is returned. **This list will include disabled endpoint
templates in addition to enabled endpoint templates. The operation does
not require a request body.*

*This API supports pagination through 'limit' and 'marker' usage. Marker
is templateId and should be valid otherwise 404 (not found) error is
going to be returned.*

*Note: Only tenant specific enabled and global endpoint templates are
returned as part of service catalog during scoped token validation
call.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

Marker value is not valid (not found in database).

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*Valid X-Auth-Token value is required.*

#### **Query String Values**

*'serviceName' value is optional.*

*'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")*

*marker is templateId value.*

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

#### Request and response schema,  XML Schema Definition

[Endpoint templates](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd)

No request body is required. The call returns a list of endpoint templates.

#### **Example(s)**

#### Endpoint Templates request with Auth Token for JSON and XML response.

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates?serviceName=Compute&limit=5 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443

HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=DFCFC378DE6320D5C411461BD518902F; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2286
Date: Tue, 01 May 2012 17:56:33 GMT

{
  "endpointTemplates" : {
    "anies" : null,
    "endpointTemplate" : [ {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "100",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-1.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    }, {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "110",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-2.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    }, {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "111",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-3.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    } ],
    "otherAttributes" : {
    }
  }
}
~~~

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates?limit=5 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443



HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=B982B0384A07FED4F9C0182501C7FFDF; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 2543
Date: Tue, 01 May 2012 17:54:24 GMT


<ns1:endpointTemplates xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:endpointTemplate id="100" type="compute" name="Compute" region="az-1.region-a.geo-1" publicURL="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-1.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="110" type="compute" name="Compute" region="az-2.region-a.geo-1" publicURL="https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-2.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="111" type="compute" name="Compute" region="az-3.region-a.geo-1" publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="120" type="object-store" name="Object Storage" region="region-a.geo-1" publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%" adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/" global="false" enabled="true" releaseState="public">
      <ns1:version id="1.0"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="130" type="identity" name="Identity" region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" internalURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" global="true" enabled="true" releaseState="public">
      <ns1:version id="2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/extension"/>
   </ns1:endpointTemplate>
</ns1:endpointTemplates>
~~~


#### Get Enabled Endpoint Templates

Verb

URI

Description

**GET**

**[iaas:HPKeystoneExtensionBaseURI]/endpointTemplates/enabled?serviceName={ServiceName}**

Get a list of enabled endpoint templates.

#### **Detailed Description**

Get a list of available endpoint templates. If serviceName is provided
in query, then endpoint templates specific to only that service are
included in response.  In case of incorrect service name ( does not
exist in system), empty list is returned. This list will to include only
enabled endpoint templates. The operation does not require a request
body.

This API supports pagination through 'limit' and 'marker' usage. Marker
is templateId and should be valid otherwise 404 (not found) error is
going to be returned.

*Note: Only tenant specific enabled and global endpoint templates are
returned as part of service catalog during scoped token validation
call.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

Marker value is not valid (not found in database).

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*Valid X-Auth-Token value is required.*

#### **Query String Values**

*'serviceName' value is optional.*

*'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")*

*marker is templateId value *

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

#### Request and response schema,  XML Schema Definition

[Endpoint templates](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd)

No request body is required. The call returns a list of enabled endpoint templates.

#### **Example(s)**

Endpoint Templates request with Auth Token for JSON and XML response.

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates/enabled?limit=4 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443


HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=AAB73BB788D3C4C074D29B7FDF0E5E86; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2905
Date: Tue, 01 May 2012 18:11:05 GMT

{
  "endpointTemplates" : {
    "anies" : null,
    "endpointTemplate" : [ {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "100",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-1.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    }, {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "110",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-2.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    }, {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "111",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-3.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    }, {
      "version" : {
        "id" : "1.0",
        "info" : null,
        "list" : null,
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/",
      "enabled" : true,
      "global" : false,
      "id" : "120",
      "internalURL" : null,
      "name" : "Object Storage",
      "otherAttributes" : {
      },
      "publicURL" : "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%",
      "publicURL2" : null,
      "region" : "region-a.geo-1",
      "releaseState" : "public",
      "type" : "object-store"
    } ],
    "otherAttributes" : {
    }
  }
}
~~~

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates/enabled?limit=4 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443

HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=D2D513368A8C87BB990F528CA809F59F; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 2099
Date: Tue, 01 May 2012 18:13:03 GMT

<ns1:endpointTemplates xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:endpointTemplate id="100" type="compute" name="Compute" region="az-1.region-a.geo-1" 
           publicURL="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
           publicURL2="https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
           adminURL="https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/" 
           global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-1.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="110" type="compute" name="Compute" region="az-2.region-a.geo-1" 
           publicURL="https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
           publicURL2="https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
           adminURL="https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/" 
           global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-2.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="111" type="compute" name="Compute" region="az-3.region-a.geo-1" 
           publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
           publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
           adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" 
           global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="120" type="object-store" name="Object Storage" region="region-a.geo-1" 
           publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%" 
           adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/" 
           global="false" enabled="true" releaseState="public">
      <ns1:version id="1.0"/>
   </ns1:endpointTemplate>
</ns1:endpointTemplates>
~~~

#### Get Endpoint Template By Id

Verb

URI

Description

**GET**

**[iaas:HPKeystoneExtensionBaseURI]/endpointTemplates/{endpointTemplateId}**

Get an endpoint template by Id

#### **Detailed Description**

*Get an endpoint template by endpointTemplateId. **The operation does
not require a request body.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

endpointTemplateId not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*Valid X-Auth-Token value is required.*

#### **Query String Values**

*No additional query string values required.*

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

#### Request and response schema,  XML Schema Definition

[Endpoint templates](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd)

No request body is required. The call returns the specified endpoint template.

#### **Example(s)**

An endpoint template request with Auth Token for JSON and XML response.\

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates/111 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443

HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=26457FB26BD6F8EB5D0214BEF521B01A; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 705
Date: Tue, 01 May 2012 17:58:17 GMT

{
  "EndpointTemplate" : {
    "version" : {
      "id" : "1.1",
      "info" : null,
      "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
    "enabled" : true,
    "global" : false,
    "id" : "111",
    "internalURL" : null,
    "name" : "Compute",
    "otherAttributes" : {
    },
    "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
    "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
    "region" : "az-3.region-a.geo-1",
    "releaseState" : "public",
    "type" : "compute"
  }
}
~~~

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates/111 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443

HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=86F04EB5AE761FF0933F90844BF6441A; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 791
Date: Tue, 01 May 2012 17:59:00 GMT

<ns1:endpointTemplate id="111" type="compute" 
name="Compute" region="az-3.region-a.geo-1" 
publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" 
global="false" enabled="true" releaseState="public" 
xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
</ns1:endpointTemplate>
~~~

#### Add Endpoint Template

Verb

URI

Description

**POST**

**[iaas:HPKeystoneExtensionBaseURI]/endpointTemplates**

Add new endpoint template data

#### **Detailed Description**

Adds new endpoint template data. Endpoint template data is provided in
POST request body. Service name ('name' attribute) and region is
required in EndpointTemplate. Input 'id' needs to be unique value in the
system. 

Name (service name) and region combination needs to be unique in
system.
 Service with given name should already be registered with system
otherwise related error is returned back. Similarly type (service type)
should have a valid system-recognized (pre-defined) value.
 Release state attribute if not provided in input data, then its value
is derived from related registered service. If provided, then value
should have a valid system-recognized (pre-defined) value.

If enabled and global flag values are not provided in input data, system
uses 'true' and 'false' as its default value respectively. 

Region code is not marked as required in current implementation but
should be provided.  The format of region code is
 [csbu:az-number].[csbu:region-alpha].[csbu:geo-number]   So, and
example would be: az-1.region-a.geo-1

*Note: Only tenant specific enabled and global endpoint templates are
returned as part of service catalog during scoped token validation
call.*

#### **Normal Response Codes**

**201 **(Created)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

endpointTemplateId not found.

**409** (Conflict)

Another template exists for given service name and region
 Another template already exists for given template id.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*Valid X-Auth-Token value is required.*

#### **Query String Values**

None.

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

#### Request and response schema,  XML Schema Definition

[Endpoint templates](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd)

#### **Normal Response Codes**

**201 **(Created)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

endpointTemplateId not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

Request body includes the new endpoint template with required fields
defined.

Response body is the newly created template.

#### **Example(s)**

##### XML Request 

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 719

<ns1:endpointTemplate id="215" type="compute" 
name="Compute" region="az-3.region-a.geo-6" 
publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" 
global="false" enabled="true" xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
</ns1:endpointTemplate>
~~~

##### XML Response

~~~
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=30639D2AB6506F0C93DC6D4681AF069A; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 791
Date: Tue, 01 May 2012 18:01:52 GMT

<ns1:endpointTemplate id="215" type="compute" 
name="Compute" region="az-3.region-a.geo-6" 
publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" 
global="false" enabled="true" releaseState="public" 
xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
</ns1:endpointTemplate>
~~~

##### JSON Request 

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 704


  "EndpointTemplate" : {
    "version" : {
      "id" : "1.1",
      "info" : null,
      "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
    "enabled" : true,
    "global" : false,
    "id" : "216",
    "internalURL" : null,
    "name" : "Compute",
    "otherAttributes" : {
    },
    "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
    "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
    "region" : "az-3.region-a.geo-7",
    "releaseState" : "public",
    "type" : "compute"
  }
}
~~~

##### JSON Response 

~~~
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=A6E1D38BE03CE5F52B1C30D61DE88271; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 705
Date: Tue, 01 May 2012 18:06:19 GMT

{
  "EndpointTemplate" : {
    "version" : {
      "id" : "1.1",
      "info" : null,
      "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
    "enabled" : true,
    "global" : false,
    "id" : "216",
    "internalURL" : null,
    "name" : "Compute",
    "otherAttributes" : {
    },
    "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
    "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
    "region" : "az-3.region-a.geo-7",
    "releaseState" : "public",
    "type" : "compute"
  }
}
~~~

#### Update Endpoint Template

Verb

URI

Description

**PUT**

**[iaas:HPKeystoneExtensionBaseURI]/endpointTemplates/{endpointTemplateId}**

Updates existing endpoint template data

#### **Detailed Description**

*Updates existing endpoint template data. Endpoint template data is*
*provided in PUT request body. Id, service name and region are required
in EndpointTemplate**. Returns back is the updated endpoint template
data as the response body. If optional attributes values are not
provided or left blank, then it will overwrite existing attribute value,
with null or blank respectively, in system if there.*

*Name (service name) and region combination needs to be unique in
system. *
 *Service with given name should already be registered with system
otherwise related error is returned back. Similarly type (service type)
should have a valid system-recognized (pre-defined) value.*
 *Release state attribute if not provided in input data, then its value
is left unchnaged. If provided, then value should have a valid
system-recognized (pre-defined) value.*

*Template must exist in system otherwise returns 404 (item not found)
error.*

*If enabled and global flag values are not provided in input data,
system does not update its existing values for other fields, it will
update with null/blank if not provided. *

#### **Normal Response Codes**

**200 **(OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

endpointTemplateId not found.

**409** (Conflict)

Another template exists for given service name and region.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*Valid X-Auth-Token value is required.*

#### **Query String Values**

None.

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

#### Request and response schema,  XML Schema Definition

[Endpoint templates](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd)

Request body contains the endpoint template to be updated.

Response body is the updated endpoint template.

#### **Example(s)**

##### XML Request 

~~~
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates/130 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9c7424b0be3d7fd233fa60
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 536

<endpointTemplate id="130" type="identity" 
name="Identity" region="region-a.geo-1" 
publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
internalURL="hhttps://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
global="true" enabled="true" 
xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
     <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0" 
           list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
</endpointTemplate>
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=F40BD043DC35086A78BD2963A2FD5759; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 797
Date: Mon, 17 Oct 2011 18:36:40 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<endpointTemplate xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns5="http://www.w3.org/2005/Atom" 
id="130" type="identity" name="Identity" 
region="region-a.geo-1" 
publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
internalURL="hhttps://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
global="true" enabled="true" releaseState="public">
  <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0"
         list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
</endpointTemplate>
~~~

##### JSON Request 

~~~
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates/111 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Content-Length: 704
Host: localhost:8443


  "EndpointTemplate" : {
    "version" : {
      "id" : "1.1",
      "info" : null,
      "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
    "enabled" : true,
    "global" : false,
    "id" : "111",
    "internalURL" : null,
    "name" : "Compute",
    "otherAttributes" : {
    },
    "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
    "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
    "region" : "az-3.region-a.geo-1",
    "releaseState" : "public",
    "type" : "compute"
  }
}
~~~

##### JSON Response 

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=3EA75781EBE573B3E9EA8490E9E20BD0; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 705
Date: Tue, 01 May 2012 18:05:18 GMT

{
  "EndpointTemplate" : {
    "version" : {
      "id" : "1.1",
      "info" : null,
      "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
    "enabled" : true,
    "global" : false,
    "id" : "111",
    "internalURL" : null,
    "name" : "Compute",
    "otherAttributes" : {
    },
    "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
    "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
    "region" : "az-3.region-a.geo-1",
    "releaseState" : "public",
    "type" : "compute"
  }
}
~~~

#### Delete Endpoint Template

Verb

URI

Descripton

**DELETE**

**[iaas:HPKeystoneExtensionBaseURI]/endpointTemplates/{endpointTemplateId}**

Deletes an endpoint template

#### **Detailed Description**

*Deletes an endpoint template for the specified
endpointTemplateId** This will also remove all tenant association with
this template.*

*endpointTemplateId** ** is required otherwise 400 (bad request) is
returned.*

*If* *endpointTemplateId** **is not present in system, 404 (item not
found) error is returned.*

#### **Normal Response Codes**

**204 **(No Content)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

endpointTemplateId not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*Valid X-Auth-Token value is required.*

#### **Query String Values**

None.

#### **Request and Response Resource Representations**

*No content is expected in request and response body.*

#### Request and response schema,  XML Schema Definition

[Endpoint templates](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd)

#### **Example(s)**

~~~
DELETE https://localhost:8443//v2.0/HP-IDM/v1.0/endpointTemplates/1200 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443

HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 03 Aug 2011 19:59:03 GMT
~~~


#### Model Schema Information

XSD model used for endpoint operations is described in **token.xsd** and
**endpoints.xsd**. Currently its customized version of keystone schema
to handle multiple different definitions of elements. Elements in
conflict are defined as superset

Token.xsd: [http://keg.dev.uswest.hpcloud.net:8080/job/Control\_Services\_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd)  (includes
endpoint.xsd)
Endpoint.xsd: [http://keg.dev.uswest.hpcloud.net:8080/job/Control\_Services\_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/endpoints.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/endpoints.xsd)