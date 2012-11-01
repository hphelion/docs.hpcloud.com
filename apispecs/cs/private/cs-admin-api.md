---
layout: page
title:
title_section:
description:
group: apispec

---
{% include JB/setup %}


# 1. Overview

*Brief introduction and overview of the service and its intended use.*



## 1.1 API Maturity Level


**Maturity Level**: GA

**Version API Status**: CURRENT


---


# 2. Architecture View


## 2.1 Overview
*References to architectural details of the service.*

## 2.2 Conceptual/Logical Architecture View
*Describe the logical components of the system and their responsibilities*

## 2.3 Infrastructure Architecture View
*Describe how the API fits into the overall HPCS Infrastructure*

## 2.4 Entity Relationship Diagram
*Describe the relationships between the various entities (resources) involved in the API*


---

# 3. Account-level View
*Describe the relationship of the API with respect to the accounts, groups, tenants, regions, availability zones etc.*


# 4. REST API Specifications
*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*

## 4.1 Admin API Operations


**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseUri**: {Host}/v2.0

**HPKeystoneExtensionBaseURI**: {BaseUri}/HP-IDM/v1.0

**Admin URI**: N/A

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |
| Action | [Post Action](#post_action) | POST | [HPKeystoneExtensionBaseURI]/action/{action} | Y/Y | {Privilege Level} |
| Action | [Get Jobs By Account](#get_jobs_by_account) | GET | [HPKeystoneExtensionBaseURI]/job | Y/Y | {Privilege Level} |
| Action | [Get A Job Ticket](#get_a_job_ticket) | GET | [HPKeystoneExtensionBaseURI]/job/{ticketId} | Y/Y | {Privilege Level} |
| Action | [Restart A TIMEDOUT Job](#restart_a_timedout_job) | PUT | [HPKeystoneExtensionBaseURI]/job/{ticketId} | Y/Y | {Privilege Level} |
| Action | [Delete A Job](#delete_a_job) | PUT | [HPKeystoneExtensionBaseURI]/job/{ticketId} | Y/Y | {Privilege Level} |
| Action | [Get Error Jobs](#get_error_jobs) | GET | [HPKeystoneExtensionBaseURI]/job/error | Y/Y | {Privilege Level} |
| Action | [Get A Count Of Error Jobs](#get_a_count_of_error_jobs) | GET | [HPKeystoneExtensionBaseURI]/job/error/count | Y/Y | {Privilege Level} |
| Action | [Get Error Jobs By Category](#get_error_jobs_by_category) | GET | [HPKeystoneExtensionBaseURI]/job/error/{category} | Y/Y | {Privilege Level} |
| Action | [Delete Error Jobs By Category](#delete_error_jobs_by_category) | GET | [HPKeystoneExtensionBaseURI]/job/error/{category} | Y/Y | {Privilege Level} |
| Action | [Get Jobs By Status](#get_jobs_by_status) | GET | [HPKeystoneExtensionBaseURI]/job/status/{status} | Y/Y | {Privilege Level} |
| Action | [Get Job Count By Status](#get_job_count_by_status) | GET | [HPKeystoneExtensionBaseURI]/job/status/{status}/count | Y/Y | {Privilege Level} |
| Domains | [Check For Existence Of Domain Name](#check_for_existence_of_domain_name) | GET | [HPKeystoneExtensionBaseURI]/job/status/{status}/count | Y/Y | Anonymous |
| Domains | [Create A Domain](#create_a_domain) | GET | [HPKeystoneExtensionBaseURI]/domains  | Y/Y | System Adminstrator (SA) |
| Domains | [Delete A Domain](#delete_a_domain) | DELETE | [HPKeystoneExtensionBaseURI]/domains/{domainId}  | Y/Y | System Adminstrator (SA) |
| Domains | [Get A Domain](#get_a_domain) | GET | [HPKeystoneExtensionBaseURI]/domains/{domainId}  | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get All Domains](#get_all_domains) | GET | [HPKeystoneExtensionBaseURI]/domains | Y/Y | System Adminstrator (SA) |
| Domains | [Get Groups For A Domain](#get_groups_for_a_domain) | GET | [HPKeystoneExtensionBaseURI]/domains/{domainId}/groups | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Subscribe Able Services For A Domain](#get_subscribe_able_services_for_a_domain) | GET | [HPKeystoneExtensionBaseURI]/domains/{domainId}/subscribeableServices | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Service Activations For A Domain](#get_service_activations_for_a_domain) | GET | [HPKeystoneExtensionBaseURI]/domains/{domainId}/services | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Tenants For A Domain](#get_tenants_for_a_domain) | GET | [HPKeystoneExtensionBaseURI]/domains/{domainId}/tenants | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Users For A Domain](#get_users_for_a_domain) | GET | [HPKeystoneExtensionBaseURI]/domains/{domainId}/tenants | Y/Y | System Adminstrator (SA), Domain Admin (DA) |
| Domains | [List Role Definitions (Deprecated)](#list_role_definitions_(deprecated)) | GET | [HPKeystoneExtensionBaseURI]/domains/{domainId}/roles | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Transfer Ownership Of A Domain](#transfer_ownership_of_a_domain) | PUT | [HPKeystoneExtensionBaseURI]/domains/{domainId}/owner/{userId}	 | Y/Y | System Adminstrator (SA) |
| Endpoint Template | [{addendpointtemplate}](#{addendpointtemplate}) | PUT | [HPKeystoneExtensionBaseURI]/domains/{domainId} | Y/Y | {Privilege Level} |
| Endpoint Template | [{deleteendpointtemplate}](#{deleteendpointtemplate}) | PUT | [HPKeystoneExtensionBaseURI]/domains/{domainId} | Y/Y | {Privilege Level} |
| Endpoint Template | [{getenabledendpointtemplates}](#{getenabledendpointtemplates}) | PUT | [HPKeystoneExtensionBaseURI]/domains/{domainId} | Y/Y | {Privilege Level} |
| Endpoint Template | [{getendpointtemplatebyid}](#{getendpointtemplatebyid}) | PUT | [HPKeystoneExtensionBaseURI]/domains/{domainId} | Y/Y | {Privilege Level} |
| Endpoint Template | [{getendpointtemplates}](#{getendpointtemplates}) | PUT | [HPKeystoneExtensionBaseURI]/domains/{domainId} | Y/Y | {Privilege Level} |
| Endpoint Template | [{updateendpointtemplate}](#{updateendpointtemplate}) | PUT | [HPKeystoneExtensionBaseURI]/domains/{domainId} | Y/Y | {Privilege Level} |
| Group | [Add A User To A Group](#add_a_user_to_a_group) | PUT | [HPKeystoneExtensionBaseURI]/domains/{domainId} | Y/Y | SA, DA |
| Group | [Create A Group](#create_a_group) | POST | [HPKeystoneExtensionBaseURI]/groups | Y/Y | SA,DA |
| Group | [Delates A Group](#delates_a_group) | DELETE | [HPKeystoneExtensionBaseURI]/groups/{groupId} | Y/Y | SA ,DA |
| Group | [Get A Specific Group](#get_a_specific_group) | GET | [HPKeystoneExtensionBaseURI]/groups/{groupId} | Y/Y | SA,DA, DU  |
| Group | [List Users For The Group](#list_users_for_the_group) | GET | [HPKeystoneExtensionBaseURI]/groups/{groupId}/users | Y/Y | SA,DA |
| Group | [Delete User From The Group](#delete_user_from_the_group) | DELETE | [HPKeystoneExtensionBaseURI]/groups/{groupId}/users/{userId} | Y/Y | SA,DA |
| Group | [Update Group](#update_group) | PUT | [HPKeystoneExtensionBaseURI]/groups/{groupId} | Y/Y | SA, DA |
| Management Console | [User Details](#user_details) | GET | [HPKeystoneExtensionBaseURI]/users/details/{userId} | Y/Y | MC-CS Certificate |
| Management Console | [User Preferences](#user_preferences) | GET | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | MC-CS Certificate |
| Management Console | [User Preferences](#user_preferences) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | MC-CS Certificate |
| Region | [{getservicebyid}](#{getservicebyid}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Region | [{listregisteredservices}](#{listregisteredservices}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Region | [{registernewservice}](#{registernewservice}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Region | [{updateservice}](#{updateservice}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{checktenantroleassignmentforuser}](#{checktenantroleassignmentforuser}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{creategroupsglobalroleassignment}](#{creategroupsglobalroleassignment}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{createtenantroleassignmentforgroup}](#{createtenantroleassignmentforgroup}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{createtenantroleassignmentforuser}](#{createtenantroleassignmentforuser}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{createusersglobalroleassignment}](#{createusersglobalroleassignment}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{deletegroupsglobalroleassignment}](#{deletegroupsglobalroleassignment}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{deletetenantroleassignmentforgroup}](#{deletetenantroleassignmentforgroup}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{deletetenantroleassignmentforuser}](#{deletetenantroleassignmentforuser}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{deleteusersglobalroleassignment}](#{deleteusersglobalroleassignment}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{getnontenantrasdomain}](#{getnontenantrasdomain}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{getusersglobalrole}](#{getusersglobalrole}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{listgroupsglobalroles}](#{listgroupsglobalroles}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{listtenantroleassignment}](#{listtenantroleassignment}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{listtenantroleassignmentforgroup}](#{listtenantroleassignmentforgroup}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{listtenantroleassignmentforuser}](#{listtenantroleassignmentforuser}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Assignment | [{listusersglobalroles}](#{listusersglobalroles}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Defs | [{createroledef}](#{createroledef}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Defs | [{deleteroledef}](#{deleteroledef}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Defs | [{getdomainsroledefs}](#{getdomainsroledefs}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Defs | [{getroleadef}](#{getroleadef}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Defs | [{listroledefs}](#{listroledefs}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Defs | [{updateroledef}](#{updateroledef}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Role Defs | [{updateroledefscope}](#{updateroledefscope}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Service | [{getservicebyid}](#{getservicebyid}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Service | [{listregisteredservices}](#{listregisteredservices}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Service | [{registernewservice}](#{registernewservice}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Service | [{updateservice}](#{updateservice}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Signature | [{ec2signature}](#{ec2signature}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Signature | [{genericsignature}](#{genericsignature}) | PUT | [HPKeystoneExtensionBaseURI]/preferences/{userId} | Y/Y | {Privilege Level} |
| Tenant | [Get All Tenants](#get_all_tenants) | GET | [HPKeystoneExtensionBaseURI]/tenants | Y/Y | SA |
| Tenant | [Get A Tenant](#get_a_tenant) | GET | [HPKeystoneExtensionBaseURI]/tenants/{tenantId}  | Y/Y | SA, DA, DU |
| Tenant | [Check For Existence Of Tenant Name](#check_for_existence_of_tenant_name) | GET | [HPKeystoneExtensionBaseURI]/tenants/{tenantId}  | Y/Y | Anon |
| Tenant | [Get A List Of Users For A Tenant (includes Role Assignments)](#get_a_list_of_users_for_a_tenant_(includes_role_assignments)) | GET | [HPKeystoneExtensionBaseURI]/tenants/{tenantId}/users | Y/Y | SA, DA |
| Tenant | [Create A Tenant](#create_a_tenant) | POST | [HPKeystoneExtensionBaseURI]/tenants  | Y/Y | SA, DA |
| Tenant | [Update A Tenant](#update_a_tenant) | PUT | [HPKeystoneExtensionBaseURI]/tenants/{tenantID}  | Y/Y | SA, DA |
| Tenant | [Delete A Tenant](#delete_a_tenant) | DELETE | [HPKeystoneExtensionBaseURI]/tenants/{tenantId} | Y/Y | SA, DA |
| Tenant | [Get Endpoints For A Tenant](#get_endpoints_for_a_tenant) | GET | HPKeystoneExtensionBaseURI]/tenants/{tenantId}/endpoints | Y/Y | SA, DA, DU |
| Tenant | [Add Endpoint To A Tenant](#add_endpoint_to_a_tenant) | POST | HPKeystoneExtensionBaseURI]/tenants/{tenantId]}/endpoints | Y/Y | SA, DA |
| Tenant | [Remove Endpoints From A Tenant](#remove_endpoints_from_a_tenant) | DELETE | HPKeystoneExtensionBaseURI]/tenants/{tenantId}/endpoints/{endpointId} | Y/Y | DA, SA |
| Token | [Validate Token](#validate_token) | GET | [KeystoneBaseURI]/tokens/{tokenId} | Y/Y | Anon |
| Token | [Quick Token Validation](#quick_token_validation) | GET | [KeystoneBaseURI]/tokens/{tokenId} | Y/Y | Anon |
| Token | [Refresh Token](#refresh_token) | GET | [KeystoneBaseURI]/tokens/{tokenId} | Y/Y | SS |
| Users | [List Users](#list_users) | GET | [HPKeystoneExtensionBaseURI]/users | Y/Y | SA, DA, SS |
| Users | [Get A User](#get_a_user) | GET | [HPKeystoneExtensionBaseURI]/users/{userId}  | Y/Y | SA, DA, SS |
| Users | [Check For Existence Of User](#check_for_existence_of_user) | GET | [HPKeystoneExtensionBaseURI]/users/{userId}  | Y/Y | Anon |
| Users | [Create A New User](#create_a_new_user) | POST | [HPKeystoneExtensionBaseURI/users | Y/Y | SA, DA, SR |
| Users | [Delete A User](#delete_a_user) | DELETE | [HPKeystoneExtensionBaseURI]/users/{userId} | Y/Y | SA, DA |
| Users | [Get All Groups For A User](#get_all_groups_for_a_user) | GET | [HPKeystoneExtensionBaseURI]/users/{userId}/groups | Y/Y | SA, DA, SS |
| Users | [Update Password For A User](#update_password_for_a_user) | PUT | [HPKeystoneExtensionBaseURI]/users/{userId}/password | Y/Y | SA, DA, SS |
| Users | [Initial Password Reset](#initial_password_reset) | POST | [HPKeystoneExtensionBaseURI]/users/password/reset | Y/Y | SA, DA, Anon |
| Users | [Validate Password ResetId And Update Password](#validate_password_resetid_and_update_password) | PUT | [HPKeystoneExtensionBaseURI]/users/password/reset/{resetId} | Y/Y | Anon |
| Users | [List A User's Non Tenant Role Assignments](#list_a_users_non_tenant_role_assignments) | GET | [HPKeystoneExtensionBaseURI]/users/{userId}/username}/roles | Y/Y | SA, DA, DU |
| Users | [Check User's Non Tenant Role Assignment](#check_users_non_tenant_role_assignment) | GET | [HPKeystoneExtensionBaseURI]/users/{userId}/username}/roles | Y/Y | SA, DA, DU |
| Users | [Create A User's Non Tenant Role Assignment](#create_a_users_non_tenant_role_assignment) | PUT | [HPKeystoneExtensionBaseURI]/users/{userId}/roles/{roleId} | Y/Y | SA, DA |
| Users | [Delete A User's Non Tenant Role Assignment](#delete_a_users_non_tenant_role_assignment) | DELETE | [HPKeystoneExtensionBaseURI]/users/{userId}/roles/{roleId} | Y/Y | SA, DA |
| User Access Key | [{createaccesskey}](#{createaccesskey}) | DELETE | [HPKeystoneExtensionBaseURI]/users/{userId}/roles/{roleId} | Y/Y | {Privilege Level} |
| User Access Key | [{deleteaccesskey}](#{deleteaccesskey}) | DELETE | [HPKeystoneExtensionBaseURI]/users/{userId}/roles/{roleId} | Y/Y | {Privilege Level} |
| User Access Key | [{getaccesskey}](#{getaccesskey}) | DELETE | [HPKeystoneExtensionBaseURI]/users/{userId}/roles/{roleId} | Y/Y | {Privilege Level} |
| User Access Key | [{importaccesskey}](#{importaccesskey}) | DELETE | [HPKeystoneExtensionBaseURI]/users/{userId}/roles/{roleId} | Y/Y | {Privilege Level} |
| User Access Key | [{updateaccesskey}](#{updateaccesskey}) | DELETE | [HPKeystoneExtensionBaseURI]/users/{userId}/roles/{roleId} | Y/Y | {Privilege Level} |
| User Certificate | [Delete User Certificate](#delete_user_certificate) | DELETE | [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} 	D | Y/Y | SA, DA, SS |
| User Certificate | [Get User Certificate](#get_user_certificate) | GET | [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} | Y/Y | SA, DA, SS |
| User Certificate | [Create A User Certificate](#create_a_user_certificate) | POST | [HPKeystoneExtensionBaseURI]/certificates | Y/Y | SA, DA, SS |
| User Certificate | [Import User Certificate(s)](#import_user_certificate(s)) | PUT | [HPKeystoneExtensionBaseURI]/certificates | Y/Y | SA, DA, SS |
| User Certificate | [Update User Certificate](#update_user_certificate) | PUT | [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} 	 | Y/Y | SA,DA,SS |
| User Key Pair | [{createkeypair}](#{createkeypair}) | PUT | [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} 	 | Y/Y | {Privilege Level} |
| User Key Pair | [{deletekeypair}](#{deletekeypair}) | PUT | [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} 	 | Y/Y | {Privilege Level} |
| User Key Pair | [{getkeypair}](#{getkeypair}) | PUT | [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} 	 | Y/Y | {Privilege Level} |
| User Key Pair | [{getkeypairs}](#{getkeypairs}) | PUT | [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} 	 | Y/Y | {Privilege Level} |
| User Key Pair | [{importkeypair}](#{importkeypair}) | PUT | [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} 	 | Y/Y | {Privilege Level} |
| User Key Pair | [{updatekeypair}](#{updatekeypair}) | PUT | [HPKeystoneExtensionBaseURI]/certificates/{issuerName}/{serialNumber} 	 | Y/Y | {Privilege Level} |

## 4.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

## 4.3 Common Response Headers
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *

## 4.4 Admin API Operation Details
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*


### 4.4.1 Action

This page contains information about the 8 available Action Service REST APIs.

    Post Action
    Get Jobs by Account
    Get A Job
    Restart Timed-Out Job
    Delete a Job
    Get Error Jobs
    Get a Count of Error Jobs
    Get Error Jobs by Category
    Delete Error Jobs by Category
    Get Jobs by Status
    Get Job Count by Status

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.1.1 <a id="post_action"></a>Post Action####
#### POST [HPKeystoneExtensionBaseURI]/action/{action}
Privilege Level: {Privilege Level}*

Submit an action to be executed. Each action takes a specific set of execution parameters within the content of the Post. (For an exact list of parameters for each Action, click the link below.) In the absence of any query parameters, the Action will be submitted and the call will immediately return a Job Ticket. The Job Ticket contains information about the executing Job, and can be refreshed through the job API call.
An Action request may contain the timeOut query parameter that is set to a non-zero positive value. The value indicates that the request should wait at least the given length of time for the Action to complete - either successfully or due to error. If the Action does not complete with the time period then the job is cancelled and any completed action steps will be rolled back.

**Request Data**

See documentation of the multifarious actions that can be posted at the Available Actions page.   Examples below are illustrative only.

**URL Parameters**

* *{action}* - String - The action for which to create a job ticket
* *{timeout}* - Long - The timeout.  Without the timeout specified the returned JobTicket would have a state of PENDING instead of COMPLETE

**Data Parameters**

The parameters are dependent on the action being posted.  See documentation under Available Actions.

JSON

```
POST https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/action/updateDomain?timeOut=60000 HTTP/1.1
X-Auth-Token: HPAuth_4e89f121318cd70066d68c2e
Date: Mon, 3 Oct 2011 11:30:10 -0600
Content-Type: application/json
User-Agent: Maxwell/Smart
Host: Pat Sajak
 
{"JobTicket": {"actionParams":{"status": "SUSPENDED_3", "domainId": "92636548281306"}}}
```

**Success Response**

**Status Code**

201 (Created)

**Response Data**

Examples below are illustrative only.  Actual results will depend on the action being posted - see documentation under Available Actions.

JSON

```
{
  "JobTicket" : {
    "action" : "UpdateDomain",
    "actionParams" : {
    },
    "actionResults" : {
      "SALESFORCE_ACCOUNT" : "001Q000000Yg8SJIAZ",
      "UMS_DOMAIN" : "92636548281306"
    },
    "completion" : "2012-10-30T16:18:03.145Z",
    "errorCategory" : "",
    "errorDescription" : "",
    "status" : "COMPLETE",
    "stepStatus" : {
      "UpdateKmsDomain" : "COMPLETE",
      "UpdateZuoraAccount" : "COMPLETE",
      "UpdateServicesForDomain" : "COMPLETE",
      "UpdateSalesforceAccount" : "COMPLETE",
      "UpdateUmsDomain" : "COMPLETE"
    },
    "submission" : "2012-10-30T16:18:01.140Z",
    "ticketId" : "508ffdb9e4b0c294a11da454"
  }
}
```


**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X POST -H 'User-Agent: Jakarta Commons-HttpClient/3.1' -H 'Content-Type: application/json' --cert <cert-path> --cacert <ca-cert-path> --data '{"JobTicket": {"actionParams":{"status": "SUSPENDED_3", "domainId": "92636548281306"}}}' -H 'X-Auth-Token: <auth-token>' [HPKeystoneExtensionBaseURI]/action/UpdateDomain?timeOut=20000
```

#### 4.4.1.2 <a id="get_jobs_by_account"></a>Get Jobs By Account####
#### GET [HPKeystoneExtensionBaseURI]/job
*Privilege Level: {Privilege Level}*

Return a list of all Job Tickets submitted by the specified Account ID. 

When an Action is submitted it is not executed immediately. Instead, the Action request parameters are stored in the database within an instance of JobTicket. A JobTicket contains all of the request parameters, and also includes submission date and execution status. (Note that old JobTickets are periodically purged from the system after a configurable length of time.)

**Request Data**

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *accountId* - Long - The UMS User Id for the account

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "TicketList" : {
    "Tickets" : [ {
      "action" : "UpdateUser",
      "actionParams" : {
      },
      "actionResults" : {
        "mailToOldAddress" : "dkennedy@hp.com",
        "accountId" : "60809900579962",
        "mailToNewAddress" : "david.kennedy@hp.com",
        "SALESFORCE_CONTACT" : "003Q000000a25LNIAY",
        "emailed" : "EMAIL_UPDATED_EMAIL_ID:dkennedy@hp.com,EMAIL_UPDATED_EMAIL_ID:david.kennedy@hp.com"
      },
      "completion" : "2012-10-30T10:19:44.435Z",
      "errorCategory" : "",
      "errorDescription" : "",
      "status" : "COMPLETE",
      "stepStatus" : {
        "UpdateZuoraContact" : "COMPLETE",
        "SendEmailUpdateEmails" : "COMPLETE",
        "UpdateSalesforceContact" : "COMPLETE",
        "UpdateUmsUser" : "COMPLETE",
        "UpdateKmsUser" : "COMPLETE"
      },
      "submission" : "2012-10-30T10:19:40.590Z",
      "ticketId" : "508fa9bce4b0c294a11da398"
    } ]
  }
}
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
curl -k -s -S --connect-timeout 2 --noproxy 127.0.0.1,localhost,hpcloud.net -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job?accountId=60809900579962
```

#### 4.4.1.3 <a id="get_a_job_ticket"></a>Get A Job Ticket####
#### GET [HPKeystoneExtensionBaseURI]/job/{ticketId}
*Privilege Level: {Privilege Level}*

This call will return the specified Job Ticket, and will optionally block the caller until the Job Ticket is marked as complete.

This request accepts a query parameter, "timeOut", that specifies the length of time in milliseconds to wait until the given Job Ticket is marked as complete. If the "timeOut" query parameter is not present or is set to zero then the call will return immediately with the current state of the Action Job.

**Request Data**

**URL Parameters**

* *ticketId* - 24 digit hex - The id of the ticket to be retrieved.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "JobTicket" : {
    "action" : "ActivateService",
    "actionError" : {
      "category" : "PROVISIONING",
      "httpErrorCode" : 404,
      "message" : "Registered Service [ComputeERROR] not found.",
      "retryable" : false,
      "stackTrace" : [ {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
        "fileName" : "ActionStepBase.java",
        "lineNumber" : 548,
        "methodName" : "validateZuoraProduct"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
        "fileName" : "ActionStepBase.java",
        "lineNumber" : 517,
        "methodName" : "loadProduct"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription",
        "fileName" : "CreateZuoraSubscription.java",
        "lineNumber" : 24,
        "methodName" : "initializeAndValidate"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
        "fileName" : "ActionBase.java",
        "lineNumber" : 361,
        "methodName" : "executeAction"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
        "fileName" : "ActivateService.java",
        "lineNumber" : 46,
        "methodName" : "executeAction_aroundBody0"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
        "fileName" : "ActivateService.java",
        "lineNumber" : 45,
        "methodName" : "executeAction"
      }, {
        "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
        "fileName" : "ActionBase.java",
        "lineNumber" : 325,
        "methodName" : "run"
      }, {
        "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
        "fileName" : "ThreadPoolExecutor.java",
        "lineNumber" : 886,
        "methodName" : "runTask"
      }, {
        "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
        "fileName" : "ThreadPoolExecutor.java",
        "lineNumber" : 908,
        "methodName" : "run"
      }, {
        "declaringClass" : "java.lang.Thread",
        "fileName" : "Thread.java",
        "lineNumber" : 662,
        "methodName" : "run"
      } ]
    },
    "actionParams" : {
    },
    "actionResults" : {
    },
    "completion" : "2012-10-29T09:57:58.552Z",
    "errorCategory" : "PROVISIONING",
    "errorDescription" : "Registered Service [ComputeERROR] not found.",
    "status" : "ERROR",
    "stepStatus" : {
      "CreateZuoraSubscription" : "PENDING",
      "ProvisionService" : "PENDING",
      "FindOrCreateUmsTenant" : "PENDING"
    },
    "submission" : "2012-10-29T09:57:57.082Z",
    "ticketId" : "508e5325e4b02ace8d0d20e6"
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<JobTicket>
	<actionParams />
	<stepStatus>
		<entry>
			<key>CreateZuoraSubscription</key>
			<value>PENDING</value>
		</entry>
		<entry>
			<key>ProvisionService</key>
			<value>PENDING</value>
		</entry>
		<entry>
			<key>FindOrCreateUmsTenant</key>
			<value>PENDING</value>
		</entry>
	</stepStatus>
	<actionResults />
	<action>ActivateService</action>
	<actionError>
		<category>PROVISIONING</category>
		<httpErrorCode>404</httpErrorCode>
		<message>Registered Service [ComputeERROR] not found.</message>
		<retryable>false</retryable>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
			</declaringClass>
			<fileName>ActionStepBase.java</fileName>
			<lineNumber>548</lineNumber>
			<methodName>validateZuoraProduct</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
			</declaringClass>
			<fileName>ActionStepBase.java</fileName>
			<lineNumber>517</lineNumber>
			<methodName>loadProduct</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription
			</declaringClass>
			<fileName>CreateZuoraSubscription.java</fileName>
			<lineNumber>24</lineNumber>
			<methodName>initializeAndValidate</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
			</declaringClass>
			<fileName>ActionBase.java</fileName>
			<lineNumber>361</lineNumber>
			<methodName>executeAction</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
			</declaringClass>
			<fileName>ActivateService.java</fileName>
			<lineNumber>46</lineNumber>
			<methodName>executeAction_aroundBody0</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
			</declaringClass>
			<fileName>ActivateService.java</fileName>
			<lineNumber>45</lineNumber>
			<methodName>executeAction</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
			</declaringClass>
			<fileName>ActionBase.java</fileName>
			<lineNumber>325</lineNumber>
			<methodName>run</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
			</declaringClass>
			<fileName>ThreadPoolExecutor.java</fileName>
			<lineNumber>886</lineNumber>
			<methodName>runTask</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
			</declaringClass>
			<fileName>ThreadPoolExecutor.java</fileName>
			<lineNumber>908</lineNumber>
			<methodName>run</methodName>
		</stackTrace>
		<stackTrace>
			<declaringClass>java.lang.Thread</declaringClass>
			<fileName>Thread.java</fileName>
			<lineNumber>662</lineNumber>
			<methodName>run</methodName>
		</stackTrace>
	</actionError>
	<completion>2012-10-29T09:57:58.552Z</completion>
	<errorCategory>PROVISIONING</errorCategory>
	<errorDescription>Registered Service [ComputeERROR] not found.
	</errorDescription>
	<status>ERROR</status>
	<submission>2012-10-29T09:57:57.082Z</submission>
	<ticketId>508e5325e4b02ace8d0d20e6</ticketId>
</JobTicket>
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/{ticketId}
```

#### 4.4.1.4 <a id="restart_a_timedout_job"></a>Restart A TIMEDOUT Job####
#### PUT [HPKeystoneExtensionBaseURI]/job/{ticketId}
*Privilege Level: {Privilege Level}*

Some Actions contain Steps that are retryable. Examples are calls to Zuora or Salesforce, which might fail due to internet connectivity issues. These steps contain a retry count the determines how many times they should re-attempt execution. Once all retries have been used up the Step and the Action are tagged with the TIMEDOUT status.

This API resets an Action and its Steps from TIMEDOUT to RETRY. This will cause the job to be executed again.

**Request Data**

**URL Parameters**

* *{ticketId}* - 24 digit hex - The id of the ticket to be retrieved.

**Data Parameters**

This call does not require a request body.

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
Content-Length: 508
Date: Thu, 06 Oct 2011 16:38:15 GMT
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
curl -k -s -S --connect-timeout 2 --noproxy 127.0.0.1,localhost,hpcloud.net -m 30 -X PUT -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: HPAuth_07ea10efcbcd4a16441f45c7b4bc7aad0a657688576ec67a55ee6e2f00eea8b8" [HPKeystoneExtensionBaseURI]/job/508fa9bce4b0c294a11da398
```

#### 4.4.1.5 <a id="delete_a_job"></a>Delete A Job####
#### DELETE HPKeystoneExtensionBaseURI/job/{ticketId}
*Privilege Level: {Privilege Level}*

This API call deletes a specified Job Ticket.

Job Tickets for Actions which complete successfully are eventually removed from the system. But Actions which fail must have their Job Tickets manually deleted using this API call.

**Request Data**

```
DELETE https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/4e8c7849318cf2e142e76ef4 HTTP/1.1
X-Auth-Token: HPAuth_4e8c7849318cf2e142e76ef1
Date: Wed, 5 Oct 2011 09:31:28 -0600
User-Agent: Maxwell/Smart
Host: Pat Sajak
```

**URL Parameters**

* *ticketId* - Long - The id of the ticket to be deleted

**Data Parameters**

This call does not require a request body.

**Success Response**

204 - OK

**Response Data**

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 05 Oct 2011 15:31:25 GMT
```

**Error Response**

400 (Bad Request)               Malformed request in URI or request body.
401 (Unauthorized)              The caller does not have the privilege required to perform the operation.
403 (Forbidden)                 Disabled or suspended user making the request.
500 (Internal Server Error)     The server encountered a problem while processing the request.
503 (Service Unavailable)       The server is unavailable to process the request.

**Curl Example**

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X DELETE -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/{ticketId}
```

#### 4.4.1.6 <a id="get_error_jobs"></a>Get Error Jobs####
#### GET [HPKeystoneExtensionBaseURI]/job/error
*Privilege Level: {Privilege Level}*

Return a list of all Job Tickets that are in the ERROR or CANCELLED state.

**Request Data**

This call requires no data.

**URL Parameters**

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "TicketList" : {
    "Tickets" : [ {
      "action" : "ActivateService",
      "actionError" : {
        "category" : "PROVISIONING",
        "httpErrorCode" : 404,
        "message" : "Registered Service [ComputeERROR] not found.",
        "retryable" : false,
        "stackTrace" : [ {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
          "fileName" : "ActionStepBase.java",
          "lineNumber" : 548,
          "methodName" : "validateZuoraProduct"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
          "fileName" : "ActionStepBase.java",
          "lineNumber" : 517,
          "methodName" : "loadProduct"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription",
          "fileName" : "CreateZuoraSubscription.java",
          "lineNumber" : 24,
          "methodName" : "initializeAndValidate"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 361,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
          "fileName" : "ActivateService.java",
          "lineNumber" : 46,
          "methodName" : "executeAction_aroundBody0"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
          "fileName" : "ActivateService.java",
          "lineNumber" : 45,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 325,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 886,
          "methodName" : "runTask"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 908,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.lang.Thread",
          "fileName" : "Thread.java",
          "lineNumber" : 662,
          "methodName" : "run"
        } ]
      },
      "actionParams" : {
      },
      "actionResults" : {
      },
      "completion" : "2012-10-29T09:57:58.552Z",
      "errorCategory" : "PROVISIONING",
      "errorDescription" : "Registered Service [ComputeERROR] not found.",
      "status" : "ERROR",
      "stepStatus" : {
        "CreateZuoraSubscription" : "PENDING",
        "ProvisionService" : "PENDING",
        "FindOrCreateUmsTenant" : "PENDING"
      },
      "submission" : "2012-10-29T09:57:57.082Z",
      "ticketId" : "508e5325e4b02ace8d0d20e6"
    }, {
      "action" : "ActivateService",
      "actionError" : {
        "category" : "PROVISIONING",
        "httpErrorCode" : 404,
        "message" : "Registered Service [ComputeERROR] not found.",
        "retryable" : false,
        "stackTrace" : [ {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
          "fileName" : "ActionStepBase.java",
          "lineNumber" : 548,
          "methodName" : "validateZuoraProduct"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
          "fileName" : "ActionStepBase.java",
          "lineNumber" : 517,
          "methodName" : "loadProduct"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription",
          "fileName" : "CreateZuoraSubscription.java",
          "lineNumber" : 24,
          "methodName" : "initializeAndValidate"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 361,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
          "fileName" : "ActivateService.java",
          "lineNumber" : 46,
          "methodName" : "executeAction_aroundBody0"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActivateService",
          "fileName" : "ActivateService.java",
          "lineNumber" : 45,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 325,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 886,
          "methodName" : "runTask"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 908,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.lang.Thread",
          "fileName" : "Thread.java",
          "lineNumber" : 662,
          "methodName" : "run"
        } ]
      },
      "actionParams" : {
      },
      "actionResults" : {
      },
      "completion" : "2012-10-29T10:00:14.231Z",
      "errorCategory" : "PROVISIONING",
      "errorDescription" : "Registered Service [ComputeERROR] not found.",
      "status" : "ERROR",
      "stepStatus" : {
        "CreateZuoraSubscription" : "PENDING",
        "ProvisionService" : "PENDING",
        "FindOrCreateUmsTenant" : "PENDING"
      },
      "submission" : "2012-10-29T10:00:12.917Z",
      "ticketId" : "508e53ace4b02ace8d0d20f7"
    } ]
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<TicketList>
	<Tickets>
		<actionParams />
		<stepStatus>
			<entry>
				<key>CreateZuoraSubscription</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>ProvisionService</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>FindOrCreateUmsTenant</key>
				<value>PENDING</value>
			</entry>
		</stepStatus>
		<actionResults />
		<action>ActivateService</action>
		<actionError>
			<category>PROVISIONING</category>
			<httpErrorCode>404</httpErrorCode>
			<message>Registered Service [ComputeERROR] not found.</message>
			<retryable>false</retryable>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
				</declaringClass>
				<fileName>ActionStepBase.java</fileName>
				<lineNumber>548</lineNumber>
				<methodName>validateZuoraProduct</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
				</declaringClass>
				<fileName>ActionStepBase.java</fileName>
				<lineNumber>517</lineNumber>
				<methodName>loadProduct</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription
				</declaringClass>
				<fileName>CreateZuoraSubscription.java</fileName>
				<lineNumber>24</lineNumber>
				<methodName>initializeAndValidate</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>361</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
				</declaringClass>
				<fileName>ActivateService.java</fileName>
				<lineNumber>46</lineNumber>
				<methodName>executeAction_aroundBody0</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
				</declaringClass>
				<fileName>ActivateService.java</fileName>
				<lineNumber>45</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>325</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>886</lineNumber>
				<methodName>runTask</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>908</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.lang.Thread</declaringClass>
				<fileName>Thread.java</fileName>
				<lineNumber>662</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
		</actionError>
		<completion>2012-10-29T09:57:58.552Z</completion>
		<errorCategory>PROVISIONING</errorCategory>
		<errorDescription>Registered Service [ComputeERROR] not found.
		</errorDescription>
		<status>ERROR</status>
		<submission>2012-10-29T09:57:57.082Z</submission>
		<ticketId>508e5325e4b02ace8d0d20e6</ticketId>
	</Tickets>
	<Tickets>
		<actionParams />
		<stepStatus>
			<entry>
				<key>CreateZuoraSubscription</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>ProvisionService</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>FindOrCreateUmsTenant</key>
				<value>PENDING</value>
			</entry>
		</stepStatus>
		<actionResults />
		<action>ActivateService</action>
		<actionError>
			<category>PROVISIONING</category>
			<httpErrorCode>404</httpErrorCode>
			<message>Registered Service [ComputeERROR] not found.</message>
			<retryable>false</retryable>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
				</declaringClass>
				<fileName>ActionStepBase.java</fileName>
				<lineNumber>548</lineNumber>
				<methodName>validateZuoraProduct</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
				</declaringClass>
				<fileName>ActionStepBase.java</fileName>
				<lineNumber>517</lineNumber>
				<methodName>loadProduct</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.zuora.CreateZuoraSubscription
				</declaringClass>
				<fileName>CreateZuoraSubscription.java</fileName>
				<lineNumber>24</lineNumber>
				<methodName>initializeAndValidate</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>361</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
				</declaringClass>
				<fileName>ActivateService.java</fileName>
				<lineNumber>46</lineNumber>
				<methodName>executeAction_aroundBody0</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActivateService
				</declaringClass>
				<fileName>ActivateService.java</fileName>
				<lineNumber>45</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>325</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>886</lineNumber>
				<methodName>runTask</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>908</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.lang.Thread</declaringClass>
				<fileName>Thread.java</fileName>
				<lineNumber>662</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
		</actionError>
		<completion>2012-10-29T10:00:14.231Z</completion>
		<errorCategory>PROVISIONING</errorCategory>
		<errorDescription>Registered Service [ComputeERROR] not found.
		</errorDescription>
		<status>ERROR</status>
		<submission>2012-10-29T10:00:12.917Z</submission>
		<ticketId>508e53ace4b02ace8d0d20f7</ticketId>
	</Tickets>
</TicketList>
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
curl -k -s -S --connect-timeout 2 --noproxy <proxy-excpetions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/error
```

#### 4.4.1.7 <a id="get_a_count_of_error_jobs"></a>Get A Count Of Error Jobs####
#### GET [HPKeystoneExtensionBaseURI]/job/error/count
*Privilege Level: {Privilege Level}*

Return a count of all error job tickets in the database. Error tickets have a status of either ERROR or TIMEDOUT.

**Request Data**

The call does not require any parameters.

**URL Parameters**

**Data Parameters**

This call does not require a request body.

**Success Response**

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: text/plain
Transfer-Encoding: chunked
Date: Thu, 06 Oct 2011 16:12:00 GMT
 
7
```

**Status Code**

200 - OK

**Response Data**

```
48
```

**Error Response**

400 (Bad Request)               Malformed request in URI or request body.
401 (Unauthorized)              The caller does not have the privilege required to perform the operation.
403 (Forbidden)                 Disabled or suspended user making the request.
500 (Internal Server Error)     The server encountered a problem while processing the request.
503 (Service Unavailable)       The server is unavailable to process the request.

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Curl Example**

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/error/count
```
#### 4.4.1.8 <a id="get_error_jobs_by_category"></a>Get Error Jobs By Category####
#### GET [HPKeystoneExtensionBaseURI]/job/error/{category}
*Privilege Level: {Privilege Level}*

Job Tickets that are in the ERROR state will have an Action Exception attached to them. Action Exceptions are categorize, and can be retrieved or delete in bulk by category. This API is used to retreive all ERROR action jobs whose Action Exceptions are of a specified category. The list of all categories is found on the Action Exception page.

**Request Data**

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *category* - String - The category of errors to get.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "TicketList" : {
    "Tickets" : [ {
      "action" : "EnterpriseUserEmailVerification",
      "actionError" : {
        "category" : "USER_INPUT",
        "httpErrorCode" : 400,
        "message" : "Missing required parameter [PASSWORD]",
        "retryable" : false,
        "stackTrace" : [ {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ums.ValidateEmailVerificationNonce",
          "fileName" : "ValidateEmailVerificationNonce.java",
          "lineNumber" : 36,
          "methodName" : "initializeAndValidate"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 361,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.EnterpriseUserEmailVerification",
          "fileName" : "EnterpriseUserEmailVerification.java",
          "lineNumber" : 76,
          "methodName" : "executeAction_aroundBody2"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.EnterpriseUserEmailVerification",
          "fileName" : "EnterpriseUserEmailVerification.java",
          "lineNumber" : 75,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 325,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 886,
          "methodName" : "runTask"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 908,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.lang.Thread",
          "fileName" : "Thread.java",
          "lineNumber" : 662,
          "methodName" : "run"
        } ]
      },
      "actionParams" : {
      },
      "actionResults" : {
      },
      "completion" : "2012-10-29T14:21:10.641Z",
      "errorCategory" : "USER_INPUT",
      "errorDescription" : "Missing required parameter [PASSWORD]",
      "status" : "ERROR",
      "stepStatus" : {
        "ActivateUmsUser" : "PENDING",
        "UpdateSalesforceContact" : "PENDING",
        "ValidateEmailVerificationNonce" : "PENDING",
        "SendWelcomeEmail" : "PENDING",
        "UpdateKmsUser" : "PENDING"
      },
      "submission" : "2012-10-29T14:21:10.621Z",
      "ticketId" : "508e90d6e4b02ace8d0d2525"
    }, {
      "action" : "ForgotPasswordReset",
      "actionError" : {
        "category" : "USER_INPUT",
        "httpErrorCode" : 403,
        "message" : "domain is in state: SUSPENDED_3",
        "retryable" : false,
        "stackTrace" : [ {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser",
          "fileName" : "ForgotPasswordResetOnUmsUser.java",
          "lineNumber" : 56,
          "methodName" : "checkOperationPermitted"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser",
          "fileName" : "ForgotPasswordResetOnUmsUser.java",
          "lineNumber" : 29,
          "methodName" : "doExecuteStep_aroundBody0"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser",
          "fileName" : "ForgotPasswordResetOnUmsUser.java",
          "lineNumber" : 26,
          "methodName" : "doExecuteStep"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase",
          "fileName" : "ActionStepBase.java",
          "lineNumber" : 179,
          "methodName" : "executeStep"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 383,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ForgotPasswordReset",
          "fileName" : "ForgotPasswordReset.java",
          "lineNumber" : 45,
          "methodName" : "executeAction_aroundBody0"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ForgotPasswordReset",
          "fileName" : "ForgotPasswordReset.java",
          "lineNumber" : 44,
          "methodName" : "executeAction"
        }, {
          "declaringClass" : "com.hp.csbu.cc.action.impl.actions.ActionBase",
          "fileName" : "ActionBase.java",
          "lineNumber" : 325,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 886,
          "methodName" : "runTask"
        }, {
          "declaringClass" : "java.util.concurrent.ThreadPoolExecutor$Worker",
          "fileName" : "ThreadPoolExecutor.java",
          "lineNumber" : 908,
          "methodName" : "run"
        }, {
          "declaringClass" : "java.lang.Thread",
          "fileName" : "Thread.java",
          "lineNumber" : 662,
          "methodName" : "run"
        } ]
      },
      "actionParams" : {
      },
      "actionResults" : {
      },
      "completion" : "2012-10-29T14:22:09.475Z",
      "errorCategory" : "USER_INPUT",
      "errorDescription" : "domain is in state: SUSPENDED_3",
      "status" : "ERROR",
      "stepStatus" : {
        "ForgotPasswordResetOnUmsUser" : "ERROR",
        "SendForgotPasswordResetEmail" : "PENDING"
      },
      "submission" : "2012-10-29T14:22:09.239Z",
      "ticketId" : "508e9111e4b02ace8d0d258b"
    } ]
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<TicketList>
	<Tickets>
		<actionParams />
		<stepStatus>
			<entry>
				<key>ActivateUmsUser</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>UpdateSalesforceContact</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>ValidateEmailVerificationNonce</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>SendWelcomeEmail</key>
				<value>PENDING</value>
			</entry>
			<entry>
				<key>UpdateKmsUser</key>
				<value>PENDING</value>
			</entry>
		</stepStatus>
		<actionResults />
		<action>EnterpriseUserEmailVerification</action>
		<actionError>
			<category>USER_INPUT</category>
			<httpErrorCode>400</httpErrorCode>
			<message>Missing required parameter [PASSWORD]</message>
			<retryable>false</retryable>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ums.ValidateEmailVerificationNonce
				</declaringClass>
				<fileName>ValidateEmailVerificationNonce.java</fileName>
				<lineNumber>36</lineNumber>
				<methodName>initializeAndValidate</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>361</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.EnterpriseUserEmailVerification
				</declaringClass>
				<fileName>EnterpriseUserEmailVerification.java</fileName>
				<lineNumber>76</lineNumber>
				<methodName>executeAction_aroundBody2</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.EnterpriseUserEmailVerification
				</declaringClass>
				<fileName>EnterpriseUserEmailVerification.java</fileName>
				<lineNumber>75</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>325</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>886</lineNumber>
				<methodName>runTask</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>908</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.lang.Thread</declaringClass>
				<fileName>Thread.java</fileName>
				<lineNumber>662</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
		</actionError>
		<completion>2012-10-29T14:21:10.641Z</completion>
		<errorCategory>USER_INPUT</errorCategory>
		<errorDescription>Missing required parameter [PASSWORD]
		</errorDescription>
		<status>ERROR</status>
		<submission>2012-10-29T14:21:10.621Z</submission>
		<ticketId>508e90d6e4b02ace8d0d2525</ticketId>
	</Tickets>
	<Tickets>
		<actionParams />
		<stepStatus>
			<entry>
				<key>ForgotPasswordResetOnUmsUser</key>
				<value>ERROR</value>
			</entry>
			<entry>
				<key>SendForgotPasswordResetEmail</key>
				<value>PENDING</value>
			</entry>
		</stepStatus>
		<actionResults />
		<action>ForgotPasswordReset</action>
		<actionError>
			<category>USER_INPUT</category>
			<httpErrorCode>403</httpErrorCode>
			<message>domain is in state: SUSPENDED_3</message>
			<retryable>false</retryable>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser
				</declaringClass>
				<fileName>ForgotPasswordResetOnUmsUser.java</fileName>
				<lineNumber>56</lineNumber>
				<methodName>checkOperationPermitted</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser
				</declaringClass>
				<fileName>ForgotPasswordResetOnUmsUser.java</fileName>
				<lineNumber>29</lineNumber>
				<methodName>doExecuteStep_aroundBody0</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ums.ForgotPasswordResetOnUmsUser
				</declaringClass>
				<fileName>ForgotPasswordResetOnUmsUser.java</fileName>
				<lineNumber>26</lineNumber>
				<methodName>doExecuteStep</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.steps.ActionStepBase
				</declaringClass>
				<fileName>ActionStepBase.java</fileName>
				<lineNumber>179</lineNumber>
				<methodName>executeStep</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>383</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ForgotPasswordReset
				</declaringClass>
				<fileName>ForgotPasswordReset.java</fileName>
				<lineNumber>45</lineNumber>
				<methodName>executeAction_aroundBody0</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ForgotPasswordReset
				</declaringClass>
				<fileName>ForgotPasswordReset.java</fileName>
				<lineNumber>44</lineNumber>
				<methodName>executeAction</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>com.hp.csbu.cc.action.impl.actions.ActionBase
				</declaringClass>
				<fileName>ActionBase.java</fileName>
				<lineNumber>325</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>886</lineNumber>
				<methodName>runTask</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.util.concurrent.ThreadPoolExecutor$Worker
				</declaringClass>
				<fileName>ThreadPoolExecutor.java</fileName>
				<lineNumber>908</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
			<stackTrace>
				<declaringClass>java.lang.Thread</declaringClass>
				<fileName>Thread.java</fileName>
				<lineNumber>662</lineNumber>
				<methodName>run</methodName>
			</stackTrace>
		</actionError>
		<completion>2012-10-29T14:22:09.475Z</completion>
		<errorCategory>USER_INPUT</errorCategory>
		<errorDescription>domain is in state: SUSPENDED_3</errorDescription>
		<status>ERROR</status>
		<submission>2012-10-29T14:22:09.239Z</submission>
		<ticketId>508e9111e4b02ace8d0d258b</ticketId>
	</Tickets>
</TicketList>
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
curl -k -s -S --connect-timeout 2 --noproxy <proxy-excpetions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/error/USER_INPUT
```

#### 4.4.1.9 <a id="delete_error_jobs_by_category"></a>Delete Error Jobs By Category####
#### DELETE HPKeystoneExtensionBaseURI/job/error/{category}
*Privilege Level: {Privilege Level}*

Job Tickets that are in the ERROR state will have an Action Exception attached to them. Action Exceptions are categorized, and can be retrieved or delete in bulk by category. This API is used to delete all ERROR action jobs whose Action Exceptions are of a specified category. The list of all categories is found on the Action Exception page.

**Request Data**

```
DELETE https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/USER_INPUT HTTP/1.1
X-Auth-Token: HPAuth_4e8c7849318cf2e142e76ef1
Date: Wed, 5 Oct 2011 09:31:28 -0600
User-Agent: Maxwell/Smart
Host: Pat Sajak
```

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{category}* - String - See the action exception page.

**Data Parameters**

This call does not require a request body.

**Success Response**

204 - OK

**Response Data**


**Error Response**

* 400 (Bad Request) 		Malformed request in URI or request body.
* 401 (Unauthorized)		The caller does not have the privilege required to perform the operation.
* 403 (Forbidden)		Disabled or suspended user making the request.
* 500 (Internal Server Error) 	The server encountered a problem while processing the request.
* 503 (Service Unavailable)	The server is unavailable to process the request.

**Response Data**

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 05 Oct 2011 15:31:25 GMT
```

**Curl Example**

```
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

#### 4.4.1.10 <a id="get_jobs_by_status"></a>Get Jobs By Status####
#### GET [HPKeystoneExtensionBaseURI]/job/status/{status}
*Privilege Level: {Privilege Level}*

Return all Job Tickets from the database which have the given status value. The Action Page provides a list of all possible status values.

**Request Data**

**URL Parameters**

* *{status}* - Job status - 
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{
  "TicketList" : {
    "Tickets" : [ {
      "action" : "UserNameRecovery",
      "actionParams" : {
      },
      "actionResults" : {
        "emailed" : "USERNAME_RECOVERY_EMAIL_ID:dkennedy@hp.com"
      },
      "completion" : "2012-10-30T08:45:52.842Z",
      "errorCategory" : "",
      "errorDescription" : "",
      "status" : "COMPLETE",
      "stepStatus" : {
        "SendUserNameRecoveryEmail" : "COMPLETE"
      },
      "submission" : "2012-10-29T17:28:53.089Z",
      "ticketId" : "508ebcd52cdc77bc0f3990bd"
    }, {
      "action" : "SelfRegistration",
      "actionParams" : {
      },
      "actionResults" : {
        "SALESFORCE_ACCOUNT" : "001Q000000Yg7gWIAR",
        "KMS_TENANT" : "28117301830361",
        "SALESFORCE_CONTACT" : "003Q000000a25LNIAY",
        "UMS_USER" : "60809900579962",
        "ZUORA_DOMAIN_ACCOUNT" : "2c92c0f93aaaf209013ab12f47ce1720",
        "emailed" : "WELCOME_TO_CLOUD_EMAIL_ID:dkennedy@hp.com",
        "KMS_USER_KEY" : "ADXJR934XW5NHK7H92TF",
        "KMS_USER" : "60809900579962",
        "UMS_DOMAIN" : "28117301830361",
        "KMS_SECRET_KEY" : "v7QPZBeLiOX+OB3VncGlCMDGsAkI4whsEPvjDft+"
      },
      "completion" : "2012-10-30T10:19:38.466Z",
      "errorCategory" : "",
      "errorDescription" : "",
      "status" : "COMPLETE",
      "stepStatus" : {
        "CreateKmsUserKeys" : "COMPLETE",
        "CreateZuoraAccountAndContact" : "COMPLETE",
        "CreateKmsDomain" : "COMPLETE",
        "CreateUmsUserAndDomain" : "COMPLETE",
        "SendWelcomeEmail" : "COMPLETE",
        "CreateSalesforceContactAndAccount" : "COMPLETE",
        "CreateKmsUser" : "COMPLETE"
      },
      "submission" : "2012-10-30T10:19:24.505Z",
      "ticketId" : "508fa9ace4b0c294a11da38a"
    }, {
      "action" : "UpdateUser",
      "actionParams" : {
      },
      "actionResults" : {
        "mailToOldAddress" : "dkennedy@hp.com",
        "accountId" : "60809900579962",
        "mailToNewAddress" : "david.kennedy@hp.com",
        "SALESFORCE_CONTACT" : "003Q000000a25LNIAY",
        "emailed" : "EMAIL_UPDATED_EMAIL_ID:dkennedy@hp.com,EMAIL_UPDATED_EMAIL_ID:david.kennedy@hp.com"
      },
      "completion" : "2012-10-30T10:19:44.435Z",
      "errorCategory" : "",
      "errorDescription" : "",
      "status" : "COMPLETE",
      "stepStatus" : {
        "UpdateZuoraContact" : "COMPLETE",
        "SendEmailUpdateEmails" : "COMPLETE",
        "UpdateSalesforceContact" : "COMPLETE",
        "UpdateUmsUser" : "COMPLETE",
        "UpdateKmsUser" : "COMPLETE"
      },
      "submission" : "2012-10-30T10:19:40.590Z",
      "ticketId" : "508fa9bce4b0c294a11da398"
    } ]
  }
}
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exceptions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/status/COMPLETE
```

#### 4.4.1.11 <a id="get_job_count_by_status"></a>Get Job Count By Status####
#### GET [HPKeystoneExtensionBaseURI]/job/status/{status}/count
*Privilege Level: {Privilege Level}*

Return a count of all Job Tickets from the database which have the given status value. The Action Page provides a list of all possible status values.

**Request Data**

**URL Parameters**

* *{status}* - String - The status of the tasks required

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
26
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exceptions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/status/COMPLETE/count
```


### 4.4.2 Domains

The entity that serves as a collection of users, groups, roles, and tenants. It represents the primary relationship between the customer and HP.  A Domain can be an individual or company.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.2.1 <a id="check_for_existence_of_domain_name"></a>Check For Existence Of Domain Name####
#### HEAD [HPKeystoneExtensionBaseURI]/domains?name=domainName 
*Privilege Level: Anonymous*

This API does case insensitive domainName lookup in system. It returns http status code 200 (Ok) when provided domainName exists and returns 404 (not found) when provided domainName is not found in the system. If provided domainName is blank or missing, then it returns 204 (No content). The domain name with extra spaces is converted to single space in-between words and then look up is done for its existence. So domain name " Abc Corp" and "ABC    Corp" are treated as same and will be found if entry is there in system. In system, the corresponding name is going to be stored as "abc corp" in a separate field.    
  
As this API just checks for existence of provided domainName, it does not do look into status (or any other entity attribute) for case when matching domain is found.

**Request Data**

This API does not require http header X-Auth-Token and is protected by client certificate authentication. There is no response body returned in API response data. 

**URL Parameters**

* *name* - string - name of the domain to look for existence (required)

**Data Parameters**

This call does not require a request body

JSON

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
```

XML

Case-insensitive lookup of above domainName

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=domain_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
```

Optional:

JSON 

When provided domainName not found

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
```

When missing domainName in request

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
```

**Success Response**

There is no response body returned. Status code indicates the result where 200 indicates that provided name exists and 404 indicates when name does not exist.

**Status Code**

200 - OK , 404 - NOT FOUND

**Response Data**

This call does not return a response body and result is determined through returned http status code. Response body is present only in case of errors.

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:15:56 GMT
```

XML

Response for case-insensitive lookup of above domainName

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:17:00 GMT
```

**Error Response**

Status code 204 is returned when either domain name is missing or blank.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 204 | No Content | When domainName is missing or blank |  
| 400 | Bad Request | Malformed request in URI |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

When provided domainName is not found

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: \-1
Content-Type: text/html;charset=utf-8
Content-Length: 952
Date: Tue, 21 Aug 2012 19:17:43 GMT
```

When missing domainName in request

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: \-1
Date: Tue, 21 Aug 2012 19:18:23 GMT
```


Curl Example

```
curl -k  --cert dev_hpmiddleware.pem  -I -H "Accept: application/json" "https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21565"
```

**Additional Notes**




#### 4.4.2.2 <a id="create_a_domain"></a>Create A Domain####
#### GET [HPKeystoneExtensionBaseURI]/domains 
*Privilege Level: System Adminstrator (SA)*

Creates a domain using the specified request body. A response body is also returned with the new domain information with a service generated domainId.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**



**Data Parameters**

See schema file, domain.xsd, for more details on the request and response data structure.



* *name* - string - Name of the domain to be created
* *description* - (Optional) - string - description of domain
* *addressLine1* (Optional) - string - 
* *addressLine2* (Optional) - string - 
* *city* (Optional) - string - 
* *state* (Optional) - string - 
* *zip* (Optional) - string - 
* *country* (Optional) - string - 
* *phone* (Optional) - string - 
* *company* (Optional) - string - 
* *website* (Optional) - string - 
* *emailAddress* (Optional) - string -
* *billToAddress" (Optional) - Bill to Address 



JSON

```
POST https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
Content-Type: application/json
Content-Length: 495
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

{
  "domain" : {
    "description" : "See's Candies Domain",
    "anies" : null,
    "addressLine1" : "128, Market Blvd",
    "addressLine2" : null,
    "city" : "San Francisco",
    "company" : null,
    "country" : "USA",
    "domainId" : "50277849949620",
    "emailAddress" : "owner@sees.com",
    "name" : "Sees Candies",
    "otherAttributes" : {
    },
    "phone" : "1-800-555-1212",
    "state" : "CA",
    "status" : "enabled",
    "website" : "www.sees.com",
    "zip" : "90210"
  }
}
```

XML

```
POST /v2.0/HP-IDM/v1.0/domains HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f47d0b12cdc8b1c3905dbda
Host: localhost:9999
Connection: keep-alive
Content-Length: 617
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled">
  <description>Hp's Private Cloud Domain</description>
  <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
   </billToAddress> 
</domain>
```

Optional:


**Success Response**

The response body contains data for newly created domain with http status code of 201.

**Status Code**

201 - CREATED

**Response Data**

Response data structure is same as input domain data

JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=5A0C0E3AD8FBB574807901C3F1FB5741; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 426
Date: Tue, 30 Oct 2012 20:19:32 GMT

{
  "domain" : {
    "description" : "See's Candies Domain",
    "addressLine1" : "128, Market Blvd",
    "city" : "San Francisco",
    "country" : "USA",
    "domainId" : "25279093386747",
    "emailAddress" : "owner@sees.com",
    "name" : "Sees Candies",
    "otherAttributes" : {
    },
    "phone" : "1-800-555-1212",
    "state" : "CA",
    "status" : "enabled",
    "website" : "www.sees.com",
    "zip" : "90210"
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
Content-Type: application/xml
Content-Length: 643
Date: Fri, 24 Feb 2012 18:02:43 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" domainId="80354991891807" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled">
  <description>Hp's Private Cloud Domain</description>
  <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
   </billToAddress> 
</domain>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**


| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation   |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 409 | Identity Fault | A Domain with the required parameters already exist in the system  |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  



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

In case domain name already exists
```
HTTP/1.1 409 Conflict
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=8AD5634E0DBA2968E3136CDB8F3C6EB5; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 154
Date: Tue, 30 Oct 2012 20:20:32 GMT

{
  "IdentityFault" : {
    "message" : "Identity fault",
    "details" : "Domain already exists",
    "code" : 409,
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
curl -k --cert dev_hpmiddleware.pem  -XPOST -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" -d '{  "domain" : {  "name" : "Sees Candies 6" } }'  https://localhost:35357/v2.0/HP-IDM/v1.0/domains
```

**Additional Notes**



#### 4.4.2.3 <a id="delete_a_domain"></a>Delete A Domain####
#### DELETE [HPKeystoneExtensionBaseURI]/domains/{domainId} 
*Privilege Level: System Adminstrator (SA)*

Deletes the specified domain by its {domainID}. This API deletes the Users, Tenants, Groups, Roles, RoleRefs and Grants associated to the Domain.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**



**Data Parameters**

This call does not require a request body

JSON

```
DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```

XML

Now trying to delete previously deleted domain, expecting error.

```
DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```

Optional:



**Success Response**

There is no respone body and respons code of 204 is returned after successful deletion of domain.

**Status Code**

204 - No Content

**Response Data**

This call does not have a response body other than in case of errors.

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=38FAFEF8E7816E6B717B1328FC6AFF49; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Tue, 30 Oct 2012 21:30:16 GMT
```

XML

Response for deleting previously deleted domain.

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=5E50B7163151DDF072B2B0E5AF5B33BF; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 368
Date: Tue, 30 Oct 2012 21:31:04 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?><itemNotFound xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="404"><message>Not found</message><details>Domain does not exist</details></itemNotFound>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation    |  
| 403 | Forbidden | Disabled or suspended user making the request. This error is also returned when there is dependent data that needs to be removed as well |  
| 404 | Not Found | The Domain for domainId does not exist    |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

Response for deleting previously deleted domain.

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=E58C6550A98478BD88C3392EB379F734; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 148
Date: Tue, 30 Oct 2012 21:43:21 GMT

{
  "itemNotFound" : {
    "code" : 404,
    "details" : "Domain does not exist",
    "message" : "Not found",
    "otherAttributes" : {
    }
  }
}
```

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
curl -k --cert dev_hpmiddleware.pem  -XDELETE -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196
```

**Additional Notes**



#### 4.4.2.4 <a id="get_a_domain"></a>Get A Domain####
#### GET [HPKeystoneExtensionBaseURI]/domains/{domainId} 
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

Get a domain based on the {domainId} specified. DomainId's are opaque values returned with get domain list operations. 

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body

JSON

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/63283648950838 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_5032ad14957cb3caab6c33eb
```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/81132865245171 HTTP/1.1GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/63283648950838 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_5032ad14957cb3caab6c33eb
```

Optional:



**Success Response**

The domain data is returned with http status code of 200 for provided domainId.

**Status Code**

200 - OK

**Response Data**

See schema file, domain.xsd, for more details on the domain response data structure.

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 603
Date: Mon, 20 Aug 2012 23:07:59 GMT
 
{
  "domain" : {
    "description" : "Hp's Private Cloud Domain",
    "anies" : null,
    "addressLine1" : "1, HP Way",
    "addressLine2" : null,
    "billingId" : "4028e69737163f4e013732dc605210ba",
    "city" : "Cupertino",
    "company" : "HP",
    "contactId" : "001Q000000TU4q4IAD",
    "country" : "USA",
    "domainId" : "63283648950838",
    "emailAddress" : "hp-private-cloud-6@hp.com",
    "name" : "HP Private Cloud Domain",
    "otherAttributes" : {
    },
    "phone" : "1-888-555-1212",
    "state" : "CA",
    "status" : "enabled",
    "website" : "www.hp.com",
    "zip" : "90210"
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
Content-Type: application/xml
Content-Length: 719
Date: Mon, 20 Aug 2012 23:06:39 GMT
 
<domain domainId="63283648950838" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled" billingId="4028e69737163f4e013732dc605210ba" contactId="001Q000000TU4q4IAD" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <description>Hp's Private Cloud Domain</description>
</domain>
```

**Error Response**

Please refer to error response body for additional details.


**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The Domain for domainId does not exist    |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

When provided domainId is not found in the system

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=FFE0355EF1D55E4EC60754298955D53C; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 148
Date: Tue, 30 Oct 2012 23:32:45 GMT

{
  "itemNotFound" : {
    "code" : 404,
    "details" : "Domain does not exist",
    "message" : "Not found",
    "otherAttributes" : {
    }
  }
}
```

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
curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196
```

**Additional Notes**


#### 4.4.2.5 <a id="get_all_domains"></a>Get All Domains####
#### GET [HPKeystoneExtensionBaseURI]/domains
*Privilege Level: System Adminstrator (SA)*

Allows reading a list of all domains. This API supports pagination through 'limit' and 'marker' usage. The returned list may be filtered to allow only those domains which the caller has access to. 

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


**URL Parameters**


* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list
* *name* (Optional)} - string - filter by domain name

**Data Parameters**

This call does not require a request body

JSON

With limit parameter provided

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains?limit=2 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)


```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

```

Optional:

JSON

With marker and parameter both set


```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains?limit=2&marker=23213441623236 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```


**Success Response**

Returns list of domains for given input with http status code 200.

**Status Code**

200 - OK

**Response Data**



JSON

Listing all domains response

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=9CE7501B1B4C569F720C15B6692C7DD2; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2353
Date: Tue, 30 Oct 2012 23:53:11 GMT

{
  "domains" : {
    "domain" : [ {
      "owners" : {
        "owner" : [ {
          "otherAttributes" : {
          },
          "userId" : "00000000003001"
        } ]
      },
      "domainId" : "00000000001001",
      "name" : "HP Cloud System Domain",
      "otherAttributes" : {
      },
      "status" : "enabled"
    }, {
      "domainId" : "23213441623236",
      "name" : "Sees Candies 6",
      "otherAttributes" : {
      },
      "status" : "enabled"
    }, {
      "description" : "See's Candies Domain",
      "addressLine1" : "128, Market Blvd",
      "city" : "San Francisco",
      "country" : "USA",
      "domainId" : "25279093386747",
      "emailAddress" : "owner@sees.com",
      "name" : "Sees Candies",
      "otherAttributes" : {
      },
      "phone" : "1-800-555-1212",
      "state" : "CA",
      "status" : "enabled",
      "website" : "www.sees.com",
      "zip" : "90210"
    }, {
      "domainId" : "45548920306336",
      "name" : "Sees Candies 5",
      "otherAttributes" : {
      },
      "status" : "enabled"
    }, {
      "description" : "See's Candies Domain",
      "addressLine1" : "128, Market Blvd",
      "city" : "San Francisco",
      "country" : "USA",
      "domainId" : "53584481318159",
      "emailAddress" : "owner@sees.com",
      "name" : "Sees Candies 2",
      "otherAttributes" : {
      },
      "phone" : "1-800-555-1212",
      "state" : "CA",
      "status" : "enabled",
      "website" : "www.sees.com",
      "zip" : "90210"
    }, {
      "owners" : {
        "owner" : [ {
          "otherAttributes" : {
          },
          "userId" : "77641675774128"
        } ]
      },
      "domainId" : "69985299710130",
      "emailAddress" : "test@test.com",
      "name" : "69985299710130-DOMAIN",
      "otherAttributes" : {
      },
      "status" : "enabled"
    }, {
      "domainId" : "82997401317216",
      "name" : "Sees Candies 4",
      "otherAttributes" : {
      },
      "status" : "enabled"
    }, {
      "owners" : {
        "owner" : [ {
          "otherAttributes" : {
          },
          "userId" : "74110440977688"
        } ]
      },
      "domainId" : "95403455987464",
      "emailAddress" : "test@test.com",
      "name" : "95403455987464-DOMAIN",
      "otherAttributes" : {
      },
      "status" : "enabled"
    } ],
    "otherAttributes" : {
    }
  }
}
```

Listing response with marker and parameter both set
```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=587724ABE90EFF995115B4C07680F1F5; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 658
Date: Tue, 30 Oct 2012 23:51:42 GMT

{
  "domains" : {
    "domain" : [ {
      "description" : "See's Candies Domain",
      "addressLine1" : "128, Market Blvd",
      "city" : "San Francisco",
      "country" : "USA",
      "domainId" : "25279093386747",
      "emailAddress" : "owner@sees.com",
      "name" : "Sees Candies",
      "otherAttributes" : {
      },
      "phone" : "1-800-555-1212",
      "state" : "CA",
      "status" : "enabled",
      "website" : "www.sees.com",
      "zip" : "90210"
    }, {
      "domainId" : "45548920306336",
      "name" : "Sees Candies 5",
      "otherAttributes" : {
      },
      "status" : "enabled"
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
Set-Cookie: JSESSIONID=68E1E45A984F2747A98E2DF07E95B3E5; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 1625
Date: Tue, 30 Oct 2012 23:54:44 GMT

<domains xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <domain domainId="00000000001001" name="HP Cloud System Domain" status="enabled">
      <owners>
         <owner userId="00000000003001"/>
      </owners>
   </domain>
   <domain domainId="23213441623236" name="Sees Candies 6" status="enabled"/>
   <domain domainId="25279093386747" name="Sees Candies" emailAddress="owner@sees.com" addressLine1="128, Market Blvd" city="San Francisco" state="CA" zip="90210" country="USA" website="www.sees.com" phone="1-800-555-1212" status="enabled">
      <description>See's Candies Domain</description>
   </domain>
   <domain domainId="45548920306336" name="Sees Candies 5" status="enabled"/>
   <domain domainId="53584481318159" name="Sees Candies 2" emailAddress="owner@sees.com" addressLine1="128, Market Blvd" city="San Francisco" state="CA" zip="90210" country="USA" website="www.sees.com" phone="1-800-555-1212" status="enabled">
      <description>See's Candies Domain</description>
   </domain>
   <domain domainId="69985299710130" name="69985299710130-DOMAIN" emailAddress="test@test.com" status="enabled">
      <owners>
         <owner userId="77641675774128"/>
      </owners>
   </domain>
   <domain domainId="82997401317216" name="Sees Candies 4" status="enabled"/>
   <domain domainId="95403455987464" name="95403455987464-DOMAIN" emailAddress="test@test.com" status="enabled">
      <owners>
         <owner userId="74110440977688"/>
      </owners>
   </domain>
</domains>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | When invalid marker is provided    |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

When invalid marker is provided

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=D3AC697EC1B71E03C6250E8EFDE8996E; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 154
Date: Tue, 30 Oct 2012 23:56:58 GMT

{
  "itemNotFound" : {
    "code" : 404,
    "details" : "Marker in request not found",
    "message" : "Not found",
    "otherAttributes" : {
    }
  }
}
```

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
curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains
```

**Additional Notes**


#### 4.4.2.6 <a id="get_groups_for_a_domain"></a>Get Groups For A Domain####
#### GET [HPKeystoneExtensionBaseURI]/domains/{domainId}/groups
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API is used to get list of groups for a given domain. Api results can be filtered by using parameters. Query parameters "marker" and "limit" can be used for pagination


**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list

Following filters can be used to filter the response data.

*Inclusion Filters*
* *groupId (Optional)* - string - include results for given groupId. Filters groupId and groupName are mutually exclusive. You can filter either using groupId or using groupName.
* *groupName (Optional)* - string - include results for given groupName. Filters groupId and groupName are mutually exclusive. You can filter either using groupId or using groupName  

*Exclusion Filters*
* *excludeRoles (Optional)* - string - comma separated roleId to exclude 


**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body

JSON

Request with filters
```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/groups HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```

XML

Request with marker and groupName

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/groups?marker=20249143710988&groupName=Domain%20Administrators HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```

Optional:

XML

Request with filters

```
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP_IDM/v1.0/domains/641564254582/groups/groupId=1234&excludeRoles=roleId1,roleId22 HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

**Success Response**

List groups for domain for given filter criteria and marker if there with http status code 200.

**Status Code**

200 - OK

**Response Data**


JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=8DD402CDD89EF3A61D73B915F4B8BE42; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 474
Date: Wed, 31 Oct 2012 15:42:34 GMT

{
  "groups" : {
    "group" : [ {
      "description" : "Sees Candies   3 Domain Administrators",
      "domainId" : "66751536630361",
      "id" : "20249143710988",
      "name" : "Domain Administrators",
      "otherAttributes" : {
      }
    }, {
      "description" : "Sees Candies   3 Users",
      "domainId" : "66751536630361",
      "id" : "80305392769921",
      "name" : "Users",
      "otherAttributes" : {
      }
    } ],
    "otherAttributes" : {
    }
  }
}
```

XML

Request with marker and groupName

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=10C0D5531A322E76410588242947F78D; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 332
Date: Wed, 31 Oct 2012 16:44:21 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?><groups xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom"/>
```  


**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or groupId within the marker was not found. Or both groupId and groupName is specified   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

```
{
  "badRequest" : {
    "code" : 400,
    "details" : "Bad input request : Filters groupId and groupName are mutually exclusive.  You can't use both at the same time",
    "message" : "Bad request",
    "otherAttributes" : {
    }
  }
}
```

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
curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196/groups
```

**Additional Notes**


#### 4.4.2.7 <a id="get_subscribe_able_services_for_a_domain"></a>Get Subscribe Able Services For A Domain####
#### GET [HPKeystoneExtensionBaseURI]/domains/{domainId}/subscribeableServices
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API returns all subscribe able services that are available for the given {domainId} . It can also filter the result based on service name or endpoint template id. In request, either 'serviceName' filter or 'serviceEndpointId' filter is to be used. If both of filter values are provided, then error is returned back. This is essentially endpoint template data with some additional subscription specific attributes.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**


* *serviceName (Optional)* - string - Use service name if need to get subscrible data for all endpoints within that service.

* *endpointTemplateId (Optional)* - string - User endpoint template Id to get specific endpoint subscrible able data

**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body.


JSON

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/subscribeableServices HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/64521341789596/subscribeableServices HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f46a309b0bebb59e36f663f
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

Optional:

JSON

With serviceName filter
```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/subscribeableServices?serviceName=Compute HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```


**Success Response**

The response is a list of subscribe able services for the domain. Results are filtered by serviceName if serviceName is provided. Result will include single subscribe able service as identified endpoint template id if its provided in query.

**Status Code**

200 - OK

**Response Data**


JSON

```
{"subscribeableServices": {
   "otherAttributes": {},
   "subscribeableService":    [
            {
         "adminURL": "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": false,
         "id": "100",
         "name": "Compute",
         "otherAttributes": {},
         "publicURL": "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
         "publicURL2": "https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
         "region": "az-1.region-a.geo-1",
         "releaseState": "public",
         "type": "compute",
         "version":          {
            "id": "1.1",
            "list": "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
            "otherAttributes": {}
         }
      },
            {
         "adminURL": "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": false,
         "id": "110",
         "name": "Compute",
         "otherAttributes": {},
         "publicURL": "https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
         "publicURL2": "https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
         "region": "az-2.region-a.geo-1",
         "releaseState": "public",
         "type": "compute",
         "version":          {
            "id": "1.1",
            "list": "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
            "otherAttributes": {}
         }
      },
            {
         "adminURL": "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": false,
         "id": "111",
         "name": "Compute",
         "otherAttributes": {},
         "publicURL": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
         "publicURL2": "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
         "region": "az-3.region-a.geo-1",
         "releaseState": "public",
         "type": "compute",
         "version":          {
            "id": "1.1",
            "list": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
            "otherAttributes": {}
         }
      },
            {
         "adminURL": "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/",
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": false,
         "id": "120",
         "name": "Object Storage",
         "otherAttributes": {},
         "publicURL": "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%",
         "region": "region-a.geo-1",
         "releaseState": "public",
         "type": "object-store",
         "version":          {
            "id": "1.0",
            "otherAttributes": {}
         }
      },
            {
         "adminURL": "https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/",
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": true,
         "id": "130",
         "internalURL": "https://region-a.geo-1.identity-internal.hpcloudsvc.com/v2.0/",
         "name": "Identity",
         "otherAttributes": {},
         "publicURL": "https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/",
         "region": "region-a.geo-1",
         "releaseState": "public",
         "type": "identity",
         "version":          {
            "id": "2.0",
            "list": "https://region-a.geo-1.identity.hpcloudsvc.com/extension",
            "otherAttributes": {}
         }
      },
            {
         "adminURL": "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": false,
         "id": "140",
         "name": "Block Storage",
         "otherAttributes": {},
         "publicURL": "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
         "region": "az-1.region-a.geo-1",
         "releaseState": "public",
         "type": "volume",
         "version":          {
            "id": "1.1",
            "list": "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
            "otherAttributes": {}
         }
      },
 
            {
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": false,
         "id": "150",
         "name": "CDN",
         "otherAttributes": {},
         "publicURL": "https://region-a.geo-1.cdnmgmt.hpcloudsvc.com/v1.0/",
         "region": "region-a.geo-1",
         "releaseState": "public",
         "type": "hpext:cdn",
         "version":          {
            "id": "1.0",
            "otherAttributes": {}
         }
      },
            {
         "adminURL": "https://glance1.uswest.hpcloud.net:9292/v1.0",
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": false,
         "id": "160",
         "name": "Image Management",
         "otherAttributes": {},
         "region": "az-1.region-a.geo-1",
         "releaseState": "public",
         "type": "image",
         "version":          {
            "id": "1.0",
            "otherAttributes": {}
         }
      },
            {
         "adminURL": "https://glance2.uswest.hpcloud.net:9292/v1.0",
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": false,
         "id": "170",
         "name": "Image Management",
         "otherAttributes": {},
         "region": "az-2.region-a.geo-1",
         "releaseState": "public",
         "type": "image",
         "version":          {
            "id": "1.0",
            "otherAttributes": {}
         }
      },
            {
         "adminURL": "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": false,
         "id": "113",
         "name": "EC2",
         "otherAttributes": {},
         "publicURL": "https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
         "region": "az-2.region-a.geo-1",
         "releaseState": "public",
         "type": "ec2",
         "version":          {
            "id": "1.1",
            "list": "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
            "otherAttributes": {}
         }
      },
            {
         "adminURL": "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
         "canSubscribe": true,
         "enabled": true,
         "endpointReleaseState": "public",
         "global": false,
         "id": "114",
         "name": "EC2",
         "otherAttributes": {},
         "publicURL": "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
         "region": "az-3.region-a.geo-1",
         "releaseState": "public",
         "type": "ec2",
         "version":          {
            "id": "1.1",
            "list": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
            "otherAttributes": {}
         }
      }
   ]
}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=4ADA3703B5E45F3C198E4E4F0CC9A4D8; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 5128
Date: Thu, 23 Feb 2012 20:37:58 GMT
 
<subscribeableServices xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="100" type="compute" name="Compute" region="az-1.region-a.geo-1" publicURL="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-1.region-a.geo-1.compute.hpcloudsvc.com"/>
      <subscribedInfo subscribedOn="2011-10-21T22:04:11.000Z" tenantId="36733265821255" status="deleted"/>
      <subscribedInfo subscribedOn="2011-10-21T22:05:43.000Z" tenantId="79402136023481" status="enabled"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="110" type="compute" name="Compute" region="az-2.region-a.geo-1" publicURL="https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-2.region-a.geo-1.compute.hpcloudsvc.com"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="111" type="compute" name="Compute" region="az-3.region-a.geo-1" publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" id="120" type="object-store" name="Object Storage" region="region-a.geo-1" publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%" adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/" global="false" enabled="true">
      <version id="1.0"/>
      <subscribedInfo subscribedOn="2011-10-25T20:51:49.000Z" tenantId="72290583996765"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="130" type="identity" name="Identity" region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" internalURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" global="true" enabled="true">
      <version id="2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/extension"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="140" type="hpext:block-store" name="Block Storage" region="az-1.region-a.geo-1" publicURL="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" adminURL="https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-1.region-a.geo-1.compute.hpcloudsvc.com"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="141" type="hpext:block-store" name="Block Storage" region="az-2.region-a.geo-1" publicURL="https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" adminURL="https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-2.region-a.geo-1.compute.hpcloudsvc.com"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="142" type="hpext:block-store" name="Block Storage" region="az-3.region-a.geo-1" publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
   </subscribeableService>
   <subscribeableService releaseState="preview" endpointReleaseState="public" canSubscribe="false" id="150" type="hpext:cdn" name="CDN" region="region-a.geo-1" publicURL="https://region-a.geo-1.cdnmgmt.hpcloudsvc.com/v1.0/" global="false" enabled="true">
      <version id="1.0"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="160" type="image" name="Image Management" region="az-1.region-a.geo-1" adminURL="https://glance1.uswest.hpcloud.net:9292/v1.0" global="false" enabled="true">
      <version id="1.0"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="170" type="image" name="Image Management" region="az-2.region-a.geo-1" adminURL="https://glance2.uswest.hpcloud.net:9292/v1.0" global="false" enabled="true">
      <version id="1.0"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="180" type="image" name="Image Management" region="az-3.region-a.geo-1" adminURL="https://glance3.uswest.hpcloud.net:9292/v1.0" global="false" enabled="true">
      <version id="1.0"/>
   </subscribeableService>
</subscribeableServices>
```

Optional

JSON

With serviceName filter

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=57031777BBA23809F2B7B172E342A8F9; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2265
Date: Wed, 31 Oct 2012 18:13:14 GMT

{
  "subscribeableServices" : {
    "otherAttributes" : {
    },
    "subscribeableService" : [ {
      "adminURL" : "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
      "canSubscribe" : true,
      "enabled" : true,
      "endpointReleaseState" : "public",
      "global" : false,
      "id" : "100",
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-1.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute",
      "version" : {
        "id" : "1.1",
        "list" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      }
    }, {
      "adminURL" : "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
      "canSubscribe" : true,
      "enabled" : true,
      "endpointReleaseState" : "public",
      "global" : false,
      "id" : "110",
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-2.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute",
      "version" : {
        "id" : "1.1",
        "list" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      }
    }, {
      "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
      "canSubscribe" : true,
      "enabled" : true,
      "endpointReleaseState" : "public",
      "global" : false,
      "id" : "111",
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-3.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute",
      "version" : {
        "id" : "1.1",
        "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      }
    } ]
  }
}
```


**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI; If present, non-numeric endpoint template id is provided; If present, invalid endpoint template id is provided.; If present, invalid service name is provided.; If both serviceName and endpointTemplateId values are provided. |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or tenantId filter is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

```
HTTP/1.1 400 Bad Request
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=670399F2C2059BD56F33D988AE8A2712; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 181
Date: Wed, 31 Oct 2012 18:16:24 GMT
Connection: close

{
  "badRequest" : {
    "code" : 400,
    "details" : "Invalid service name specified, serviceName = Computer",
    "message" : "BAD_REQUEST",
    "otherAttributes" : {
    }
  }
}
```

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=274CFEB4593E9BB8D00C8DED21E3E75B; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 193
Date: Wed, 31 Oct 2012 18:15:44 GMT

{
  "itemNotFound" : {
    "code" : 404,
    "details" : "Domain with domainId : 66751536630362 does not exist in the System",
    "message" : "NOT_FOUND",
    "otherAttributes" : {
    }
  }
}
```

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
curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/subscribeableServices?serviceName=Compute 
```

**Additional Notes**



#### 4.4.2.8 <a id="get_service_activations_for_a_domain"></a>Get Service Activations For A Domain####
#### GET [HPKeystoneExtensionBaseURI]/domains/{domainId}/services
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API returns all services that have been activated for the given {domainId} . It can also filter the result based on tenantId. 

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**


* *tenantId (Optional)* - string - tenantId to list service activation for that tenant

**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body.


JSON

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/23268133247776/services?tenantId=35871429575842 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ea802a5b0be7e989230032e
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/23268133247776/services HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ea802a5b0be7e989230032e
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

Optional:

JSON

When no activated services are there for a domain
```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/services HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```



**Success Response**

The response is a list of activated services for the domain (filtered by tenantId if tenantId is provided)

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
Content-Length: 686
Date: Wed, 26 Oct 2011 13:14:07 GMT
 
{
  "activatedServices" : {
    "anies" : null,
    "activatedService" : [ {
      "id" : null,
      "otherAttributes" : {
      },
      "region" : "az-1.region-a.geo-1",
      "serviceName" : "Compute",
      "serviceType" : "compute",
      "status" : "enabled",
      "subscribedOn" : "2011-10-25T20:50:13.000Z",
      "tenantId" : "35871429575842",
      "endpointTemplateId" : "100"
    }, {
      "id" : null,
      "otherAttributes" : {
      },
      "region" : "az-2.region-a.geo-1",
      "serviceName" : "Compute",
      "serviceType" : "compute",
      "status" : "enabled",
      "subscribedOn" : "2011-10-25T20:50:28.000Z",
      "tenantId" : "35871429575842",
      "endpointTemplateId" : "110"
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
Set-Cookie: JSESSIONID=12934DBA01E8E9F9A3E783F34C75F700; Path=/; Secure
Content-Type: application/xml
Content-Length: 894
Date: Wed, 26 Oct 2011 13:20:14 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<activatedServices xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns5="http://www.w3.org/2005/Atom">
<activatedService serviceName="Compute" serviceType="compute" region="az-1.region-a.geo-1" subscribedOn="2011-10-25T20:50:13.000Z" tenantId="35871429575842" status="enabled" endpointTemplateId="100"/>
<activatedService serviceName="Compute" serviceType="compute" region="az-2.region-a.geo-1" subscribedOn="2011-10-25T20:50:28.000Z" tenantId="35871429575842" status="enabled" endpointTemplateId="110"/>
<activatedService serviceName="Object Storage" serviceType="object-store" region="region-a.geo-1" subscribedOn="2011-10-25T20:51:49.000Z" tenantId="90260810095453" status="enabled" endpointTemplateId="120"/>
</activatedServices>
```

Optional

JSON

When no activated services are there for a domain
```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=F7E5F28138F5A7337CA8434B4FEA17BE; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 65
Date: Wed, 31 Oct 2012 16:06:04 GMT

{
  "activatedServices" : {
    "otherAttributes" : {
    }
  }
}
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or tenantId filter is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

```
{
  "itemNotFound" : {
    "code" : 404,
    "details" : "Domain with domainId : 66751536630362 does not exist in the System",
    "message" : "NOT_FOUND",
    "otherAttributes" : {
    }
  }
}
```

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
curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/services
```

**Additional Notes**



#### 4.4.2.9 <a id="get_tenants_for_a_domain"></a>Get Tenants For A Domain####
#### GET [HPKeystoneExtensionBaseURI]/domains/{domainId}/tenants
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This REST API returns all tenants of a {domainId} and takes a "marker" and "limit" parameter to limit the number of Tenants in the response.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list

**Data Parameters**

See schema file for more details on the response data structure.  

This call does not require a request body

JSON

```
GET /v2.0/HP-IDM/v1.0/domains/29649421790262/tenants HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8f7d182cdcb96406c8c61b
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /V2.0/HP-IDM/v1.0/domains/798477662343/tenants HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

Optional:


**Success Response**

The response is a list of tenant resources for the domain. 

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
Content-Length: 367
Date: Fri, 07 Oct 2011 22:45:44 GMT
 
{
  "tenants": {
    "anies": null,
    "otherAttributes": {
 
    },
    "tenant": [
      {
        "description": "Tenant for hosting Time Warner Applications & services",
        "domainId": "29649421790262",
        "name": "Time Warner Tenant Services",
        "otherAttributes": {
 
        },
        "status": "enabled",
        "tenantId": "96488406679080"
      }
    ]
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
Content-Type: application/xml
Content-Length: 525
Date: Tue, 16 Aug 2011 21:24:54 GMT
 
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<tenants xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"
xmlns:ns2="http://www.w3.org/2005/Atom"
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0">
  <tenant status="enabled" domainId="798477662343"
  tenantId="842515505915"
  description="Tenant for Sales service"
  name="Forecasting Tenant" />
  <tenant status="enabled" domainId="798477662343"
  tenantId="225260164476"
  description="Tenant for Forecasting service"
  name="Sales Tenant" />
</tenants>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or marker is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

```
{
  "itemNotFound" : {
    "code" : 404,
    "details" : "Domain does not exist",
    "message" : "Not found",
    "otherAttributes" : {
    }
  }
}
```

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
curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630362/tenants
```

**Additional Notes**



#### 4.4.2.10 <a id="get_users_for_a_domain"></a>Get Users For A Domain####
#### {HTTP Verb: GET, POST, DELETE, PUT} [HPKeystoneExtensionBaseURI]/domains/{domainId}/users?limit=pagesize&marker=userId&excludeGroups=groupid1,groupdid2&excludeRoles=roleId1,roleId2&userId=userId&userName=userName&excludeTenantId=tenantid1,tenantId2
*Privilege Level: System Adminstrator (SA), Domain Admin (DA)*

This API returns all users of a {domainId} .  The Api results can be filtered using filters which are specified as query parameters.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list

Following filters can be used to filter the response data.

*Inclusion-Filters*
* *userId (Optional)* - string - include results for given userId. Filters userId and userName are mutually exclusive. You can filter either using userId or using userName.
* *userName (Optional)* - string - include results for given userName. Filters userId and userName are mutually exclusive. You can filter either using userId or using userName.  

*Exclusion Filters*
* *excludeRoles (Optional)* - string - comma separated roleId to exclude 
* *excludeGroups (Optional)* - string - comma separated groupId to exclude 
* *excludeTenantId (Optional)* - string - tenantId to exclude


**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body

JSON

```
GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/domains/798477662343/users HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

Optional:

JSON

Request with excludeRoles
```
GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users?excludeRoles=RoleId1,RoleId2 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
Host: localhost:9999
Connection: keep-alive
```

Request with excludeGroups
```
GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users?excludeGroups=GroupId1,GroupId22 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
Host: localhost:9999
Connection: keep-alive
```

XML

Request with exclusion filter
```
GET /v2.0/HP-IDM/v1.0/domains/798477662343/users?excludeGroups=000002002,000002001 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```


Request with userId filter
```
GET /v2.0/HP-IDM/v1.0/domains/798477662343/users?userId=12345 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

List of users returned for given input criteria with http status code 200.

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
Content-Length: 716
Date: Wed, 05 Oct 2011 21:37:04 GMT
 
{
  "users" : {
    "anies" : null,
    "otherAttributes" : {
    },
    "user" : [ {
      "roles" : null,
      "addressLine1" : "128, Hollywood Blvd",
      "addressLine2" : null,
      "city" : "Los Angeles",
      "company" : null,
      "country" : "USA",
      "domainId" : "53615830984009",
      "emailAddress" : "larryking@timewarner.com",
      "firstName" : "Larry",
      "lastName" : "King",
      "otherAttributes" : {
      },
      "password" : null,
      "phone" : "1-800-555-1212",
      "state" : "CA",
      "status" : "enabled",
      "userId" : "27000063617046",
      "username" : "larryking@timewarner.com",
      "website" : "http://www.timewarner.com",
      "zip" : "90210"
    } ]
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
Content-Type: application/xml
Content-Length: 822
Date: Wed, 10 Aug 2011 19:35:24 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<users xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
  <user domainId="798477662343" status="enabled" isDomainOwner="true" emailAddress="johndoe@papsi.com" website="http://www.pepsi.com" phone="1-800-555-1212" zip="89072" country="USA" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" accountId="627893056455" username="johndoe@papsi.com" name="John Doe"/>
  <user domainId="798477662343" status="enabled" emailAddress="amymiller@papsi.com" website="http://www.pepsi.com" phone="1-800-555-1212" zip="89072" country="USA" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" accountId="968754602297" username="amymiller@papsi.com" name="Amy Miller"/>
</users>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or marker is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

```
{
  "itemNotFound" : {
    "code" : 404,
    "details" : "Domain does not exist",
    "message" : "Not found",
    "otherAttributes" : {
    }
  }
}
```

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
curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/798477662343/users?userId=12345
```

**Additional Notes**



#### 4.4.2.11 <a id="list_role_definitions_(deprecated)"></a>List Role Definitions (Deprecated)####
#### GET [HPKeystoneExtensionBaseURI]/domains/{domainId}/roles
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API is used to list all the roles defined in the domain and takes a "marker" and "limit" parameter to limit the number of roles in the response.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list

**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body

JSON

```
GET /v2.0/HP-IDM/v1.0/domains/641564254582/roles HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

XML

```
GET /v2.0/HP-IDM/v1.0/domains/641564254582/roles HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

Optional:



**Success Response**

List of roles with http status code 200.

**Status Code**

200 - OK

**Response Data**


JSON

```
{"roles": {"role": [
      {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role01",
      "description": "role01- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
      "tenantId": "12345678909876"
   }, {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role02",
      "description": "role02- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
      "tenantId": "12345678909876"
   }, {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role03",
      "description": "role03- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
      "tenantId": "12345678909876"
   },
]}
```

XML

```
<roles xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role01</roleName>
      <description>role01- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role02</roleName>
      <description>role02- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role03</roleName>
      <description>role03- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
</roles>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or marker is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

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
curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196/roles
```

**Additional Notes**



#### 4.4.2.12 <a id="transfer_ownership_of_a_domain"></a>Transfer Ownership Of A Domain####
#### PUT [HPKeystoneExtensionBaseURI]/domains/{domainId}/owner/{userId}	
*Privilege Level: System Adminstrator (SA)*

A Domain has a owner, it is usually the first user of the Domain or the self registered user during the self registration process. This REST API transfers the domain ownership from one valid User of that Domain to another valid User of the Domain. 

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

* *domanId* - string - {domanId} of the Domain for which the ownership transfer should happen.
* *userId* - string - {userId} of the new owner of the Domain.

**URL Parameters**


**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body


JSON

```
PUT /v2.0/HP-IDM/v1.0/domains/29649421790262/owner/60414337132139 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8f7d182cdcb96406c8c61b
Host: localhost:9999
Connection: keep-alive
```

XML

```
PUT /v2.0/HP-IDM/v1.0/domains/662648896689/owner/129024620458 HTTP/1.1
Accept: application/xml
account_id: 000000003001
Content-Type: application/xml
domain_id: 000000001001
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

Optional:


**Success Response**

Transfer ownership of a Domain with http status code 200

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
Content-Length: 603
Date: Fri, 07 Oct 2011 22:55:55 GMT
 
{
  "user": {
    "roles": null,
    "addressLine1": "128, Hollywood Blvd",
    "addressLine2": null,
    "city": "Los Angeles",
    "company": null,
    "country": "USA",
    "domainId": "29649421790262",
    "emailAddress": "larryking3@timewarner.com",
    "firstName": "Larry",
    "lastName": "King III",
    "otherAttributes": {
 
    },
    "password": null,
    "phone": "1-800-555-1212",
    "state": "CA",
    "status": "enabled",
    "userId": "60414337132139",
    "username": "larryking3@timewarner.com",
    "website": "http://www.timewarner.com",
    "zip": "90210"
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
Content-Type: application/xml
Content-Length: 437
Date: Tue, 30 Aug 2011 00:06:02 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" name="Tom Riddle" username="tomriddle@timewarner.com" userId="129024620458" addressLine1="128, Hollywood Blvd" city="Los Angeles" state="CA" country="USA" zip="90210" phone="1-800-555-1212" website="http://www.timewarner.com" emailAddress="tomriddle@timewarner.com" status="enabled" domainId="662648896689"/>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or userId is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

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
curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/662648896689/owner/129024620458 
```

**Additional Notes**


#### 4.4.2.13 <a id="update_a_domain"></a>Update A Domain####
#### PUT [HPKeystoneExtensionBaseURI]/domains/{domainId}
*Privilege Level: System Adminstrator (SA), Domain Admin (DA**)

Allows update of an existing domain using the {domainId} and request body. Does not allow update or change of domainID.

DA* indicates that only attributes returned on the list operation as defined by Domain-Tenant-User-Group Model can be edited


**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.

The request requires the updated Domain resource.  
The response is the updated Domain resource.


JSON

```
PUT /v2.0/HP-IDM/v1.0/domains/91177319722637 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e83a4532cdcb4bf5faa76ce
Host: localhost:9999
Connection: keep-alive
Content-Length: 40
 
{
  "domain": {
    "phone": "1-800-NO-DISNEY"
  }
}
```

XML

```
PUT /v2.0/HP-IDM/v1.0/domains/26856794720485 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ef385b32cdc64f2eead137c
Host: localhost:9999
Connection: keep-alive
Content-Length: 384
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" phone="1-800-NO-DISNEY" addressLine2="Studio Lanes"/>
```

Optional:


**Success Response**

Updated domain resource is returned with http status code 200

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
Content-Length: 461
Date: Wed, 28 Sep 2011 22:49:56 GMT
 
 
{
  "domain" : {
    "anies" : null,
    "addressLine1" : "128, Hollywood Blvd",
    "addressLine2" : null,
    "city" : "Los Angeles",
    "company" : null,
    "country" : "USA",
    "domainId" : "91177319722637",
    "emailAddress" : "owner@timewarner.com",
    "name" : "Time Warner Inc",
    "otherAttributes" : {
    },
    "phone" : "1-800-NO-DISNEY",
    "state" : "CA",
    "status" : "enabled",
    "website" : "Time Warner",
    "zip" : "90210"
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
Content-Type: application/xml
Content-Length: 508
Date: Thu, 22 Dec 2011 19:51:00 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" domainId="26856794720485" name="action-king-DOMAIN" emailAddress="actionking@hp.com" addressLine2="Studio Lanes" company="action-king" phone="1-800-NO-DISNEY" status="enabled"/>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified {domainId} in request URI is not found   |  
| 409 | Conflict | The updated domain name already exists in the system   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

```
{
  "IdentityFault" : {
    "message" : "Conflict",
    "details" : "Domain already exists",
    "code" : 409,
    "otherAttributes" : {
    }
  }
}
```

```
{
  "itemNotFound" : {
    "code" : 404,
    "details" : "Domain does not exist",
    "message" : "Not found",
    "otherAttributes" : {
    }
  }
}
```

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
curl -k --cert dev_hpmiddleware.pem  -XPUT -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" -H "Content-type: application/json" -d '{  "domain" : {  "name" : "Sees Candies 61", "phone": "1-800-NO-DISNEY"} }' https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361
```

**Additional Notes**



### 4.4.3 Endpoint Template

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.3.1 <a id="{addendpointtemplate}"></a>{addendpointtemplate}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.2 <a id="{deleteendpointtemplate}"></a>{deleteendpointtemplate}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.3 <a id="{getenabledendpointtemplates}"></a>{getenabledendpointtemplates}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.4 <a id="{getendpointtemplatebyid}"></a>{getendpointtemplatebyid}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.5 <a id="{getendpointtemplates}"></a>{getendpointtemplates}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.6 <a id="{updateendpointtemplate}"></a>{updateendpointtemplate}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.4 Group

Group is a collection of users. The primary purpose of group is to provide multiple users with the same privillages

**Status Lifecycle**

**Rate Limits**

**Quota Limits**

**Business Rules**

None.


#### 4.4.4.1 <a id="add_a_user_to_a_group"></a>Add A User To A Group####
####  PUT
[HPKeystoneExtensionBaseURI]/groups/{groupId}/users/{userId}
*Privilege Level: SA, DA*

This API is used to add an existing user to a specified group of the given domain. This interface requires the groupId and userId.

**Request Data**

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.


JSON

```
PUT https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
Content-Length: 0
```

XML

```
PUT https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
Content-Length: 0
```


**Success Response**

The response body contains location of newly created group with http status code of 303.


**Status Code**

303 - OK

**Response Data**


JSON

```
HTTP/1.1 303 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Location: https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/
Content-Length: 0
Date: Mon, 01 Aug 2011 18:27:33 GMT
Connection: close
```

XML

```
HTTP/1.1 303 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Location: https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/
Content-Length: 0
Date: Mon, 01 Aug 2011 18:27:33 GMT
Connection: close
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified groupId or userId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request|
 

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
curl -i -H "X-Auth-Token:HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -X PUT "https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203"
```

**Additional Notes**


#### 4.4.4.2 <a id="create_a_group"></a>Create A Group####
####  POST [HPKeystoneExtensionBaseURI]/groups
*Privilege Level: SA,DA*

{Description about the method call}

**Request Data**

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.


JSON

```
POST /v2.0/HP-IDM/v1.0/groups HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f46ba6b2cdc8b1c3905dbca
Host: localhost:9999
Connection: keep-alive
Content-Length: 108
 
{
  "group": {
    "description": "HP Software Group",
    "domainId": "69409986171623",
    "name": "HP Software"
  }
}
```

XML

```
POST /v2.0/HP-IDM/v1.0/groups HTTP/1.1
Accept: application/xml
Content-Type: application/xml
Accept: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f46b1162cdc8b1c3905dbc3
Host: localhost:9999
Connection: keep-alive
Content-Length: 487
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<group xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" domainId="69409986171623" name="HP Cloud Services Business Unit">
  <description>HP Cloud Services Business Unit Engineering and Marketing</description>
</group>
```


**Success Response**

The response body contains data for newly created group with http status code of 201.


**Status Code**

201 - OK

**Response Data**


JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 507
Date: Thu, 23 Feb 2012 21:36:07 GMT
 
{
  "group": {
    "description": "HP Software Group",
    "domainId": "69409986171623",
    "name": "HP Software"
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
Content-Type: application/xml
Content-Length: 507
Date: Thu, 23 Feb 2012 21:36:07 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<group xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" id="68906974845076" domainId="69409986171623" name="HP Cloud Services Business Unit">
  <description>HP Cloud Services Business Unit Engineering and Marketing</description>
</group>
```

**Error Response**

Please refer to error response body for additional details.


**Status Code**


| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified domainId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request| 

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
curl -k  -XPOST -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" -d '{  "group": {   "description": "HP Software Group",    "domainId":"69409986171623",    "name": "HP Software"  }}'  https://localhost:35357/v2.0/HP-IDM/v1.0/groups
```

**Additional Notes**


#### 4.4.4.3 <a id="delates_a_group"></a>Delates A Group####
####  DELETE [HPKeystoneExtensionBaseURI]/groups/{groupId}
*Privilege Level: SA ,DA*

Delete a group specified by the groupId. This operation also deletes the associated Roles associated to the Group. This operation does not delete User objects associated with the Group.

**Request Data**

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.


JSON

```
DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/groups/245398746613/ HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
```

XML

```
DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/groups/245398746613/ HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
```


**Success Response**

The response doesn't have any body. It has  http status code  204.

**Status Code**

204 - OK

**Response Data**

This call doesn't have response body. It returns http code 204 

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=37BD6EDBDC2A58CD18201DFD2C21B6C2; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 28 Dec 2011 19:14:46 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=37BD6EDBDC2A58CD18201DFD2C21B6C2; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 28 Dec 2011 19:14:46 GMT
```

**Error Response**

Please refer to error response body for additional details.


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified groupId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request| 

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
curl -i -H "X-Auth-Token:HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -X DELETE "https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/"
```

**Additional Notes**



#### 4.4.4.4 <a id="get_a_specific_group"></a>Get A Specific Group####
####  GET [HPKeystoneExtensionBaseURI]/groups/{groupId}
*Privilege Level: SA,DA, DU *

{Description about the method call}

**Request Data**


**URL Parameters**


**Data Parameters**

This call does not require a request body

JSON

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678 HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

XML

```

GET https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678 HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

**Success Response**

This call returns the corresponding group. 

**Status Code**

200 - OK

**Response Data**



JSON

```
HTTP/1.1 200 OKHTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=0872F482F66338B2E69820CF34D6BAB0; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 205
Date: Wed, 28 Dec 2011 18:59:46 GMT
 
{
  "group" : {
    "description" : "A Description of the group1",
    "anies" : null,
    "id" : "92138406758615",
    "name" : "HaneefGroup3",
    "otherAttributes" : {
    }
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
Content-Type: application/xml
Content-Length: 277
Date: Mon, 01 Aug 2011 18:26:30 GMT
Connection: close
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><group xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" id="583891759678" name="HaneefGroup3"><description>A Description of the group1</description></group>
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified groupId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request| 

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
curl -k -H "X-Auth-Token:HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3"  "https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/"
```

**Additional Notes**



#### 4.4.4.5 <a id="list_users_for_the_group"></a>List Users For The Group####
####  GET [HPKeystoneExtensionBaseURI]/groups/{groupId}/users
*Privilege Level: SA,DA*

This API is used to list the users for a specified group and takes a "marker" and "limit" parameter to limit the number of Users in the response. Results can also be filtered by using optional filters

**Request Data**


**URL Parameters**

* *limit (Optional)*  - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list
* *username* (Optional)}  - string - filter by user name
* *userId* (Optional)}  - string - filter by user Id


**Data Parameters**

This call does not require a request body 

JSON

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080

```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

Optional: Sample requests using query parameters and filters 

JSON :

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?userName=username HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?userId=412367 HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?limit=50?maker=34353535& HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

**Success Response**

This call retuns list of users 

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
Content-Length: 277
Date: Mon, 01 Aug 2011 18:26:30 GMT
Connection: close

{
  "users" : {
    "otherAttributes" : {
    },
    "user" : [ {
      "domainId" : "00000000001001",
      "emailAddress" : "haneef.ali@hp.com",
      "firstName" : "haneef",
      "otherAttributes" : {
      },
      "passwordResetRequired" : "true",
      "status" : "enabled",
      "userId" : "59587095111744",
      "username" : "haneef"
    },
   {
      "domainId" : "00000000001001",
      "emailAddress" : "haneef.ali1@hp.com",
      "firstName" : "haneef1",
      "otherAttributes" : {
      },
      "passwordResetRequired" : "true",
      "status" : "enabled",
      "userId" : "59587095111745",
      "username" : "haneef1"
    }
 ]
 }

```

XML

```

HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 277
Date: Mon, 01 Aug 2011 18:26:30 GMT
Connection: close

<?xml version="1.0" encoding="UTF-8" standalone="yes"?><users xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom"><user firstName="haneef" username="haneef" userId="59587095111744" emailAddress="haneef.ali@hp.com" status="enabled" domainId="00000000001001" passwordResetRequired="true"/></users>
```

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 277
Date: Mon, 01 Aug 2011 18:26:30 GMT
Connection: close

{
  "users" : {
    "otherAttributes" : {
    },
    "user" : [ {
      "domainId" : "00000000001001",
      "emailAddress" : "haneef.ali@hp.com",
      "firstName" : "haneef",
      "otherAttributes" : {
      },
      "passwordResetRequired" : "true",
      "status" : "enabled",
      "userId" : "59587095111744",
      "username" : "haneef"
    }
 ]
 }

```


**Error Response**

Please refer to error response body for additional details.


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified groupId is not found or userid is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request| 

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
curl -v -k -H "X-Auth-Token: HPAuth_b0846199b9d7c4aa0c7c86169ef693e6298da25c564adff6e002bea84f0b337f"   -H "Accept: application/json" https://csnode.ndd.aw1.hpcloud.net:35357/v2.0/HP-IDM/v1.0/groups/00000000002002/users?userName=haneef

```

**Additional Notes**



#### 4.4.4.6 <a id="delete_user_from_the_group"></a>Delete User From The Group####
#### DELETE 	[HPKeystoneExtensionBaseURI]/groups/{groupId}/users/{userId}
*Privilege Level: SA,DA*

Remove a user from a group   

**Request Data**


**URL Parameters**


**Data Parameters**


JSON

```
DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

XML

```
DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```


**Success Response**

The response doesn't have any content. 

**Status Code**

204 - OK

**Response Data**

The response doesn't have any content

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 01 Aug 2011 18:31:40 GMT
Connection: close
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 01 Aug 2011 18:31:40 GMT
Connection: close
```

**Error Response**

Please refer to error response body for additional details.


**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
curl -v -k -H "X-Auth-Token: HPAuth_b0846199b9d7c4aa0c7c86169ef693e6298da25c564adff6e002bea84f0b337f" -X DELETE  -H "Accept: application/json" https://csnode.ndd.aw1.hpcloud.net:35357/v2.0/HP-IDM/v1.0/groups/00000000002002/993639569203
```

**Additional Notes**


#### 4.4.4.7 <a id="update_group"></a>Update Group####
####  PUT 	[HPKeystoneExtensionBaseURI]/groups/{groupId}
*Privilege Level: SA, DA*

Update a group resource for the specified groupId.   Only description and name can  be updated in this operation.

**Request Data**


**URL Parameters**


**Data Parameters**



JSON

```
PUT /v2.0/HP-IDM/v1.0/groups/68906974845076 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f46b1162cdc8b1c3905dbc3
Host: localhost:9999
Connection: keep-alive
Content-Length: 108
 
{
  "group": {
    "description": "HP Software Group",
    "domainId": "69409986171623",
    "name": "HP Software"
  }
}
```

XML

```
PUT /v2.0/HP-IDM/v1.0/groups/68906974845076 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f46b1162cdc8b1c3905dbc3
Host: localhost:9999
Connection: keep-alive
Content-Length: 487
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<group xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" domainId="69409986171623" name="HP Software">
  <description>HP Software Group</description>
</group>
```



**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 206
Date: Thu, 23 Feb 2012 22:16:06 GMT
 
{
  "group": {
    "description": "HP Software Group",
    "anies": null,
    "domainId": "69409986171623",
    "id": "68906974845076",
    "name": "HP Software",
    "otherAttributes": {
 
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
Content-Type: application/xml
Content-Length: 507
Date: Thu, 23 Feb 2012 21:36:07 GMT
 
<group id="68906974845076" name="HP Software" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <description>HP Software Group</description>
</group>
```

**Error Response**

Please refer to error response body for additional details.


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified groupId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request| 

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
curl -k  -X PUT -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" -d '{  "group": {   "description": "HP Software Group",      "name": "HP Software"  }}'  https://localhost:35357/v2.0/HP-IDM/v1.0/groups/68906974845076
```

**Additional Notes**




### 4.4.5 Management Console

Hitherto the MC has stored data in its own Mongo service and defined its own database and set of collections. Control Services was added to the HP Cloud deployment in the Maine release. CS also maintains its own Mongo service and database. 

There are two primary problems with maintaining separate Mongo services for MC and CS. First, we must install and maintain two separate systems. In the current release CS and MC do not even share the same Mongo version. Second, MC and CS maintain their own copies of exactly the same data without any mechanism for automated reconciliation. This has led to issues of data inconsistencies during the Augusta timeframe.

For the Texas release we plan to expose Control Service APIs to allow the Management Console to easily store and access persistent data from the CS Mongo database. This will prevent issues of data inconsistencies. Additionally, the CS Mongo service will be configured with a second database dedicated to MC. The MC database will only store transient data and will not require backup. This will alleviate the overhead of installing and maintain to separate versions and installations in the data center.

This page describes the proposed  APIs that the Management Console will use to access persistent data that is maintained in the Control Services database. The following experimental APIs are available only on the Texas development branch. The APIs are currently not listed in the list of published Control Services APIs while they are under development.

#### Issues to be Resolved ####

* PurgeUser action must cascade to the user's preferences. Need to check PurgeDomain call to see if it also propagates...
* We need to review the contents of the UserDetails class. What fields should we add and/or remove.
* Need to configure the security XML file so that only MC can access these APIs.
* Might be nice to bundle the UserDetails with the Token call so MC could grab everything for a user in one go.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.5.1 <a id="user_details"></a>User Details####
#### GET [HPKeystoneExtensionBaseURI]/users/details/{userId}
*Privilege Level: MC-CS Certificate*

The UserDetails class is a dynamically constructed amalgamation of many different database collections.

**Request Data**

**URL Parameters**

* *userId* - Long - The id of the user

**Data Parameters**

This call does not require a request body

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "user" : {
    "state" : "Colorado",
    "country" : "United States",
    "status" : "ENABLED",
    "city" : "Fort Collins",
    "accountId" : "37598452056865",
    "domainId" : "71688867269283",
    "contactId" : null,
    "billingId" : "4028e6963577fe0d0135828a2e5647d8",
    "addressLine1" : "1234 Harmony Road",
    "addressLine2" : "MS 5678",
    "zip" : "97222",
    "phone" : "9705551212",
    "company" : "Hewlett Packard Cloud Seeding",
    "website" : "http://www.hp.com",
    "emailAddress" : "bozo@hp.com",
    "passwordResetCount" : null,
    "passwordResetTime" : null,
    "passwordLockoutStartTime" : null,
    "username" : "JL1329334986631",
    "firstName" : "James",
    "lastName" : "Long",
    "passwordLockoutCount" : null,
    "passwordLockoutWindow" : null,
    "timeLastSuccessfulLogin" : null,
    "passwordRetryTimespan" : null,
    "passwordRetryStartTime" : null
  },
  "domain" : {
    "name" : "71688867269283-DOMAIN",
    "state" : "Colorado",
    "country" : "United States",
    "status" : "ENABLED",
    "description" : null,
    "city" : "Fort Collins",
    "domainId" : "71688867269283",
    "contactId" : null,
    "billingId" : "4028e6963577fe0d0135828a2b7f47d1",
    "addressLine1" : "1234 Harmony Road",
    "addressLine2" : "MS 5678",
    "zip" : "97222",
    "phone" : "9705551212",
    "company" : "Hewlett Packard Cloud Seeding",
    "website" : "http://www.hp.com",
    "emailAddress" : "bozo@hp.com"
  },
  "tenants" : [ {
    "name" : "NoveTenant1329334994693",
    "status" : "ENABLED",
    "description" : "Compute",
    "tenantId" : "39525494045831",
    "billingId" : null,
    "swiftAccountHash" : null
  } ],
  "jobs" : [ {
    "status" : "COMPLETE",
    "action" : "TEST",
    "errorDescription" : "",
    "submission" : null,
    "completion" : null,
    "jobticketId" : ""
  } ],
  "preferences" : {
    "substore" : [ {
      "storeName" : "UI Preferences",
      "store" : {
        "substore" : [ ],
        "preference" : [ {
          "key" : "Font",
          "value" : "Dingbat"
        }, {
          "key" : "BackgroundColor",
          "value" : "BLACK"
        }, {
          "key" : "ForegroundColor",
          "value" : "BROWN"
        } ]
      }
    } ],
    "preference" : [ ],
    "accountId" : "37598452056865",
    "id" : {
      "time" : 1329335008000,
      "machine" : 224520590,
      "timeSecond" : 1329335008,
      "inc" : -1996416285,
      "new" : false
    },
    "setId" : true,
    "idHex" : null,
    "version" : 1,
    "setVersion" : true,
    "dateRecordAdded" : 1329335008246,
    "setDateRecordAdded" : true,
    "dateLastModified" : 1329335008246,
    "setDateLastModified" : true,
    "bs" : false,
    "immutable" : null
  },
  "id" : null,
  "setId" : false,
  "idHex" : null,
  "version" : 0,
  "setVersion" : true,
  "dateRecordAdded" : null,
  "setDateRecordAdded" : false,
  "dateLastModified" : null,
  "setDateLastModified" : false,
  "bs" : false,
  "immutable" : null
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<userDetails>
    <version>0</version>
    <domain>
        <addressLine1>1234 Harmony Road</addressLine1>
        <addressLine2>MS 5678</addressLine2>
        <billingId>4028e6963577fe0d0135828a2b7f47d1</billingId>
        <city>Fort Collins</city>
        <company>Hewlett Packard Cloud Seeding</company>
        <country>United States</country>
        <domainId>71688867269283</domainId>
        <emailAddress>bozo@hp.com</emailAddress>
        <name>71688867269283-DOMAIN</name>
        <phone>9705551212</phone>
        <state>Colorado</state>
        <status>ENABLED</status>
        <website></website>
        <zip>97222</zip>
    </domain>
    <jobTickets>
        <jobTicket>
            <action>TEST</action>
            <errorDescription></errorDescription>
            <jobticketId></jobticketId>
            <status>COMPLETE</status>
        </jobTicket>
    </jobTickets>
    <userPreferences>
        <dateLastModified>2012-02-15T12:43:28.246-07:00</dateLastModified>
        <dateRecordAdded>2012-02-15T12:43:28.246-07:00</dateRecordAdded>
        <id/>
        <version>1</version>
        <userId>37598452056865</userId>
        <substores>
            <substore>
                <storeName>UI Preferences</storeName>
                <store>
                    <substores/>
                    <preferences>
                        <preference>
                            <key>Font</key>
                            <value>Dingbat</value>
                        </preference>
                        <preference>
                            <key>BackgroundColor</key>
                            <value>BLACK</value>
                        </preference>
                        <preference>
                            <key>ForegroundColor</key>
                            <value>BROWN</value>
                        </preference>
                    </preferences>
                </store>
            </substore>
        </substores>
        <preferences/>
    </userPreferences>
    <tenants>
        <tenant>
            <services>
                <service>
                    <regionCode>az-1.region-a.geo-1</regionCode>
                    <serviceName>Compute</serviceName>
                    <status>ENABLED</status>
                </service>
                <service>
                    <regionCode>az-1.region-a.geo-1</regionCode>
                    <serviceName>Block Storage</serviceName>
                    <status>ENABLED</status>
                </service>
                <service>
                    <regionCode>az-1.region-a.geo-1</regionCode>
                    <serviceName>Image Management</serviceName>
                    <status>ENABLED</status>
                </service>
            </services>
            <description>Compute</description>
            <name>NoveTenant1329334994693</name>
            <status>ENABLED</status>
            <tenantId>39525494045831</tenantId>
        </tenant>
    </tenants>
    <user>
        <accountId>37598452056865</accountId>
        <addressLine1>1234 Harmony Road</addressLine1>
        <addressLine2>MS 5678</addressLine2>
        <billingId>4028e6963577fe0d0135828a2e5647d8</billingId>
        <city>Fort Collins</city>
        <company>Hewlett Packard Cloud Seeding</company>
        <country>United States</country>
        <domainId>71688867269283</domainId>
        <emailAddress>bozo@hp.com</emailAddress>
        <firstName>James</firstName>
        <lastName>Long</lastName>
        <phone>9705551212</phone>
        <state>Colorado</state>
        <status>ENABLED</status>
        <username>JL1329334986631</username>
        <website></website>
        <zip>97222</zip>
    </user>
</userDetails>
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

An incorrect user id will result in a service unavailable response.
 
```
{
  "serviceUnavailable" : {
    "code" : 500,
    "details" : "Server error",
    "message" : "Service unavailable",
    "otherAttributes" : {
    }
  }
}
```

An incorrect auth token will result in a service unavailable response.

```
{
  "serviceUnavailable" : {
    "code" : 500,
    "details" : "Server error",
    "message" : "Service unavailable",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

**Curl Example**

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/users/details/<user-id>
```


#### 4.4.5.2 <a id="user_preferences"></a>User Preferences####
#### GET [HPKeystoneExtensionBaseURI]/preferences/{userId}
*Privilege Level: MC-CS Certificate*

The UserPreference database collection is nothing more that a set of nested hash maps that is associated with a specific user.  Querying it returns that hash map.

**Request Data**

Only the user id is required to retrieve the preferences.

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *userId* - Long - The id of the user.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
{ "substore":
  [
    { "storeName":"Stuff",
      "store":
        {
          "substore":[],
          "preference":
            [
              {"key":"Key 1","value":"Value One"},
              {"key":"Something Else","value":"Another thing...."},
              {"key":"Crap","value":"More Crap"}
            ],
        }
    },
    { "storeName":"More Stuff",
      "store":
        {
          "substore":[],
          "preference":
            [
              {"key":"Quote","value":"\"There is nothing either good or bad, but thinking makes it so.\""},
              {"key":"Source","value":"Hamlet II,ii"},
              {"key":"Author","value":"Billy Shakespeare"}
            ],
        }
    }
  ],
  "preference":[],
  "accountId":"1329330396830",
  "id":{"time":1329330396000,"machine":224492956,"timeSecond":1329330396,"inc":827625712,"new":false},
  "setId":true,
  "idHex":"4f3bf8dc0d617d9c315490f0",
  "version":1,
  "setVersion":true,
  "dateRecordAdded":1329330396999,
  "setDateRecordAdded":true,
  "dateLastModified":1329330396999,
  "setDateLastModified":true,
  "bs":false,
  "immutable":null
}
```

XML

```
{xml data structure here}
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<userPreferences>
    <dateLastModified>2012-02-15T11:16:13.421-07:00</dateLastModified>
    <dateRecordAdded>2012-02-15T11:16:13.421-07:00</dateRecordAdded>
    <id/>
    <version>1</version>
    <userId>1329329773337</userId>
    <substores>
        <substore>
            <storeName>Stuff</storeName>
            <store>
                <substores/>
                <preferences>
                    <preference>
                        <key>Key 1</key>
                        <value>Value One</value>
                    </preference>
                    <preference>
                        <key>Something Else</key>
                        <value>Another thing....</value>
                    </preference>
                    <preference>
                        <key>Crap</key>
                        <value>More Crap</value>
                    </preference>
                </preferences>
            </store>
        </substore>
        <substore>
            <storeName>More Stuff</storeName>
            <store>
                <substores/>
                <preferences>
                    <preference>
                        <key>Quote</key>
                        <value>&quot;There is nothing either good or bad, but thinking makes it so.&quot;</value>
                    </preference>
                    <preference>
                        <key>Source</key>
                        <value>Hamlet II,ii</value>
                    </preference>
                    <preference>
                        <key>Author</key>
                        <value>Billy Shakespeare</value>
                    </preference>
                </preferences>
            </store>
        </substore>
    </substores>
    <preferences/>
</userPreferences>
```

Curl Example

```
curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <path-to-cert> --cacert <path-to-cacert> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/preferences/<userId>
```

#### PUT [HPKeystoneExtensionBaseURI]/preferences/{userId}
*Privilege Level: MC-CS Certificate*

The UserPreference database collection is nothing more that a set of nested hash maps that is associated with a specific user.  Values may be updated.

**Request Data**

Only the user id is required to retrieve the preferences.

**URL Parameters**

Not yet documented

* *userId* - Long - The id of the user.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

Not yet documented.

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

Not yet documented.

**Curl Example**

Not yet documented.


### 4.4.6 Region

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.6.1 <a id="{getservicebyid}"></a>{getservicebyid}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.6.2 <a id="{listregisteredservices}"></a>{listregisteredservices}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.6.3 <a id="{registernewservice}"></a>{registernewservice}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.6.4 <a id="{updateservice}"></a>{updateservice}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.7 Role Assignment

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.7.1 <a id="{checktenantroleassignmentforuser}"></a>{checktenantroleassignmentforuser}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.2 <a id="{creategroupsglobalroleassignment}"></a>{creategroupsglobalroleassignment}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.3 <a id="{createtenantroleassignmentforgroup}"></a>{createtenantroleassignmentforgroup}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.4 <a id="{createtenantroleassignmentforuser}"></a>{createtenantroleassignmentforuser}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.5 <a id="{createusersglobalroleassignment}"></a>{createusersglobalroleassignment}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.6 <a id="{deletegroupsglobalroleassignment}"></a>{deletegroupsglobalroleassignment}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.7 <a id="{deletetenantroleassignmentforgroup}"></a>{deletetenantroleassignmentforgroup}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.8 <a id="{deletetenantroleassignmentforuser}"></a>{deletetenantroleassignmentforuser}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.9 <a id="{deleteusersglobalroleassignment}"></a>{deleteusersglobalroleassignment}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.10 <a id="{getnontenantrasdomain}"></a>{getnontenantrasdomain}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.11 <a id="{getusersglobalrole}"></a>{getusersglobalrole}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.12 <a id="{listgroupsglobalroles}"></a>{listgroupsglobalroles}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.13 <a id="{listtenantroleassignment}"></a>{listtenantroleassignment}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.14 <a id="{listtenantroleassignmentforgroup}"></a>{listtenantroleassignmentforgroup}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.15 <a id="{listtenantroleassignmentforuser}"></a>{listtenantroleassignmentforuser}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.16 <a id="{listusersglobalroles}"></a>{listusersglobalroles}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.8 Role Defs

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.8.1 <a id="{createroledef}"></a>{createroledef}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.2 <a id="{deleteroledef}"></a>{deleteroledef}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.3 <a id="{getdomainsroledefs}"></a>{getdomainsroledefs}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.4 <a id="{getroleadef}"></a>{getroleadef}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.5 <a id="{listroledefs}"></a>{listroledefs}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.6 <a id="{updateroledef}"></a>{updateroledef}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.7 <a id="{updateroledefscope}"></a>{updateroledefscope}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.9 Service

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.9.1 <a id="{getservicebyid}"></a>{getservicebyid}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.9.2 <a id="{listregisteredservices}"></a>{listregisteredservices}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.9.3 <a id="{registernewservice}"></a>{registernewservice}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.9.4 <a id="{updateservice}"></a>{updateservice}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.10 Signature

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.10.1 <a id="{ec2signature}"></a>{ec2signature}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.10.2 <a id="{genericsignature}"></a>{genericsignature}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.11 Tenant

A Tenant is a collection of services, associated with zero or more users who have access to these services via role references.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.11.1 <a id="get_all_tenants"></a>Get All Tenants####
#### GET [HPKeystoneExtensionBaseURI]/tenants
*Privilege Level: SA*

Allows reading a list of all tenants across domains. This API supports pagination through 'limit' and 'marker' usage. The returned list may be filtered to allow only those tenants which the caller has access to. The operation does not require a request body.

**Request Data**

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the resource Id of the last item in the previous list.
* *name* (Optional) - string - name of the tenant to be returned.

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.


JSON

```
GET /v2.0/HP-IDM/v1.0/tenants/ HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/tenants/ HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

Optional:

Request With Name Filter:

JSON

```
GET /v2.0/HP-IDM/v1.0/tenants?name=tenantName HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/tenants?name=tenantName HTTP/1.1
Accept: application/json
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 240
Date: Tue, 29 Nov 2011 17:17:50 GMT
 
{
  "tenants": {
    "anies": null,
    "otherAttributes": {
 
    },
    "tenant": [
      {
        "description": "Tenant for hosting Time Warner Applications and services",
        "anies" : null,
        "domainId": "26349998090400",
        "name": "Time Warner Tenant Services",
        "otherAttributes": {
 
        },
        "status": "enabled",
        "tenantId": "541212460710"
      }
    ]
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
Content-Type: application/xml
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenants xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.w3.org/2005/Atom">
   <tenant name="Time Warner Tenant Services" tenantId="541212460710" domainId="26349998090400" status="enabled">
      <description>Tenant for hosting Time Warner Applications and services</description>
   </tenant>
</tenant>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants"
```

#### 4.4.11.2 <a id="get_a_tenant"></a>Get A Tenant####
#### GET [HPKeystoneExtensionBaseURI]/tenants/{tenantId} 
*Privilege Level: SA, DA, DU*

Get a tenant based on the {tenantId} specified. tenantId's are opaque values returned with get tenant list operations. This operation does not require a request body.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to be retrieved.

**Data Parameters**

This call does not require a request body.

JSON

```
GET /v2.0/HP-IDM/v1.0/tenants/48164969660120 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e9767412cdcb18069188479
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e9767412cdcb18069188479
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 286
Date: Thu, 13 Oct 2011 22:36:13 GMT
 
{
  "tenant" : {
    "description" : "Tenant for hosting Time Warner Oracle Applications & services",
    "domainId" : "47826457774667",
    "name" : "Time Warner Oracle Tenant Services",
    "otherAttributes" : {
    },
    "status" : "enabled",
    "tenantId" : "48164969660120"
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
Content-Type: application/xml
Content-Length: 254
Date: Wed, 10 Aug 2011 22:36:32 GMT
 
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"
enabled="true" status="enabled" domainId="798477662343"
tenantId="270316896886"
description="Tenant for Sales Forecasting service" />
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The Tenant for this tenantId does not exist. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/48164969660120" 
```

#### 4.4.11.3 <a id="check_for_existence_of_tenant_name"></a>Check For Existence Of Tenant Name####
#### HEAD [HPKeystoneExtensionBaseURI]/tenants?name=tenantName
*Privilege Level: Anon*

Returns http status code indicating the result of tenantName existence check.

This API does case sensitive tenantName lookup in system. It returns http status code 200 (Ok) when provided tenantName exists and returns 404 (not found) when provided tenantName is not found in the system. If provided tenantName is blank or missing, then it returns 204 (No content). The tenant name with extra spaces is converted to single space in-between words and then look up is done for its existence. So tenant name " Abc Image Service " and "ABC    Image service" are treated as same and will be found if entry is there in system. In system, the corresponding name is going to be stored as "abc image service" in a separate field.
As this API just checks for existence of provided tenantName, it does not do look into status (or any other entity attribute) for case when matching tenant is found.

**Request Data**

**URL Parameters**

* *name* - string - name of the tenant to check for existence of.

**Data Parameters**

This call does not require a request body.

XML/JSON Request and Response

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants?name=HP%20Cloud%20System%20Domain's-Tenant01 HTTP/1.1
Accept-Encoding: gzip,deflate
 
 
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:29:46 GMT
```

XML/JSON Request and Response (case-insensitive lookup of above tenantName)

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants?name=hP%20ClOUD%20SYstem%20Domain's-Tenant01 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
 
 
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:30:54 GMT
```

XML/JSON Request and Response (provided tenantName not found)

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants HTTP/1.1HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
 
 
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: \-1
Content-Type: text/html;charset=utf-8
Content-Length: 952
Date: Tue, 21 Aug 2012 19:31:40 GMT
```

XML/JSON Request Response (missing tenantName in request)

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants HTTP/1.1
Accept-Encoding: gzip,deflate
 
 
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Tue, 21 Aug 2012 19:32:10 GMT
```

**Success Response**

**Status Code**

* 200 - OK
* 404 - NOT FOUND

**Response Data**

This call does not return a response body.

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 204 | No Content | When tenantName is missing or blank. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

**Response Data**

This call does not return a response body.

Curl Example

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X HEAD -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants?name=tenantName"
```

**Additional Notes**

There is no response body returned in API response data. This API does not require http header X-Auth-Token and is protected by client certificate authentication.

#### 4.4.11.4 <a id="get_a_list_of_users_for_a_tenant_(includes_role_assignments)"></a>Get A List Of Users For A Tenant (includes Role Assignments)####
#### GET [HPKeystoneExtensionBaseURI]/tenants/{tenantId}/users
*Privilege Level: SA, DA*

This API returns all Users for a given Tenant, Roles associated for each User is also returned. If the user is not a valid, an error is returned.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to return users for.
* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the resource Id of the last item in the previous list.

**Data Parameters**

This call does not require a request body.

JSON

```
GET /v2.0/HP-IDM/v1.0/tenants/96488406679080/users HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8b5dea2cdc3d29c14604d5
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/tenants/96488406679080/users HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8b6e4c2cdc999e9328f727
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 1484
Date: Tue, 04 Oct 2011 19:44:31 GMT
 
{
  "users": {
    "anies": null,
    "otherAttributes": {
 
    },
    "user": [
      {
        "roles": [
          {
            "anies": null,
            "description": "Group 26155043473055 has role domainadmin in 29649421790262 domain",
            "id": "00000000004003",
            "otherAttributes": {
 
            },
            "serviceId": null,
            "tenantId": null
          },
          {
            "anies": null,
            "description": "User 31190669223287 has role null in 29649421790262 domain",
            "id": "82420955976896",
            "otherAttributes": {
 
            },
            "serviceId": null,
            "tenantId": "96488406679080"
          },
          {
            "anies": null,
            "description": "Group 55207359871951 has role null in 29649421790262 domain",
            "id": "00000000004004",
            "otherAttributes": {
 
            },
            "serviceId": null,
            "tenantId": null
          }
        ],
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": "USA",
        "domainId": "29649421790262",
        "emailAddress": "Xml?User8&@timewarner.com",
        "firstName": "First",
        "lastName": "Last",
        "otherAttributes": {
 
        },
        "password": null,
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "userId": "31190669223287",
        "username": "Xml?User8&@timewarner.com",
        "website": "http://www.timewarner.com",
        "zip": "90210"
      }
    ]
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
Set-Cookie: JSESSIONID=98D892BBE6A3F1093562567297E334B9; Path=/v2.0
Content-Type: application/xml
Content-Length: 913
Date: Tue, 04 Oct 2011 20:36:51 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<users xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
  <user firstName="First" lastName="Last" username="Xml?User8&amp;@timewarner.com" userId="31190669223287" addressLine1="128, Hollywood Blvd" city="Los Angeles" state="CA" country="USA" zip="90210" phone="1-800-555-1212" website="http://www.timewarner.com" emailAddress="Xml?User8&amp;@timewarner.com" status="enabled" domainId="29649421790262">
    <roles id="00000000004003" description="Group 26155043473055 has role domainadmin in 29649421790262 domain"/>
    <roles id="82420955976896" description="User 31190669223287 has role null in 29649421790262 domain" tenantId="96488406679080"/>
    <roles id="00000000004004" description="Group 55207359871951 has role null in 29649421790262 domain"/>
  </user>
</users>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The Tenant for this tenantId does not exist. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/users"
```

#### 4.4.11.5 <a id="create_a_tenant"></a>Create A Tenant####
#### POST [HPKeystoneExtensionBaseURI]/tenants 
*Privilege Level: SA, DA*

Creates a tenant using the specified request body. The provided tenant name MUST be unique in the system.  A response body is also returned with the new tenant information with a service generated tenantId.

**Request Data**

**URL Parameters**

None.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *description* - string - Description of the tenant being created.
* *domainId* - string - The Id of the domain this tenant is a member of.
* *name* - string - The name of the tenant being created.
* *status* - string (Optional) - String to describe the initial status of this tenant (enabled/disabled).

JSON

```
POST /v2.0/HP-IDM/v1.0/tenants HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e9767412cdcb18069188479
Host: localhost:9999
Connection: keep-alive
Content-Length: 165
 
{
  "tenant": {
    "description": "Payroll Tenant Services for TimeWarner",
    "domainId": "47826457774667",
    "name": "Payroll Tenant Services",
    "status": "enabled"
  }
}
```

XML

```
POST /v2.0/HP-IDM/v1.0/tenants HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
Content-Length: 254
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" name="Time Warner Salesforce Services" domainId="27960688482075" status="enabled">
  <description>Tenant for hosting Time Warner Salesforce Applications</description>
</tenant>
```

**Success Response**

**Status Code**

* 200 - Created

**Response Data**

JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 252
Date: Thu, 13 Oct 2011 22:51:31 GMT
 
{
  "tenant": {
    "description": "Payroll Tenant Services for TimeWarner",
    "domainId": "47826457774667",
    "name": "Payroll Tenant Services",
    "otherAttributes": {
 
    },
    "status": "enabled",
    "tenantId": "34159634776038"
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
Set-Cookie: JSESSIONID=709FDF3145EB4A85A2253B00AE39CD18; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 319
Date: Wed, 28 Sep 2011 21:43:24 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
name="HP Swift Tenant Services" 
description="Tenant for hosting HR Applications &amp; services" 
tenantId="76063089090850" 
domainId="77759980331221" 
status="enabled" 
swiftAccountHash="1234bcdefgh"/>
```

XML response with swift account hash

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 278
Date: Fri, 19 Aug 2011 20:37:03 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" name="HR Tenant Services" description="Tenant for hosting HR Applications &amp; services" tenantId="309492202938" domainId="798477662343" status="enabled"/>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Will be returned if a Tenant with the name already exists in the system or if a Tenant with swift account hash already exists in the system. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X POST -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants" -d '{"tenant":{"description":"Payroll Tenant Services for TimeWarner","domainId":"47826457774667","name":"Payroll Tenant Services","status":"enabled"}}'
```

#### 4.4.11.6 <a id="update_a_tenant"></a>Update A Tenant####
#### PUT [HPKeystoneExtensionBaseURI]/tenants/{tenantID} 
*Privilege Level: SA, DA*

Allows updating an existing tenant using the tenantId and request body. Does not allow update or change of tenantId and domainId ('domainId' cannot be updated, passing that in request body will result in failure).

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to be updated.

**Data Parameters**

See tenant schema file for more details on the request and response data structure.

JSON

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/37942731773710 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ecab298b0be470b008da2ab
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 132
 
{"tenant": {
   "description": "Tenant for Market forecasting service",
   "otherAttributes": {"swiftAccountHash": "abcd23456"}
}}
```

XML

```
PUT /v2.0/HP-IDM/v1.0/tenants/33841725750480 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4eb4288e2cdca60d5a48e9a1
Host: localhost:9999
Connection: keep-alive
Content-Length: 350
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" status="disabled"/>
```

XML (with swift account hash)

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/76063089090850 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e8397c5b0bedc2f5c932a15
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 267
 
<tenant name="HP Swift Tenant Services" 
description="Tenant for hosting HR Applications &amp; services" 
status="enabled" 
swiftAccountHash="abcdefgh123456" 
xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"/>
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=C869D386993E9F92B3E2FC1935B00154; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 313
Date: Mon, 21 Nov 2011 20:20:53 GMT
 
{
  "tenant" : {
    "description" : "Tenant for Market forecasting service",
    "anies" : null,
    "domainId" : "32046002839662",
    "name" : "HP Swift Tenant 2 Services",
    "otherAttributes" : {
      "swiftAccountHash" : "abcd23456"
    },
    "status" : "enabled",
    "tenantId" : "37942731773710"
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
Set-Cookie: JSESSIONID=3E1203905FC35B1519A6107B936173B5; Path=/
Content-Type: application/xml
Content-Length: 491
Date: Fri, 04 Nov 2011 18:02:42 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" name="EMail Service" tenantId="33841725750480" domainId="36528361097134" status="disabled">
  <description>Tenant for Email and Chat Service</description>
</tenant>
```

XML (with swift account hash)

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=86D76B52AABD080B77ED24F0722DF175; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 322
Date: Wed, 28 Sep 2011 21:59:05 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
name="HP Swift Tenant Services" 
description="Tenant for hosting HR Applications &amp; services" 
tenantId="76063089090850" 
domainId="77759980331221" 
status="enabled" 
swiftAccountHash="abcdefgh123456"/>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The Tenant for this tenantId does not exist. |
| 409 | Conflict | Will be returned if a Tenant with the name already exists in the system or if a Tenant with swift account hash already exists in the system. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X PUT -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/37942731773710" -d '{"tenant":{"description":"Tenant for Market forecasting service","otherAttributes":{"swiftAccountHash":"abcd23456"}}}'
```

#### 4.4.11.7 <a id="delete_a_tenant"></a>Delete A Tenant####
#### DELETE [HPKeystoneExtensionBaseURI]/tenants/{tenantId}
*Privilege Level: SA, DA*

Deletes the specified tenant by its tenantId. This API also deletes the Roles and Endpoints associated with the Tenant.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to be deleted.

**Data Parameters**

This call does not require a request body.

XML

```
DELETE /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

JSON

```
DELETE /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 204 (No Content), Deletion of the Tenant was successful.

**Response Data**

This call does not return a response body.

(No JSON/XML format differences)

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=74ADEBA6F2523478A1700D664FD70C75; Path=/v2.0; Secure
Date: Wed, 12 Oct 2011 22:02:16 GMT
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request.  This error is also returned when there is dependent data that needs to be removed as well. |
| 404 | Not Found | The Tenant for this tenantId does not exist. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X DELETE -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/48164969660120" 
```

#### 4.4.11.8 <a id="get_endpoints_for_a_tenant"></a>Get Endpoints For A Tenant####
#### GET HPKeystoneExtensionBaseURI]/tenants/{tenantId}/endpoints
*Privilege Level: SA, DA, DU*

Get a list of endpoints for a tenant. Each endpoint data in the returned list has reference URL which can be used to query specific endpointTemplate (i.e. in format /endpointTemplates/{endpointTemplateId}) . This list will include disabled endpoint templates id. The operation does not require a request body.

TenantId is required and must be enabled in the system. This will not include global endpoints which are available to all tenants in all domains.

This API supports pagination through 'limit' and 'marker' usage. Marker is endpointId and should be valid otherwise 404 (not found) error is going to be returned.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to return endpoints for.
* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the resource Id of the last item in the previous list.

**Data Parameters**

This call does not require a request body.

JSON

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 1311
Date: Wed, 12 Oct 2011 21:55:43 GMT
 
{
  "endpoints" : {
    "anies" : null,
    "endpoint" : [ {
      "version" : {
        "id" : "1.0",
        "info" : "http://127.0.0.1:8080//info/v1.0",
        "list" : "http://127.0.0.1:8080/allVersions",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
      "id" : 541,
      "internalURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
      "name" : "Object Storage",
      "otherAttributes" : {
      },
      "publicURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
      "region" : "RegionOne",
      "tenantId" : "95096564413950",
      "type" : "object-store"
    }, {
      "version" : {
        "id" : "1.1",
        "info" : "http://127.0.0.1:9292/info/v1.1",
        "list" : "http://127.0.0.1:9292/allVersions",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "http://127.0.0.1:9292/v1.1/%tenant_id%",
      "id" : 542,
      "internalURL" : "http://127.0.0.1:9292/v1.1/%tenant_id%",
      "name" : "Image Management",
      "otherAttributes" : {
      },
      "publicURL" : "http://127.0.0.1:9292/v1.1/%tenant_id%",
      "region" : "RegionOne",
      "tenantId" : "95096564413950",
      "type" : "image-service"
    } ],
    "otherAttributes" : {
    }
  }
}
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=CDB7DDF03251286D930B9FEAE11F5128; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 977
Date: Wed, 12 Oct 2011 21:52:02 GMT
 
<endpoints xmlns="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns2="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns3="http://www.w3.org/2005/Atom">
   <endpoint id="541" type="object-store" name="Object Storage"
            region="RegionOne" publicURL="http://127.0.0.1:8080/v1/AUTH_%tenant_id%" 
            internalURL="http://127.0.0.1:8080/v1/AUTH_%tenant_id%" 
            adminURL="http://127.0.0.1:8080/v1/AUTH_%tenant_id%" 
            tenantId="95096564413950">
      <version id="1.0" info="http://127.0.0.1:8080//info/v1.0" list="http://127.0.0.1:8080/allVersions"/>
   </endpoint>
   <endpoint id="542" type="image-service" name="Image Management"
            region="RegionOne" publicURL="http://127.0.0.1:9292/v1.1/%tenant_id%"
            internalURL="http://127.0.0.1:9292/v1.1/%tenant_id%"
            adminURL="http://127.0.0.1:9292/v1.1/%tenant_id%" 
            tenantId="95096564413950">
      <version id="1.1" info="http://127.0.0.1:9292/info/v1.1" list="http://127.0.0.1:9292/allVersions"/>
   </endpoint>
</endpoints>
Accept-Encoding: gzip,deflate
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | Either the tenantId specified is not found or invalid marker is provided (matching marker id not found in database). |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints"
```

**Additional Notes**

*Open Issues*

1. Do we just include enabled endpoints or all of them? In keystone reference code base, it does not filter by enabled flag (i.e. includes all of them).
Current Impl: We don't filter by enabled flag so include all of them.
1. Do we need to include global endpoints (endpoint templates with global flag as true) in this call? In keystone reference code base, it does not include them.  Current Impl: We don't include global endpoint templates in the response.


#### 4.4.11.9 <a id="add_endpoint_to_a_tenant"></a>Add Endpoint To A Tenant####
#### POST HPKeystoneExtensionBaseURI]/tenants/{tenantId]}/endpoints
*Privilege Level: SA, DA*

Add endpoint template association with a tenant. 

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to return users for.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *endpointTemplate id* - string - Unique ID of the endpoint template being associated to this tenant.

JSON

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 51
 
{
    "endpointTemplate":{
        "id":120
    }
}
```

XML

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 183
 
<endpointTemplate
  xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:type="EndpointTemplateWithOnlyId"
  id="110"/>
```

**Success Response**

**Status Code**

* 201 - Created

**Response Data**

JSON

```
HTTP/1.1 201 CreatedHTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 589
Date: Wed, 12 Oct 2011 21:38:10 GMT
 
{
  "endpoint" : {
    "version" : {
      "id" : "1.0",
      "info" : "http://127.0.0.1:8080//info/v1.0",
      "list" : "http://127.0.0.1:8080/allVersions",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
    "id" : 541,
    "internalURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
    "name" : "Object Storage",
    "otherAttributes" : {
    },
    "publicURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
    "region" : "RegionOne",
    "tenantId" : "95096564413950",
    "type" : "object-store"
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
Set-Cookie: JSESSIONID=CDB8CBA09CE01A8160BAC1D4A2EE01A4; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 574
Date: Wed, 12 Oct 2011 21:44:26 GMT
 
<endpoint id="542" type="image-service" name="Image Management" 
region="RegionOne" 
publicURL="http://127.0.0.1:9292/v1.1/%tenant_id%" 
internalURL="http://127.0.0.1:9292/v1.1/%tenant_id%" 
adminURL="http://127.0.0.1:9292/v1.1/%tenant_id%" 
tenantId="95096564413950" 
xmlns="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns2="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns3="http://www.w3.org/2005/Atom">
   <version id="1.1" info="http://127.0.0.1:9292/info/v1.1" 
        list="http://127.0.0.1:9292/allVersions"/>
</endpoint>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The Tenant for this tenantId does not exist. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X POST -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints" -d '{"endpointTemplate":{"id":120}}'
```

#### 4.4.11.10 <a id="remove_endpoints_from_a_tenant"></a>Remove Endpoints From A Tenant####
#### DELETE HPKeystoneExtensionBaseURI]/tenants/{tenantId}/endpoints/{endpointId}
*Privilege Level: DA, SA*

Remove tenant's endpoint template association for given endpoint id. The operation does not require a request body.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to delete the endpoint from.
* *endpointId* - string - Unique ID of the endpoint being deleted from this tenant.

**Data Parameters**

This call does not require a request body.

XML

```
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints/543 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

JSON

```
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints/543 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 204 (No Content), Deletion of the endpoint template association was successful.

**Response Data**

This call does not return a response body.

(No JSON/XML format differences)

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=74ADEBA6F2523478A1700D664FD70C75; Path=/v2.0; Secure
Date: Wed, 12 Oct 2011 22:02:16 GMT
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | Either the Tenant for this tenantId or the Endpoint for the endpointId doesn't exist. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X DELETE -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints/543"
```
### 4.4.12 Token

A yummy cookie one uses to bribe the authorization monster.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.12.1 <a id="validate_token"></a>Validate Token####
#### GET [KeystoneBaseURI]/tokens/{tokenId}
*Privilege Level: Anon*

This API is used to validate a token. Validation includes checking that
the token belongs to a particular user and it has not expired.  On
successful validation, the response contains permissions relevant to a
particular client. If the query parameter, belongTo, is provided the
call will check the corresponding TenantId to ensure that token belongs
to that tenant. If there is no tenantId then it is globally scoped. In
the event a token is not valid, a 404 (item not found) will be returned.

Filter Roles:

For scoped token validation, optional query parameter **HP-IDM-serviceId
and/or **HP-IDM-endpointTemplateId** can be used to include only
specific subset of roles in response. If the parameter values are
provided and there are no specific roles found, then 401 (unauthorized)
error is generated. Both HP-IDM-serviceId and HP-IDM-endpointTemplateId
parameter can be used in a validate token request.
 In HP-IDM-serviceId and HP-IDM-endpointTemplateId  parameter
values, multiple ids can be specified as comma separated values. To
request global roles to be included in response, global identifier
(which is currently configured as **global**) must be used in either
of query parameter value. If both of query parameters are not specified
or has empty values, then response include all roles available for that
scoped token. In case of unscoped token validation, only global roles
are returned and HP-IDM-serviceId and HP-IDM-endpointTemplateId query
parameter, if there, is ignored.
 In case HP-IDM-endpointTemplateId value is provided for scoped token
validation, system looks into existing tenant endpointTemplate
association and uses that to filter matching endpoint specific roles. As
a service can have multiple endpoints (i.e. endpointTemplate), so if
both a serviceId and its endpointTemplateId are provided as input, then
endpointTemplateId takes precedence and we ignore the provided
serviceId. This is done to find more granular role data which in this
case is endpoint template id.

In case of scoped token validation, if that tenant has swift account
hash available in CS system, then its value is returned as a response
header with name 'X-HP-IDM-swift-account-hash'.

Note: This request does not expect X-Auth-Token header but if its
provided, then it needs to be have a valid token value otherwise
forbidden (403) error is returned.

**Request Data**

See examples below.

**URL Parameters**

* *belongsTo* (Optional) - string - tenent ID in which the token is scoped to
* *HP-IDM-serviceId* (Optional) - list of IDs (strings) - filter service specific roles
* *HP-IDM-endpointTemplateId* (Optional) - list of IDs (strings) - filter endpoint template specific roles

**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.

JSON

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

Optional:

JSON

ValidateToken  Request for JSON (unscoped token where HP-IDM-serviceId parameter value is ignored)

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a82d4b0be3c45af828494?HP-IDM-serviceId=110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

ValidateToken JSON Request ( HP-IDM-serviceId parameter with 120 service id value)

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=120 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

ValidateToken XML Request  (HP-IDM-serviceId parameter with 110 (Object Storage service) value and HP-IDM-endpointTemplateId parameter with 110 (Compute - AZ2) value)

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=110&HP-IDM-endpointTemplateId=110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

ValidateToken  XML Request ( HP-IDM-serviceId parameter with 'global' only)

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=global HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
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
Set-Cookie: JSESSIONID=D63D9FAC8FA835321F36E51CE07F2485; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_TENANT_NAME: TestTenant14892659460460094027
HTTP_X_USER_ID: 85397174931388
Content-Type: application/json
Content-Length: 454
Date: Fri, 09 Mar 2012 22:16:50 GMT
 
{"access": {
  "token": {
    "expires": "2012-03-10T10:12:37.474Z",
    "id": "HPAuth_4f5a7fe06a25ab00f896bee4",
    "tenant": {
      "id": "22674990706167",
      "name": "TestTenant14892659460460094027"
    }
  },
  "user": {
    "id": "85397174931388",
    "name": "TestUser14892658343713707444",
    "roles": [{
      "id": "00000000004026",
      "serviceId": "120",
      "name": "projectmanager",
      "tenantId": "22674990706167"
    }]
  }
}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=451446B2BE922152AD41799AC7453A0B; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_TENANT_NAME: TestTenant14892659460460094027
HTTP_X_USER_ID: 85397174931388
Content-Type: application/xml
Content-Length: 608
Date: Fri, 09 Mar 2012 22:38:55 GMT
 
<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom" xmlns:ns4="http://docs.openstack.org/common/api/v1.0">
   <token id="HPAuth_4f5a7fe06a25ab00f896bee4" expires="2012-03-10T10:12:37.474Z">
      <tenant id="22674990706167" name="TestTenant14892659460460094027"/>
   </token>
   <user id="85397174931388" name="TestUser14892658343713707444">
      <roles>
         <role id="00000000004026" name="projectmanager" serviceId="120" tenantId="22674990706167"/>
      </roles>
   </user>
</access>
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Item Not Found

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com:35357/v2.0/tokens/HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c"
```

**Additional Notes**


#### 4.4.12.2 <a id="quick_token_validation"></a>Quick Token Validation####
#### HEAD [KeystoneBaseURI]/tokens/\<tokenId\>?belongsTo=tenantId
*Privilege Level: Anon*

This API is used to do a quick token validation. Validation includes checking that the token belongs to a particular user and it has not expired.   If the query parameter, belongTo, is provided the call will check the corresponding tenantId to ensure membership in that tenant. If there is no tenantId then it is globally scoped. In the event a token is not valid, a 404 (item not found) will be returned.  This call won't return any roles associated with the token.
In case of scoped token validation, if that tenant has swift account hash available in CS system, then its value is returned as a response header with name 'X-HP-IDM-swift-account-hash'.
Note: This request does not expect X-Auth-Token header but if its provided, then it needs to be have a valid token value otherwise forbidden (403) error is returned.

**Request Data**

See examples below.

**URL Parameters**

* *belongsTo* (Optional) - string - tenent ID in which the token is scoped to

**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.

JSON

```
HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

Optional:

JSON

With belongsTo filtering.

```
HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?belongsTo=345234435 HTTP/1.1
Accept-Encoding: gzip,deflate
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

With belongsTo filtering.

```
HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?belongsTo=345234435 HTTP/1.1
Accept-Encoding: gzip,deflate
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

**Success Response**

**Status Code**

204 - OK

**Response Data**

This call does not return a response body.

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Item Not Found

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -XHEAD "https://az-1.region-a.geo-1.compute.hpcloudsvc.com:35357/v2.0/tokens/HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c"
```

**Additional Notes**


#### 4.4.12.3 <a id="refresh_token"></a>Refresh Token####
#### [HPKeystoneExtensionBaseURI]/tokens/\<tokenId\>
*Privilege Level: SS*

This API is used to refresh the expiration time by generating new token. Before expiration time can be modified, validation is done to check token is not expired, user and its domain is currently enabled (similar to what is done in token validation). Once all validation checks are successful, the new token is generated with expiration time is increased to next 720 minutes (token default expiration duration). The expiration time is increased by 12 hours from current time and not from token (passed in request) expiration time. The newly generated will also get refreshed response data from system.

This a self-service user action. So token in X-Auth-Token header needs to be same as token to be re-scoped otherwise it will raise unauthorized error.

**Request Data**

See examples below.

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tokens/HPAuth_4e934043b0be09f52fb4c29d HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e934043b0be09f52fb4c29d
Accept: application/json
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 0
```

XML

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tokens/HPAuth_4e934043b0be09f52fb4c29d HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e934043b0be09f52fb4c29d
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 0
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
Content-Length: 406
Date: Mon, 10 Oct 2011 19:02:25 GMT
 
{"access": {
   "token":    {
      "tenant":       {
         "id": "95096564413950",
         "name": "HP5 Tenant Services",
         "otherAttributes": {}
      },
      "anies": null,
      "expires": 1318275144906,
      "id": "HPAuth_4e934043b0be09f52fb4c29d",
      "otherAttributes": {}
   },
   "serviceCatalog": null,
   "anies": null,
   "otherAttributes": {}
}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=73C402A7E410D5FF0734ED370CF1A40F; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 361
Date: Mon, 10 Oct 2011 18:59:53 GMT
 
<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/common/api/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4e934043b0be09f52fb4e23f" expires="2011-10-10T19:29:53.382Z">
      <tenant id="95096564413950" name="HP5 Tenant Services"/>
   </token>
</access>
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Item Not Found

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
curl -k -XPOST --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tokens/HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c
```

**Additional Notes**

### 4.4.13 Users

Cloud users.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.13.1 <a id="list_users"></a>List Users####
#### GET [HPKeystoneExtensionBaseURI]/users
*Privilege Level: SA, DA, SS*

Returns all users of all tenants and takes a "marker" and "limit" parameter to limit the number of Users in the response. Can also be used to lookup users by `name` or `emailAddress`.

**Request Data**

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional)} - string - the resource Id of the last item in the previous list
* *name* (Optional) - string - lookup users by name
* *emailAddress* (Optional) - string - lookup users by emailAddress

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
GET /v2.0/HP-IDM/v1.0/users HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/users HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

Optional:

JSON

Return 50 users at a time.

```
GET /v2.0/HP-IDM/v1.0/users?limit=50 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

Return 10 users at a time, starting with user ID `345367`

```
GET /v2.0/HP-IDM/v1.0/users?limit=10&marker=345367 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

Lookup users by name.

```
GET /v2.0/HP-IDM/v1.0/users?name=jdoe HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

Lookup users by email.

```
GET /v2.0/HP-IDM/v1.0/users?emailAddress=jdoe@acme.com HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```


XML

Lookup users by name.

```
GET /v2.0/HP-IDM/v1.0/users?name=jdoe HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

Lookup users by email.

```
GET /v2.0/HP-IDM/v1.0/users?emailAddress=jdoe@acme.com HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
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
Content-Length: 5749
Date: Thu, 22 Sep 2011 19:35:15 GMT
 
{
  "users": {
    "anies": null,
    "otherAttributes": {
 
    },
    "user": [
      {
        "addressLine1": null,
        "addressLine2": null,
        "city": null,
        "company": null,
        "country": null,
        "domainId": "00000000001001",
        "emailAddress": null,
        "firstName": null,
        "lastName": null,
        "otherAttributes": {
 
        },
        "password": null,
        "phone": null,
        "state": null,
        "status": "enabled",
        "userId": "00000000003001",
        "username": "self",
        "website": null,
        "zip": null
      },
      {
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": "USA",
        "domainId": "58569153761853",
        "emailAddress": "JeffWall3@timewarner.com",
        "firstName": "First",
        "lastName": "LAAAST",
        "otherAttributes": {
 
        },
        "password": null,
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "userId": "68411377324438",
        "username": "XmlUser7@timewarner.com",
        "website": "http://www.timewarner.com",
        "zip": "90210"
      },
      {
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": "USA",
        "domainId": "35682413541771",
        "emailAddress": "larryking@timewarner.com",
        "firstName": "Larry",
        "lastName": "King",
        "otherAttributes": {
 
        },
        "password": null,
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "userId": "96015523000467",
        "username": "larryking@timewarner.com",
        "website": null,
        "zip": "90210"
      }
    ]
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
Content-Type: application/xml
Content-Length: 3225
Date: Tue, 09 Aug 2011 20:53:54 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<users xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
  <user domainId="798477662343" isDomainOwner="true" emailAddress="johndoe@papsi.com" website="http://www.pepsi.com" phone="1-800-555-1212" zip="89072" country="USA" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" accountId="627893056455" username="johndoe@papsi.com" name="John Doe"/>
  <user domainId="798477662343" emailAddress="amymiller@papsi.com" website="http://www.pepsi.com" phone="1-800-555-1212" zip="89072" country="USA" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" accountId="968754602297" username="amymiller@papsi.com" name="Amy Miller"/>
  <user domainId="980913511718" isDomainOwner="true" emailAddress="janedoe@timewarner.com" website="http://www.timewarner.com" phone="1-800-555-1212" zip="90210" country="USA" state="CA" city="Los Angeles" addressLine1="128, Hollywood Blvd" accountId="559855934411" username="janedoe@timewarner.com" name="Jane Doe"/>
</users>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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

***List Users***

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users"
```

***Lookup Users By Name***

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users?name=jdoe"
```

***Lookup Users By Email***

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users?emailAddress=jdoe@acme.com"
```

**Additional Notes**


#### 4.4.13.2 <a id="get_a_user"></a>Get A User####
#### GET [HPKeystoneExtensionBaseURI]/users/{userId} 
*Privilege Level: SA, DA, SS*


Gets a user resource for the specified userId.

**Request Data**

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
GET /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
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
Content-Length: 554
Date: Thu, 22 Sep 2011 19:46:36 GMT
 
{
  "user": {
    "addressLine1": "128, Hollywood Blvd",
    "addressLine2": null,
    "city": "Los Angeles",
    "company": null,
    "country": "USA",
    "domainId": "35682413541771",
    "emailAddress": "larryking@timewarner.com",
    "firstName": "Larry",
    "lastName": "King",
    "otherAttributes": {
 
    },
    "password": null,
    "passwordResetRequired" : "true",
    "phone": "1-800-555-1212",
    "state": "CA",
    "status": "enabled",
    "userId": "96015523000467",
    "username": "larryking@timewarner.com",
    "website": null,
    "zip": "90210"
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
Content-Type: application/xml
Content-Length: 429
Date: Tue, 09 Aug 2011 20:59:31 GMT
 
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" domainId="980913511718" isDomainOwner="true" emailAddress="janedoe@timewarner.com" website="http://www.timewarner.com" phone="1-800-555-1212" zip="90210" country="USA" state="CA" city="Los Angeles" addressLine1="128, Hollywood Blvd" accountId="559855934411" username="janedoe@timewarner.com" name="Jane Doe" "passwordResetRequired"="true"/>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The specified userId was not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467
```

**Additional Notes**


#### 4.4.13.3 <a id="check_for_existence_of_user"></a>Check For Existence Of User####
#### HEAD [HPKeystoneExtensionBaseURI]/users?name=username
*Privilege Level: Anon*

This API does case-insensitive username lookup in system. It returns http status code 200 (Ok) when provided username exists and returns 404 (not found) when provided username is not found in the system. If provided username is blank or missing, then it returns 204 (No content).
As this API just checks for existence of provided username, it does not do look into status (or any other entity attribute) for case when matching user is found.

There is no response body returned in API response data. This API does not require http header X-Auth-Token and is protected by client certificate authentication.

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

* *name* (Optional) - string - username

**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/users?name=User1_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
```

XML

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/users?name=user1_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 200 | OK | Given user exist |
| 404 | Not Found | Given user does not exist. |

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 18:49:33 GMT
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 18:49:33 GMT
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 204 | No Content | When username is missing or blank. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users?name=user1_2012_08_21_11_01_30_565"
```

**Additional Notes**

#### 4.4.13.4 <a id="create_a_new_user"></a>Create A New User####
#### POST [HPKeystoneExtensionBaseURI/users
*Privilege Level: SA, DA, SR*

Creates a new user within a specific domain with a service generated userId for the user resource.

When a Domain Administrator creates a new User, the User object created will have the "passwordResetRequired" flag set to "true". In this case, the caller should force the User to reset the password for the User.

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

```
POST /v2.0/HP-IDM/v1.0/users HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e80e1c62cdc54e6ca175310
Host: localhost:9999
Connection: keep-alive
Content-Length: 354
 
{
  "user": {
    "addressLine1": "128, Hollywood Blvd",
    "city": "Los Angeles",
    "country": "USA",
    "domainId": "30047399135069",
    "emailAddress": "larryking@timewarner.com",
    "firstName": "Larry",
    "lastName": "King",
    "password": "changeme",
    "phone": "1-800-555-1212",
    "state": "CA",
    "username": "larryking@timewarner.com",
    "zip": "90210"
  }
}
```

XML

```
POST /v2.0/HP-IDM/v1.0/users HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e80e1c62cdc54e6ca175310
Host: localhost:9999
Connection: keep-alive
Content-Length: 399
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" emailAddress="XmlUser9@timewarner.com" website="http://www.timewarner.com" phone="1-800-555-1212" zip="90210" country="USA" state="CA" city="Los Angeles" addressLine1="128, Hollywood Blvd" password="changeme" username="XmlUser9@timewarner.com" lastName="Last" firstName="First"/>
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 554
Date: Mon, 26 Sep 2011 20:34:36 GMT
 
{
  "user": {
    "addressLine1": "128, Hollywood Blvd",
    "addressLine2": null,
    "city": "Los Angeles",
    "company": null,
    "country": "USA",
    "domainId": "30047399135069",
    "emailAddress": "larryking@timewarner.com",
    "firstName": "Larry",
    "lastName": "King",
    "otherAttributes": {
 
    },
    "password": null,
    "passwordResetRequired" : "true",
    "phone": "1-800-555-1212",
    "state": "CA",
    "status": "enabled",
    "userId": "37846208811131",
    "username": "larryking@timewarner.com",
    "website": null,
    "zip": "90210"
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
Set-Cookie: JSESSIONID=C066B06A95E6B2ED4CF9763AEF2464A2; Path=/v2.0
Content-Type: application/xml
Content-Length: 446
Date: Mon, 26 Sep 2011 20:40:01 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" firstName="First" lastName="Last" username="XmlUser9@timewarner.com" userId="20489940157791" addressLine1="128, Hollywood Blvd" city="Los Angeles" state="CA" country="USA" zip="90210" phone="1-800-555-1212" website="http://www.timewarner.com" emailAddress="XmlUser9@timewarner.com" status="enabled" domainId="34315693600572" passwordResetRequired="true"/>
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The specified domain was not found. |
| 409 | Conflict | An User with the required parameters already exist in the system |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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

Assuming there exist a file "new_user.json" with the following content:

```
{
  "user": {
    "addressLine1": "128, Hollywood Blvd",
    "city": "Los Angeles",
    "country": "USA",
    "domainId": "30047399135069",
    "emailAddress": "larryking@timewarner.com",
    "firstName": "Larry",
    "lastName": "King",
    "password": "changeme",
    "phone": "1-800-555-1212",
    "state": "CA",
    "username": "larryking@timewarner.com",
    "zip": "90210"
  }
}
```

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -XPOST -d @new_user.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users"
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.13.5 <a id="update_a_user"></a>Update A User####
#### PUT [HPKeystoneExtensionBaseURI]/users/{userId} 
*Privilege Level: SA, DA\*, SS*

Updates a user for the specified userId.

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

```
PUT /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b92aa2cdcd8e4c569ca3f
Host: localhost:9999
Connection: keep-alive
Content-Length: 58
 
{
  "user": {
    "emailAddress": "larrykinglive@timewarner.com"
  }
}
```

XML

```
PUT /v2.0/HP-IDM/v1.0/users/559855934411 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
Content-Length: 177
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" emailAddress="janedoe2@timewarner.com" status="enabled"/>
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 558
Date: Thu, 22 Sep 2011 19:58:59 GMT
 
 
{
  "user": {
    "addressLine1": "128, Hollywood Blvd",
    "addressLine2": null,
    "city": "Los Angeles",
    "company": null,
    "country": "USA",
    "domainId": "35682413541771",
    "emailAddress": "larrykinglive@timewarner.com",
    "firstName": "Larry",
    "lastName": "King",
    "otherAttributes": {
 
    },
    "password": null,
    "phone": "1-800-555-1212",
    "state": "CA",
    "status": "enabled",
    "userId": "96015523000467",
    "username": "larryking@timewarner.com",
    "website": null,
    "zip": "90210"
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
Content-Type: application/xml
Content-Length: 430
Date: Tue, 09 Aug 2011 21:07:33 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" domainId="980913511718" isDomainOwner="true" emailAddress="janedoe2@timewarner.com" website="http://www.timewarner.com" phone="1-800-555-1212" zip="90210" country="USA" state="CA" city="Los Angeles" addressLine1="128, Hollywood Blvd" accountId="559855934411" username="janedoe@timewarner.com" name="Jane Doe"/>
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The specified user was not found. |
| 409 | Conflict | An User with the required parameters already exist in the sys
tem |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


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

Assuming there exist a file "update_user.json" with the following content:

```
{
  "user": {
    "emailAddress": "larrykinglive@timewarner.com"
  }
}
```

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -XPUT -d @update_user.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467"
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.13.6 <a id="delete_a_user"></a>Delete A User####
#### DELETE [HPKeystoneExtensionBaseURI]/users/{userId}
*Privilege Level: SA, DA*

Deletes a user for the specified userId. If the User is an owner of the Domain, this API checks if the caller has privileges to delete a owner of the Domain.

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
DELETE /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b95f52cdcd8e4c569ca44
Host: localhost:9999
Connection: keep-alive
```

XML

```
DELETE /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b95f52cdcd8e4c569ca44
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

204 - No Content

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=A17A0BD786F05FEC1AE4E25BF8680323; Path=/v2.0
Date: Thu, 22 Sep 2011 20:10:44 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=A17A0BD786F05FEC1AE4E25BF8680323; Path=/v2.0
Date: Thu, 22 Sep 2011 20:10:44 GMT
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The specified user was not found. |
| 409 | Conflict | An User with the required parameters already exist in the sys
tem |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -XDELETE "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467"
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.13.7 <a id="get_all_groups_for_a_user"></a>Get All Groups For A User####
#### GET [HPKeystoneExtensionBaseURI]/users/{userId}/groups
*Privilege Level: SA, DA, SS*

Returns all groups for the user specified within the userId.

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional)} - string - the resource Id of the last item in the previous list

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
GET /v2.0/HP-IDM/v1.0/users/627893056455/groups HTTP/1.1
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/users/627893056455/groups HTTP/1.1
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=DAC25DAF81622AC8A4854FA4687879F7; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 293
Date: Tue, 27 Dec 2011 20:01:19 GMT
 
{
  "groups" : {
    "anies" : null,
    "group" : [ {
      "description" : "HP System domain users group",
      "anies" : null,
      "domainId" : null,
      "id" : "00000000002002",
      "name" : "Users",
      "otherAttributes" : {
      }
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
Content-Type: application/xml
Content-Length: 465
Date: Tue, 16 Aug 2011 16:40:14 GMT
 
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<groups xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"
xmlns:ns2="http://www.w3.org/2005/Atom"
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0">
  <group name="Domain Administrators" id="875209688034">
    <description>johndoe@papsi.com-DOMAIN Domain
    Administrators</description>
  </group>
  <group name="Users" id="279700901952">
    <description>johndoe@papsi.com-DOMAIN Users</description>
  </group>
</groups>
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The specified userId or groupId was not found. |
tem |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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

Return all the groups for a given user.

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467/groups"
```

Return maximum of 10 groups at a time, starting with groupId '1234556', for a given user.

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467/groups?limit=10&marker=1234556"
```


**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.13.8 <a id="update_password_for_a_user"></a>Update Password For A User####
#### PUT [HPKeystoneExtensionBaseURI]/users/{userId}/password
*Privilege Level: SA, DA, SS*

Update a user's password specified by the userId.

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
PUT /v2.0/HP-IDM/v1.0/users/53382673413858/password HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ec697442cdcf4983a3bf3cb
Host: localhost:9999
Connection: keep-alive
Content-Length: 50
 
{
  "passwordUpdate": {
    "newPassword": "changed$pwd"
  }
}
```

XML

```
PUT /v2.0/HP-IDM/v1.0/users/53382673413858/password HTTP/1.1
Accept: application/json
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ec697442cdcf4983a3bf3cb
Host: localhost:9999
Connection: keep-alive
Content-Length: 157
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<passwordUpdate xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" newPassword="changed$pwd"/>
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

204 - No Content

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=4470C4AB8BD315EAAC0156F5AF822442; Path=/
Date: Fri, 18 Nov 2011 18:03:03 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=8C6A602EB93E746CCE4B6F173E6FA484; Path=/
Date: Fri, 18 Nov 2011 17:58:24 GMT
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The specified user was not found. |
tem |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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

Assuming there exist a file "new_password.json" with the following content:

```
{
  "passwordUpdate": {
    "newPassword": "changed$pwd"
  }
}
```

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -XPUT -d @new_password.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/53382673413858/password"
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.13.9 <a id="initial_password_reset"></a>Initial Password Reset####
#### POST [HPKeystoneExtensionBaseURI]/users/password/reset
*Privilege Level: SA, DA, Anon*

This API is used to initiate a forgot password reset for a given username.  If the username is validated, an email will be sent to the user (based on the email attribute of the user object) containing a URL link with an embedded resetId.  The user is expected to then click on the link which will send them to a location on the HP Services web management console where the console will then pickup the resetId and validate it.

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

* *userName* - string - username of the user to reset the password

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
POST /v2.0/HP-IDM/v1.0/users/password/reset?userName=jschmo HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8080
Content-Length: 0
```

XML

```
POST /v2.0/HP-IDM/v1.0/users/password/reset?userName=jschmo HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8080
Content-Length: 0
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

204 - No Content

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 22 Aug 2011 04:55:08 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 22 Aug 2011 04:55:08 GMT
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
tem |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -XPOST "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/password/reset?usernName=jschmo"
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.13.10 <a id="validate_password_resetid_and_update_password"></a>Validate Password ResetId And Update Password####
#### PUT [HPKeystoneExtensionBaseURI]/users/password/reset/{resetId}
*Privilege Level: Anon*

This API is used to validate the password resetId (nonce), if validated, then the user's password will be updated based on the new password passed in the body of the  call.  Updated user object is returned as response.

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
PUT /v2.0/HP-IDM/v1.0/users/password/reset/UlZacHJ4a2V2LzFyNENSMW1vdlhONGJxK2hWMmgxcGVqd0FvVURtOC9jZz1FUA HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:35357
Content-Length: 59
 
{
  "passwordUpdate": {
    "newPassword": "changeme"
  }
}
```

XML

```
PUT /v2.0/HP-IDM/v1.0/users/password/reset/azEyRGpxK3l3QmdRYmYwZlVBQ0VxUWRncnVScFM4SEJSN3BVUTZ2akJ6OD1Neg HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:35357
Content-Length: 155
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?> <passwordUpdate xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" newPassword="newpwd"  />
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
HTTP/1.1 200 OKHTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=005BC8D3F99AB57DF8CC7A913672E991; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 515
Date: Tue, 29 Nov 2011 17:28:20 GMT
 
{
  "user" : {
    "roles" : null,
    "addressLine1" : null,
    "addressLine2" : null,
    "city" : null,
    "company" : null,
    "country" : null,
    "domainId" : "00000000001001",
    "emailAddress" : "haneef.ali@hp.com",
    "firstName" : "firstName",
    "lastName" : "lastName",
    "otherAttributes" : {
    },
    "password" : null,
    "phone" : null,
    "state" : null,
    "status" : "enabled",
    "userId" : "62327210706778",
    "username" : "haneef",
    "website" : null,
    "zip" : null
  }
}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=0D4F1347839350183EFE2A3553C4FF61; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 431
Date: Tue, 29 Nov 2011 17:42:30 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" firstName="firstName" lastName="lastName" username="haneef" userId="62327210706778" emailAddress="haneef.ali@hp.com" status="enabled" domainId="00000000001001"/>
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | When provided nonce is not found and hence user cannot be determined. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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

Assuming there exist a file "mypasword.json" with the following content:

```
{
  "passwordUpdate": {
    "newPassword": "changeme"
  }
}
```

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "Content-Type: application/json" -H "Accept: application/json" -XPUT -d @mypassword.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/password/reset/UlZacHJ4a2V2LzFyNENSMW1vdlhONGJxK2hWMmgxcGVqd0FvVURtOC9jZz1FUA"
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.11 <a id="list_a_users_non_tenant_role_assignments"></a>List A User's Non Tenant Role Assignments####
#### GET [HPKeystoneExtensionBaseURI]/users/{userId}/username}/roles
*Privilege Level: SA, DA, DU*

This API would return all the non tenant role assignments for a user in his domain filtered by serviceId.

**Request Data**

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100. 
* *marker* (Optional)} - string - the resource Id of the last item in the previous list
* *serviceId* (Optional) - string - filter by serviceId

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
GET /v2.0/HP-IDM/v1.0/users/345678902345/roles HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/users/345678902345/roles HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

Optional:

JSON

Filtered by service ID:

```
GET /v2.0/HP-IDM/v1.0/users/345678902345/roles?serviceId=100 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

Return maximum of 10 roles at a time, starting with role ID `123456`:

```
GET /v2.0/HP-IDM/v1.0/users/345678902345/roles?limit=10&marker=123456 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

XML

Filtered by service ID:

```
GET /v2.0/HP-IDM/v1.0/users/345678902345/roles?serviceId=100 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

Return maximum of 10 roles at a time, starting with role ID `123456`:

```
GET /v2.0/HP-IDM/v1.0/users/345678902345/roles?limit=10&marker=123456 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
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
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
 
{"roles": {"role": [
      {
      "roleAssignmentId": "PA8C8XYF9ftQuuZoUB66mt8ypEEWzgMFpGxpz8dvZ7U=",
      "roleId": "00000000004004",
      "roleName": "domainuser",
      "subjectId": "777700000003",
      "subjectName": "atiwari-1",
      "subjectType": "User",
      "description": "Non Tenant Role Assignment : User atiwari-1, id 777700000003, role domainuser on domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "100",
      "isCrossDomain": false
   },
      {
      "roleAssignmentId": "hKQIXLCqaK74kvbTrQQ6LRn1WXzSqlB+JrgO4FSaE8s=",
      "roleId": "00000000004003",
      "roleName": "domainadmin",
      "subjectId": "777700000003",
      "subjectName": "atiwari-1",
      "subjectType": "User",
      "description": "Non Tenant Role Assignment : User atiwari-1, id 777700000003, role domainadmin on domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "100",
      "isCrossDomain": false
   }
]}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
 
<roles xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
   <role>
      <roleAssignmentId>PA8C8XYF9ftQuuZoUB66mt8ypEEWzgMFpGxpz8dvZ7U=</roleAssignmentId>
      <roleId>00000000004004</roleId>
      <roleName>domainuser</roleName>
      <subjectId>777700000003</subjectId>
      <subjectName>atiwari-1</subjectName>
      <subjectType>User</subjectType>
      <description>Non Tenant Role Assignment : User atiwari-1, id 777700000003, role domainuser on domain 777700000000</description>
      <domainId>777700000000</domainId>
      <serviceId>100</serviceId>
      <isCrossDomain>false</isCrossDomain>
   </role>
   <role>
      <roleAssignmentId>hKQIXLCqaK74kvbTrQQ6LRn1WXzSqlB+JrgO4FSaE8s=</roleAssignmentId>
      <roleId>00000000004003</roleId>
      <roleName>domainadmin</roleName>
      <subjectId>777700000003</subjectId>
      <subjectName>atiwari-1</subjectName>
      <subjectType>User</subjectType>
      <description>Non Tenant Role Assignment : User atiwari-1, id 777700000003, role domainadmin on domain 777700000000</description>
      <domainId>777700000000</domainId>
      <serviceId>100</serviceId>
      <isCrossDomain>false</isCrossDomain>
   </role>
</roles>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/345678902345/roles?serviceId=100"
```

**Additional Notes**

#### 4.4.13.12 <a id="check_users_non_tenant_role_assignment"></a>Check User's Non Tenant Role Assignment####
#### HEAD [HPKeystoneExtensionBaseURI]/users/\<userId\>/roles/\<roleId\> 
*Privilege Level: SA, DA, DU*

This API check to see if the give user has the given role assignment.

**Constraints**

* This is not a privileged operation so far.
* All the id's should represent a valid entity (userId, roleId)
* non tenant role assignments are not associated with a tenant.

**Request Data**

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
GET /v2.0/HP-IDM/v1.0/users/345678902345/roles/00000000004003 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

XML

```
HEAD /v2.0/HP-IDM/v1.0/users/345678902345/roles/00000000004003 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 200 | OK | User's non tenant role exist. |
| 404 | Not Found | User's non tenant role does not exist. |

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=20DD4F9E1E3D2B0485DC81D93609DE30; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Wed, 26 Sep 2012 17:58:59 GMT
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=20DD4F9E1E3D2B0485DC81D93609DE30; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Wed, 26 Sep 2012 17:58:59 GMT
```

**Error Response**

**Status Code**


tatus Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" -XHEAD "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/345678902345/roles/00000000004003"
```

**Additional Notes**

#### 4.4.13.13 <a id="create_a_users_non_tenant_role_assignment"></a>Create A User's Non Tenant Role Assignment####
#### PUT [HPKeystoneExtensionBaseURI]/users/{userId}/roles/{roleId}
*Privilege Level: SA, DA*

This API is used to create a non tenant role assignment for user in his domain.

##### Constraints

* This is a privileged operation, only superadmin or domainadmin can create a role assignment.
* Only super admin is allowed to make a role assignment for "System" scoped roles.
* All the id's should represent a valid entity (userId, roleId)
* Role assignment should be made on users domain.
* Tenant role assignment is not allowed.
* Cross domain role assignment is not supported for non tenant role.

**Request Data**

**URL Parameters** 

None

**Data Parameters** 
    
See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
PUT /v2.0/HP-IDM/v1.0/users/12345678909876/roles/334343434 HTTP/1.1
Accept: application/json
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

XML

```
PUT /v2.0/HP-IDM/v1.0/users/12345678909876/roles/334343434 HTTP/1.1
Accept: application/xml
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

201 - Created

**Response Data**


JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
```

XML

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 200 | OK | Role assignment is policy and here we can safely return OK in case of duplicate role assignment. |
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The specified user or role was not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" -XPUT "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/12345678909876/roles/334343434"
```

**Additional Notes**

#### 4.4.13.14 <a id="delete_a_users_non_tenant_role_assignment"></a>Delete A User's Non Tenant Role Assignment####
#### DELETE [HPKeystoneExtensionBaseURI]/users/{userId}/roles/{roleId}
*Privilege Level: SA, DA*

This API is used to delete a non tenant role assignment for a user. 

##### Constraints
* This is a privileged operation.
* All the id's should represent a valid entity (userId, roleId)
* Delete a tenant role are not allowed.

**Request Data**

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
DELETE /v2.0/HP-IDM/v1.0/users/559855934411/roles/07568653986543 HTTP/1.1
Accept: application/json
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

XML

```
DELETE /v2.0/HP-IDM/v1.0/users/559855934411/roles/07568653986543 HTTP/1.1
Accept: application/json
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

204 - No Content

**Response Data**


JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Tue, 09 Aug 2011 22:20:25 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Tue, 09 Aug 2011 22:20:25 GMT
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The specified user was not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" -XDELETE "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/12345678909876/roles/334343434"
```

**Additional Notes**

### 4.4.14 User Access Key

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.14.1 <a id="{createaccesskey}"></a>{createaccesskey}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.14.2 <a id="{deleteaccesskey}"></a>{deleteaccesskey}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.14.3 <a id="{getaccesskey}"></a>{getaccesskey}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.14.4 <a id="{importaccesskey}"></a>{importaccesskey}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.14.5 <a id="{updateaccesskey}"></a>{updateaccesskey}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.15 User Certificate

User Certificate Operations.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.15.1 <a id="get_user_certificates"></a>Get User Certificates####
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


#### 4.4.15.2 <a id="delete_user_certificate"></a>Delete User Certificate####
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


#### 4.4.15.3 <a id="get_user_certificate"></a>Get User Certificate####
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

#### 4.4.15.4 <a id="create_a_user_certificate"></a>Create A User Certificate####
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


#### 4.4.15.5 <a id="import_user_certificate(s)"></a>Import User Certificate(s)####
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

#### 4.4.15.6 <a id="update_user_certificate"></a>Update User Certificate####
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test/1239dac6" -XPUT -d "{
  "certificate" : {
    "status" : "inactive"
  }
}"
```

**Additional Notes**



### 4.4.16 User Key Pair

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.16.1 <a id="{createkeypair}"></a>{createkeypair}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.16.2 <a id="{deletekeypair}"></a>{deletekeypair}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.16.3 <a id="{getkeypair}"></a>{getkeypair}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.16.4 <a id="{getkeypairs}"></a>{getkeypairs}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.16.5 <a id="{importkeypair}"></a>{importkeypair}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.16.6 <a id="{updatekeypair}"></a>{updatekeypair}####
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
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

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


# 5. Additional References

## 5.1 Resources

**Wiki Page**: {Link to Wiki page}

**Code Repo**:  {Link to the internal Github repo}

**API Lead Contact**: {Name of contact}

---

# 6. Glossary

{Put down definitions of terms and items that need explanation.}

---

