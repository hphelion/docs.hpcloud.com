---
layout: page
permalink: /api/identity/admin/
title: Identity Services Admin API
product: identity
private: true

---
# Identity Services Admin API


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
| Action | [Post Action](#post_action) | POST | /HP-IDM/v1.0/action/{action} | Y/Y | SA |
| Action | [Get Jobs By Account](#get_jobs_by_account) | GET | /HP-IDM/v1.0/job | Y/Y | SA |
| Action | [Get A Job Ticket](#get_a_job_ticket) | GET | /HP-IDM/v1.0/job/{ticketId} | Y/Y | SA |
| Action | [Restart A TIMEDOUT Job](#restart_a_timedout_job) | PUT | /HP-IDM/v1.0/job/{ticketId} | Y/Y | SA |
| Action | [Delete A Job](#delete_a_job) | PUT | /HP-IDM/v1.0/job/{ticketId} | Y/Y | SA |
| Action | [Get Error Jobs](#get_error_jobs) | GET | /HP-IDM/v1.0/job/error | Y/Y | SA |
| Action | [Get A Count Of Error Jobs](#get_a_count_of_error_jobs) | GET | /HP-IDM/v1.0/job/error/count | Y/Y | SA |
| Action | [Get Error Jobs By Category](#get_error_jobs_by_category) | GET | /HP-IDM/v1.0/job/error/{category} | Y/Y | SA |
| Action | [Delete Error Jobs By Category](#delete_error_jobs_by_category) | GET | /HP-IDM/v1.0/job/error/{category} | Y/Y | SA |
| Action | [Get Jobs By Status](#get_jobs_by_status) | GET | /HP-IDM/v1.0/job/status/{status} | Y/Y | SA |
| Action | [Get Job Count By Status](#get_job_count_by_status) | GET | /HP-IDM/v1.0/job/status/{status}/count | Y/Y | SA |
| Domains | [Check For Existence Of Domain Name](#check_for_existence_of_domain_name) | GET | /HP-IDM/v1.0/job/status/{status}/count | Y/Y | Anonymous |
| Domains | [Create A Domain](#create_a_domain) | GET | /HP-IDM/v1.0/domains  | Y/Y | System Adminstrator (SA) |
| Domains | [Delete A Domain](#delete_a_domain) | DELETE | /HP-IDM/v1.0/domains/{domainId}  | Y/Y | System Adminstrator (SA) |
| Domains | [Get A Domain](#get_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}  | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get All Domains](#get_all_domains) | GET | /HP-IDM/v1.0/domains | Y/Y | System Adminstrator (SA) |
| Domains | [Get Groups For A Domain](#get_groups_for_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}/groups | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Subscribe Able Services For A Domain](#get_subscribe_able_services_for_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}/subscribeableServices | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Service Activations For A Domain](#get_service_activations_for_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}/services | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Tenants For A Domain](#get_tenants_for_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}/tenants | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Users For A Domain](#get_users_for_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}/tenants | Y/Y | System Adminstrator (SA), Domain Admin (DA) |
| Domains | [List Role Definitions (Deprecated)](#list_role_definitions_deprecated) | GET | /HP-IDM/v1.0/domains/{domainId}/roles | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Transfer Ownership Of A Domain](#transfer_ownership_of_a_domain) | PUT | /HP-IDM/v1.0/domains/{domainId}/owner/{userId}	 | Y/Y | System Adminstrator (SA) |
| Endpoint Templates | [Add Endpoint Template](#add_endpoint_template) | POST | /HP-IDM/v1.0/endpointTemplates | Y/Y | SA, SVC |
| Endpoint Templates | [Delete Endpoint Template](#delete_endpoint_template) | DELETE | /HP-IDM/v1.0/endpointTemplates/ {endpointTemplateId}  | Y/Y | SA, SVC |
| Endpoint Templates | [Get Enabled Endpoint Templates](#get_enabled_endpoint_templates) | GET | /HP-IDM/v1.0/endpointTemplates/enabled | Y/Y | SA, SVC, DA, DU  |
| Endpoint Templates | [Get Endpoint Template By Id](#get_endpoint_template_by_id) | GET | /HP-IDM/v1.0/endpointTemplates/{endpointTemplateId} | Y/Y | SA, SVC, DA, DU |
| Endpoint Templates | [Get Endpoint Templates](#get_endpoint_templates) | GET | /HP-IDM/v1.0/endpointTemplates | Y/Y | SA, SVC, DA, DU  |
| Endpoint Templates | [Update Endpoint Template](#update_endpoint_template) | GET | /HP-IDM/v1.0/endpointTemplates | Y/Y | SA, SVC  |
| Groups | [Add A User To A Group](#add_a_user_to_a_group) | PUT | /HP-IDM/v1.0/groups/{groupId}/users/{userId} | Y/Y | SA, DA |
| Groups | [Create A Group](#create_a_group) | POST | /HP-IDM/v1.0/groups | Y/Y | SA,DA |
| Groups | [Delates A Group](#delates_a_group) | DELETE | /HP-IDM/v1.0/groups/{groupId} | Y/Y | SA ,DA |
| Groups | [Get A Specific Group](#get_a_specific_group) | GET | /HP-IDM/v1.0/groups/{groupId} | Y/Y | SA,DA, DU  |
| Groups | [List Users For The Group](#list_users_for_the_group) | GET | /HP-IDM/v1.0/groups/{groupId}/users | Y/Y | SA,DA |
| Groups | [Delete User From The Group](#delete_user_from_the_group) | DELETE | /HP-IDM/v1.0/groups/{groupId}/users/{userId} | Y/Y | SA,DA |
| Groups | [Update Group](#update_group) | PUT | /HP-IDM/v1.0/groups/{groupId} | Y/Y | SA, DA |
| Management Console | [User Details](#user_details) | GET | /HP-IDM/v1.0/users/details/{userId} | Y/Y | MC-CS Certificate |
| Management Console | [User Preferences](#user_preferences) | GET | /HP-IDM/v1.0/preferences/{userId} | Y/Y | MC-CS Certificate |
| Management Console | [User Preferences](#user_preferences) | PUT | /HP-IDM/v1.0/preferences/{userId} | Y/Y | MC-CS Certificate |
| Role Assignment | [List Role Assignments Made On A Tenant](#list_role_assignments_made_on_a_tenant) | GET | /tenants/{tenantId}/roles | Y/Y | SA, DA, DU |
| Role Assignment | [List Tenant Role Assignments For A User](#list_tenant_role_assignments_for_a_user) | GET | /tenants/{tenantId}/roles | Y/Y | SA, DA, DU |
| Role Assignment | [Check Tenant Role Assignment For A User](#check_tenant_role_assignment_for_a_user) | GET | /tenants/{tenantId}/roles | Y/Y | SA, DA, DU |
| Role Assignment | [Create Tenant Role Assignments For A User](#create_tenant_role_assignments_for_a_user) | PUT | /tenants/{tenantId}/users/{userId}/roles/{roleId} | Y/Y | SA, DA |
| Role Assignment | [Delete Tenant Role Assignment For A User](#delete_tenant_role_assignment_for_a_user) | DELETE | /tenants/{tenantId}/users/{userId}/roles/{roleId} | Y/Y | SA, DA |
| Role Assignment | [List Tenant Role Assignments For A Group](#list_tenant_role_assignments_for_a_group) | GET | /tenants/{tenantId}/groups/{groupId}/roles | Y/Y | SA, DA, DU |
| Role Assignment | [Create Tenant Role Assignments For A Group](#create_tenant_role_assignments_for_a_group) | PUT | /tenants/{tenantId}/groups/{groupId}/roles/{roleId} | Y/Y | SA, DA |
| Role Assignment | [Delete Tenant Role Assignment For A Group](#delete_tenant_role_assignment_for_a_group) | DELETE | /tenants/{tenantId}/groups/{userId}/roles/{roleId} | Y/Y | SA, DA |
| Role Defs | [Create Role Definition](#create_role_definition) | POST | /HP-IDM/v1.0/roleDefs | Y/Y | SA, SVC, DA |
| Role Defs | [Delete Role Definition](#delete_role_definition) | DELETE | /HP-IDM/v1.0/roleDefs/{roleId} | Y/Y | SA, SVC, DA |
| Role Defs | [Update Role Definition](#update_role_definition) | PUT | /HP-IDM/v1.0/roleDefs/{roleId} | Y/Y | SA, SVC, DA |
| Role Defs | [Update Role Scope](#update_role_scope) | PUT | /HP-IDM/v1.0/roleDefs/{roleId}/scope | Y/Y | SA, SVC |
| Role Defs | [Get A Role Definition](#get_a_role_definition) | GET | /HP-IDM/v1.0/roleDefs/{roleId} | Y/Y | SA, SVC, DA, DU |
| Role Defs | [List Role Definitions](#list_role_definitions) | GET | /HP-IDM/v1.0/roleDefs | Y/Y | SA, SVC |
| Services | [Get Service By Id](#get_service_by_id) | GET | /HP-IDM/v1.0/services/{serviceId}    | Y/Y | SA, SVC |
| Services | [List Registered Services](#list_registered_services) | GET | /HP-IDM/v1.0/services | Y/Y | SA, SVC, DA, DU |
| Services | [Register New Service](#register_new_service) | POST | /HP-IDM/v1.0/services  	 | Y/Y | SA, SVC |
| Services | [Update Service](#update_service) | PUT | /HP-IDM/v1.0/services/{serviceId}  	 | Y/Y | SA, SVC |
| Signature | [EC2 Signature](#ec2_signature) | POST | /HP-IDM/v1.0/ec2Tokens | Y/Y | Anon |
| Signature | [Generic Signature](#generic_signature) | POST | /HP-IDM/v1.0/gstokens | Y/Y | Anon |
| Tenants | [List Tenants](#list_tenants) | GET | /tenants | Y/Y | SS |
| Tenants | [Get All Tenants](#get_all_tenants) | GET | /HP-IDM/v1.0/tenants | Y/Y | SA |
| Tenants | [Get A Tenant](#get_a_tenant) | GET | /HP-IDM/v1.0/tenants/{tenantId}  | Y/Y | SA, DA, DU |
| Tenants | [Check For Existence Of Tenant Name](#check_for_existence_of_tenant_name) | GET | /HP-IDM/v1.0/tenants/{tenantId}  | Y/Y | Anon |
| Tenants | [Get A List Of Users For A Tenant (includes Role Assignments)](#get_a_list_of_users_for_a_tenant_(includes_role_assignments)) | GET | /HP-IDM/v1.0/tenants/{tenantId}/users | Y/Y | SA, DA |
| Tenants | [Create A Tenant](#create_a_tenant) | POST | /HP-IDM/v1.0/tenants  | Y/Y | SA, DA |
| Tenants | [Update A Tenant](#update_a_tenant) | PUT | /HP-IDM/v1.0/tenants/{tenantID}  | Y/Y | SA, DA |
| Tenants | [Delete A Tenant](#delete_a_tenant) | DELETE | /HP-IDM/v1.0/tenants/{tenantId} | Y/Y | SA, DA |
| Tenants | [Get Endpoints For A Tenant](#get_endpoints_for_a_tenant) | GET | /HP-IDM/v1.0/tenants/{tenantId}/endpoints | Y/Y | SA, DA, DU |
| Tenants | [Add Endpoint To A Tenant](#add_endpoint_to_a_tenant) | POST | /HP-IDM/v1.0/tenants/{tenantId]}/endpoints | Y/Y | SA, DA |
| Tenants | [Remove Endpoints From A Tenant](#remove_endpoints_from_a_tenant) | DELETE | /HP-IDM/v1.0/tenants/{tenantId}/endpoints/{endpointId} | Y/Y | DA, SA |
| Tokens | [Authenticate](#authenticate) | POST | /tokens | Y/Y | Anon |
| Tokens | [Rescope Token](#rescope_token) | POST | /tokens | Y/Y | SS |
| Tokens | [Revoke Token](#revoke_token) | DELETE | /HP-IDM/v1.0/tokens/{tokenId} | Y/Y | SA,DA,SS |
| Tokens | [Swift Legacy Authentication](#swift_legacy_authentication) | GET | /v1.0 | Y/Y | Anon |
| Tokens | [Swift Legacy Authentication](#swift_legacy_authentication) | GET | /v1.1 | Y/Y | Anon |
| Tokens | [Swift Legacy Authentication](#swift_legacy_authentication) | GET | /auth/v1.0 | Y/Y | Anon |
| Tokens | [Swift Legacy Authentication](#swift_legacy_authentication) | GET | /auth/v1.1 | Y/Y | Anon |
| Tokens | [Validate Token](#validate_token) | GET | /tokens/{tokenId} | Y/Y | Anon |
| Tokens | [Quick Token Validation](#quick_token_validation) | GET | /tokens/{tokenId} | Y/Y | Anon |
| Tokens | [Refresh Token](#refresh_token) | GET | /tokens/{tokenId} | Y/Y | SS |
| Users | [List Users](#list_users) | GET | /HP-IDM/v1.0/users | Y/Y | SA, SS |
| Users | [Get A User](#get_a_user) | GET | /HP-IDM/v1.0/users/{userId}  | Y/Y | SA, DA, SS |
| Users | [Check For Existence Of User](#check_for_existence_of_user) | GET | /HP-IDM/v1.0/users/{userId}  | Y/Y | Anon |
| Users | [Create A New User](#create_a_new_user) | POST | /HP-IDM/v1.0/users | Y/Y | SA, DA, SR |
| Users | [Delete A User](#delete_a_user) | DELETE | /HP-IDM/v1.0/users/{userId} | Y/Y | SA, DA |
| Users | [Get All Groups For A User](#get_all_groups_for_a_user) | GET | /HP-IDM/v1.0/users/{userId}/groups | Y/Y | SA, DA, SS |
| Users | [Update Password For A User](#update_password_for_a_user) | PUT | /HP-IDM/v1.0/users/{userId}/password | Y/Y | SA, DA, SS |
| Users | [Initial Password Reset](#initial_password_reset) | POST | /HP-IDM/v1.0/users/password/reset | Y/Y | SA, DA, Anon |
| Users | [Validate Password ResetId And Update Password](#validate_password_resetid_and_update_password) | PUT | /HP-IDM/v1.0/users/password/reset/{resetId} | Y/Y | Anon |
| Users | [List A User's Non Tenant Role Assignments](#list_a_users_non_tenant_role_assignments) | GET | /HP-IDM/v1.0/users/{userId}/username}/roles | Y/Y | SA, DA, DU |
| Users | [Check User's Non Tenant Role Assignment](#check_users_non_tenant_role_assignment) | GET | /HP-IDM/v1.0/users/{userId}/username}/roles | Y/Y | SA, DA, DU |
| Users | [Create A User's Non Tenant Role Assignment](#create_a_users_non_tenant_role_assignment) | PUT | /HP-IDM/v1.0/users/{userId}/roles/{roleId} | Y/Y | SA, DA |
| Users | [Delete A User's Non Tenant Role Assignment](#delete_a_users_non_tenant_role_assignment) | DELETE | /HP-IDM/v1.0/users/{userId}/roles/{roleId} | Y/Y | SA, DA |
| User Access Keys | [Create User Access Key](#create_user_access_key) | POST | /HP-IDM/v1.0/accesskeys | Y/Y | SA, DA, SS |
| User Access Keys | [Delete User Access Key](#delete_user_access_key) | DELETE | /HP-IDM/v1.0/accesskeys/{accesskeyId}  | Y/Y | SA, DA, SS |
| User Access Keys | [Get Access Keys](#get_access_keys) | GET | /HP-IDM/v1.0/accesskeys | Y/Y | SA,DA, SS |
| User Access Keys | [Get An Access Key](#get_an_access_key) | GET | /HP-IDM/v1.0/accesskeys/{accesskeyId} | Y/Y | SA,DA,SS |
| User Access Keys | [Import User Access Key(s)](#import_user_access_key | PUT | /HP-IDM/v1.0/accesskeys | Y/Y | SA, DA, SS |
| User Access Keys | [Update User Access Key](#update_user_access_key) | PUT | /HP-IDM/v1.0/accesskeys/{accesskeyId} | Y/Y | SA, DA, SS |
| User Certificates | [Delete User Certificate](#delete_user_certificate) | DELETE | /HP-IDM/v1.0/certificates/{issuerName}/{serialNumber} 	D | Y/Y | SA, DA, SS |
| User Certificates | [Get User Certificate](#get_user_certificate) | GET | /HP-IDM/v1.0/certificates/{issuerName}/{serialNumber} | Y/Y | SA, DA, SS |
| User Certificates | [Create A User Certificate](#create_a_user_certificate) | POST | /HP-IDM/v1.0/certificates | Y/Y | SA, DA, SS |
| User Certificates | [Import User Certificate(s)](#import_user_certificate(s)) | PUT | /HP-IDM/v1.0/certificates | Y/Y | SA, DA, SS |
| User Certificates | [Update User Certificate](#update_user_certificate) | PUT | /HP-IDM/v1.0/certificates/{issuerName}/{serialNumber} 	 | Y/Y | SA,DA,SS |
| User Key Pairs | [Create User Key Pair](#create_user_key_pair) | POST | /HP-IDM/v1.0/keypairs | Y/Y | SA, DA, SS |
| User Key Pairs | [Delete User Key Pair](#delete_user_key_pair) | DELETE | /HP-IDM/v1.0/keypairs/{keypairId} | Y/Y | SA, DA, SS |
| User Key Pairs | [Get User Key Pair](#get_user_key_pair) | GET | /HP-IDM/v1.0/keypairs/{keypairId} | Y/Y | SA, DA, SS |
| User Key Pairs | [Get User Key Pairs](#get_user_key_pairs) | GET | /HP-IDM/v1.0/keypairs | Y/Y | SA, DA, SS |
| User Key Pairs | [Import User Key Pair(s)](#import_user_key_pair(s)) | PUT | /HP-IDM/v1.0/keypairs | Y/Y | SA, DA, SS |
| User Key Pairs | [Update User Key Pair](#update_user_key_pair) | PUT | /HP-IDM/v1.0/keypairs/{keypairId} | Y/Y | SA, DA, SS |

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
 
#### 4.4.1.1 Post Action#### {#post_action}
#### POST /HP-IDM/v1.0/action/{action}
Privilege Level: {Privilege Level}*

Submit an action to be executed. Each action takes a specific set of execution parameters within the content of the Post. (For an exact list of parameters for each Action, click the link below.) In the absence of any query parameters, the Action will be submitted and the call will immediately return a Job Ticket. The Job Ticket contains information about the executing Job, and can be refreshed through the job API call.
An Action request may contain the timeOut query parameter that is set to a non-zero positive value. The value indicates that the request should wait at least the given length of time for the Action to complete - either successfully or due to error. If the Action does not complete with the time period then the job is cancelled and any completed action steps will be rolled back.

Please see [Appendix A: Available Actions](#available_action) for detail information on the actions.

**Request Data**

See documentation of the multifarious actions that can be posted at the Available Actions page.   Examples below are illustrative only.

**URL Parameters**

* *{action}* - String - The action for which to create a job ticket
* *{timeout}* - Long - The timeout.  Without the timeout specified the returned JobTicket would have a state of PENDING instead of COMPLETE

**Data Parameters**

The parameters are dependent on the action being posted.  See documentation under Available Actions.

JSON

	POST https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/action/updateDomain?timeOut=60000 HTTP/1.1
	X-Auth-Token: HPAuth_4e89f121318cd70066d68c2e
	Date: Mon, 3 Oct 2011 11:30:10 -0600
	Content-Type: application/json
	User-Agent: Maxwell/Smart
	Host: Pat Sajak
	 
	{"JobTicket": {"actionParams":{"status": "SUSPENDED_3", "domainId": "92636548281306"}}}

**Success Response**

**Status Code**

201 (Created)

**Response Data**

Examples below are illustrative only.  Actual results will depend on the action being posted - see documentation under Available Actions.

JSON

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


**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X POST -H 'User-Agent: Jakarta Commons-HttpClient/3.1' -H 'Content-Type: application/json' --cert <cert-path> --cacert <ca-cert-path> --data '{"JobTicket": {"actionParams":{"status": "SUSPENDED_3", "domainId": "92636548281306"}}}' -H 'X-Auth-Token: <auth-token>' [HPKeystoneExtensionBaseURI]/action/UpdateDomain?timeOut=20000

#### 4.4.1.2 Get Jobs By Account#### {#get_jobs_by_account}
#### GET /HP-IDM/v1.0/job
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

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k -s -S --connect-timeout 2 --noproxy 127.0.0.1,localhost,hpcloud.net -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job?accountId=60809900579962

#### 4.4.1.3 Get A Job Ticket#### {#get_a_job_ticket}
#### GET /HP-IDM/v1.0/job/{ticketId}
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

XML

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

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/{ticketId}

#### 4.4.1.4 Restart A TIMEDOUT Job#### {#restart_a_timedout_job}
#### PUT /HP-IDM/v1.0/job/{ticketId}
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

	HTTP/1.1 200 OK
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: -1
	Content-Type: application/json
	Content-Length: 508
	Date: Thu, 06 Oct 2011 16:38:15 GMT

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k -s -S --connect-timeout 2 --noproxy 127.0.0.1,localhost,hpcloud.net -m 30 -X PUT -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: HPAuth_07ea10efcbcd4a16441f45c7b4bc7aad0a657688576ec67a55ee6e2f00eea8b8" [HPKeystoneExtensionBaseURI]/job/508fa9bce4b0c294a11da398

#### 4.4.1.5 Delete A Job#### {#delete_a_job}
#### DELETE HPKeystoneExtensionBaseURI/job/{ticketId}
*Privilege Level: {Privilege Level}*

This API call deletes a specified Job Ticket.

Job Tickets for Actions which complete successfully are eventually removed from the system. But Actions which fail must have their Job Tickets manually deleted using this API call.

**Request Data**

	DELETE https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/4e8c7849318cf2e142e76ef4 HTTP/1.1
	X-Auth-Token: HPAuth_4e8c7849318cf2e142e76ef1
	Date: Wed, 5 Oct 2011 09:31:28 -0600
	User-Agent: Maxwell/Smart
	Host: Pat Sajak

**URL Parameters**

* *ticketId* - Long - The id of the ticket to be deleted

**Data Parameters**

This call does not require a request body.

**Success Response**

204 - OK

**Response Data**

	HTTP/1.1 204 No Content
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: -1
	Date: Wed, 05 Oct 2011 15:31:25 GMT

**Error Response**

400 (Bad Request)               Malformed request in URI or request body.
401 (Unauthorized)              The caller does not have the privilege required to perform the operation.
403 (Forbidden)                 Disabled or suspended user making the request.
500 (Internal Server Error)     The server encountered a problem while processing the request.
503 (Service Unavailable)       The server is unavailable to process the request.

**Curl Example**

	curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X DELETE -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/{ticketId}

#### 4.4.1.6 Get Error Jobs#### {#get_error_jobs}
#### GET /HP-IDM/v1.0/job/error
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

XML

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

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k -s -S --connect-timeout 2 --noproxy <proxy-excpetions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/error

#### 4.4.1.7 Get A Count Of Error Jobs#### {#get_a_count_of_error_jobs}
#### GET /HP-IDM/v1.0/job/error/count
*Privilege Level: {Privilege Level}*

Return a count of all error job tickets in the database. Error tickets have a status of either ERROR or TIMEDOUT.

**Request Data**

The call does not require any parameters.

**URL Parameters**

**Data Parameters**

This call does not require a request body.

**Success Response**

	HTTP/1.1 200 OK
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: -1
	Content-Type: text/plain
	Transfer-Encoding: chunked
	Date: Thu, 06 Oct 2011 16:12:00 GMT
	 
	7

**Status Code**

200 - OK

**Response Data**

	48

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

	curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/error/count

#### 4.4.1.8 Get Error Jobs By Category#### {#get_error_jobs_by_category}
#### GET /HP-IDM/v1.0/job/error/{category}
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

XML

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

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k -s -S --connect-timeout 2 --noproxy <proxy-excpetions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/error/USER_INPUT

#### 4.4.1.9 Delete Error Jobs By Category#### {#delete_error_jobs_by_category}
#### DELETE HPKeystoneExtensionBaseURI/job/error/{category}
*Privilege Level: {Privilege Level}*

Job Tickets that are in the ERROR state will have an Action Exception attached to them. Action Exceptions are categorized, and can be retrieved or delete in bulk by category. This API is used to delete all ERROR action jobs whose Action Exceptions are of a specified category. The list of all categories is found on the Action Exception page.

**Request Data**

	DELETE https://kswj2.fc.hp.com:8443/v2.0/HP-IDM/v1.0/job/USER_INPUT HTTP/1.1
	X-Auth-Token: HPAuth_4e8c7849318cf2e142e76ef1
	Date: Wed, 5 Oct 2011 09:31:28 -0600
	User-Agent: Maxwell/Smart
	Host: Pat Sajak

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

	HTTP/1.1 204 No Content
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: -1
	Date: Wed, 05 Oct 2011 15:31:25 GMT

**Curl Example**

	{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}

#### 4.4.1.10 Get Jobs By Status#### {#get_jobs_by_status}
#### GET /HP-IDM/v1.0/job/status/{status}
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

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k -s -S --connect-timeout 2 --noproxy <proxy-exceptions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/status/COMPLETE

#### 4.4.1.11 Get Job Count By Status#### {#get_job_count_by_status}
#### GET /HP-IDM/v1.0/job/status/{status}/count
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

	26

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>


Curl Example

	curl -k -s -S --connect-timeout 2 --noproxy <proxy-exceptions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "Accept: application/json" -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/job/status/COMPLETE/count



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


#### 4.4.2.1 Check For Existence Of Domain Name#### {#check_for_existence_of_domain_name}
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

	HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21_11_01_30_565 HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/json

XML

Case-insensitive lookup of above domainName

	HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=domain_2012_08_21_11_01_30_565 HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/xml

Optional:

JSON 

When provided domainName not found

	HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21565 HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/json

When missing domainName in request

	HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/xml

**Success Response**

There is no response body returned. Status code indicates the result where 200 indicates that provided name exists and 404 indicates when name does not exist.

**Status Code**

200 - OK , 404 - NOT FOUND

**Response Data**

This call does not return a response body and result is determined through returned http status code. Response body is present only in case of errors.

JSON

	HTTP/1.1 200 OK
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: -1
	Content-Length: 0
	Date: Tue, 21 Aug 2012 19:15:56 GMT

XML

Response for case-insensitive lookup of above domainName

	HTTP/1.1 200 OK
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: -1
	Content-Length: 0
	Date: Tue, 21 Aug 2012 19:17:00 GMT

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

	HTTP/1.1 404 Not Found
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: \-1
	Content-Type: text/html;charset=utf-8
	Content-Length: 952
	Date: Tue, 21 Aug 2012 19:17:43 GMT

When missing domainName in request

	HTTP/1.1 204 No Content
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: \-1
	Date: Tue, 21 Aug 2012 19:18:23 GMT


Curl Example

	curl -k  --cert dev_hpmiddleware.pem  -I -H "Accept: application/json" "https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21565"

**Additional Notes**




#### 4.4.2.2 Create A Domain#### {#create_a_domain}
#### GET /HP-IDM/v1.0/domains 
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

XML

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

Optional:


**Success Response**

The response body contains data for newly created domain with http status code of 201.

**Status Code**

201 - CREATED

**Response Data**

Response data structure is same as input domain data

JSON

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

XML

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

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

In case domain name already exists

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

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XPOST -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" -d '{  "domain" : {  "name" : "Sees Candies 6" } }'  https://localhost:35357/v2.0/HP-IDM/v1.0/domains

**Additional Notes**



#### 4.4.2.3 Delete A Domain#### {#delete_a_domain}
#### DELETE /HP-IDM/v1.0/domains/{domainId} 
*Privilege Level: System Adminstrator (SA)*

Deletes the specified domain by its {domainID}. This API deletes the Users, Tenants, Groups, Roles, RoleRefs and Grants associated to the Domain.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**



**Data Parameters**

This call does not require a request body

JSON

	DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196 HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/json
	X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
	Host: localhost:35357
	Connection: Keep-Alive
	User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

Now trying to delete previously deleted domain, expecting error.

	DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196 HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/xml
	X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
	Host: localhost:35357
	Connection: Keep-Alive
	User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

Optional:



**Success Response**

There is no respone body and respons code of 204 is returned after successful deletion of domain.

**Status Code**

204 - No Content

**Response Data**

This call does not have a response body other than in case of errors.

JSON

	HTTP/1.1 204 No Content
	Server: Apache-Coyote/1.1
	Set-Cookie: JSESSIONID=38FAFEF8E7816E6B717B1328FC6AFF49; Path=/; Secure
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: -1
	Date: Tue, 30 Oct 2012 21:30:16 GMT

XML

Response for deleting previously deleted domain.

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

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XDELETE -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196

**Additional Notes**



#### 4.4.2.4 Get A Domain#### {#get_a_domain}
#### GET /HP-IDM/v1.0/domains/{domainId} 
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

Get a domain based on the {domainId} specified. DomainId's are opaque values returned with get domain list operations. 

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body

JSON

	GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/63283648950838 HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/json
	X-Auth-Token: HPAuth_5032ad14957cb3caab6c33eb

XML

	GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/81132865245171 HTTP/1.1GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/63283648950838 HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/xml
	X-Auth-Token: HPAuth_5032ad14957cb3caab6c33eb

Optional:



**Success Response**

The domain data is returned with http status code of 200 for provided domainId.

**Status Code**

200 - OK

**Response Data**

See schema file, domain.xsd, for more details on the domain response data structure.

JSON

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

XML

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
	   <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
	   </billToAddress> 
	</domain>

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

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196

**Additional Notes**


#### 4.4.2.5 Get All Domains#### {#get_all_domains}
#### GET /HP-IDM/v1.0/domains
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

	GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains?limit=2 HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/json
	X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
	Host: localhost:35357
	Connection: Keep-Alive
	User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

	GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/xml
	X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
	Host: localhost:35357
	Connection: Keep-Alive
	User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

Optional:

JSON

With marker and parameter both set

	GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains?limit=2&marker=23213441623236 HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/json
	X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
	Host: localhost:35357
	Connection: Keep-Alive
	User-Agent: Apache-HttpClient/4.1.1 (java 1.5)


**Success Response**

Returns list of domains for given input with http status code 200.

**Status Code**

200 - OK

**Response Data**



JSON

Listing all domains response

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

Listing response with marker and parameter both set

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

XML

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
	      <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
	      </billToAddress> 
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

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains

**Additional Notes**


#### 4.4.2.6 Get Groups For A Domain#### {#get_groups_for_a_domain}
#### GET /HP-IDM/v1.0/domains/{domainId}/groups
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

	GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/groups HTTP/1.1
	Accept-Encoding: gzip,deflate
	X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
	Host: localhost:35357
	Connection: Keep-Alive
	User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

Request with marker and groupName

	GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/groups?marker=20249143710988&groupName=Domain%20Administrators HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/xml
	X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
	Host: localhost:35357
	Connection: Keep-Alive
	User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

Optional:

XML

Request with filters

	GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP_IDM/v1.0/domains/641564254582/groups/groupId=1234&excludeRoles=roleId1,roleId22 HTTP/1.1
	Connection: close
	Accept: application/xml
	User-Agent: Jakarta Commons-HttpClient/3.1
	Host: haneef-desktop.americas.hpqcorp.net:8080

**Success Response**

List groups for domain for given filter criteria and marker if there with http status code 200.

**Status Code**

200 - OK

**Response Data**


JSON

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

XML

Request with marker and groupName

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

	{
	  "badRequest" : {
	    "code" : 400,
	    "details" : "Bad input request : Filters groupId and groupName are mutually exclusive.  You can't use both at the same time",
	    "message" : "Bad request",
	    "otherAttributes" : {
	    }
	  }
	}

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196/groups

**Additional Notes**


#### 4.4.2.7 Get Subscribe Able Services For A Domain#### {#get_subscribe_able_services_for_a_domain}
#### GET /HP-IDM/v1.0/domains/{domainId}/subscribeableServices
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

	GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/subscribeableServices HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/json
	X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
	Host: localhost:35357
	Connection: Keep-Alive
	User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

	GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/64521341789596/subscribeableServices HTTP/1.1
	Accept-Encoding: gzip,deflate
	X-Auth-Token: HPAuth_4f46a309b0bebb59e36f663f
	Accept: application/xml
	User-Agent: Jakarta Commons-HttpClient/3.1
	Host: localhost:8443

Optional:

JSON

With serviceName filter

	GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/subscribeableServices?serviceName=Compute HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/json
	X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
	Host: localhost:35357
	Connection: Keep-Alive
	User-Agent: Apache-HttpClient/4.1.1 (java 1.5)


**Success Response**

The response is a list of subscribe able services for the domain. Results are filtered by serviceName if serviceName is provided. Result will include single subscribe able service as identified endpoint template id if its provided in query.

**Status Code**

200 - OK

**Response Data**


JSON

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

XML

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

Optional

JSON

With serviceName filter

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

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/subscribeableServices?serviceName=Compute 

**Additional Notes**



#### 4.4.2.8 Get Service Activations For A Domain#### {#get_service_activations_for_a_domain}
#### GET /HP-IDM/v1.0/domains/{domainId}/services
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

	GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/23268133247776/services?tenantId=35871429575842 HTTP/1.1
	Accept-Encoding: gzip,deflate
	X-Auth-Token: HPAuth_4ea802a5b0be7e989230032e
	Accept: application/json
	User-Agent: Jakarta Commons-HttpClient/3.1
	Host: localhost:8443

XML

	GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/23268133247776/services HTTP/1.1
	Accept-Encoding: gzip,deflate
	X-Auth-Token: HPAuth_4ea802a5b0be7e989230032e
	Accept: application/xml
	User-Agent: Jakarta Commons-HttpClient/3.1
	Host: localhost:8443

Optional:

JSON

When no activated services are there for a domain

	GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/services HTTP/1.1
	Accept-Encoding: gzip,deflate
	Accept: application/json
	X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
	Host: localhost:35357
	Connection: Keep-Alive
	User-Agent: Apache-HttpClient/4.1.1 (java 1.5)


**Success Response**

The response is a list of activated services for the domain (filtered by tenantId if tenantId is provided)

**Status Code**

200 - OK

**Response Data**


JSON

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

XML

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

Optional

JSON

When no activated services are there for a domain

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

	{
	  "itemNotFound" : {
	    "code" : 404,
	    "details" : "Domain with domainId : 66751536630362 does not exist in the System",
	    "message" : "NOT_FOUND",
	    "otherAttributes" : {
	    }
	  }
	}

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/services

**Additional Notes**



#### 4.4.2.9 Get Tenants For A Domain#### {#get_tenants_for_a_domain}
#### GET /HP-IDM/v1.0/domains/{domainId}/tenants
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

	GET /v2.0/HP-IDM/v1.0/domains/29649421790262/tenants HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Wink Client v1.1.2
	X-Auth-Token: HPAuth_4e8f7d182cdcb96406c8c61b
	Host: localhost:9999
	Connection: keep-alive

XML

	GET /V2.0/HP-IDM/v1.0/domains/798477662343/tenants HTTP/1.1
	Accept: application/xml
	Content-Type: application/xml
	User-Agent: Wink Client v1.1.2
	Host: localhost:9999
	Connection: keep-alive

Optional:


**Success Response**

The response is a list of tenant resources for the domain. 

**Status Code**

200 - OK

**Response Data**


JSON

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

XML

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

	{
	  "itemNotFound" : {
	    "code" : 404,
	    "details" : "Domain does not exist",
	    "message" : "Not found",
	    "otherAttributes" : {
	    }
	  }
	}

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630362/tenants

**Additional Notes**



#### 4.4.2.10 Get Users For A Domain#### {#get_users_for_a_domain}
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

	GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Wink Client v1.1.2
	X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
	Host: localhost:9999
	Connection: keep-alive

XML

	GET /v2.0/HP-IDM/v1.0/domains/798477662343/users HTTP/1.1
	Accept: application/xml
	Content-Type: application/xml
	User-Agent: Wink Client v1.1.2
	Host: localhost:9999
	Connection: keep-alive

Optional:

JSON

Request with excludeRoles

	GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users?excludeRoles=RoleId1,RoleId2 HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Wink Client v1.1.2
	X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
	Host: localhost:9999
	Connection: keep-alive

Request with excludeGroups

	GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users?excludeGroups=GroupId1,GroupId22 HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Wink Client v1.1.2
	X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
	Host: localhost:9999
	Connection: keep-alive

XML

Request with exclusion filter

	GET /v2.0/HP-IDM/v1.0/domains/798477662343/users?excludeGroups=000002002,000002001 HTTP/1.1
	Accept: application/xml
	Content-Type: application/xml
	User-Agent: Wink Client v1.1.2
	Host: localhost:9999
	Connection: keep-alive


Request with userId filter

	GET /v2.0/HP-IDM/v1.0/domains/798477662343/users?userId=12345 HTTP/1.1
	Accept: application/xml
	Content-Type: application/xml
	User-Agent: Wink Client v1.1.2
	Host: localhost:9999
	Connection: keep-alive

**Success Response**

List of users returned for given input criteria with http status code 200.

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

	{
	  "itemNotFound" : {
	    "code" : 404,
	    "details" : "Domain does not exist",
	    "message" : "Not found",
	    "otherAttributes" : {
	    }
	  }
	}

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/798477662343/users?userId=12345

**Additional Notes**



#### 4.4.2.11 List Role Definitions (Deprecated)#### {#list_role_definitions_deprecated}
#### GET /HP-IDM/v1.0/domains/{domainId}/roles
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

	GET /v2.0/HP-IDM/v1.0/domains/641564254582/roles HTTP/1.1
	Connection: close
	Accept: application/json
	User-Agent: Jakarta Commons-HttpClient/3.1
	Host: haneef-desktop.americas.hpqcorp.net:8080

XML

	GET /v2.0/HP-IDM/v1.0/domains/641564254582/roles HTTP/1.1
	Connection: close
	Accept: application/xml
	User-Agent: Jakarta Commons-HttpClient/3.1
	Host: haneef-desktop.americas.hpqcorp.net:8080

Optional:



**Success Response**

List of roles with http status code 200.

**Status Code**

200 - OK

**Response Data**


JSON

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

XML

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

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196/roles

**Additional Notes**



#### 4.4.2.12 Transfer Ownership Of A Domain#### {#transfer_ownership_of_a_domain}
#### PUT /HP-IDM/v1.0/domains/{domainId}/owner/{userId}	
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

	PUT /v2.0/HP-IDM/v1.0/domains/29649421790262/owner/60414337132139 HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Wink Client v1.1.2
	X-Auth-Token: HPAuth_4e8f7d182cdcb96406c8c61b
	Host: localhost:9999
	Connection: keep-alive

XML

	PUT /v2.0/HP-IDM/v1.0/domains/662648896689/owner/129024620458 HTTP/1.1
	Accept: application/xml
	account_id: 000000003001
	Content-Type: application/xml
	domain_id: 000000001001
	User-Agent: Wink Client v1.1.2
	Host: localhost:9999
	Connection: keep-alive

Optional:


**Success Response**

Transfer ownership of a Domain with http status code 200

**Status Code**

200 - OK

**Response Data**


JSON

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

XML

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

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/662648896689/owner/129024620458 

**Additional Notes**


#### 4.4.2.13 Update A Domain#### {#update_a_domain}
#### PUT /HP-IDM/v1.0/domains/{domainId}
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

XML

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

Optional:


**Success Response**

Updated domain resource is returned with http status code 200

**Status Code**

200 - OK

**Response Data**



JSON

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

XML

	HTTP/1.1 200 OK
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: -1
	Content-Type: application/xml
	Content-Length: 508
	Date: Thu, 22 Dec 2011 19:51:00 GMT
	 
	<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
	<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" domainId="26856794720485" name="action-king-DOMAIN" emailAddress="actionking@hp.com" addressLine2="Studio Lanes" company="action-king" phone="1-800-NO-DISNEY" status="enabled">
	<billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
	 </billToAddress> 
	</domain>

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

	{
	  "IdentityFault" : {
	    "message" : "Conflict",
	    "details" : "Domain already exists",
	    "code" : 409,
	    "otherAttributes" : {
	    }
	  }
	}

	{
	  "itemNotFound" : {
	    "code" : 404,
	    "details" : "Domain does not exist",
	    "message" : "Not found",
	    "otherAttributes" : {
	    }
	  }
	}

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cert dev_hpmiddleware.pem  -XPUT -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" -H "Content-type: application/json" -d '{  "domain" : {  "name" : "Sees Candies 61", "phone": "1-800-NO-DISNEY"} }' https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361

**Additional Notes**




### 4.4.3 Endpoint Templates

The Endpoint Template REST API provides the ability to manage service endpoints.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.3.1 Add Endpoint Template#### {#add_endpoint_template}
#### POST /HP-IDM/v1.0/endpointTemplates
*Privilege Level: SA, SVC*

Adds new endpoint template data. Endpoint template data is provided in POST request body. Service name ('name' attribute) and region is required in EndpointTemplate. Input 'id' needs to be unique value in the system. 

Name (service name) and region combination needs to be unique in system. 
Service with given name should already be registered with system otherwise related error is returned back. Similarly type (service type) should have a valid system-recognized (pre-defined) value.
Release state attribute if not provided in input data, then its value is derived from related registered service. If provided, then value should have a valid system-recognized (pre-defined) value.

If enabled and global flag values are not provided in input data, system uses 'true' and 'false' as its default value respectively. 

Region code is not marked as required in current implementation but should be provided.  The format of region code is  [csbu:az-number].[csbu:region-alpha].[csbu:geo-number]   So, and example would be: az-1.region-a.geo-1

Note: Only tenant specific enabled and global endpoint templates are returned as part of service catalog during scoped token validation call.


**Request Data**


**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

Request body includes the new endpoint template with required fields defined.

JSON

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

XML

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

**Success Response**


**Status Code**

201 - Created

**Response Data**

JSON

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

XML

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

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | EndpointTemplateId not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X POST -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -d '{  "EndpointTemplate" : {  "name" : "Compute", "type":"compute", "id":"215","region":"az-3.region-a.geo-6","global":"false","enabled":"true",releaseState="public","publicURL": "https:\/\/az-3.region-a.geo-1.compute.hpcloudsvc.com\/v1.1\/", "adminURL": "https:\/\/https://nv-aw2az3-manage0009.uswest.hpcloud.net\/v1.1\/"} }' "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates"

**Additional Notes**


#### 4.4.3.2 Delete Endpoint Template#### {#delete_endpoint_template}
#### DELETE /HP-IDM/v1.0/endpointTemplates/ {endpointTemplateId} 
*Privilege Level: SA, SVC*

Deletes an endpoint template for the specified endpointTemplateId This will also remove all tenant association with this template.

endpointTemplateId  is required otherwise 400 (bad request) is returned.

If endpointTemplateId is not present in system, 404 (item not found) error is returned.

**Request Data**


**URL Parameters**

* *endpointTemplateId* - scalar - Unique ID of the endpoint template to be deleted.

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.


**Success Response**

**Status Code**

204 - No Content

**Response Data**

No content is expected in response body

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | EndpointTemplateId not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X DELETE -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/xml" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates/1200"

**Additional Notes**


#### 4.4.3.3 Get Enabled Endpoint Templates#### {#get_enabled_endpoint_templates}
#### GET /HP-IDM/v1.0/endpointTemplates/enabled
*Privilege Level: SA, SVC, DA, DU *

Get a list of available endpoint templates. If serviceName is provided in query, then endpoint templates specific to only that service are included in response.  In case of incorrect service name ( does not exist in system), empty list is returned. This list will to include only enabled endpoint templates. The operation does not require a request body.

This API supports pagination through 'limit' and 'marker' usage. Marker is templateId and should be valid otherwise 404 (not found) error is going to be returned.

Note: Only tenant specific enabled and global endpoint templates are returned as part of service catalog during scoped token validation call.

**Request Data**


**URL Parameters**

* *serviceName* (Optional) - string - service name to return endpoint templates specific to
* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the template Id. 


**Data Parameters**

This call does not require a request body.


**Success Response**


**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | Marker value is not valid (not found in database).  |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |


**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/xml" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates/enabled?limit=4"

**Additional Notes**


#### 4.4.3.4 Get Endpoint Template By Id#### {#get_endpoint_template_by_id}
#### GET /HP-IDM/v1.0/endpointTemplates/{endpointTemplateId}
*Privilege Level: SA, SVC, DA, DU*

Get an endpoint template by endpointTemplateId.

**Request Data**

The operation does not require a request body.

**URL Parameters**

* *endpointTemplateId* - scalar - The numeric id for a endpoint template

**Data Parameters**

This operation does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | EndpointTemplateId not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/xml" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates/1200"

**Additional Notes**


#### 4.4.3.5 Get Endpoint Templates#### {#get_endpoint_templates}
#### GET /HP-IDM/v1.0/endpointTemplates
*Privilege Level: SA, SVC, DA, DU *

Get a list of endpoint templates. If serviceName is provided in query, then endpoint templates specific to only that service are included in response. In case of incorrect service name ( does not exist in system), empty list is returned. This list will include disabled endpoint templates in addition to enabled endpoint templates. The operation does not require a request body.

This API supports pagination through 'limit' and 'marker' usage. Marker is templateId and should be valid otherwise 404 (not found) error is going to be returned.

Note: Only tenant specific enabled and global endpoint templates are returned as part of service catalog during scoped token validation call.

**Request Data**

**URL Parameters**

* *serviceName* (Optional) - string - service name to return endpoint templates specific to
* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the template Id. 

**Data Parameters**

This call does not require a request body.


**Success Response**


**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | Marker value is not valid (not found in database).  |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |


**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/xml" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates?serviceName=Compute&limit=5"

**Additional Notes**


#### 4.4.3.6 Update Endpoint Template#### {#update_endpoint_template}
#### PUT HPKeystoneExtensionBaseURI]/endpointTemplates/{endpointTemplateId} 
*Privilege Level: SA, SVC *

Updates existing endpoint template data. Endpoint template data is provided in PUT request body. Id, service name and region are required in EndpointTemplate. Returns back is the updated endpoint template data as the response body. If optional attributes values are not provided or left blank, then it will overwrite existing attribute value, with null or blank respectively, in system if there.

Name (service name) and region combination needs to be unique in system. 
Service with given name should already be registered with system otherwise related error is returned back. Similarly type (service type) should have a valid system-recognized (pre-defined) value.
Release state attribute if not provided in input data, then its value is left unchnaged. If provided, then value should have a valid system-recognized (pre-defined) value.

Template must exist in system otherwise returns 404 (item not found) error.

If enabled and global flag values are not provided in input data, system does not update its existing values for other fields, it will update with null/blank if not provided. 

**Request Data**


**URL Parameters**

* *endpointTemplateId* - scalar - The numeric id for a endpoint template

**Data Parameters**

See schema file for more details on the request and response data structure.

Request body contains the endpoint template to be updated.

JSON

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

XML

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


**Success Response**


**Status Code**

200 - OK

**Response Data**

Response body is the updated endpoint template.

JSON

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

XML

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

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | EndpointTemplateId not found.   |
| 409 | Conflict | Another template exists for given service name and region.    |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |


**Response Data**

JSON

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

	curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X PUT -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates/111" -d '{  "EndpointTemplate" : {  "name" : "Compute",  "region":"az-3.region-a.geo-1",releaseState="preview"} }'

**Additional Notes**



### 4.4.4 Groups

Group is a collection of users. The primary purpose of group is to provide multiple users with the same privillages

**Status Lifecycle**

**Rate Limits**

**Quota Limits**

**Business Rules**

None.


#### 4.4.4.1 Add A User To A Group#### {#add_a_user_to_a_group}
####  PUT /HP-IDM/v1.0/groups/{groupId}/users/{userId}
*Privilege Level: SA, DA*

This API is used to add an existing user to a specified group of the given domain. This interface requires the groupId and userId.

**Request Data**

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.


JSON

	PUT https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
	Connection: close
	Accept: application/json
	User-Agent: Jakarta Commons-HttpClient/3.1
	Host: haneef-desktop.americas.hpqcorp.net:8080
	Content-Length: 0

XML

	PUT https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203
	Connection: close
	Accept: application/xml
	User-Agent: Jakarta Commons-HttpClient/3.1
	Host: haneef-desktop.americas.hpqcorp.net:8080
	Content-Length: 0


**Success Response**

The response body contains location of newly created group with http status code  303.


**Status Code**

303 - OK

**Response Data**


JSON

	HTTP/1.1 303 Created
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: -1
	Location: https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/
	Content-Length: 0
	Date: Mon, 01 Aug 2011 18:27:33 GMT
	Connection: close

XML

	HTTP/1.1 303 Created
	Server: Apache-Coyote/1.1
	Cache-Control: no-cache
	Pragma: no-cache
	Expires: -1
	Location: https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/
	Content-Length: 0
	Date: Mon, 01 Aug 2011 18:27:33 GMT
	Connection: close

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

	{
	  "unauthorized" : {
	    "code" : 401,
	    "details" : "Invalid credentials",
	    "message" : "UNAUTHORIZED",
	    "otherAttributes" : {
	    }
	  }
	}

XML

	<?xml version="1.0" ?>
	<unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
	  <message>
	    UNAUTHORIZED
	  </message>
	  <details>
	    Invalid credentials
	  </details>
	</unauthorized>

Curl Example

    curl -i -H "X-Auth-Token:HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -X PUT "https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203"

**Additional Notes**


#### 4.4.4.2 Create A Group#### {#create_a_group}
####  POST /HP-IDM/v1.0/groups
*Privilege Level: SA,DA*

{Description about the method call}

**Request Data**

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.


JSON

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

XML

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


**Success Response**

The response body contains data for newly created group with http status code of 201.


**Status Code**

201 - OK

**Response Data**


JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" ?>
    <unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
      <message>
        UNAUTHORIZED
      </message>
      <details>
        Invalid credentials
      </details>
    </unauthorized>

Curl Example

    curl -k  -XPOST -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" -d '{  "group": {   "description": "HP Software Group",    "domainId":"69409986171623",    "name": "HP Software"  }}'  https://localhost:35357/v2.0/HP-IDM/v1.0/groups

**Additional Notes**


#### 4.4.4.3 Delates A Group#### {#delates_a_group}
####  DELETE /HP-IDM/v1.0/groups/{groupId}
*Privilege Level: SA ,DA*

Delete a group specified by the groupId. This operation also deletes the associated Roles associated to the Group. This operation does not delete User objects associated with the Group.

**Request Data**

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.


JSON

    DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/groups/245398746613/ HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1

XML

    DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/groups/245398746613/ HTTP/1.1
    Connection: close
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1


**Success Response**

The response doesn't have any body. It has  http status code  204.

**Status Code**

204 - OK

**Response Data**

This call doesn't have response body. It returns http code 204 

JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=37BD6EDBDC2A58CD18201DFD2C21B6C2; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Wed, 28 Dec 2011 19:14:46 GMT

XML

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=37BD6EDBDC2A58CD18201DFD2C21B6C2; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Wed, 28 Dec 2011 19:14:46 GMT

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" ?>
    <unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
      <message>
        UNAUTHORIZED
      </message>
      <details>
        Invalid credentials
      </details>
    </unauthorized>

Curl Example

    curl -i -H "X-Auth-Token:HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -X DELETE "https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/"

**Additional Notes**



#### 4.4.4.4 Get A Specific Group#### {#get_a_specific_group}
####  GET /HP-IDM/v1.0/groups/{groupId}
*Privilege Level: SA,DA, DU *

{Description about the method call}

**Request Data**


**URL Parameters**


**Data Parameters**

This call does not require a request body

JSON

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678 HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

XML

    
    GET https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678 HTTP/1.1
    Connection: close
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

**Success Response**

This call returns the corresponding group. 

**Status Code**

200 - OK

**Response Data**



JSON

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

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 277
    Date: Mon, 01 Aug 2011 18:26:30 GMT
    Connection: close
     
    <?xml version="1.0" ?>
    <group id="583891759678" name="HaneefGroup3" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0">
      <description>
        A Description of the group1
      </description>
    </group>

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" ?>
    <unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
      <message>
        UNAUTHORIZED
      </message>
      <details>
        Invalid credentials
      </details>
    </unauthorized>

Curl Example

    curl -k -H "X-Auth-Token:HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3"  "https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/"

**Additional Notes**



#### 4.4.4.5 List Users For The Group#### {#list_users_for_the_group}
####  GET /HP-IDM/v1.0/groups/{groupId}/users
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

    GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080
    

XML

    GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

Optional: Sample requests using query parameters and filters 

JSON :

    GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?userName=username HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

XML

    GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?userId=412367 HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

XML

    GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?limit=50?maker=34353535& HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

**Success Response**

This call retuns list of users 

**Status Code**

200 - OK

**Response Data**


JSON

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
    

XML

    
    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 277
    Date: Mon, 01 Aug 2011 18:26:30 GMT
    Connection: close
    
    <?xml version="1.0" ?>
    <users xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
      <user domainId="00000000001001" emailAddress="haneef.ali@hp.com" firstName="haneef" passwordResetRequired="true" status="enabled" userId="59587095111744" username="haneef"/>
    </users>

JSON

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" ?>
    <unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
      <message>
        UNAUTHORIZED
      </message>
      <details>
        Invalid credentials
      </details>
    </unauthorized>

Curl Example

    curl -v -k -H "X-Auth-Token: HPAuth_b0846199b9d7c4aa0c7c86169ef693e6298da25c564adff6e002bea84f0b337f"   -H "Accept: application/json" https://csnode.ndd.aw1.hpcloud.net:35357/v2.0/HP-IDM/v1.0/groups/00000000002002/users?userName=haneef
    

**Additional Notes**



#### 4.4.4.6 Delete User From The Group#### {#delete_user_from_the_group}
#### DELETE 	/HP-IDM/v1.0/groups/{groupId}/users/{userId}
*Privilege Level: SA,DA*

Remove a user from a group   

**Request Data**


**URL Parameters**


**Data Parameters**


JSON

    DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

XML

    DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
    Connection: close
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080


**Success Response**

The response doesn't have any content. 

**Status Code**

204 - OK

**Response Data**

The response doesn't have any content

JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Mon, 01 Aug 2011 18:31:40 GMT
    Connection: close

XML

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Mon, 01 Aug 2011 18:31:40 GMT
    Connection: close

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" ?>
    <unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
      <message>
        UNAUTHORIZED
      </message>
      <details>
        Invalid credentials
      </details>
    </unauthorized>

Curl Example

    curl -v -k -H "X-Auth-Token: HPAuth_b0846199b9d7c4aa0c7c86169ef693e6298da25c564adff6e002bea84f0b337f" -X DELETE  -H "Accept: application/json" https://csnode.ndd.aw1.hpcloud.net:35357/v2.0/HP-IDM/v1.0/groups/00000000002002/993639569203

**Additional Notes**


#### 4.4.4.7 Update Group#### {#update_group}
####  PUT 	/HP-IDM/v1.0/groups/{groupId}
*Privilege Level: SA, DA*

Update a group resource for the specified groupId.   Only description and name can  be updated in this operation.

**Request Data**


**URL Parameters**


**Data Parameters**



JSON

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

XML

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



**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" ?>
    <unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
      <message>
        UNAUTHORIZED
      </message>
      <details>
        Invalid credentials
      </details>
    </unauthorized>

Curl Example

    curl -k  -X PUT -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" -d '{  "group": {   "description": "HP Software Group",      "name": "HP Software"  }}'  https://localhost:35357/v2.0/HP-IDM/v1.0/groups/68906974845076

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

#### 4.4.5.1 User Details#### {#user_details}
#### GET /HP-IDM/v1.0/users/details/{userId}
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

    {"userDetails": {
       "bs": false,
       "domain":    {
          "domainId": "33678705570176",
          "emailAddress": "kim.jensen2@hp.com",
          "name": "33678705570176-DOMAIN",
          "owners": ["41145980532179"],
          "status": "ENABLED"
       },
       "jobTickets": [],
       "setDateLastModified": false,
       "setDateRecordAdded": false,
       "setId": false,
       "setVersion": true,
       "tenants":    [
                {
             "description": "Object Storage",
             "name": "TS1-TC2A-SwiftTestTenant12112012141901492",
             "services": [         {
                "regionCode": "region-a.geo-1",
                "serviceName": "Object Storage",
                "status": "ENABLED"
             }],
             "status": "ENABLED",
             "tenantId": "19893479403843"
          },
                {
             "description": "Object Storage",
             "name": "TS1-TC2C-SwiftTestTenant12112012141901492",
             "services": [         {
                "regionCode": "region-a.geo-1",
                "serviceName": "Object Storage",
                "status": "ENABLED"
             }],
             "status": "ENABLED",
             "tenantId": "33349277569059"
          },
                {
             "description": "Object Storage",
             "name": "TS1-TC2D-SwiftTestTenant12112012141901492",
             "services": [         {
                "regionCode": "region-a.geo-1",
                "serviceName": "Object Storage",
                "status": "ENABLED"
             }],
             "status": "ENABLED",
             "tenantId": "51153082887747"
          },
                {
             "description": "Object Storage",
             "name": "TS1-TC2B-SwiftTestTenant12112012141901492",
             "services": [         {
                "regionCode": "region-a.geo-1",
                "serviceName": "Object Storage",
                "status": "ENABLED"
             }],
             "status": "ENABLED",
             "tenantId": "73489722654413"
          }
       ],
       "user":    {
          "accountId": "41145980532179",
          "dateRecordAdded": "2012-11-12T22:19:01.539Z",
          "domainId": "33678705570176",
          "emailAddress": "kim.jensen2@hp.com",
          "status": "ENABLED",
          "timeLastSuccessfulLogin": "2012-11-12T22:19:02.961Z",
          "username": "SW_12112012141901492"
       },
       "userPreferences":    {
          "bs": false,
          "preferenceNames": [],
          "preferences": [],
          "setDateLastModified": false,
          "setDateRecordAdded": false,
          "setId": false,
          "setVersion": true,
          "substoreNames": [],
          "substores": [],
          "version": 0
       },
       "version": 0
    }}
    

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <userDetails>
       <version>0</version>
       <domain>
          <domainId>33678705570176</domainId>
          <emailAddress>kim.jensen2@hp.com</emailAddress>
          <name>33678705570176-DOMAIN</name>
          <owners>
             <owner>41145980532179</owner>
          </owners>
          <status>ENABLED</status>
       </domain>
       <jobTickets/>
       <userPreferences>
          <version>0</version>
          <substores/>
          <preferences/>
       </userPreferences>
       <tenants>
          <tenant>
             <services>
                <service>
                   <regionCode>region-a.geo-1</regionCode>
                   <serviceName>Object Storage</serviceName>
                   <status>ENABLED</status>
                </service>
             </services>
             <description>Object Storage</description>
             <name>TS1-TC2A-SwiftTestTenant12112012141901492</name>
             <status>ENABLED</status>
             <tenantId>19893479403843</tenantId>
          </tenant>
          <tenant>
             <services>
                <service>
                   <regionCode>region-a.geo-1</regionCode>
                   <serviceName>Object Storage</serviceName>
                   <status>ENABLED</status>
                </service>
             </services>
             <description>Object Storage</description>
             <name>TS1-TC2C-SwiftTestTenant12112012141901492</name>
             <status>ENABLED</status>
             <tenantId>33349277569059</tenantId>
          </tenant>
          <tenant>
             <services>
                <service>
                   <regionCode>region-a.geo-1</regionCode>
                   <serviceName>Object Storage</serviceName>
                   <status>ENABLED</status>
                </service>
             </services>
             <description>Object Storage</description>
             <name>TS1-TC2D-SwiftTestTenant12112012141901492</name>
             <status>ENABLED</status>
             <tenantId>51153082887747</tenantId>
          </tenant>
          <tenant>
             <services>
                <service>
                   <regionCode>region-a.geo-1</regionCode>
                   <serviceName>Object Storage</serviceName>
                   <status>ENABLED</status>
                </service>
             </services>
             <description>Object Storage</description>
             <name>TS1-TC2B-SwiftTestTenant12112012141901492</name>
             <status>ENABLED</status>
             <tenantId>73489722654413</tenantId>
          </tenant>
       </tenants>
       <user>
          <accountId>41145980532179</accountId>
          <dateRecordAdded>2012-11-12T14:19:01.539-08:00</dateRecordAdded>
          <domainId>33678705570176</domainId>
          <emailAddress>kim.jensen2@hp.com</emailAddress>
          <status>ENABLED</status>
          <timeLastSuccessfulLogin>2012-11-12T14:19:02.961-08:00</timeLastSuccessfulLogin>
          <username>SW_12112012141901492</username>
       </user>
    </userDetails>

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

An incorrect user id will result in a service unavailable response.
 
    {
      "serviceUnavailable" : {
        "code" : 500,
        "details" : "Server error",
        "message" : "Service unavailable",
        "otherAttributes" : {
        }
      }
    }

An incorrect auth token will result in a service unavailable response.

    {
      "serviceUnavailable" : {
        "code" : 500,
        "details" : "Server error",
        "message" : "Service unavailable",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

**Curl Example**

    curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <cert-path> --cacert <cacert-path> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/users/details/<user-id>


#### 4.4.5.2 User Preferences#### {#user_preferences}
#### GET /HP-IDM/v1.0/preferences/{userId}
*Privilege Level: MC-CS Certificate*

The UserPreference database collection is nothing more that a set of nested hash maps that is associated with a specific user.  Querying it returns that hash map.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
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

XML

    {xml data structure here}

**Error Response**

**Status Code**


| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation   |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

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

Curl Example

    curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X GET -H "User-Agent: Jakarta Commons-HttpClient/3.1" --cert <path-to-cert> --cacert <path-to-cacert> -H "X-Auth-Token: <auth-token>" [HPKeystoneExtensionBaseURI]/preferences/<userId>

#### PUT /HP-IDM/v1.0/preferences/{userId}
*Privilege Level: MC-CS Certificate*

The UserPreference database collection is nothing more that a set of nested hash maps that is associated with a specific user.  Values may be updated.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
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

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation   |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

503 - Service Unavailable

**Response Data**

Not yet documented.

**Curl Example**

Not yet documented.



### 4.4.6 Role Assignment

API to create, update, list and delete CS role assignments

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.6.1 List Role Assignments Made On A Tenant#### {#list_role_assignments_made_on_a_tenant}
#### GET /tenants/{tenantId}/roles
*Privilege Level: SA, DA, DU*

This API would return all the role assignments made on a tenant in its domain filtered by serviceId. Tenant role assignments are always associated with a tenant.

Constraints:

List tenant role assignments is not a privileged operation so far.
ServiceId is not a mandatory field, if provided response should be filtered.
SubjectType is required if subjectId filter is used

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant

The following are the supported list of query parameters to filter the results

* *serviceId* (Optional) - string - list roles specific to the service identified by this id
* *roleId* (Optional) - string - filter by roles having this id
* *subjectType* (Optional) - string - could be one of User/Group
* *subjectId* (Optional)} - string - id of the User/Group specified above
* *limit* (Optional)} - number - limit the results by the specified page size
* *marker* (Optional)} - string - continue returning results after the specified marker

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

    GET /v2.0/HP-IDM/v1.0/tenants/11111111/roles?serviceId=120 HTTP/1.1
    Accept: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

200 - OK
204 - No content

**Response Data**


JSON

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
          "roleAssignmentId": "CmVSz8s9o1ds4Pw25S0Mwk8SBgA63FXWMxRIx4Ix9DQ=",
          "roleId": "00000000004023",
          "roleName": "Admin",
          "subjectId": "777700000004",
          "subjectName": "testGroupId01",
          "subjectType": "Group",
          "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000",
          "domainId": "777700000000",
          "serviceId": "120",
          "tenantId": "777700000001",
          "isCrossDomain": false
       },
          {
          "roleAssignmentId": "az1UVA2ngsdEGgLgOm9kXRbt3FcN3TqaJLO0zN9Aww=",
          "roleId": "00000000004023",
          "roleName": "Admin",
          "subjectId": "777700000003",
          "subjectName": "atiwari-1",
          "subjectType": "User",
          "description": "Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000",
          "domainId": "777700000000",
          "serviceId": "120",
          "tenantId": "777700000001",
          "isCrossDomain": false
       },
          {
          "roleAssignmentId": "oYYbwF2RKU5YRURKRAlJnKvNGbqaeEaenvr0YFFr5s=",
          "roleId": "00000000004016",
          "roleName": "netadmin",
          "subjectId": "777700000004",
          "subjectName": "testGroupId01",
          "subjectType": "Group",
          "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000",
          "domainId": "777700000000",
          "serviceId": "120",
          "tenantId": "777700000001",
          "isCrossDomain": false
       },
          {
          "roleAssignmentId": "znWxft23Ncf3GIWbTJQhlL7jnzLkW5jFLXmRWPh2vIg=",
          "roleId": "00000000004016",
          "roleName": "netadmin",
          "subjectId": "777700000003",
          "subjectName": "atiwari-1",
          "subjectType": "User",
          "description": "Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000",
          "domainId": "777700000000",
          "serviceId": "120",
          "tenantId": "777700000001",
          "isCrossDomain": false
       }
    ]}}

XML

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
          <roleAssignmentId>CmVSz8s9o1ds4Pw25S0Mwk8SBgA63FXWMxRIx4Ix9DQ=</roleAssignmentId>
          <roleId>00000000004023</roleId>
          <roleName>Admin</roleName>
          <subjectId>777700000004</subjectId>
          <subjectName>testGroupId01</subjectName>
          <subjectType>Group</subjectType>
          <description>Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000</description>
          <domainId>777700000000</domainId>
          <serviceId>120</serviceId>
          <tenantId>777700000001</tenantId>
          <isCrossDomain>false</isCrossDomain>
       </role>
       <role>
          <roleAssignmentId>az1UVA2ngsdEGgLgOm9kXRbt3FcN3TqaJLO0zN9Aww=</roleAssignmentId>
          <roleId>00000000004023</roleId>
          <roleName>Admin</roleName>
          <subjectId>777700000003</subjectId>
          <subjectName>atiwari-1</subjectName>
          <subjectType>User</subjectType>
          <description>Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000</description>
          <domainId>777700000000</domainId>
          <serviceId>120</serviceId>
          <tenantId>777700000001</tenantId>
          <isCrossDomain>false</isCrossDomain>
       </role>
       <role>
          <roleAssignmentId>oYYbwF2RKU5YRURKRAlJnKvNGbqaeEaenvr0YFFr5s=</roleAssignmentId>
          <roleId>00000000004016</roleId>
          <roleName>netadmin</roleName>
          <subjectId>777700000004</subjectId>
          <subjectName>testGroupId01</subjectName>
          <subjectType>Group</subjectType>
          <description>Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000</description>
          <domainId>777700000000</domainId>
          <serviceId>120</serviceId>
          <tenantId>777700000001</tenantId>
          <isCrossDomain>false</isCrossDomain>
       </role>
       <role>
          <roleAssignmentId>znWxft23Ncf3GIWbTJQhlL7jnzLkW5jFLXmRWPh2vIg=</roleAssignmentId>
          <roleId>00000000004016</roleId>
          <roleName>netadmin</roleName>
          <subjectId>777700000003</subjectId>
          <subjectName>atiwari-1</subjectName>
          <subjectType>User</subjectType>
          <description>Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000</description>
          <domainId>777700000000</domainId>
          <serviceId>120</serviceId>
          <tenantId>777700000001</tenantId>
          <isCrossDomain>false</isCrossDomain>
       </role>
    </roles>

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended tenant making the request |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -sk --cacert $CACERT -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/98765733650021/roles?serviceId=xxx\&domainId=yyy\&limit=10\&marker=zzz

**Additional Notes**

None


#### 4.4.6.2 List Tenant Role Assignments For A User#### {#list_tenant_role_assignments_for_a_user}
#### GET {path only, no root path} tenants/{tenantId}/users/{userId}/roles?serviceId=xxx&limit=pagesize&marker=roleId
*Privilege Level: SA, DA, DU*

This API would return all the role assignments made on a particular tenant for a user filtered by serviceId.

Constraints:

List a users tenant role assignments is not a privileged operation so far.
ServiceId is not a mandatory field, if provided response should be filtered.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *userId* - string - the unique id of the user

The following are the supported list of query parameters to filter the results

* *serviceId* (Optional) - string - list roles specific to the service identified by this id
* *limit* (Optional)} - number - limit the results by the specified page size
* *marker* (Optional)} - string - continue returning results after the specified marker

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

    GET /v2.0/HP-IDM/v1.0/tenants/11111111/users/345678902345/roles?serviceId=120 HTTP/1.1
    Accept: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

200 - OK
204 - No content

**Response Data**

JSON

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
          "roleAssignmentId": "az1UVA2ngsdEGgLgOm9kXRbt3FcN3TqaJLO0zN9Aww=",
          "roleId": "00000000004023",
          "roleName": "Admin",
          "subjectId": "777700000003",
          "subjectName": "atiwari-1",
          "subjectType": "User",
          "description": "Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000",
          "domainId": "777700000000",
          "serviceId": "120",
          "tenantId": "777700000001",
          "isCrossDomain": false
       },
          {
          "roleAssignmentId": "znWxft23Ncf3GIWbTJQhlL7jnzLkW5jFLXmRWPh2vIg=",
          "roleId": "00000000004016",
          "roleName": "netadmin",
          "subjectId": "777700000003",
          "subjectName": "atiwari-1",
          "subjectType": "User",
          "description": "Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000",
          "domainId": "777700000000",
          "serviceId": "120",
          "tenantId": "777700000001",
          "isCrossDomain": false
       }
    ]}}

XML

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
          <roleAssignmentId>az1UVA2ngsdEGgLgOm9kXRbt3FcN3TqaJLO0zN9Aww=</roleAssignmentId>
          <roleId>00000000004023</roleId>
          <roleName>Admin</roleName>
          <subjectId>777700000003</subjectId>
          <subjectName>atiwari-1</subjectName>
          <subjectType>User</subjectType>
          <description>Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000</description>
          <domainId>777700000000</domainId>
          <serviceId>120</serviceId>
          <tenantId>777700000001</tenantId>
          <isCrossDomain>false</isCrossDomain>
       </role>
       <role>
          <roleAssignmentId>znWxft23Ncf3GIWbTJQhlL7jnzLkW5jFLXmRWPh2vIg=</roleAssignmentId>
          <roleId>00000000004016</roleId>
          <roleName>netadmin</roleName>
          <subjectId>777700000003</subjectId>
          <subjectName>atiwari-1</subjectName>
          <subjectType>User</subjectType>
          <description>Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000</description>
          <domainId>777700000000</domainId>
          <serviceId>120</serviceId>
          <tenantId>777700000001</tenantId>
          <isCrossDomain>false</isCrossDomain>
       </role>
    </roles>

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended user making the request |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -sk --cacert $CACERT -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/11111111/roles?serviceId=120

**Additional Notes**

None


#### 4.4.6.3 Check Tenant Role Assignment For A User#### {#check_tenant_role_assignment_for_a_user}
#### HEAD /tenants/{tenantId}/users/{userId}/roles/{roleId}
*Privilege Level: SA, DA, DU*

This API would not return any content.

Constraints:

This is not a privileged operation so far.
All the id's should represent a valid entity (userId, roleId)
non tenant role assignments are not associated with a tenant.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *userId* - string - the unique id of the user
* *roleId* - string - the unique id of the role

The following are the supported list of query parameters to filter the results

* *limit* (Optional)} - number - limit the results by the specified page size
* *marker* (Optional)} - string - continue returning results after the specified marker

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

    HEAD /v2.0/HP-IDM/v1.0/tenants/777700000001/users/777700000003/roles/00000000004026 HTTP/1.1
    Accept: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

200 - OK
204 - No content

**Response Data**


JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=20DD4F9E1E3D2B0485DC81D93609DE30; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Wed, 26 Sep 2012 17:58:59 GMT

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=20DD4F9E1E3D2B0485DC81D93609DE30; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Wed, 26 Sep 2012 17:58:59 GMT

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended tenant making the request |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -sk --cacert $CACERT -XHEAD -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/98765733650021/users/1234/roles/4567

**Additional Notes**

None


#### 4.4.6.4 Create Tenant Role Assignments For A User#### {#create_tenant_role_assignments_for_a_user}
#### PUT /tenants/{tenantId}/users/{userId}/roles/{roleId}
*Privilege Level: SA, DA*

This API is used to create a tenant role assignment for user.

Constraints:

This is a privileged operation, only superadmin or domainadmin can create a role assignment.
Only super admin is allowed to make a role assignment for "System" scoped roles.
All the entities in the context should be valid (User, Domain, Role)
non tenant role assignment is not allowed.
Cross domain role assignment is supported for non tenant role.
Role assignment should be made on tenant's domain.
Service must be activated on the tenant.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *userId* - string - the unique id of the user
* *roleId* - string - the unique id of the role

No query parameters are required for this call

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

    PUT /v2.0/HP-IDM/v1.0/tenants/11111111/users/12345678909876/roles/00000000004023 HTTP/1.1
    Accept: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

200 - OK (if role already exists)
201 - Created

**Response Data**

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended tenant making the request |
| 404 | Not Found | The specified tenant, user or role was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -sk --cacert $CACERT -XPUT -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/98765733650021/users/1234/roles/4567

**Additional Notes**

None


#### 4.4.6.5 Delete Tenant Role Assignment For A User#### {#delete_tenant_role_assignment_for_a_user}
#### DELETE /tenants/{tenantId}/users/{userId}/roles/{roleId}
*Privilege Level: SA, DA*

This API is used to delete a tenant role assignment for a user. 

Constraints:

This is a privileged operation.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *userId* - string - the unique id of the user
* *roleId* - string - the unique id of the role

No query parameters are required for this call

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

    DELETE /v2.0/HP-IDM/v1.0/tenants/11111111/users/12345678909876/roles/00000000004023 HTTP/1.1
    Accept: application/json
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

200 - OK

**Response Data**

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Tue, 09 Aug 2011 22:20:25 GMT

**Error Response**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended tenant making the request |
| 404 | Not Found | The specified tenant, user or role was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -sk --cacert $CACERT -XDELETE -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/11111111/users/12345678909876/roles/00000000004023

**Additional Notes**

None


#### 4.4.6.6 List Tenant Role Assignments For A Group#### {#list_tenant_role_assignments_for_a_group}
#### GET /tenants/{tenantId}/groups/{groupId}/roles
*Privilege Level: SA, DA, DU*

This API would return all the tenant role assignments for a group filtered by serviceId. 

Constraints:

List a group's tenant role assignments is not a privileged operation so far.
ServiceId is not a mandatory field, if provided response should be filtered.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *groupId* - string - the unique group id 

The following are the supported list of query parameters to filter the results

* *serviceId* (Optional) - string - list roles specific to the service identified by this id
* *limit* (Optional)} - number - limit the results by the specified page size
* *marker* (Optional)} - string - continue returning results after the specified marker


**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

    GET /v2.0/HP-IDM/v1.0/tenants/11111111/groups/345678902345/roles?serviceId=120 HTTP/1.1
    Accept: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

200 - OK
204 - No Content

**Response Data**

JSON

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
          "roleAssignmentId": "CmVSz8s9o1ds4Pw25S0Mwk8SBgA63FXWMxRIx4Ix9DQ=",
          "roleId": "00000000004023",
          "roleName": "Admin",
          "subjectId": "777700000004",
          "subjectName": "testGroupId01",
          "subjectType": "Group",
          "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000",
          "domainId": "777700000000",
          "serviceId": "120",
          "tenantId": "777700000001",
          "isCrossDomain": false
       },
          {
          "roleAssignmentId": "oYYbwF2RKU5YRURKRAlJnKvNGbqaeEaenvr0YFFr5s=",
          "roleId": "00000000004016",
          "roleName": "netadmin",
          "subjectId": "777700000004",
          "subjectName": "testGroupId01",
          "subjectType": "Group",
          "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000",
          "domainId": "777700000000",
          "serviceId": "120",
          "tenantId": "777700000001",
          "isCrossDomain": false
       }
    ]}}

XML 

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
          "roleAssignmentId": "CmVSz8s9o1ds4Pw25S0Mwk8SBgA63FXWMxRIx4Ix9DQ=",
          "roleId": "00000000004023",
          "roleName": "Admin",
          "subjectId": "777700000004",
          "subjectName": "testGroupId01",
          "subjectType": "Group",
          "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000",
          "domainId": "777700000000",
          "serviceId": "120",
          "tenantId": "777700000001",
          "isCrossDomain": false
       },
          {
          "roleAssignmentId": "oYYbwF2RKU5YRURKRAlJnKvNGbqaeEaenvr0YFFr5s=",
          "roleId": "00000000004016",
          "roleName": "netadmin",
          "subjectId": "777700000004",
          "subjectName": "testGroupId01",
          "subjectType": "Group",
          "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000",
          "domainId": "777700000000",
          "serviceId": "120",
          "tenantId": "777700000001",
          "isCrossDomain": false
       }
    ]}}

**Error Response**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended group making the request |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -sk --cacert $CACERT -XDELETE -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/11111111/groups/12345678909876/roles?serviceId=120\&limit=10\&marker=1234

**Additional Notes**

None


#### 4.4.6.7 Create Tenant Role Assignments For A Group#### {#create_tenant_role_assignments_for_a_group}
#### PUT /tenants/{tenantId}/groups/{groupId}/roles/{roleId}
*Privilege Level: SA, DA*

This API is used to create a tenant role assignment for group.

Constraints:

This is a privileged operation, only superadmin or domainadmin can create a role assignment.
Only super admin is allowed to make a role assignment for "System" scoped roles.
All the entities in the context should be valid (Group, Domain, Role)
non tenant role assignment is not allowed.
Role assignment should be made on tenant's domain.
Cross domain role assignment is supported for non tenant role.
Service must be activated on the tenant.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *groupId* - string - the unique id of the group
* *roleId* - string - the unique id of the role

No query parameters are required for this call

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

    PUT /v2.0/HP-IDM/v1.0/tenants/11111111/groups/12345678909876/roles/00000000004023 HTTP/1.1
    Accept: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

200 - OK (if role already exists)
201 - Created

**Response Data**

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended group making the request |
| 404 | Not Found | The specified tenant, user or role was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -sk --cacert $CACERT -XPUT -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/98765733650021/groups/1234/roles/4567

**Additional Notes**

None


#### 4.4.6.8 Delete Tenant Role Assignment For A Group#### {#delete_tenant_role_assignment_for_a_group}
#### DELETE /tenants/{tenantId}/groups/{userId}/roles/{roleId}
*Privilege Level: SA, DA*

This API is used to delete a tenant role assignment for a group. 

Constraints:

This is a privileged operation.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *groupId* - string - the unique id of the group
* *roleId* - string - the unique id of the role

No query parameters are required for this call

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

    DELETE /v2.0/HP-IDM/v1.0/tenants/11111111/groups/12345678909876/roles/00000000004023 HTTP/1.1
    Accept: application/json
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

200 - OK
204 - No Content

**Response Data**

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Tue, 09 Aug 2011 22:20:25 GMT

**Error Response**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended group making the request |
| 404 | Not Found | The specified tenant, user or role was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -sk --cacert $CACERT -XDELETE -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/11111111/groups/12345678909876/roles/00000000004023

**Additional Notes**

None


### 4.4.7 Role Defs

Roles are entities defined in system to support notion of capability (e.g. SuperAdmin, block-admin, projectmanager etc...), subjects (users/groups) are associated with role to form a logical grouping, subjects with same role have similar capabilities in system. Roles are associated with security policies which provides capability to a role on a particular target as defined in the policy.

There are mainly following two types of role definition supported in CS.

###Global Role Definition###
Global roles are defined in system so that they can be used by any domain across the system for purpose of role assignment. Based on the role scope (explained later) of a global role definition, superadmin or a domainadmin can create role assignments with global role. The domainId field of a global role definition is wild carded (domainId=*) that makes the role definition global. 

There are following two categories of global role definition

* *Non Tenant Role Definition:* A non tenant role definition should not be used for tenant role assignment, which means one can not create a tenant role assignment with such role definitions. Global non tenant role definitions should always have tenantId field empty/null (tenantId=null).
* *Tenant Role Definition:* A tenant role definition is used to associate a subject (user/group) with a tenant, that means non tenant role assignment is not possible with such role definitions. Global tenant role definitions should always have tenantId field wild carded (tenantId=*).

###Domain Role Definition###
Role can be defined for specific domain, such roles can not be used for the purpose of role assignments outside the domain, the domainId field of the role definition should point to a specific domain in the system. Superadmin or domainAdmin are allowed to create such roles.  

There is following one category of domain role definition supported

* *Non Tenant Role Definition:* Domain non tenant role should not be used for role assignment with the context of a tenant, in other words the policy associated with the domain non tenant role definition should not mapped to a target in tenant. Domain non tenant role definition should always have tenantId field empty/null (tenantId=null). This is the only kind of role definition a domain admin is allowed to create in his/her domain.

###Role Definition Attributes###

####roleId:
RoleId to uniquely identify a role definition in system. 

#####Constraints:#####
* Should be 14 digit system generated number.  
* RoleId must be uniques in system.

####roleName:
Human readable name of the role definition(e.g. novaadmin, domainadmin). 

#####Constraints:#####  
* Role name must be unique within a domain.  
* Role Name should not have special character, except (-).  
* One can update the roleName of a role definition even if the role assignment exists for that role definition.  

####description:
Description of the role definition. 

####domainId:
Domain id for which this role definition is valid.

#####Constraints:#####  
* If domainId=*, This makes the role definition global, a global role definition can be used for role assignment in any domain.  
* If domainId=xxxx, This makes the role definition domain specific, these role can only be used for role assignment within that domain.  
* SA or service on boarding users can create a global role definition with domainId=*.  
* SA can create role definition for a specific domain domainId=xxx.  
* DA can create role definition with in his domain domainId=xxxx.  

####tenantId:
The tenantId filed of role definition governs whether role can be associated with a tenant. If the tenantId field is null or empty that means tenant role assignment is not possible with that role definition.

#####Constraints:#####  
* If tenantId=Null/Empty, This means that the role assignment with this role definition cannot be possible with any tenant.  
* If tenantId=*, This means that the role assignment with role definition cannot be possible without a tenant and applicable to all tenants in domain.   
* SA or service on boarding user can create a global role definition with tenantId=*.  
* DA can *not* create role definition in his domain with tenantId=xxxx, for DA it will be tenantId=Null/Empty.  

####serviceId:
ServiceId field is used to scope role definition to a specific service. 

#####Constraints:#####  
*  SA or service on boarding user are allowed to create role definition with serviceId=xxx for a valid service.  
*  DA is not allowed to create role definition for a specific service except identity management service (serviceId=100).  

####roleScope:
roleScope impose visibility to the role definition.
Default= Public 

#####Constraints:#####  
* Public : Roles with "Public" scope are visible to customer and can be used by customer for role assignment (e.g. domainadmin, domainuser).  
* Public_SAR : Roles with "Public_SAR" scope are service activation ready. (e.g. Object Storage admin). These roles are automatically assigned to the domain's admin group at the time of service activation, customer domain admin can also make role assignment for these roles.  
* System : "System" scoped roles are not visible to customer and are reserved for system use only (e.g. superadmin). Special privilege (SA) will be required to create role assignment for these roles.  
* This attribute should only be visible to SA but not be visible to customer.  
* Roles are created with the default scope “Public” and only way to change the scope to update the scope.  
* Only SA or service on boarding user can scope a role definition.  

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.7.1 Create Role Definition#### {#create_role_definition}
#### POST /HP-IDM/v1.0/roleDefs
*Privilege Level: SA, SVC, DA*

This API is used to create a new role definition in system.

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.

* *roleName* - String - Human readable name of the role definition.
* *domainId* - String - Domain id for which this role definition is valid.
* *tenantId* (Optional) - String - Tenant id for which this role definition is valid.
* *serviceId* (Optional) - String - Service id for which this role definition is valid.
* *description* (Optional) - String - description of the role definition.

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
    Accept: application/xml
    Content-Type: application/json
    Host: localhost:8443
    Content-Length: 50
    {
      "role": {
        "roleName": "db-admin",
        "tenantId": "222",
        "domainId": "123",
        "serviceId": "140"
        "description": "db-admin for xyz tenant"
      }
    }

XML

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
    Accept: application/xml
    Content-Type: application/xml
    Host: localhost:8443
    Content-Length: 50
     
    <role xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
       <roleName>db-admin</roleName>
       <description>db-admin for xyz tenant</description>
       <domainId>123</domainId>
       <serviceId>140</serviceId>
       <tenantId>222</tenantId>
    </role>

Optional:

**Success Response**

The response body contains data for newly created role definition with http status code of 201.

**Status Code**

201 - CREATED

**Response Data**

Response data should look as below

JSON

    {
      "role": {
        "roleId": "12121"
        "roleName": "db-admin",
        "tenantId": "222",
        "domainId": "123",
        "serviceId": "140"
        "description": "db-admin for xyz tenant"
      }
    }

XML

    <role xmlns=" http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
       <roleId>12121</roleId>
       <roleName>db-admin</roleName>
       <description>db-admin for xyz tenant</description>
       <domainId>123</domainId>
       <serviceId>140</serviceId>
       <tenantId>222</tenantId>
    </role>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 409 | Conflict  | Duplicate role definition |   
| 500 | Internal Server Error | The server encountered a problem while processing the request |  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XPOST -H "X-Auth-Token: HPAuth_TOCKEN" -H "Content-type: application/json" -d '{"role":{"roleName":"db-admin","tenantId":"58046189288043","domainId":"40527047618047","serviceId":"120","description":"role for db admin"}}'  https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs
    

**Additional Notes**
   * Role creation is a privileged operation. 
   * Only superadmin can create global role where the domainId=*.
   * Only superadmin can create role on behalf of any domain.
   * Domain Admin are allowed to create role definitions within their own domain, which means domainId filed should be set to their own domain.
   * Role can not be created for non existing domain, tenant, service etc.
   * Role are create with default roleScope=Public. Role scope provide visibility to the role (e.g. Roles with System scope should not be visible to customer)
   * RoleName is mandatory field and must be unique within a domain per service, there may be duplicate role name across domains.
   * DomainId is a mandatory field.
   * ServiceId is a mandatory field, if serviceId is 100 then tenantId field should be empty or if serviceId is not equal to 100 then there must be a tenantId  provided in request.


#### 4.4.7.2 Delete Role Definition#### {#delete_role_definition}
#### DELETE /HP-IDM/v1.0/roleDefs/{roleId}
*Privilege Level: SA, SVC, DA*

This API is used to delete a role definition identified by roleId. 

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

**Data Parameters**

This call does not require a request body

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

204 - No Content

**Response Data**

This call does not require a request body.

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 409 | Conflict  | In case of existing role assignment for the role   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request |  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON
Response for deleting previously deleted domain.

    HTTP/1.1 404 Not Found
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=FE74A50121DBE8B200CCA95E9B759EED; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 176
    Date: Wed, 31 Oct 2012 20:35:12 GMT
    
    {
      "identityFault" : {
        "code" : "BAD_REQUEST",
        "message" : "Role not found for roleId 16159990324894",
        "details" : "Role not found for roleId 16159990324894"
      }
    }
    
    HTTP/1.1 403 Forbidden
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=DCCE78AA6D9D3EF884E81979DC381898; Path=/; Secure
    Content-Type: application/json;charset=UTF-8
    Content-Length: 54
    Date: Wed, 31 Oct 2012 20:38:22 GMT
    
    {
      "forbidden": {
        "message": "Invalid token",
        "code": 403
      }
    }
    
    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <forbidden code="403" xmlns="http://docs.openstack.org/identity/api/v2.0">
       <message>Invalid token</message>
    </forbidden>
    
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XDELETE -H "X-Auth-Token: HPAuth_TOCKEN" https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs/16159990324894
    

**Additional Notes**
* Role deletion is a privileged operation.
* Superadmin can delete roles from customer domain as well as from system domain.
* domain admin can only delete roles defined in their own domain.
* Delete role is not allowed is there exist a role assignment for the role.



#### 4.4.7.3 Update Role Definition#### {#update_role_definition}
#### PUT /HP-IDM/v1.0/roleDefs/{roleId}
*Privilege Level: SA, SVC, DA*

This API is used to update an existing role definition. RoleId is used to uniquely identify a role definition in the system.

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.

* *roleName* - String - Human readable name of the role definition.
* *description* (Optional) - String - description of the role definition.

JSON

    PUT https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs/XXXXXXXXXXXXXX HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
    Accept: application/xml
    Content-Type: application/json
    Host: localhost:8443
    Content-Length: 50
    {
      "role": {
        "roleName": "mongo-db-admin",
        "description": "mongo-db-admin for abc tenant"
      }
    }

XML 

    
    PUT https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs/XXXXXXXXXXXXXX HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
    Accept: application/json
    Content-Type: application/xml
    Host: localhost:8443
    Content-Length: 50
    
    <role xmlns=" http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
       <roleName>mongo-db-admin</roleName>
       <description>mongo-db-admin for xyz tenant</description>
    </role>

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

JSON

    {
      "role": {
        "roleId": "12121"
        "roleName": "mongo-db-admin",
        "tenantId": "222",
        "domainId": "123",
        "serviceId": "140"
        "description": "mongo-db-admin for xyz tenant"
      }

XML

    <role xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
       <roleId>12121</roleId>
       <roleName>mongo-db-admin</roleName>
       <description>mongo-db-admin for xyz tenant</description>
       <domainId>123</domainId>
       <serviceId>140</serviceId>
       <tenantId>222</tenantId>
    </role>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 409 | Conflict  | In case of existing role name or role assignment for the role |  
| 500 | Internal Server Error | The server encountered a problem while processing the request |  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

    HTTP/1.1 404 Not Found
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=42CC6D3F833AAB14A6E7B83B2267F251; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 162
    Date: Wed, 31 Oct 2012 21:04:36 GMT
    
    {
      "identityFault" : {
        "code" : "BAD_REQUEST",
        "message" : "Role not found for roleId 2342422",
        "details" : "Role not found for roleId 2342422"
      }
    }
    
    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XPUT -H "X-Auth-Token: HPAuth_TOCKEN" -H "Content-type: application/json" '{"role":{"roleName":"mongo-db-admin","description":"mongo-db-admin for abc tenant"}}'  https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs/123456789012

**Additional Notes**

* Role update is privileged operation.
* Superadmin can update a role defined within system domain or in customer domain.
* Only superadmin can update the domainId of the role definition unless there is no role association exist for the role.
* Domain admin are not allowed to change the domainId field of role definition.
* Domain admin are not allowed update system defined roles or roles from other domains.
* Update on certain (domainId, tenantId, serviceId) field are not allowed if there are existing role assignments in the system for the role. 
* Update on roleName and description is allowed even if there exist a role assignment.
* Update role should also obeys the constraints defined in create role.



#### 4.4.7.4 Update Role Scope#### {#update_role_scope}
#### PUT /HP-IDM/v1.0/roleDefs/{roleId}/scope
*Privilege Level: SA, SVC*

This API is used to update the scope an existing role defined in system. Following are the possible role scope defined in system

* Public : Roles with "Public" scope can be used by customer for role assignment (e.g. domainadmin, domainuser).
* Public_SAR : Roles with "Public_SAR" scope are defined by service and injected in system at the time of service registration (e.g. Object Storage admin).  These roles are automatically assigned to user at the time of service provisioning, customer domain admin can also make  role assignment for these roles.
* System : "System" scoped roles are not visible to customer and are reserved for system use only (e.g. superadmin). Special privilege (SA) will be required to create role assignment for these roles.

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.

* *roleScope* - String - Human readable name of the role definition.



JSON

    PUT https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs/XXXXXXXXXXXXXX/scope HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
    Accept: application/xml
    Content-Type: application/json
    Host: localhost:8443
    Content-Length: 50
     
    {
      "scope": {
        "roleScope": "Public_SAR"
      }
    }

XML

    PUT https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs/XXXXXXXXXXXXXX/scope HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
    Accept: application/xml
    Content-Type: application/xml
    Host: localhost:8443
    Content-Length: 50
     
    <scope xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
       <roleScope>Public_SAR</roleScope>
    </scope>
    

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

204 - No Content

**Response Data**

There will be no response fir this request.

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 409 | Conflict  | In case of existing role name or role assignment for the role |  
| 500 | Internal Server Error | The server encountered a problem while processing the request |  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

    HTTP/1.1 404 Not Found
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=42CC6D3F833AAB14A6E7B83B2267F251; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 162
    Date: Wed, 31 Oct 2012 21:04:36 GMT
    
    {
      "identityFault" : {
        "code" : "BAD_REQUEST",
        "message" : "Role not found for roleId 2342422",
        "details" : "Role not found for roleId 2342422"
      }
    }
    
    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XPUT -H "X-Auth-Token: HPAuth_TOCKEN" -H "Content-type: application/json" '{"scope":{"roleScope":"Public_SAR"}}'  https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs/123456789012/scipe

**Additional Notes**

* Update role scope is a privileged operation, only superadmin is allowed to do so.
* Update role scope is not allowed if there is an existing role assignments in the system for a role.


#### 4.4.7.5 Get A Role Definition#### {#get_a_role_definition}
#### GET /HP-IDM/v1.0/roleDefs/{roleId}
*Privilege Level: SA, SVC, DA, DU*

This API is used to get a role definition specified by a roleId.

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

**Data Parameters**


This call does not require a request body

**Success Response**

The role definition will be return. 

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

    {
      "role": {
        "roleId": "xxxxxxxxxxxx",
        "roleName": "db-admin",
        "description": "db-admin for abc tenant",
        "tenantId": "xxxxxxxxxxxx"
        "domainId": "xxxxxxxxxxxx"
        "serviceId": "xxxxxxxxxxxx"
      }
    }

XML

    <role xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
        <roleId>xxxxxxxxxxxx</roleId>
        <roleName>db-admin</roleName>
        <description>db-admin for abc tenant</description>
        <tenantId>xxxxxxxxxxxx</tenantId>
        <serviceId>xxxxxxxxxxxxxx</serviceId>
        <domainId>xxxxxxxxxxxx</domainId>
    </role>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 500 | Internal Server Error | The server encountered a problem while processing the request |  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

    HTTP/1.1 404 Not Found
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=3CF024C732444A0434F6632CA7C3C80A; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 160
    Date: Wed, 31 Oct 2012 21:18:51 GMT
    
    {
      "identityFault" : {
        "code" : "BAD_REQUEST",
        "message" : "No role found for roleId 2312312",
        "details" : "No role found for roleId 2312312"
      }
    }
    
    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XGET -H "X-Auth-Token: HPAuth_TOCKEN" https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs/16159990324894

**Additional Notes**
* Superadmin can get a role from any domain.
* Domain admin and domain users are not allowed to access roles from other domains, except system defined public global roles (domainId=*).



#### 4.4.7.6 List Role Definitions#### {#list_role_definitions}
#### GET /HP-IDM/v1.0/roleDefs

*Privilege Level: SA, SVC*

This API is used to get a list of role definitions defined in system and is reserved for admin use only. Filer options (domainId, tenantId, serviceId and serviceName) are provided with this API to get the manageable size of response list.

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list
* *domainId* (Optional)} - string - filter by domainId
* *tenantId* (Optional)} - string - filter by tenant
* *serviceId* (Optional)} - string - filter by serviceId
* *roleName* (Optional)} - string - filter by roleName


**Data Parameters**

This call does not require a request body

**Success Response**

Returns list of roleDefs for given input with http status code 200.

**Status Code**

200 - OK

**Response Data**

JSON

    {"roles": {"role": [
          {
          "roleId": "001",
          "roleName": "role01",
          "description": "role01- description",
          "serviceId" : "100",
          "domainId": "123",
          "tenantId": ""
       }, {
          "roleId": "002",
          "roleName": "role02",
          "description": "role02- description",
          "serviceId" : "140",
          "domainId": "123",
          "tenantId": "*"
       }, {
          "roleId": "003",
          "roleName": "role03",
          "description": "role03- description",
          "serviceId" : "150",
          "domainId": "123",
          "tenantId": "xxxxxxxxxxxx"
       },
    ]}

XML

    <roles xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
    <role >
       <roleId>001</roleId>
       <roleName>Role001</roleName>
       <description>some desc</description>
       <domainId>123</domainId>
       <serviceId>100</serviceId>
       <tenantId></tenantId>
    </role>
    <role >
       <roleId>002</roleId>
       <roleName>Role001</roleName>
       <description> some desc </description>
       <domainId>123</domainId>
       <serviceId>140</serviceId>
       <tenantId>*</tenantId>
    </role>
    <role >
       <roleId>003</roleId>
       <roleName>Role003</roleName>
       <description>Some desc</description>
       <domainId>123</domainId>
       <serviceId>150</serviceId>
       <tenantId>xxxxxxxxxxxx</tenantId>
    </role>
    </roles>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code  | Description  | Reasons |   
| :----------- | :----------- | :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 500 | Internal Server Error | The server encountered a problem while processing the request |  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XGET -H "X-Auth-Token: HPAuth_TOCKEN" https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs

**Additional Notes**

* This is a privileged operation and only reserved for admin use .
* This APi will display roles defined in system, to get roles for specific domain appropriate filter should be used (e.g. domainId=* should be use to get global roles).
* Response can be filtered by domainId, tenantId, serviceId and serviceName.



### 4.4.8 Services

The Service REST API provides the ability to manage registered services.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.8.1 Get Service By Id#### {#get_service_by_id}
#### GET /HP-IDM/v1.0/services/{serviceId}   
*Privilege Level: SA, SVC*

This API is used to get registered service data by its id (system generated service identifier).

**Request Data**

**URL Parameters**

* *serviceId* - scalar - The numeric id for a registered service

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 236
    Date: Wed, 14 Sep 2011 22:33:42 GMT
     
    {"registerService": {
       "description": "Test Service Desc",
       "id": "18",
       "otherAttributes": {},
       "releaseState": "preview",
       "serviceName": "HP-Swift USWest Zone2",
       "serviceType": "object-store"
    }}

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=BEEB2026E2A5A6AA5FDCE7E14FB262F9; Path=/v2.0; Secure
    Content-Type: application/xml
    Content-Length: 320
    Date: Wed, 14 Sep 2011 22:35:31 GMT
     
    <ns2:registerService 
    serviceName="HP-Swift USWest Zone2" 
    serviceType="object-store" 
    releaseState="preview"
    id="18" 
    description="Test Service Desc"
    xmlns="http://docs.openstack.org/identity/api/v2.0"
    xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0"/>

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/services/18"

**Additional Notes**

#### 4.4.8.2 List Registered Services#### {#list_registered_services}
#### GET /HP-IDM/v1.0/services
*Privilege Level: SA, SVC, DA, DU*

This API is used to get paginated list of registered services available in the system. The marker value is serviceId of last item in previous list. Results are sorted by serviceId. To get list of services for a specific type of service, serviceType request parameter can be added. 

**Request Data**

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - represents serviceId of last item in previous returned list of this call. For getting list from beginning, pass no value.
* *serviceType* (Optional) - string - value to filter the list by serviceType

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/services HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_50638582957cd84dc49587a2
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/services HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_50638582957cd84dc49587a2
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

Optional:

Request With serviceType Filter:

JSON

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/services?serviceType=compute HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_50638582957cd84dc49587a2
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/services?serviceType=compute HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_50638582957cd84dc49587a2
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)


**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=B34844913BF641E4944208961C8413F5; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 1868
    Date: Wed, 26 Sep 2012 22:53:50 GMT
     
    {"registerServices": {
       "anies": null,
       "otherAttributes": {},
       "registerService":    [
                {
             "description": "HP Cloud Identity",
             "id": "100",
             "otherAttributes": {},
             "releaseState": "public",
             "serviceName": "Identity",
             "serviceType": "identity"
          },
                {
             "description": "HP Cloud Object Storage",
             "id": "110",
             "otherAttributes": {},
             "releaseState": "public",
             "serviceName": "Object Storage",
             "serviceType": "object-store"
          },
                {
             "description": "HP Cloud Compute",
             "id": "120",
             "otherAttributes": {},
             "releaseState": "public",
             "serviceName": "Compute",
             "serviceType": "compute"
          },
                {
             "description": "HP Cloud EC2 Compatibility Layer",
             "id": "121",
             "otherAttributes": {},
             "releaseState": "public",
             "serviceName": "EC2",
             "serviceType": "ec2"
          },
                {
             "description": "HP Cloud Block Storage",
             "id": "130",
             "otherAttributes": {},
             "releaseState": "public",
             "serviceName": "Block Storage",
             "serviceType": "volume"
          },
                {
             "description": "HP Cloud Image Management",
             "id": "140",
             "otherAttributes": {},
             "releaseState": "public",
             "serviceName": "Image Management",
             "serviceType": "image"
          },
                {
             "description": "HP Cloud Content Delivery Network",
             "id": "150",
             "otherAttributes": {},
             "releaseState": "public",
             "serviceName": "CDN",
             "serviceType": "hpext:cdn"
          },
                {
             "description": "HP Cloud Relational Database for MySQL",
             "id": "160",
             "otherAttributes": {},
             "releaseState": "beta",
             "serviceName": "Relational DB MySQL",
             "serviceType": "hpext:dbaas"
          }
       ]
    }}

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=864B386D67CF39F3ADBE5CD8B8F41748; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 1504
    Date: Wed, 26 Sep 2012 22:47:19 GMT
     
    <ns1:registerServices xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
       <ns1:registerService id="100" description="HP Cloud Identity" serviceName="Identity" serviceType="identity" releaseState="public"/>
       <ns1:registerService id="110" description="HP Cloud Object Storage" serviceName="Object Storage" serviceType="object-store" releaseState="public"/>
       <ns1:registerService id="120" description="HP Cloud Compute" serviceName="Compute" serviceType="compute" releaseState="public"/>
       <ns1:registerService id="121" description="HP Cloud EC2 Compatibility Layer" serviceName="EC2" serviceType="ec2" releaseState="public"/>
       <ns1:registerService id="130" description="HP Cloud Block Storage" serviceName="Block Storage" serviceType="volume" releaseState="public"/>
       <ns1:registerService id="140" description="HP Cloud Image Management" serviceName="Image Management" serviceType="image" releaseState="public"/>
       <ns1:registerService id="150" description="HP Cloud Content Delivery Network" serviceName="CDN" serviceType="hpext:cdn" releaseState="public"/>
       <ns1:registerService id="160" description="HP Cloud Relational Database for MySQL" serviceName="Relational DB MySQL" serviceType="hpext:dbaas" releaseState="beta"/>
    </ns1:registerServices>

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/services?serviceType=compute"

**Additional Notes**

#### 4.4.8.3 Register New Service#### {#register_new_service}
#### POST /HP-IDM/v1.0/services  	
*Privilege Level: SA, SVC*

This API is used to add new service registration. 

**Request Data**

**URL Parameters**

**Data Parameters**

Service registration data is expected in request body. In request data, service name and service type is required. Service name is expected to be unique so passing same service name will result in error. Case-insensitive existence check is done for service name.  If 'releaseState' value is provided, it needs to be system recognized release state otherwise it will result in error. If no release state value is provided, system defined default value ('restricted') is used. Numeric 'id' value needs to be provided otherwise it will result in error. If there is another registered service exists with given id, duplicate conflict (409) error is returned.

Following are pre-defined serviceType and releaseState values in system which are maintained in database. Please note releaseState list may grow with time. Clients can define their own serviceType values when registering new service.

Valid values for serviceType : 'compute' , 'image-service', 'object-store', 'identity', 'hpext:block-store', 'hpext:cdn'
Valid values for releaseState : 'restricted', 'preview', 'beta', 'public' , 'decommissioned'

See schema file for more details on the request and response data structure.

JSON

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/services HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4f6a6aeab0be221be646e227
    Accept: application/json
    Content-Type: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Content-Length: 211
    Host: localhost:8443
     
    {"registerService": {
       "description": "Test Service Desc",
       "id": "240",
       "otherAttributes": {},
       "releaseState": "preview",
       "serviceName": "HP-Swift USWest Zone2",
       "serviceType": "object-store"
    }}

XML

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/services HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4f6a6aeab0be221be646e227
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Content-Length: 212
    Host: localhost:8443
     
    <hpext:registerService 
    id="230"
    serviceName="HP-Nova USWest Zone2 " 
    description="Test Service Desc" 
    releaseState="preview" 
    serviceType="compute" 
    xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0"/>

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

201 - Created

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=700D7BA73D95F49792F50528D4A792B7; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 235
    Date: Thu, 22 Mar 2012 00:02:46 GMT
     
    {
      "registerService" : {
        "description" : "Test Service Desc",
        "id" : "240",
        "otherAttributes" : {
        },
        "releaseState" : "preview",
        "serviceName" : "HP-Swift USWest Zone2",
        "serviceType" : "object-store"
      }
    }

XML

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=91B57CCC2DF15E35AD6BB6B6884AB1C2; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 249
    Date: Wed, 21 Mar 2012 23:59:58 GMT
     
     
    <registerService id="230"&nbsp;
    description="Test Service Desc"&nbsp;
    serviceName="HP-Nova USWest Zone2"&nbsp;
    serviceType="compute"&nbsp;
    releaseState="preview"&nbsp;
    xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0"/>

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" -H "Content-Type: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/services" -d '{"registerService": {"description": "Test Service Desc","id": "240","otherAttributes": {},"releaseState": "preview","serviceName": "HP-Swift USWest Zone2","serviceType": "object-store"}}'

**Additional Notes**

#### 4.4.8.4 Update Service#### {#update_service}
#### PUT /HP-IDM/v1.0/services/{serviceId}  	
*Privilege Level: SA, SVC*

This API is used to modify registered service data and for decommissioning the service if its no longer in use.

**Request Data**

**URL Parameters**

**Data Parameters**

For updating a service, serviceId is required as its used to lookup existing service data. Service name and service type data cannot be null or blank.  Service name is expected to be unique so if service name is changed, it still needs to be unique in the system. Case-insensitive check is done for service name.  If 'releaseState' value is provided, it needs to be system recognized release state otherwise it will result in error. 

If service is no longer is use and needs to be marked deleted, its releaseState can be updated to 'decommissioned' . Note once its releaseState is marked deleted, its release state cannot be altered from there on.

Following are pre-defined serviceType and releaseState values in system which are maintained in database. Please note that this list may grow with time.

Valid values for serviceType : 'compute' , 'image-service', 'object-store', 'identity', 'hpext:block-store', 'hpext:cdn'
Valid values for releaseState : 'restricted', 'preview', 'beta', 'public' , 'decommissioned'

See schema file for more details on the request and response data structure.

JSON

    PUT https://localhost:8443/v2.0/HP-IDM/v1.0/services/150 HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4e9c7424b0be3d7fd233fa60
    Accept: application/json
    Content-Type: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Content-Length: 232
    Host: localhost:8443
     
    {
      "registerService" : {
        "description" : "HP Content Delivery Network Service",
        "id" : "150",
        "otherAttributes" : {
        },
        "releaseState" : "preview",
        "serviceName" : "CDN",
        "serviceType" : "hpext:cdn"
      }
    }

XML

    PUT https://localhost:8443/v2.0/HP-IDM/v1.0/services/150 HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4e9c7424b0be3d7fd233fa60
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Content-Length: 197
    Host: localhost:8443
     
    <registerService xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
    id="150" description="HP Content Delivery Network Service" 
    serviceName="CDN" serviceType="hpext:cdn" 
    releaseState="preview"/>
    

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 232
    Date: Mon, 17 Oct 2011 18:54:03 GMT
     
    {
      "registerService" : {
        "description" : "HP Content Delivery Network Service",
        "id" : "150",
        "otherAttributes" : {
        },
        "releaseState" : "preview",
        "serviceName" : "CDN",
        "serviceType" : "hpext:cdn"
      }
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=F5F3B66446537D2E713B4F9747ECCC65; Path=/v2.0; Secure
    Content-Type: application/xml
    Content-Length: 252
    Date: Mon, 17 Oct 2011 18:52:18 GMT
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <registerService xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
    id="150" 
    description="HP Content Delivery Network Service" 
    serviceName="CDN" 
    serviceType="hpext:cdn" 
    releaseState="preview"/>

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" -H "Content-Type: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/services" -d '{"registerService": {"description": "HP Content Delivery Network Service","id": "150","otherAttributes": {},"releaseState": "preview","serviceName": "CDN","serviceType": "hpext:cdn"}}'

**Additional Notes**



### 4.4.9 Signature

The Signature APIs enable the requester to obtain a token by using a signature for authentication.


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.9.1 EC2 Signature#### {#ec2_signature}
#### POST /HP-IDM/v1.0/ec2Tokens
*Privilege Level: Anon*

Validate an EC2 signature and return a scoped token.

**Detailed Description**

This API is used to validate an EC2 signature and return a token. This implementation currently supports EC2 signature versions 0, 1 and 2 (similar to keystone reference implementation). This API identifies the user through the 'access' identifier and verifies the provided signature using the data provided in request. Once the signature is successfully verified, the API returns a scoped token response with tenant and role information.

A Nova EC2 signature verification always requires a scoped token in the response. The API has to find a tenant for the user (as tenant data, id or name, if the tenant is not provided in request). This implementation expects that that that the tenant identifier is prefixed in 'access' and 'AWSAccessKeyId'. 

The optional query parameters HP-IDM-serviceId and HP-IDM-endpointTemplateId can be used to include only a specific subset of roles in the response. If there are no specific roles found, then a 401 (unauthorized) error is returned in the response. These parameters can have comma separated values to specify multiple service ids. To request global roles to be included in response, the global identifier (which is currently configured as 'global') must be used in any of two query parameter values. If this query parameter is not specified or has an empty value, then the response will include all roles available for that signature request. 

**AWSAccessKeyId Must Prefixed By Tenant ID**

Since a user's access key can be associated with multiple tenants, clients must prefix the user access key ID with the tenant ID of the tenant where the signature is scoped to prior to the signature calculation. For example, "84569201246014:8WXZS37LDZGYWM32H4LP". Notice the tenant ID "84569201246014".

For Swift-migrated access keys, which already have a tenant ID prefix, it would end up with this, "84569201246014:84569201246015:8WXZS37LDZGYWM32H4LP". In this case, both tenant IDs will be part of the signature but only the first prefix, "84569201246014", will be used to determine the tenant to be scoped. The second tenant ID, "84569201246015", is treated as part of the access key.

**Signature Details**

The signature is calculated by first creating the string to sign as described in the following sections. Then an RFC 2104 compliant HMAC is calculated over the string using SHA1 or SHA256 as the hash algorithm and the Secret Access key. The resultant signature bytes are then base64 encoded to form the signature string.

**Version 0 Signature String To Sign Details**

The supported signature method for version 0 signatures is HmacSHA1. The string to sign consists of the value associated with the "Action" query parameter concatenated with the value associated with the "Timestamp" query parameter.

**Version 1 Signature String To Sign Details**

The supported signature method for version 1 signatures is HmacSHA1. The string to sign is built by first doing a case insensitive sort of the query parameters based on the query parameter names. Then the name and value for each query parameter is concatenated together in the sorted order one-by-one to form the string.

**Version 2 Signature String To Sign Details**

The supported signature methods for version 2 signatures are HmacSHA1 and HmacSHA256.

The string to sign for version 2 signatures consists of the following concatenated in the order specified:

1) The value of the "verb" followed by "\n"

2) The canonicalized value (lowercase) of the "host" followed by "\n". The ":" and the port number may or not be included. The server signature verifier will calculate the signature with and without the ":" character and the port number included.

3) The canonicalized value of the "path" followed by "\n". If the path is not specifed or is the empty string then the character "/" is used. The canonicalized path value is formed by first URL encoding the path (using UTF-8 character set) and them making the following substitutions:

"%20" replaces "+"
"*" replaces "%2A"
"~" replaces "%7E"
"/" replaces "%2F"

4) The canonicalized query string. The canonicalized query string is formed by first performing a natural byte ordering (case sensitive sort) by name of the name/value pairs in the query string. Each name and each value are then URL encoded (using UTF-8 character set) and the following substitutions are made:

"%20" replaces "+"
"*" replaces "%2A"
"~" replaces "%7E"

Then name/value strings are formed by concatenating name, "=", and value.The resulting name/value strings are then concatenated together based on sorted order above with each separated from the other by the "&" character.

**Request Data**


**URL Parameters**

* *HP-IDM-serviceId* - (Optional) - Query Parameter - used to filter roles by service identifier. Value consists of one or more comma separated service identifier values. Specifying the the value "global" will cause global roles to be included.
* *HP-IDM-endpointTemplateId* - (Optional) - Query Parameter - used to filter roles by endpoint template identifier. Consists of one or more comma separated endpoint template identifier values. Specifying the value "global" will cause global roles to be included.

**Data Parameters**

See schema file for more details on the request and response data structure.

See the signature details descriptions above for information on what data parameters are required for each signature version.


JSON Signature Version 2

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100%2C110 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 818
     
    {
        "ec2Credentials":{
            "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "host":"localhost:80",
            "verb":"GET",
            "params":{
                "puHWtp":"oH.uGBH6F6dI5sQL1",
                "SignatureVersion":"2",
                "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
                "ehtosy":"z9.idDFmU8hZWMQzS",
                "Timestamp":"1326934083.68",
                "nlKpzmwkDWYM":"9NgzXvwjuaiVoE5cP",
                "SignatureMethod":"HmacSHA256",
                "XNyFgC83lLGV":"QE9YFUoiNaa2qv9sXw",
                "au7":".4mK1HY2",
                "Action":"HJOFRgVIBSvegztSkm",
                "dcD5xQMQx":"i9OeD",
                "5Te8ywzJQsvvsNF":"qUd",
                "ob1e06nT4":"PqqJC3JzTZaofJTfTXB"
            },
            "signature":"f+E0MFsshpiXY3CwXOYv07jJ+FXewLPbjwFk47usPiA=",
            "path":"/"
        }
    }

Optional:

JSON Signature Version 0

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100%2C110 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 815
     
    {
        "ec2Credentials":{
            "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "host":"localhost:80",
            "verb":"GET",
            "params":{
                "SignatureVersion":"0",
                "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
                "JtISfQAiYdrKOVI3":"iII",
                "3ULz":"mtJWfYPNnfUTHwIRc",
                "fOVH8OwHID":"y79b",
                "Timestamp":"1326934083.16",
                "zvTqAh2Ql9mzE":"zqC6KwMMCYq",
                "j0aawvqoNNibmF4JjoBv":"4WyqLq66tSW5dzQ8Ps.q",
                "OgUE1nimEOBSYkvDd":"dFZX3RjMRh7",
                "kNX6Oit8fDM1":"TJ7mTM7YbJQ84",
                "Action":"RyMTEhVxIOZgysaashyV",
                "w8cpX":"lnjWTLEy0nVLq",
                "4tWPmGmAfEcWP01":"X7zr4JZ1"
            },
            "signature":"4LOFvWlHu1q3jU3R6WmIE3AJpKg=",
            "path":"/"
        }
    }

JSON Signature Version 1

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100%2C110 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 607
     
    {
        "ec2Credentials":{
            "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "host":"localhost:80",
            "verb":"GET",
            "params":{
                "qI6GjS4":"1TfGb7kP.a",
                "SignatureVersion":"1",
                "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
                "WQ9":"el2",
                "Timestamp":"1326934083.26",
                "lKi9TPAP":"kQ5qjovtZ2d4wJst7NkU",
                "DuoDn0s1iCYfXnBK3V":"2doHkN",
                "1emaHCDcGwJrKk":"RJKQi",
                "Action":"ngxrsX"
            },
            "signature":"uik8Yk57mcqT85BHR8bAw9HTdiE=",
            "path":"/"
        }
    }

**Success Response**

**Status Code**

200 - OK

**Response Data**


JSON - All signature versions

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=DA7240A00E59F8E371DE567D405EB085; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 658
    Date: Thu, 19 Jan 2012 01:00:36 GMT
     
    {"access": {
      "token": {
        "expires": "2012-01-19T12:43:07.566Z",
        "id": "HPAuth_4f17671bb0be3f62bf1090d2",
        "tenant": {
          "id": "77242319481696",
          "name": "HP nova Tenant Services"
        }
      },
      "user": {
        "id": "97324764821142",
        "name": "arun2",
        "roles": [
          {
            "id": "00000000004003",
            "serviceId": "100",
            "name": "domainadmin"
          },
          {
            "id": "00000000004017",
            "serviceId": "100",
            "name": "tenant-member",
            "tenantId": "77242319481696"
          },
          {
            "id": "00000000004004",
            "serviceId": "100",
            "name": "domainuser"
          }
        ]
      }
    }}

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Missing access key id, signature value, or other parameters |
| 401 | Unauthorized | Invalid signature version, missing signature method, invalid access key, invalid signature, no tenant association found for user, no service specific roles found for service ids specified in query |
| 403 | Forbidden | User is disabled |
| 500 | Internal Server Error | The server encountered a problem while processing the request  |
| 503 | Service Unavailable | The server is unavailable to process the request  |



**Response Data**

JSON - Signature is not valid

    HTTP/1.1 401 Unauthorized
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=82034D30BB39215596243EDD6B9F2BB7; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 222
    Date: Fri, 16 Dec 2011 19:19:11 GMT
     
    {
      "unauthorized" : {
        "anies" : null,
        "code" : 401,
        "details" : "Provided signatures are not correct for access key :G8B5UNGWZU39K7BNR9KP",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

JSON - No service specific role is found

    HTTP/1.1 401 Unauthorized
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=10831C151368F11FE2F8A07EB6B34B87; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 187
    Date: Thu, 19 Jan 2012 01:09:29 GMT
     
    {
      "unauthorized" : {
        "anies" : null,
        "code" : 401,
        "details" : "Not authorized to access the service.",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -X POST -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100,110" -d '{
        "ec2Credentials":{
            "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "host":"localhost:80",
            "verb":"GET",
            "params":{
                "puHWtp":"oH.uGBH6F6dI5sQL1",
                "SignatureVersion":"2",
                "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
                "ehtosy":"z9.idDFmU8hZWMQzS",
                "Timestamp":"1326934083.68",
                "nlKpzmwkDWYM":"9NgzXvwjuaiVoE5cP",
                "SignatureMethod":"HmacSHA256",
                "XNyFgC83lLGV":"QE9YFUoiNaa2qv9sXw",
                "au7":".4mK1HY2",
                "Action":"HJOFRgVIBSvegztSkm",
                "dcD5xQMQx":"i9OeD",
                "5Te8ywzJQsvvsNF":"qUd",
                "ob1e06nT4":"PqqJC3JzTZaofJTfTXB"
            },
            "signature":"f+E0MFsshpiXY3CwXOYv07jJ+FXewLPbjwFk47usPiA=",
            "path":"/"
        }
    }'

**Additional Notes**



#### 4.4.9.2 Generic Signature#### {#generic_signature}
#### POST /HP-IDM/v1.0/gstokens
*Privilege Level: Anon*

This API is used to validate a signature and optionally return a token. Validation includes checking that the key used to generate the signature belongs to a particular user and that the key is in a valid state. The signature may be created using an access key, a private key associated with a certificate, or a private key in a key pair.

Key types supported include "accesskey", "certificate", and "keypair". If key type "certificate" is specified then the subject key identifier should be specified as the keyId parameter value.

The "signatureMethod" attribute is optional and only applicable when "accesskey" is specified for the "keyType" attribute. If the "signatureMethod" attribute is not specified then the algorithm associated with the access key at create or import time is used. 

This API can be used in two modes, (1) Signature Validation with Token Returned Mode, and (2) Signature Validation Mode.

**Signature Validation With Token Returned Mode**

This mode of operation results in a scoped or unscoped token, user information, and roles filtered by service identifiers and/or end point template identifiers being returned in the response. This is the default mode of operation. 

The optional "belongsTo" parameter can be used to verify that the user belongs to a specific tenant and to scope the returned token. The query parameters "HP-IDM-serviceId" and "HP-IDM-endpointTemplateId" are ignored if the "belongsTo" query parameter is not also specified.

The optional query parameters "HP-IDM-serviceId" and "HP-IDM-endpointTemplateId" can be used to include only a specific subset of roles in the response. If there are no specific roles found, then a response code of 401 (unauthorized) error is returned in the response. These parameters can have comma separated values to specify multiple service ids. To request global roles to be included in response, the global identifier (which is currently configured as 'global') must be used in either of the two query parameter values. If these query parameters are not specified or have an  empty value, then the response will include all the available roles for the user. 

**Signature Validation Mode**

Signature Validation Mode is used to quickly and simply validate a signature.  The token identifier and expires values are not returned. This mode is selected by explicitly selected by setting the query parameter "returnToken=false".  The query parameters  

"HP-IDM-serviceId", "HP-IDM-endpointTemplateId" and "belongsTo" function the same as in Signature Validation With Token Returned Mode above

**Request Data**

See the API description above for details on which parameters are required and optional for each mode.

**URL Parameters**

* *belongsTo* - (Optional) - Query Parameter - if specified this parameter is used to scope a token to a tenant. The value consists of a tenant identifier.
* *HP-IDM-serviceId* - (Optional) - Query Parameter - used to filter roles by service identifier. Value consists of one or more comma separated service identifier values. Specifying the the value "global" will cause global roles to be included. Ignored if belongsTo parameter is not also specified.
* *HP-IDM-endpointTemplateId* - (Optional) - Query Parameter - used to filter roles by endpoint template identifier. Consists of one or more comma separated endpoint template identifier values. Specifying the value "global" will cause global roles to be included. Ignored if the belongsTo parameter is not also specified.
* *returnToken* - (Optional) - Query Parameter - used to specify whether or not a token should be returned as a result of signature validation. Value is one of (true, false). The default value is true. This parameter does not affect the function of The query parameters "HP-IDM-serviceId", "HP-IDM-endpointTemplateId" and "belongsTo".

**Data Parameters**

See schema file for more details on the request and response data structure.

* *dataToSign* - String - the data that is to be signed
* *keyId* - String - key identifier for the key used to sign the data. If key type "certificate" is specified then the subject key identifier should be specified. 
* *keyType* - String - type of key used to generate signature. Value is one of (accesskey, certificate, keypair)
* *signature* - String - signature calculated over dataToSign using key identified by key identifier and algorithm specified in signatureMethod (or algorithm associated with key).
* *signatureMethod* - String - the algorithm used to generate the signature is optional and only applicable when "accesskey" is specified for the "keyType" attribute. If the "signatureMethod" attribute is not specified then the algorithm associated with the access key at create or import time is used.

JSON - Validate signature with token returned

    POST https://localhost:8443//v2.0/HP-IDM/v1.0/gstokens HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 261
     
    {
      "auth": {
          "genericSignatureCredentials": {
          "keyType": "accesskey",
          "keyId": "J926JC4JVE2U4YEJGMFW",
          "signatureMethod": "HmacSHA1",
          "dataToSign": "Some Data to Sign",
          "signature": "nxSnQgBxJ9kWzYzRNME8hILeHIE="
        }
      }
    }

XML - Validate signature with token returned

    POST https://localhost:8443//v2.0/HP-IDM/v1.0/gstokens HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 357
     
    <auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
    <genericSignatureCredentials keyType="accesskey" keyId="J926JC4JVE2U4YEJGMFW" signatureMethod="HmacSHA1">
    <dataToSign>Some Data to Sign</dataToSign>
    <signature>nxSnQgBxJ9kWzYzRNME8hILeHIE=</signature>
    </genericSignatureCredentials>
    </auth>

XML - Validate signature with token returned and "belongsTo" specified

    POST https://localhost:8443//v2.0/HP-IDM/v1.0/gstokens?belongsTo=80471193132652 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 357
     
    <auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
    <genericSignatureCredentials keyType="accesskey" keyId="J926JC4JVE2U4YEJGMFW" signatureMethod="HmacSHA1">
    <dataToSign>Some Data to Sign</dataToSign>
    <signature>nxSnQgBxJ9kWzYzRNME8hILeHIE=</signature>
    </genericSignatureCredentials>
    </auth>

JSON - Validate signature only

    POST https://localhost:8443//v2.0/HP-IDM/v1.0/gstokens?belongsTo=81321234014466&returnToken=false HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 261
     
    { "auth": {
       "genericSignatureCredentials": {
       "keyType": "accesskey",
       "keyId": "D3ZWJHE58ZX3EDCFZWWE",
       "signatureMethod": "HmacSHA1",
       "dataToSign": "Some Data to Sign",
       "signature": "OiEOOeciHUuXouFh6rX23p2RbE0="
    }   } }

XML - Validate signature only

    POST https://localhost:8443//v2.0/HP-IDM/v1.0/gstokens?belongsTo=81321234014466&returnToken=false HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 357
     
    <auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
    <genericSignatureCredentials keyType="accesskey" keyId="D3ZWJHE58ZX3EDCFZWWE" signatureMethod="HmacSHA1">
    <dataToSign>Some Data to Sign</dataToSign>
    <signature>OiEOOeciHUuXouFh6rX23p2RbE0=</signature>
    </genericSignatureCredentials>
    </auth>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON - Validate signature with token and roles returned

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 439
    Date: Fri, 22 Jun 2012 19:42:58 GMT
     
    {"access": {
      "token": {
        "expires": "2012-06-23T07:42:58.155Z",
        "id": "HPAuth_4fe4c9a1e4b0a799509ae9d0",
        "tenant": {}
      },
      "user": {
        "id": "70125538195745",
        "name": "sigtoken",
        "roles": [
          {
            "id": "00000000004004",
            "serviceId": "100",
            "name": "domainuser"
          },
          {
            "id": "00000000004003",
            "serviceId": "100",
            "name": "domainadmin"
          }
        ]
      }
    }}

XML - Validate signature with token returned and "belongsTo" specified

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 702
    Date: Fri, 22 Jun 2012 20:31:48 GMT
     
    <access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
       <token id="HPAuth_4fe4d634e4b0a799509ae9e1" expires="2012-06-23T08:31:48.499Z">
          <tenant id="80471193132652" name="Tenant2 for GS Testing"/>
       </token>
       <user id="70125538195745" name="sigtoken">
          <roles>
             <role id="00000000004004" name="domainuser" serviceId="100"/>
             <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="80471193132652"/>
             <role id="00000000004003" name="domainadmin" serviceId="100"/>
          </roles>
       </user>
    </access>

JSON - Validate signature only

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 557
    Date: Wed, 27 Jun 2012 20:16:01 GMT
     
    {"access": {
      "token": {"tenant": {
        "id": "81321234014466",
        "name": "Tenant for GS Testing"
      }},
      "user": {
        "id": "86973081871520",
        "name": "kevin999",
        "roles": [
          {
            "id": "00000000004003",
            "serviceId": "100",
            "name": "domainadmin"
          },
          {
            "id": "00000000004017",
            "serviceId": "100",
            "name": "tenant-member",
            "tenantId": "81321234014466"
          },
          {
            "id": "00000000004004",
            "serviceId": "100",
            "name": "domainuser"
          }
        ]
      }
    }}

XML - Validate signature only

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 629
    Date: Wed, 27 Jun 2012 20:10:15 GMT
     
    <access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
       <token>
          <tenant id="81321234014466" name="Tenant for GS Testing"/>
       </token>
       <user id="86973081871520" name="kevin999">
          <roles>
             <role id="00000000004003" name="domainadmin" serviceId="100"/>
             <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="81321234014466"/>
             <role id="00000000004004" name="domainuser" serviceId="100"/>
          </roles>
       </user>
    </access>


**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Missing key id, missing or invalid key type, missing signature value, or data to sign |
| 401 | Unauthorized | Inactive key state or non-existent key, invalid signature, no tenant association found for user, no service specific roles found for service ids specified in query |
| 403 | Forbidden | User is disabled |
| 500 | Internal Server Error | The server encountered a problem while processing the request  |
| 503 | Service Unavailable | The server is unavailable to process the request  |



**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -X POST -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/gstokens?belongsTo=30983299632008" -d '{
      "auth": {
          "genericSignatureCredentials": {
          "keyType": "accesskey",
          "keyId": "V7TEGGSZZ4NJK9UR4998",
          "signatureMethod": "HmacSHA1",
          "dataToSign": "Some Data to Sign",
          "signature": "OVOtheh+ZgbJBOvwSk4mIIMfaDw="
        }
      }
    }'

**Additional Notes**




### 4.4.10 Tenants

Tenant is a collection of services, and associated with zero or more users who have access to these services via role references.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.10.1 List Tenants#### {#list_tenants}
#### GET /tenants
*Privilege Level: SS*

This API returns a listing of all tenants for which the holder of the provided token has a role assignment. If the user is not a valid, an error is returned.

**Request Data**

This API supports pagination. See Pagination for more details.

This API also supports an optional *name* filter for get-by-name. Pagination and *name* filter are mutually exclusive.

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional)} - string - the resource Id of the last item in the previous list
* *name* (Optional) - string - name of the tenant to be returned

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

    GET /v2.0/tenants HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v2.0/tenants/ HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

Optional:

JSON

With *name* filter.

    GET /v2.0/tenants?name=tenantName HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

With pagination.

    GET /v2.0/tenants?limit=10 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

XML

With pagination.

    GET /v2.0/tenants?limit=100&marker=S4DFJ123SF HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

A list of tenants in the specified format is returned.

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "tenants": [
        {
          "id": "39595655514446",
          "name": "Banking Tenant Services",
          "description": "Banking Tenant Services for TimeWarner",
          "enabled": true,
          "created": "2011-11-29T16:59:52.635Z",
          "updated": "2011-11-29T16:59:52.635Z"
        }
      ]
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 380
    Date: Thu, 25 Aug 2011 23:33:19 GMT
    
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <tenants xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.w3.org/2005/Atom">
      <tenant id="541212460710" name="Time Warner Tenant Services" enabled="false" display-name="Time Warner Tenant Services">
        <description>Tenant for hosting Time Warner Applications & services</description>
      </tenant>
    </tenants>

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

***List Tenants***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/tenants"

***Get Tenant By Name***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/tenants?name=MyTenant"

**Additional Notes**


#### 4.4.10.2 Get All Tenants#### {#get_all_tenants}
#### GET /HP-IDM/v1.0/tenants
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

    GET /v2.0/HP-IDM/v1.0/tenants/ HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v2.0/HP-IDM/v1.0/tenants/ HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

Optional:

Request With Name Filter:

JSON

    GET /v2.0/HP-IDM/v1.0/tenants?name=tenantName HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v2.0/HP-IDM/v1.0/tenants?name=tenantName HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants"

#### 4.4.10.3 Get A Tenant#### {#get_a_tenant}
#### GET /HP-IDM/v1.0/tenants/{tenantId} 
*Privilege Level: SA, DA, DU*

Get a tenant based on the {tenantId} specified. tenantId's are opaque values returned with get tenant list operations. This operation does not require a request body.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to be retrieved.

**Data Parameters**

This call does not require a request body.

JSON

    GET /v2.0/HP-IDM/v1.0/tenants/48164969660120 HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e9767412cdcb18069188479
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e9767412cdcb18069188479
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

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

XML

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
    description="Tenant for Sales Forecasting service" >
    <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
     </billToAddress> 
    <soldToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
     </soldToAddress> 
    </tenant>

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/48164969660120" 

#### 4.4.10.4 Check For Existence Of Tenant Name#### {#check_for_existence_of_tenant_name}
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

    HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants?name=HP%20Cloud%20System%20Domain's-Tenant01 HTTP/1.1
    Accept-Encoding: gzip,deflate
     
     
    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Tue, 21 Aug 2012 19:29:46 GMT

XML/JSON Request and Response (case-insensitive lookup of above tenantName)

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

XML/JSON Request and Response (provided tenantName not found)

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

XML/JSON Request Response (missing tenantName in request)

    HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants HTTP/1.1
    Accept-Encoding: gzip,deflate
     
     
    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Tue, 21 Aug 2012 19:32:10 GMT

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

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X HEAD -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants?name=tenantName"

**Additional Notes**

There is no response body returned in API response data. This API does not require http header X-Auth-Token and is protected by client certificate authentication.

#### 4.4.10.5 Get A List Of Users For A Tenant (includes Role Assignments)#### {#get_a_list_of_users_for_a_tenant_}
#### GET /HP-IDM/v1.0/tenants/{tenantId}/users
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

    GET /v2.0/HP-IDM/v1.0/tenants/96488406679080/users HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e8b5dea2cdc3d29c14604d5
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v2.0/HP-IDM/v1.0/tenants/96488406679080/users HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e8b6e4c2cdc999e9328f727
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/users"

#### 4.4.10.6 Create A Tenant#### {#create_a_tenant}
#### POST /HP-IDM/v1.0/tenants 
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
* *billToAddress"  (Optional)
* *soldToAddress"  (Optional)

JSON

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

XML

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
    <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
     </billToAddress> 
    <soldToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
     </soldToAddress> 
    </tenant>

**Success Response**

**Status Code**

* 200 - Created

**Response Data**

JSON

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

XML

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

XML response with swift account hash

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X POST -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants" -d '{"tenant":{"description":"Payroll Tenant Services for TimeWarner","domainId":"47826457774667","name":"Payroll Tenant Services","status":"enabled"}}'

#### 4.4.10.7 Update A Tenant#### {#update_a_tenant}
#### PUT /HP-IDM/v1.0/tenants/{tenantID} 
*Privilege Level: SA, DA*

Allows updating an existing tenant using the tenantId and request body. Does not allow update or change of tenantId and domainId ('domainId' cannot be updated, passing that in request body will result in failure).

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to be updated.

**Data Parameters**

See tenant schema file for more details on the request and response data structure.

JSON

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

XML

    PUT /v2.0/HP-IDM/v1.0/tenants/33841725750480 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4eb4288e2cdca60d5a48e9a1
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 350
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" status="disabled">
    <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
     </billToAddress> 
    <soldToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
     </soldToAddress> 
    </tenant>

XML (with swift account hash)

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

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

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

XML

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

XML (with swift account hash)

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X PUT -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/37942731773710" -d '{"tenant":{"description":"Tenant for Market forecasting service","otherAttributes":{"swiftAccountHash":"abcd23456"}}}'

#### 4.4.10.8 Delete A Tenant#### {#delete_a_tenant}
#### DELETE /HP-IDM/v1.0/tenants/{tenantId}
*Privilege Level: SA, DA*

Deletes the specified tenant by its tenantId. This API also deletes the Roles and Endpoints associated with the Tenant.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to be deleted.

**Data Parameters**

This call does not require a request body.

XML

    DELETE /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
    Accept: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

JSON

    DELETE /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
    Accept: application/json
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

* 204 (No Content), Deletion of the Tenant was successful.

**Response Data**

This call does not return a response body.

(No JSON/XML format differences)

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=74ADEBA6F2523478A1700D664FD70C75; Path=/v2.0; Secure
    Date: Wed, 12 Oct 2011 22:02:16 GMT

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X DELETE -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/48164969660120" 

#### 4.4.10.9 Get Endpoints For A Tenant#### {#get_endpoints_for_a_tenant}
#### GET /HP-IDM/v1.0/tenants/{tenantId}/endpoints
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

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints"

**Additional Notes**

*Open Issues*

1. Do we just include enabled endpoints or all of them? In keystone reference code base, it does not filter by enabled flag (i.e. includes all of them).
Current Impl: We don't filter by enabled flag so include all of them.
1. Do we need to include global endpoints (endpoint templates with global flag as true) in this call? In keystone reference code base, it does not include them.  Current Impl: We don't include global endpoint templates in the response.


#### 4.4.10.10 Add Endpoint To A Tenant#### {#add_endpoint_to_a_tenant}
#### POST /HP-IDM/v1.0/tenants/{tenantId]}/endpoints
*Privilege Level: SA, DA*

Add endpoint template association with a tenant. 

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to return users for.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *endpointTemplate id* - string - Unique ID of the endpoint template being associated to this tenant.

JSON

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

XML

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

**Success Response**

**Status Code**

* 201 - Created

**Response Data**

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X POST -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints" -d '{"endpointTemplate":{"id":120}}'

#### 4.4.10.11 Remove Endpoints From A Tenant#### {#remove_endpoints_from_a_tenant}
#### DELETE /HP-IDM/v1.0/tenants/{tenantId}/endpoints/{endpointId}
*Privilege Level: DA, SA*

Remove tenant's endpoint template association for given endpoint id. The operation does not require a request body.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to delete the endpoint from.
* *endpointId* - string - Unique ID of the endpoint being deleted from this tenant.

**Data Parameters**

This call does not require a request body.

XML

    DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints/543 HTTP/1.1
    Accept: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

JSON

    DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints/543 HTTP/1.1
    Accept: application/json
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

* 204 (No Content), Deletion of the endpoint template association was successful.

**Response Data**

This call does not return a response body.

(No JSON/XML format differences)

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=74ADEBA6F2523478A1700D664FD70C75; Path=/v2.0; Secure
    Date: Wed, 12 Oct 2011 22:02:16 GMT

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X DELETE -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints/543"

### 4.4.11 Tokens

A yummy cookie one uses to bribe the authorization monster.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.11.1 Authenticate#### {#authenticate}
#### POST /tokens
*Privilege Level: Anon*

This API is used to authenticate a user to be able to use an OpenStack service. The result of a successful authentication is a token to be used with service requests. A username and password or access/secret key credentials are given as input to this interface. If authentication succeeds, the response will include an authentication token and service catalog ( list of available services for that user ). Tokens are valid for 12 hours. Issued tokens can become invalid in two cases:

1. the token has expired
2. the token has been revoked.

Besides using a username and password, another way to authenticate is using symmetric keys. Symmetric keys are user access key and secret key pairs provisioned for user account. In this type of credential data, request body is expected to contain an access key and a secret key information belonging to the user. Once those keys are verified, a new token is created. In this type of authentication, the only change is in expected request body data (please see related example below). There is no difference in response format/content whether authentication is done using password credential data or access key credential data.

##### Service Catalog:

In case of un-scoped token request, the service catalog is going to include global active endpoint templates as endpoints in its data. In case of scoped token request, the service catalog is going to include tenant specific endpoints as well as global active endpoint templates as endpoints.

##### Scoped Tokens:

A token scoped to a tenant can be obtained by providing either a tenantName or a tenantId. This will also return service endpoints for other services associated with the tenant in question. An unscoped token will likely not contain service endpoints except for those for the Identity Service. Note that if tenant information is unknown, an unscoped token can be obtained and then a list of tenants obtained. Tenant information can also be found in the Management Console.

**Request Data**

See examples below.

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

JSON

Authenticate using password credential for an unscoped token.

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
        "auth":{
            "passwordCredentials":{
                "username":"arunkant",
                "password":"changeme"
            }
        }
    }

Authenticate using password credential for a scoped token.

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
        "auth":{
            "passwordCredentials":{
                "username":"arunkant",
                "password":"changeme"
            },
            "tenantId":"95096564413950"
        }
    }

Authenticate using access key credential.

    POST https://localhost:8443/v2.0/tokens HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 176
     
    {
        "auth":{
            "apiAccessKeyCredentials":{
                "accessKey":"19N488ACAF3859DW9AFS9",
                "secretKey":"vpGCFNzFZ8BMP1g8r3J6Cy7/ACOQUYyS9mXJDlxc"
            }       
        }
    }

XML

Authenticate using password credential for a scoped token.

    ccept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    Content-Length: 211
    
    <auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://docs.openstack.org/identity/api/v2.0" tenantName="HP5 Tenant Services">
      <passwordCredentials username="arunkant" password="changeme"/>
    </auth>

Authenticate using access key credential.

    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    Content-Length: 219
    
    <auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
      <apiAccessKeyCredentials secretKey="vpGCFNzFZ8BMP1g8r3J6Cy7/ACOQUYyS9mXJDlxc" accessKey="9N488ACAF3859DW9AFS9"/>
    </auth>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 3248
    Date: Fri, 14 Oct 2011 21:17:14 GMT
     
     
    {"access": {
       "token":    {
          "expires": "2011-10-14T21:42:59.455Z",
          "id": "HPAuth_4e98a5dbb0befc448cd0454f",
          "tenant":       {
             "id": "14541255461800",
             "name": "HR Tenant Services"
          }
       },
       "user":    {
          "id": "30744378952176",
          "name": "arunkant",
          "roles":       [
                      {
                "id": "00000000004008",
                "serviceId": "120",
                "name": "nova:developer",
                "tenantId": "14541255461800"
             },
                      {
                "id": "00000000004003",
                "serviceId": "100",
                "name": "domainadmin",
                "tenantId": "14541255461800"
             },
                      {
                "id": "00000000004004",
                "serviceId": "100",
                "name": "domainuser",
                "tenantId": "14541255461800"
             },
                      {
                "id": "00000000004017",
                "serviceId": "100",
                "name": "tenant-member",
                "tenantId": "14541255461800"
             }
          ]
       },
       "serviceCatalog":    [
                {
             "name": "storage5063096349006363528",
             "type": "compute",
             "endpoints": [         {
                "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
                "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
                "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
                "region": "SFO"
             }]
          },
                {
             "name": "Object Storage",
             "type": "object-store",
             "endpoints": [         {
                "tenantId": "14541255461800",
                "adminURL": "https://region-a.geo-1.objects.hpcloudsvc.com/auth/v1.0/",
                "internalURL": "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800",
                "publicURL": "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800",
                "region": "region-a.geo-1",
                "id": "1.0",
                "info": "https://region-a.geo-1.objects.hpcloudsvc.com/info/v1.0",
                "list": "https://region-a.geo-1.objects.hpcloudsvc.com/allVersions"
             }]
          },
                {
             "name": "Identity",
             "type": "identity",
             "endpoints": [         {
                "adminURL": "https://region-a.geo-1.identity.hpcloudsvc.com/v2.0",
                "internalURL": "hhttps://region-a.geo-1.identity.hpcloudsvc.com/v2.0",
                "publicURL": "https://region-a.geo-1.identity.hpcloudsvc.com/v2.0",
                "region": "region-a.geo-1",
                "id": "2.0",
                "info": "https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0",
                "list": "https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"
             }]
          },
                {
             "name": "storage5065129211418544729",
             "type": "compute",
             "endpoints": [         {
                "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
                "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
                "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
                "region": "SFO"
             }]
          },
                {
             "name": "storage5042344434157721570",
             "type": "compute",
             "endpoints": [         {
                "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
                "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
                "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
                "region": "SFO"
             }]
          }
       ]
    }}

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 2667
    Date: Fri, 14 Oct 2011 21:18:40 GMT
     
    <access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/common/api/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
       <token id="HPAuth_4e98a5dbb0befc448cd0454f" expires="2011-10-14T21:42:59.455Z">
          <tenant id="14541255461800" name="HR Tenant Services"/>
       </token>
       <user id="30744378952176" name="arunkant">
          <roles>
             <role id="00000000004008" name="nova:developer" serviceId="120" tenantId="14541255461800"/>
             <role id="00000000004003" name="domainadmin" serviceId="100" tenantId="14541255461800"/>
             <role id="00000000004004" name="domainuser" serviceId="100" tenantId="14541255461800"/>
             <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="14541255461800"/>
          </roles>
       </user>
       <serviceCatalog>
          <service type="compute" name="storage5063096349006363528">
             <endpoint region="SFO" publicURL="https://localhost:8443/identity/api/v2.0/public/0" internalURL="https://localhost:8443/identity/api/v2.0/internal/0" adminURL="https://localhost:8443/identity/api/v2.0/admin/0">
                <version/>
             </endpoint>
          </service>
          <service type="object-store" name="Object Storage">
             <endpoint region="region-a.geo-1" tenantId="14541255461800" publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800" internalURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800" adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/auth/v1.0/">
                <version id="1.0" info="https://region-a.geo-1.objects.hpcloudsvc.com/info/v1.0" list="https://region-a.geo-1.objects.hpcloudsvc.com/allVersions"/>
             </endpoint>
          </service>
          <service type="identity" name="Identity">
             <endpoint region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" internalURL="hhttps://region-a.geo-1.identity.hpcloudsvc.com/v2.0" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0">
                <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
             </endpoint>
          </service>
          <service type="compute" name="storage5065129211418544729">
             <endpoint region="SFO" publicURL="https://localhost:8443/identity/api/v2.0/public/0" internalURL="https://localhost:8443/identity/api/v2.0/internal/0" adminURL="https://localhost:8443/identity/api/v2.0/admin/0">
                <version/>
             </endpoint>
          </service>
          <service type="compute" name="storage5042344434157721570">
             <endpoint region="SFO" publicURL="https://localhost:8443/identity/api/v2.0/public/0" internalURL="https://localhost:8443/identity/api/v2.0/internal/0" adminURL="https://localhost:8443/identity/api/v2.0/admin/0">
                <version/>
             </endpoint>
          </service>
       </serviceCatalog>
    </access>

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Response Data**

JSON

    {
      "identityFault": {
        "message": "Fault",
        "details": "Error Details...",
        "code": 500
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8"?>
    <identityFault xmlns="http://docs.openstack.org/identity/api/v2.0"
              code="500">
            <message>Fault</message>
            <details>Error Details...</details>
    </identityFault>

Curl Example

***Authenticate with Username/Password and Tenant ID***

    curl -X POST -H "Content-Type: application/json"
         https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens
         -d '{"auth":{"passwordCredentials":{"username":"falken@wg.com",          "password":"J0shua!"}, "tenantId":"72020596871800"}}'
    

***Authenticate with Access Keys and Tenant ID***

    curl -X POST -H "Content-Type: application/json"
            https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens
        -d '{"auth":{"apiAccessKeyCredentials":{"accessKey":"B5VKMNLEZ7YUN9BTFDZC", "secretKey":"CQSp+KsLQGFz6+V/S1s4XXpE42q472pD9VhIBFsn"}, "tenantId":"72020596871800"}}'

**Additional Notes**


#### 4.4.11.2 Rescope Token#### {#rescope_token}
#### POST /tokens
*Privilege Level: SS*

This API provides the ability to re-scope a valid token with another tenant. An existing unexpired token, regardless of its currently scoped or not, can be scoped to another tenant as long as the user has valid association with that tenant.

Re-scoping of token can be done from 1) unscoped token to a scoped token for specific tenant 2) scoped token from one tenant to another tenant 3) scoped token to unscoped token (with no tenantId and tenantName specified in request). Re-scoping of token does not alter the token expiration time and same token id is returned in response.

##### Service Catalog:

In case of un-scoped token request, the service catalog is going to include global active endpoint templates as endpoints in its data. In case of scoped token request, the service catalog is going to include tenant specific endpoints as well as global active endpoint templates as endpoints.

**Request Data**


**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

JSON

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 154
    
    {
        "auth": {
            "tenantName": "HP Swift Tenant Services",
            "token": {
                "id": "HPAuth_4ea80da3b0be73fc0385eceb"
            }
        }
    }

XML

    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    Content-Length: 195
    
    <auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://docs.openstack.org/identity/api/v2.0" tenantId="19694547081948">
      <token id="HPAuth_4e934043b0be09f52fb4c29d" />
    </auth>

**Success Response**


**Status Code**

200 - OK

**Response Data**


JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 1283
    Date: Wed, 26 Oct 2011 13:43:14 GMT
    
    {"access": {
      "token": {
        "expires": "2011-10-26T14:13:14.311Z",
        "id": "HPAuth_4ea80e72b0be73fc0385ecef",
        "tenant": {
          "id": "90260810095453",
          "name": "HP Swift Tenant Services"
        }
      },
      "user": {
        "id": "53449493563804",
        "name": "arunkant",
        "roles": [
          {
            "id": "00000000004017",
            "serviceId": "100",
            "name": "tenant-member",
            "tenantId": "90260810095453"
          },
          {
            "id": "00000000004003",
            "serviceId": "100",
            "name": "domainadmin",
            "tenantId": "90260810095453"
          },
          {
            "id": "00000000004004",
            "serviceId": "100",
            "name": "domainuser",
            "tenantId": "90260810095453"
          }
        ]
      },
      "serviceCatalog": [{
        "name": "Identity",
        "type": "identity",
        "endpoints": [{
          "adminURL": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/v2.0",
          "internalURL": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/v2.0",
          "publicURL": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/v2.0",
          "region": "region-a.geo-1",
          "id": "2.0",
          "info": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/info\/v2.0",
          "list": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/allVersions"
        }]
      }]
    }}

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 1166
    Date: Wed, 26 Oct 2011 13:46:53 GMT
    
    
    <access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/common/api/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
       <token id="HPAuth_4ea80e72b0be73fc0385ecef" expires="2011-10-26T14:13:14.311Z">
          <tenant id="90260810095453" name="HP Swift Tenant Services"/>
       </token>
       <user id="53449493563804" name="arunkant">
          <roles>
             <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="90260810095453"/>
             <role id="00000000004003" name="domainadmin" serviceId="100" tenantId="90260810095453"/>
             <role id="00000000004004" name="domainuser" serviceId="100" tenantId="90260810095453"/>
          </roles>
       </user>
       <serviceCatalog>
          <service type="identity" name="Identity">
             <endpoint region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" internalURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0">
                <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
             </endpoint>
          </service>
       </serviceCatalog>
    </access>

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

    {
      "identityFault": {
        "message": "Fault",
        "details": "Error Details...",
        "code": 500
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8"?>
    <identityFault xmlns="http://docs.openstack.org/identity/api/v2.0"
              code="500">
            <message>Fault</message>
            <details>Error Details...</details>
    </identityFault>

Curl Example

    curl -k -H "Content-Type: application/json" -d '{"auth":{"tenantName":"HP Swift Tenant Services","token":{"id":"HPAuth_4ea80da3b0be73fc0385eceb"}}}' -XPOST https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens

**Additional Notes**


#### 4.4.11.3 Revoke Token#### {#revoke_token}
#### DELETE /HP-IDM/v1.0/tokens/{tokenId}
*Privilege Level: SA,DA,SS*

This API is used to revoke an authentication token. This operation does not require a request body. Once a token has been revoked, attempts to validate the token via GET /tokens/tokenId will fail with a 404 (item not found) as the token no longer exists. Trying revoke a non existing token, including one which has expired will also return a 404 (item not found).

**Request Data**


**URL Parameters**

None

**Data Parameters**

This call does not require a request body.

**Success Response**


**Status Code**

200 - OK

**Response Data**


**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |


**Response Data**

JSON

    {"forbidden":{"message":"Full authentication is required to access this resource","code":403}}

XML

    <?xml version="1.0" encoding="UTF-8"?><forbidden xmlns="http://docs.openstack.org/identity/api/v2.0" code="403"><message>Full authentication is required to access this resource</message></forbidden>

Curl Example

    curl -k -XDELETE https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/HPAuth_123456789

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.4 Swift Legacy Authentication#### {#swift_legacy_authentication}
#### GET /v1.0
*Privilege Level: Anon*

#### GET /v1.1
*Privilege Level: Anon*

#### GET /auth/v1.0
*Privilege Level: Anon*

#### GET /auth/v1.1
*Privilege Level: Anon*

Pre-Keystone (aka auth v2.0), Openstack services rely on disparate authentication mechanisms to authenticate their services.  For example, Swift uses swauth, while Nova uses novaauth.  The v1/v1.1 style of authentication relies on custom HTTP headers (specific to each service) to communicate authentication data, rather than relying on well-defined XML/JSON documents that can be validated via XSDs.  With the release of Diablo, most Openstack services have switched to using Keystone API completely, with the exception of the Swift CLI tool.  To provide backward-compatibility for this particular tool, CS (as well as the FOSS Keystone) provides this API. 

**Request Data**


**URL Parameters**

None

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-User* - containing the <tenantId:username> for a scoped token for Swift
* *X-Auth-Key* - containing the password for the given user

**Success Response**


**Status Code**

200 - OK

**Response Data**

In addition to the token access response, the following response HTTP headers are populated by the server.

* *X-Auth-Token* - token ID
* *X-Storage-URL* - containing a list of public endpoints for Swift

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    X-Auth-Token: HPAuth_4f03696fe4b071e9f15c0550
    X-Storage-Url: https://az1-sw-proxy-ext-0001.rndd.aw1.hpcloud.net:443/v1.0/14565730729748
    Content-Type: application/json
    Content-Length: 1583
    Date: Tue, 03 Jan 2012 20:47:43 GMT
     
    {"access": {
      "token": {
        "expires": "2012-01-03T21:17:43.087Z",
        "id": "HPAuth_4f03696fe4b071e9f15c0550",
        "tenant": {
          "id": "14565730729748",
          "name": "Swift SSL"
        }
      },
      "user": {
        "id": "70970596121812",
        "name": "joeuserA@timewarner.com",
        "roles": [
          {
            "id": "00000000004022",
            "serviceId": "110",
            "name": "Admin",
            "tenantId": "14565730729748"
          },
          {
            "id": "00000000004013",
            "serviceId": "130",
            "name": "block-admin",
            "tenantId": "14565730729748"
          },
          {
            "id": "00000000004025",
            "serviceId": "120",
            "name": "sysadmin",
            "tenantId": "14565730729748"
          },
          {
            "id": "00000000004016",
            "serviceId": "120",
            "name": "netadmin",
            "tenantId": "14565730729748"
          },
          {
            "id": "00000000004024",
            "serviceId": "140",
            "name": "user",
            "tenantId": "14565730729748"
          },
          {
            "id": "00000000004003",
            "serviceId": "100",
            "name": "domainadmin",
            "tenantId": "14565730729748"
          },
          {
            "id": "00000000004014",
            "serviceId": "150",
            "name": "cdn-admin",
            "tenantId": "14565730729748"
          },
          {
            "id": "00000000004004",
            "serviceId": "100",
            "name": "domainuser",
            "tenantId": "14565730729748"
          },
          {
            "id": "00000000004014",
            "serviceId": "150",
            "name": "cdn-admin",
            "tenantId": "14565730729748"
          }
        ]
      }
    }}

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    X-Auth-Token: HPAuth_4f03696fe4b071e9f15c0550
    X-Storage-Url: https://az1-sw-proxy-ext-0001.rndd.aw1.hpcloud.net:443/v1.0/14565730729748
    Content-Type: application/xml
    Content-Length: 730
    Date: Tue, 03 Jan 2012 20:47:43 GMT
    
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom"><token id="HPAuth_767eaf4d50bee574eefb8e3b1081bde75edf31c59f806e35a8793296247aa7f9" expires="2012-10-10T11:09:38.813Z"><tenant id="62424047631429" name="conser4301_swift"/></token><user id="97539030347757" name="conser4301"><roles><role id="00000000004004" name="domainuser" serviceId="100"/><role id="00000000004022" name="Admin" serviceId="110" tenantId="62424047631429"/><role id="00000000004003" name="domainadmin" serviceId="100"/></roles></user></access>

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -s -k -H "X-Auth-User: 62424047631429:jdoe" -H "X-Auth-Key: secrete" -H "Accept: application/xml" -D /tmp/headers.txt https://region-a.geo-1.identity.hpcloudsvc.com:35357/v1.0

**Additional Notes**


#### 4.4.11.5 Validate Token#### {#validate_token}
#### GET /tokens/{tokenId}
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

    GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

Optional:

JSON

ValidateToken  Request for JSON (unscoped token where HP-IDM-serviceId parameter value is ignored)

    GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a82d4b0be3c45af828494?HP-IDM-serviceId=110 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

ValidateToken JSON Request ( HP-IDM-serviceId parameter with 120 service id value)

    GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=120 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

ValidateToken XML Request  (HP-IDM-serviceId parameter with 110 (Object Storage service) value and HP-IDM-endpointTemplateId parameter with 110 (Compute - AZ2) value)

    GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=110&HP-IDM-endpointTemplateId=110 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

ValidateToken  XML Request ( HP-IDM-serviceId parameter with 'global' only)

    GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=global HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

**Success Response**

**Status Code**

200 - OK

**Response Data**


JSON

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

XML

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

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Item Not Found

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com:35357/v2.0/tokens/HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c"

**Additional Notes**


#### 4.4.11.6 Quick Token Validation#### {#quick_token_validation}
#### HEAD /tokens/\<tokenId\>?belongsTo=tenantId
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

    HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

Optional:

JSON

With belongsTo filtering.

    HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?belongsTo=345234435 HTTP/1.1
    Accept-Encoding: gzip,deflate
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

With belongsTo filtering.

    HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?belongsTo=345234435 HTTP/1.1
    Accept-Encoding: gzip,deflate
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -XHEAD "https://az-1.region-a.geo-1.compute.hpcloudsvc.com:35357/v2.0/tokens/HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c"

**Additional Notes**


#### 4.4.11.7 Refresh Token#### {#refresh_token}
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

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/tokens/HPAuth_4e934043b0be09f52fb4c29d HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4e934043b0be09f52fb4c29d
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 0

XML

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/tokens/HPAuth_4e934043b0be09f52fb4c29d HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4e934043b0be09f52fb4c29d
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 0

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Item Not Found

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -XPOST --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tokens/HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c

**Additional Notes**


### 4.4.12 Users

Cloud users.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.12.1 List Users#### {#list_users}
#### GET /HP-IDM/v1.0/users
*Privilege Level: SA, SS*

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

    GET /v2.0/HP-IDM/v1.0/users HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v2.0/HP-IDM/v1.0/users HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

Optional:

JSON

Return 50 users at a time.

    GET /v2.0/HP-IDM/v1.0/users?limit=50 HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    Host: localhost:9999
    Connection: keep-alive

Return 10 users at a time, starting with user ID `345367`

    GET /v2.0/HP-IDM/v1.0/users?limit=10&marker=345367 HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    Host: localhost:9999
    Connection: keep-alive

Lookup users by name.

    GET /v2.0/HP-IDM/v1.0/users?name=jdoe HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    Host: localhost:9999
    Connection: keep-alive

Lookup users by email.

    GET /v2.0/HP-IDM/v1.0/users?emailAddress=jdoe@acme.com HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    Host: localhost:9999
    Connection: keep-alive


XML

Lookup users by name.

    GET /v2.0/HP-IDM/v1.0/users?name=jdoe HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    Host: localhost:9999
    Connection: keep-alive

Lookup users by email.

    GET /v2.0/HP-IDM/v1.0/users?emailAddress=jdoe@acme.com HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    Host: localhost:9999
    Connection: keep-alive


**Success Response**

**Status Code**

200 - OK

**Response Data**


JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

***List Users***

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users"

***Lookup Users By Name***

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users?name=jdoe"

***Lookup Users By Email***

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users?emailAddress=jdoe@acme.com"

**Additional Notes**


#### 4.4.12.2 Get A User#### {#get_a_user}
#### GET /HP-IDM/v1.0/users/{userId} 
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

    GET /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467

**Additional Notes**


#### 4.4.12.3 Check For Existence Of User#### {#check_for_existence_of_user}
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

    HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/users?name=User1_2012_08_21_11_01_30_565 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json

XML

    HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/users?name=user1_2012_08_21_11_01_30_565 HTTP/1.1
    Accept-Encoding: gzip,deflate

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

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Tue, 21 Aug 2012 18:49:33 GMT

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Tue, 21 Aug 2012 18:49:33 GMT

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users?name=user1_2012_08_21_11_01_30_565"

**Additional Notes**

#### 4.4.12.4 Create A New User#### {#create_a_new_user}
#### POST /HP-IDM/v1.0/users
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

XML

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

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

Assuming there exist a file "new_user.json" with the following content:

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

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -XPOST -d @new_user.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users"

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.12.5 Update A User#### {#update_a_user}
#### PUT /HP-IDM/v1.0/users/{userId} 
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

XML

    PUT /v2.0/HP-IDM/v1.0/users/559855934411 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 177
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" emailAddress="janedoe2@timewarner.com" status="enabled"/>

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

Assuming there exist a file "update_user.json" with the following content:

    {
      "user": {
        "emailAddress": "larrykinglive@timewarner.com"
      }
    }

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -XPUT -d @update_user.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467"

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.12.6 Delete A User#### {#delete_a_user}
#### DELETE /HP-IDM/v1.0/users/{userId}
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

    DELETE /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b95f52cdcd8e4c569ca44
    Host: localhost:9999
    Connection: keep-alive

XML

    DELETE /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e7b95f52cdcd8e4c569ca44
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

204 - No Content

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=A17A0BD786F05FEC1AE4E25BF8680323; Path=/v2.0
    Date: Thu, 22 Sep 2011 20:10:44 GMT

XML

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=A17A0BD786F05FEC1AE4E25BF8680323; Path=/v2.0
    Date: Thu, 22 Sep 2011 20:10:44 GMT

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -XDELETE "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467"

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.12.7 Get All Groups For A User#### {#get_all_groups_for_a_user}
#### GET /HP-IDM/v1.0/users/{userId}/groups
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

    GET /v2.0/HP-IDM/v1.0/users/627893056455/groups HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v2.0/HP-IDM/v1.0/users/627893056455/groups HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

Return all the groups for a given user.

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467/groups"

Return maximum of 10 groups at a time, starting with groupId '1234556', for a given user.

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467/groups?limit=10&marker=1234556"


**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.12.8 Update Password For A User#### {#update_password_for_a_user}
#### PUT /HP-IDM/v1.0/users/{userId}/password
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

XML

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

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

204 - No Content

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=4470C4AB8BD315EAAC0156F5AF822442; Path=/
    Date: Fri, 18 Nov 2011 18:03:03 GMT

XML

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=8C6A602EB93E746CCE4B6F173E6FA484; Path=/
    Date: Fri, 18 Nov 2011 17:58:24 GMT

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

Assuming there exist a file "new_password.json" with the following content:

    {
      "passwordUpdate": {
        "newPassword": "changed$pwd"
      }
    }

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -XPUT -d @new_password.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/53382673413858/password"

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.12.9 Initial Password Reset#### {#initial_password_reset}
#### POST /HP-IDM/v1.0/users/password/reset
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

    POST /v2.0/HP-IDM/v1.0/users/password/reset?userName=jschmo HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8080
    Content-Length: 0

XML

    POST /v2.0/HP-IDM/v1.0/users/password/reset?userName=jschmo HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8080
    Content-Length: 0

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

204 - No Content

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Mon, 22 Aug 2011 04:55:08 GMT

XML

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Mon, 22 Aug 2011 04:55:08 GMT

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -XPOST "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/password/reset?usernName=jschmo"

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

#### 4.4.12.10 Validate Password ResetId And Update Password#### {#validate_password_resetid_and_update_password}
#### PUT /HP-IDM/v1.0/users/password/reset/{resetId}
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

XML

    PUT /v2.0/HP-IDM/v1.0/users/password/reset/azEyRGpxK3l3QmdRYmYwZlVBQ0VxUWRncnVScFM4SEJSN3BVUTZ2akJ6OD1Neg HTTP/1.1
    Accept-Encoding: gzip,deflate
    Content-Type: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:35357
    Content-Length: 155
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?> <passwordUpdate xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" newPassword="newpwd"  />

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

Assuming there exist a file "mypasword.json" with the following content:

    {
      "passwordUpdate": {
        "newPassword": "changeme"
      }
    }

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "Content-Type: application/json" -H "Accept: application/json" -XPUT -d @mypassword.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/password/reset/UlZacHJ4a2V2LzFyNENSMW1vdlhONGJxK2hWMmgxcGVqd0FvVURtOC9jZz1FUA"

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.12.11 List A User's Non Tenant Role Assignments#### {#list_a_users_non_tenant_role_assignments}
#### GET /HP-IDM/v1.0/users/{userId}/username}/roles
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

    GET /v2.0/HP-IDM/v1.0/users/345678902345/roles HTTP/1.1
    Accept: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v2.0/HP-IDM/v1.0/users/345678902345/roles HTTP/1.1
    Accept: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

Optional:

JSON

Filtered by service ID:

    GET /v2.0/HP-IDM/v1.0/users/345678902345/roles?serviceId=100 HTTP/1.1
    Accept: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

Return maximum of 10 roles at a time, starting with role ID `123456`:

    GET /v2.0/HP-IDM/v1.0/users/345678902345/roles?limit=10&marker=123456 HTTP/1.1
    Accept: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

XML

Filtered by service ID:

    GET /v2.0/HP-IDM/v1.0/users/345678902345/roles?serviceId=100 HTTP/1.1
    Accept: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

Return maximum of 10 roles at a time, starting with role ID `123456`:

    GET /v2.0/HP-IDM/v1.0/users/345678902345/roles?limit=10&marker=123456 HTTP/1.1
    Accept: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive


**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/345678902345/roles?serviceId=100"

**Additional Notes**

#### 4.4.12.12 Check User's Non Tenant Role Assignment#### {#check_users_non_tenant_role_assignment}
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

    GET /v2.0/HP-IDM/v1.0/users/345678902345/roles/00000000004003 HTTP/1.1
    Accept: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

XML

    HEAD /v2.0/HP-IDM/v1.0/users/345678902345/roles/00000000004003 HTTP/1.1
    Accept: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 200 | OK | User's non tenant role exist. |
| 404 | Not Found | User's non tenant role does not exist. |

**Response Data**

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=20DD4F9E1E3D2B0485DC81D93609DE30; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Wed, 26 Sep 2012 17:58:59 GMT

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=20DD4F9E1E3D2B0485DC81D93609DE30; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Wed, 26 Sep 2012 17:58:59 GMT

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" -XHEAD "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/345678902345/roles/00000000004003"

**Additional Notes**

#### 4.4.12.13 Create A User's Non Tenant Role Assignment#### {#create_a_users_non_tenant_role_assignment}
#### PUT /HP-IDM/v1.0/users/{userId}/roles/{roleId}
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

    PUT /v2.0/HP-IDM/v1.0/users/12345678909876/roles/334343434 HTTP/1.1
    Accept: application/json
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

XML

    PUT /v2.0/HP-IDM/v1.0/users/12345678909876/roles/334343434 HTTP/1.1
    Accept: application/xml
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

201 - Created

**Response Data**


JSON

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1

XML

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" -XPUT "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/12345678909876/roles/334343434"

**Additional Notes**

#### 4.4.12.14 Delete A User's Non Tenant Role Assignment#### {#delete_a_users_non_tenant_role_assignment}
#### DELETE /HP-IDM/v1.0/users/{userId}/roles/{roleId}
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

    DELETE /v2.0/HP-IDM/v1.0/users/559855934411/roles/07568653986543 HTTP/1.1
    Accept: application/json
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

XML

    DELETE /v2.0/HP-IDM/v1.0/users/559855934411/roles/07568653986543 HTTP/1.1
    Accept: application/json
    X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

**Status Code**

204 - No Content

**Response Data**


JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Tue, 09 Aug 2011 22:20:25 GMT

XML

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Tue, 09 Aug 2011 22:20:25 GMT

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" -XDELETE "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/12345678909876/roles/334343434"

**Additional Notes**


### 4.4.13 User Access Keys

The User Access Key REST API provides the ability to manage user access keys.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.13.1 Create User Access Key#### {#create_user_access_key}
#### POST /HP-IDM/v1.0/accesskeys

*Privilege Level: SA, DA, SS*


**Request Data**

The optional data parameters are algorithm, domainId, keyLength, status, userId, validFrom, and validTo.

**URL Parameters**

There are no URL parameters for this operation.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *algorithm* (Optional) - String - the algorithm the key will be used with. One of 
* *domainId* - String - domain identifier of the owner of the key.
* *keyLength* (Optional) - Integer - Length of the key in bits.
* *status* (Optional) String - the key status. One the values (active, inactive). Defaults to active if not specified.
* *userId* (Optional) - String - User identifier of the owner of the key. If not specified the user identifier defaults to the user identifier of the requester.
* *validFrom* (Optional) - DateTime - The date the key becomes valid specified in the following form "YYYY-MM-DDThh:mm:ss". 
* *validTo* (Optional) - DateTime - The date the key becomes invalid specified in the following form "YYYY-MM-DDThh:mm:ss" 


A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e7b748be4b0600fec3d2a24
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 235
     
    { "accessKey":
                {
             "algorithm": "HmacSHA1",
             "keyLength": 64,
             "domainId": "00000000001001",
             "otherAttributes": {},
             "status": "active",
             "userId": "00000000003002"
           }
    }

XML

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    X-Auth-Token: HPAuth_4e69969de4b0a8f279022d55
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 259
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <accessKey userId="000000003002" domainId="000000001001" status="active" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
    <algorithm>HmacSHA1</algorithm>
    <keyLength>64</keyLength>
    </accessKey>

**Success Response**

**Status Code**

201 - Created

**Response Data**

JSON

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 376
    Date: Thu, 22 Sep 2011 18:01:17 GMT
     
    {
      "accessKey" : {
        "algorithm" : "HmacSHA1",
        "keyLength" : 64,
        "secretKey" : "pXmYG556MjD",
        "accessKeyId" : "KNGTV6EFKLPYE8LXF4VL",
        "createdOn" : 1316714474259,
        "domainId" : "00000000001001",
        "otherAttributes" : {
        },
        "status" : "active",
        "userId" : "00000000003002",
        "validFrom" : 1316714474000,
        "validTo" : 1632074474000
      }
    }

XML

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=C20FB3A7F8BE4A7EF0EA7BE232327FE6; Path=/v2.0; Secure
    Content-Type: application/xml
    Content-Length: 448
    Date: Fri, 09 Sep 2011 04:32:07 GMT
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><accessKey xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" accessKeyId="FG54K8NB67KHASRF6KY1" userId="000000003002" domainId="000000001001" status="active" validFrom="2011-09-08T21:32:04.000-07:00" validTo="2021-09-05T21:32:04.000-07:00" createdOn="2011-09-08T21:32:04.937-07:00">
       <algorithm>HmacSHA1</algorithm>
       <keyLength>64</keyLength>
       <secretKey>iwv//jFjJ2E</secretKey>
    </accessKey>

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 500 | Internal Server Error | The server encountered a problem while processing the request  |
| 503 | Service Unavailable | The server is unavailable to process the request  |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -X POST -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys" -d '{
      "accessKey" : {
        "algorithm" : "HmacSHA1",
        "keyLength" : 240,
        "domainId" : "11180052618906",
        "otherAttributes" : {
        },
        "status" : "active",
        "userId" : "84463950217213"
      }}'

**Additional Notes**



#### 4.4.13.2 Delete User Access Key#### {#delete_user_access_key}
#### DELETE /HP-IDM/v1.0/accesskeys/{accesskeyId} 
*Privilege Level: SA, DA, SS*

Delete a user access key.

**Request Data**

The accesskeyId url path parameter is required. The userId query parameter is only required to delete an access key for a user other than the requester.

**URL Parameters**

* *accesskeyId* (Required) - URL path parameter - user access key identifier string
* *userId* (Optional) - Query Parameter - User identifier of the access key owner. If not specified then defaults to userId of the requester.

**Data Parameters**

This call does not require a request body.

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**Success Response**

**Status Code**

204 - No Content

**Response Data**

This call does not return a response body on success.

JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=90D365930EDDB20FF49CC2DDA4B7C925; Path=/v2.0; Secure
    Date: Thu, 22 Sep 2011 22:15:42 GMT

XML

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=7F457E3037CCB2DEC6C33D408F544EA8; Path=/v2.0; 
    SecureDate: Fri, 09 Sep 2011 04:25:47 GMT 

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 404 | Not Found | Specified accesskeyId or userId not found   |
| 500 | Internal Server Error | The server encountered a problem while processing the request  |
| 503 | Service Unavailable | The server is unavailable to process the request  |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -X DELETE -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/ZNFNCA1JJL3T7XY12V2F" 

**Additional Notes**



#### 4.4.13.3 Get Access Keys#### {#get_access_keys}
#### GET /HP-IDM/v1.0/accesskeys

*Privilege Level: SA,DA, SS*

Gets a list of selected user access keys. 

**Request Data**

The following query parameters are optional (domainId, export, status, userId). There are no required query parameters.


**URL Parameters**

* *domainId* (Optional) - Query Parameter - Domain identifier. Selects keys with matching domain identifier.
* *export* (Optional) - Query Parameter - Export secret key value. Value is one of (true, false). If not specified the value is set to false.
* *status* (Optional) - Query Parameter - Key status. Selects keys with matching status. Value is one of (active, inactive, expired, revoked, deleted, purged).
* *userId* (Optional) - Query Parameter - User identifier. Selects keys with matching user identifier. If not specified the userId of the requester is used.


**Data Parameters**

This call does not require a request body.

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


JSON

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys?export=false HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_4e7b71f5e4b0600fec3d2a20
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys?export=false HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_4e699292e4b0a8f279022d4d
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 798
    Date: Thu, 22 Sep 2011 17:37:18 GMT
     
    {
      "accessKeys" : {
        "anies" : null,
        "accessKey" : [ {
          "algorithm" : "HmacSHA1",
          "keyLength" : 64,
          "accessKeyId" : "V7TEGGSZZ4NJK9UR4UFE",
          "createdOn" : 1316712986234,
          "domainId" : "00000000001001",
          "otherAttributes" : {
          },
          "status" : "active",
          "userId" : "00000000003002",
          "validFrom" : 1316712986000,
          "validTo" : 1632072986000
        }, {
          "algorithm" : "HmacSHA1",
          "keyLength" : 64,
          "accessKeyId" : "WHDFDP7UVJS9F3USU1NF",
          "createdOn" : 1316661731171,
          "domainId" : "00000000001001",
          "otherAttributes" : {
          },
          "status" : "active",
          "userId" : "00000000003002",
          "validFrom" : 1316661731000,
          "validTo" : 1632021731000
        } ],
        "otherAttributes" : {
        }
      }
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=744A36BAF6E7165CCBC4C6CA1812204D; Path=/v2.0; Secure
    Content-Type: application/xml
    Content-Length: 1340
    Date: Fri, 09 Sep 2011 04:20:29 GMT
     
    <accessKeys xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
       <accessKey accessKeyId="2SL748X97NEP7B6MVXPS" userId="000000003002" domainId="000000001001" status="active" validFrom="2011-09-08T15:20:20.000-07:00" validTo="2021-09-05T15:20:20.000-07:00" createdOn="2011-09-08T15:20:20.275-07:00">
          <algorithm>HmacSHA1</algorithm>
          <keyLength>64</keyLength>
       </accessKey>
       <accessKey accessKeyId="98XM1KSN7BC2C88U9S7G" userId="000000003002" domainId="000000001001" status="active" validFrom="2011-09-08T16:43:56.000-07:00" validTo="2021-09-05T16:43:56.000-07:00" createdOn="2011-09-08T16:43:56.494-07:00">
          <algorithm>HmacSHA1</algorithm>
          <keyLength>64</keyLength>
       </accessKey>
       <accessKey accessKeyId="3D76NSUB49C96DFBRUF9" userId="000000003002" domainId="000000001001" status="deleted" validFrom="2011-09-08T15:19:10.000-07:00" validTo="2021-09-05T15:19:10.000-07:00" createdOn="2011-09-08T15:19:10.378-07:00">
          <algorithm>HmacSHA1</algorithm>
          <keyLength>64</keyLength>
       </accessKey>
       <accessKey accessKeyId="9L47KGME4ZKCH9YRWDY7" userId="000000003002" domainId="000000001001" status="active" validFrom="2011-09-08T17:34:09.000-07:00" validTo="2021-09-05T17:34:09.000-07:00" createdOn="2011-09-08T17:34:09.494-07:00">
          <algorithm>HmacSHA1</algorithm>
          <keyLength>64</keyLength>
       </accessKey>
    </accessKeys>

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 404 | Not Found | Specified accesskeyId or userId not found   |
| 500 | Internal Server Error | The server encountered a problem while processing the request  |
| 503 | Service Unavailable | The server is unavailable to process the request  |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -H "X-Auth-Token: HPAuth_21805c02da2661574e46235bd8c27c10623bddc09a7cf4c67004771628e5453c" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys?export=true"

**Additional Notes**



#### 4.4.13.4 Get An Access Key#### {#get_an_access_key}
#### GET /HP-IDM/v1.0/accesskeys/{accesskeyId}

*Privilege Level: SA,DA,SS*

Gets a single user access key by it's access key identifier.

**Request Data**

The accesskeyId URL path parameter is required. The 'export' and 'userId' query parameters are optional.

**URL Parameters**

* *accesskeyId* (Required) - URL path parameter - user access key identifier string
* *userId* (Optional) - Query Parameter - user identifier string for user other than current authenticated user
* *export* (Optional) - Query Parameter - used to specify whether secret key value should be returned ("true" or "false")

**Data Parameters**

This call does not require a request body.

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


JSON

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/V7TEGGSZZ4NJK9UR4UFE?export=true HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_4e7bc0d2e4b0600fec3d2a4a
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443 
    

XML

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/3D76NSUB49C96DFBRUF9?export=false HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_4e699292e4b0a8f279022d4d
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 376
    Date: Thu, 22 Sep 2011 23:12:53 GMT
    
    {  
       "accessKey" : {    
         "algorithm" : "HmacSHA1",    
         "keyLength" : 64,    
         "secretKey" : "hNi0oiTU2sH",    
         "accessKeyId" : "V7TEGGSZZ4NJK9UR4UFE",    
         "createdOn" : 1316712986234,    
         "domainId" : "00000000001001",    
         "otherAttributes" : {    
         },    
         "status" : "active",    
         "userId" : "00000000003002",    
         "validFrom" : 1316712986000,    
         "validTo" : 1632072986000  
       }
    } 
    

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=34C3B7E6EC0F9035A75BD4A0CF6CAC37; Path=/v2.0; 
    SecureContent-Type: application/xml
    Content-Length: 415
    Date: Fri, 09 Sep 2011 04:15:42 GMT
    
    <accessKey accessKeyId="3D76NSUB49C96DFBRUF9" userId="000000003002" domainId="000000001001" status="deleted" validFrom="2011-09-08T15:19:10.000-07:00" validTo="2021-09-05T15:19:10.000-07:00" createdOn="2011-09-08T15:19:10.378-07:00" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
      <algorithm>HmacSHA1</algorithm>
      <keyLength>64</keyLength>
    </accessKey> 

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 404 | Not Found | Specified accesskeyId or userId not found   |
| 500 | Internal Server Error | The server encountered a problem while processing the request  |
| 503 | Service Unavailable | The server is unavailable to process the request  |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/HAJ5LLHHTKHBXB6MK3TL?export=true"

**Additional Notes**



#### 4.4.13.5 Import User Access Key(s)#### {#import_user_access_key}
#### PUT /HP-IDM/v1.0/accesskeys
*Privilege Level: SA, DA, SS*

Import one or more user access keys. 

**Request Data**

The request data consists of an accessKeys data structure containing one or more accessKey elements. The secretKey and algorithm elements of the accessKey are required. The accessKeyId, domainId, keyLength, status, userId, validFrom, and validTo attributes are optional.

**URL Parameters**

There are no URL parameters for this request.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *algorithm* - String - the algorithm the key will be used with. This is not validated when imported.
* *domainId* (Optional) - String - domain identifier of the owner of the key.
* *keyLength* (Optional) - Integer - Length of the key in bits.
* *status* (Optional) String - the key status. One the values (active, inactive). Defaults to active if not specified.
* *userId* (Optional) - String - User identifier of the owner of the key. If not specified the user identifier defaults to the user identifier of the requester.
* *validFrom* (Optional) - DateTime - The date the key becomes valid specified in the following form "YYYY-MM-DDThh:mm:ss". 
* *validTo* (Optional) - DateTime - The date the key becomes invalid specified in the following form "YYYY-MM-DDThh:mm:ss". 

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

    PUT https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e7bb54fe4b0600fec3d2a37
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 919
     
    {"accessKeys": {
       "anies": null,
       "accessKey":    [
                {
             "algorithm": "HmacSHA1",
             "keyLength": 64,
             "secretKey": "hNi0oiTU2sH",
             "accessKeyId": "V7TEGGSZZ4NJK9UR4998",
             "createdOn": 1316712986234,
             "domainId": "00000000001001",
             "otherAttributes": {},
             "status": "inactive",
             "userId": "00000000003002",
             "validFrom": 1316712986000,
             "validTo": 1632072986000
          },
                {
             "algorithm": "HmacSHA1",
             "keyLength": 64,
             "secretKey": "DBWjcUCMEED",
             "accessKeyId": "RVWVEGE88EHZBSBMJ999",
             "createdOn": 1316724920250,
             "domainId": "00000000001001",
             "otherAttributes": {},
             "status": "inactive",
             "userId": "00000000003002",
             "validFrom": 1316724920000,
             "validTo": 1632084920000
          }
        ],
       "otherAttributes": {}
    }}

XML

    PUT https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    X-Auth-Token: HPAuth_4e6d258be4b05605729d7c3a
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 546
     
    <accessKeys xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
       <accessKey accessKeyId="98XM1KSN7BC2C88U9999" userId="000000003002" domainId="000000001001" status="inactive" validFrom="2011-09-08T16:43:56.000-07:00" validTo="2021-09-05T16:43:56.000-07:00" createdOn="2011-09-08T16:43:56.494-07:00">
          <algorithm>HmacSHA1</algorithm>
          <keyLength>64</keyLength>
          <secretKey>HyGB2QRiOu7</secretKey>
       </accessKey>
    </accessKeys>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 802
    Date: Thu, 22 Sep 2011 22:23:53 GMT
     
    {
      "accessKeys" : {
        "anies" : null,
        "accessKey" : [ {
          "algorithm" : "HmacSHA1",
          "keyLength" : 64,
          "accessKeyId" : "V7TEGGSZZ4NJK9UR4998",
          "createdOn" : 1316730228058,
          "domainId" : "00000000001001",
          "otherAttributes" : {
          },
          "status" : "inactive",
          "userId" : "00000000003002",
          "validFrom" : 1316712986000,
          "validTo" : 1632072986000
        }, {
          "algorithm" : "HmacSHA1",
          "keyLength" : 64,
          "accessKeyId" : "RVWVEGE88EHZBSBMJ999",
          "createdOn" : 1316730228065,
          "domainId" : "00000000001001",
          "otherAttributes" : {
          },
          "status" : "inactive",
          "userId" : "00000000003002",
          "validFrom" : 1316724920000,
          "validTo" : 1632084920000
        } ],
        "otherAttributes" : {
        }
      }
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=41C4EA0FDBAB389A7F904935A283566A; Path=/v2.0; Secure
    Content-Type: application/xml
    Content-Length: 537
    Date: Sun, 11 Sep 2011 21:18:37 GMT
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <accessKeys xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
       <accessKey accessKeyId="98XM1KSN7BC2C88U9999" userId="000000003002" domainId="000000001001" status="inactive" validFrom="2011-09-08T16:43:56.000-07:00" validTo="2021-09-05T16:43:56.000-07:00" createdOn="2011-09-11T14:18:34.736-07:00">
          <algorithm>HmacSHA1</algorithm>
          <keyLength>64</keyLength>
       </accessKey>
    </accessKeys>

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 404 | Not Found | Specified accesskeyId or userId not found   |
| 409 | Conflict | An access key already exists with the specified access key identifier |
| 500 | Internal Server Error | The server encountered a problem while processing the request  |
| 503 | Service Unavailable | The server is unavailable to process the request  |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -X PUT -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys" -d '{"accessKeys": {
       "anies": null,
       "accessKey":    [
                {
             "algorithm": "HmacSHA1",
             "keyLength": 64,
             "secretKey": "hNi0oiTU2sH",
             "accessKeyId": "V7TEGGSZZ4NJK9UR4998",
             "createdOn": 1316712986234,
             "domainId": "11180052618906",
             "otherAttributes": {},
             "status": "inactive",
             "userId": "84463950217213",
             "validFrom": 1316712986000,
             "validTo": 1632072986000
          },
                {
             "algorithm": "HmacSHA1",
             "keyLength": 64,
             "secretKey": "DBWjcUCMEED",
             "accessKeyId": "RVWVEGE88EHZBSBMJ999",
             "createdOn": 1316724920250,
             "domainId": "11180052618906",
             "otherAttributes": {},
             "status": "inactive",
             "userId": "84463950217213",
             "validFrom": 1316724920000,
             "validTo": 1632084920000
          }
        ],
       "otherAttributes": {}
    }}'
    

**Additional Notes**


#### 4.4.13.6 Update User Access Key#### {#update_user_access_key}
#### PUT /HP-IDM/v1.0/accesskeys/{accesskeyId}
*Privilege Level: SA, DA, SS*

Update a user access key. This method may be used to modify the key status only.

**Request Data**

The accesskeyId url path parameter is required. The userId query parameter is optional. If the userId parameter is not specified then it defaults to the user identifer of the requester.

**URL Parameters**

* *accesskeyId* - URL path parameter - user access key identifier.
* *userId* (Optional) - Query Parameter - user identifier string. Defaults to user identifier of the requester if not specified.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *status* - {data type} - Key status. One of the values (active, inactive).

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

    PUT https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/KNGTV6EFKLPYE8LXF4VL HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e7bba89e4b0600fec3d2a3a
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 51
     
    {
      "accessKey" : {
        "status" : "inactive"
      }
    }

XML

    PUT https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/2SL748X97NEP7B6MVXPS HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    X-Auth-Token: HPAuth_4e6ab9fde4b06fe4272ee23e
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 146
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <accessKey status="inactive" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"/>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 345
    Date: Thu, 22 Sep 2011 22:47:17 GMT
     
    {
      "accessKey" : {
        "algorithm" : "HmacSHA1",
        "keyLength" : 64,
        "accessKeyId" : "KNGTV6EFKLPYE8LXF4VL",
        "createdOn" : 1316714474259,
        "domainId" : "00000000001001",
        "otherAttributes" : {
        },
        "status" : "inactive",
        "userId" : "00000000003002",
        "validFrom" : 1316714474000,
        "validTo" : 1632074474000
      }
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=4D3047BA05428AD806C48E269C8DD8B4; Path=/v2.0; Secure
    Content-Type: application/xml
    Content-Length: 416
    Date: Sat, 10 Sep 2011 01:16:12 GMT
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><accessKey xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" accessKeyId="2SL748X97NEP7B6MVXPS" userId="000000003002" domainId="000000001001" status="inactive" validFrom="2011-09-08T15:20:20.000-07:00" validTo="2021-09-05T15:20:20.000-07:00" createdOn="2011-09-08T15:20:20.275-07:00"><algorithm>HmacSHA1</algorithm><keyLength>64</keyLength></accessKey>

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 404 | Not Found | Specified accesskeyId or userId not found   |
| 500 | Internal Server Error | The server encountered a problem while processing the request  |
| 503 | Service Unavailable | The server is unavailable to process the request  |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -X PUT -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/V7TEGGSZZ4NJK9UR4998" -d '{
      "accessKey" : {
        "status" : "active"
      }
    }'

**Additional Notes**




### 4.4.14 User Certificates

User Certificate Operations.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.14.1 Get User Certificates#### {#get_user_certificates}
#### GET /HP-IDM/v1.0/certificates
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

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates?export=false HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_4e7bdbcee4b0600fec3d2a4d
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates?export=false HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_4e6eb9b9e4b0100a2619f0c5
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

Optional:

Request With issue name and serial number and :

JSON

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates?issuerName=ABC&serialNumber=DEF HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_4e7bdbcee4b0600fec3d2a4d
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates?issuerName=ABC&serialNumber=DEF HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_4e6eb9b9e4b0100a2619f0c5
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates"

**Additional Notes**


#### 4.4.14.2 Delete User Certificate#### {#delete_user_certificate}
#### DELETE /HP-IDM/v1.0/certificates/{issuerName}/{serialNumber} 	D
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

    DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test1/5669954f HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_4e7bde38e4b0600fec3d2a54
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test/1239dac6 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_4e6edf2ee4b03cd3901e21e5
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

Optional:


**Success Response**

**Status Code**

204 (No Content)

**Response Data**

JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=24830D918D66DC787E1510E8385F1623; Path=/v2.0; Secure
    Date: Fri, 23 Sep 2011 01:22:57 GMT

XML

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=AB5C4E673D143F25DE6EFC024E1A2ED9; Path=/v2.0; Secure
    Date: Tue, 13 Sep 2011 04:45:19 GMT

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test1/5669954f" -XDELETE

**Additional Notes**


#### 4.4.14.3 Get User Certificate#### {#get_user_certificate}
#### GET /HP-IDM/v1.0/certificates/{issuerName}/{serialNumber}
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

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test1/5669954f?export=true HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_4e7bde38e4b0600fec3d2a54
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test/16c13be6?export=true HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_4e6eb9b9e4b0100a2619f0c5
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

Optional:

JSON

    {json data structure here}

XML

    {xml data structure here}

**Success Response**


**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test1/5669954f?export=true"

**Additional Notes**

#### 4.4.14.4 Create A User Certificate#### {#create_a_user_certificate}
#### POST /HP-IDM/v1.0/certificates
*Privilege Level: SA, DA, SS*

Create a user certificate. This method requires a request body. The user identifier and subject elements are required elements in the body.

**Request Data**


**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.
A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call requires a request body.

JSON

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/certificates HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e7bdbcee4b0600fec3d2a4d
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 114
     
    {"certificate":{"userId":"00000000003002","domainId":"00000000001001","subject":"CN=Joe Test1","status":"active"}}

XML

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

Optional:


**Success Response**

**Status Code**

201 - Created

**Response Data**

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates" -XPOST -d "\{"certificate\":\{"userId\":\"00000000003002\",\"domainId\":\"00000000001001\",\"subject\":\"CN=Joe Test1\",\"status\":\"active\"}}"

**Additional Notes**


#### 4.4.14.5 Import User Certificate(s)#### {#import_user_certificate}
#### PUT /HP-IDM/v1.0/certificates
*Privilege Level: SA, DA, SS*

Import user certificate(s). The operation requires a request body containing the user certificate(s) and the user identifier.

**Request Data**

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

The request body contains a certificates object with the certificates to be imported.

JSON

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

XML

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

Optional:


**Success Response**

**Status Code**

200 - OK

**Response Data**


JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

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
    

**Additional Notes**

#### 4.4.14.6 Update User Certificate#### {#update_user_certificate}
#### PUT /HP-IDM/v1.0/certificates/{issuerName}/{serialNumber} 	
*Privilege Level: SA,DA,SS*

Update a user certificate. This method requires a request body containing the status element of the certificate. The issuer name {issuerName} and serial number {serialNumber} are required in the URI.

**Request Data**

**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

The request body contains a certificate object. The status attribute is required in the certificate object. All other attributes and elements of the certificate object are ignored.

JSON

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

XML

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

Optional:


**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/certificates/CN=Joe%20Test/1239dac6" -XPUT -d '{"certificate": {"status": "inactive"} }'

**Additional Notes**




### 4.4.15 User Key Pairs

The User Key Pair REST API provides the ability to manage user access keys.


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.15.1 Create User Key Pair#### {#create_user_key_pair}
#### POST /HP-IDM/v1.0/keypairs
*Privilege Level: SA, DA, SS*

Create a user key pair.

**Request Data**

The optional data parameters are domainId, publicKeyAlgorithm, publicKeyLength, status, userId, validFrom, and validTo. If not specified the userId defaults to the user identifier of the requester.

**URL Parameters**

There are no URL parameters for this operation.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *domainId* - String - domain identifier of the owner of the key.
* *publicKeyAlgorithm* (Optional) - String - the public key algorithm. One of the values (RSA, DSA). Defaults to RSA if not specified.
* *publicKeyLength* (Optional) - Integer - Length of the key in bits. Recommended value is 1024 (2048 max) for RSA and 512 (1024 max) for DSA. The default publicKeyLength is 1024 if not specified.
* *status* (Optional) String - the key pair status. One the values (active, inactive). Defaults to active if not specified.
* *userId* (Optional) - String - User identifier of the owner of the key. If not specified the user identifier defaults to the user identifier of the requester.
* *validFrom* (Optional) - DateTime - The date the key pair becomes valid specified in the following form "YYYY-MM-DDThh:mm:ss". 
* *validTo* (Optional) - DateTime - The date the key pair becomes invalid specified in the following form "YYYY-MM-DDThh:mm:ss" 

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

    POST https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token: HPAuth_4e9caa84e4b0ea896133e05e
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443
    Content-Length: 85
     
    {"keyPair":{"userId":"00000000003002","domainId":"00000000001001","status":"active"}}

XML

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


**Success Response**

**Status Code**

201 - Created

**Response Data**


JSON

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

XML

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

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | The request for the operation is not well formed or missing the required parameters |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The key pair was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -X POST -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs" -d '{"keyPair":{"publicKeyAlgorithm" : "RSA", "userId":"84463950217213","domainId":"11180052618906","status":"active"}}'

**Additional Notes**



#### 4.4.15.2 Delete User Key Pair#### {#delete_user_key_pair}
#### DELETE /HP-IDM/v1.0/keypairs/{keypairId}
*Privilege Level: SA, DA, SS*

Delete a user key pair.

**Request Data**

The keypairId url path parameter is required. The userId query parameter is only required to delete a key pair for a user other than the requester.

**URL Parameters**

* *keypairId* (Required) - URL path parameter - user key pair identifier string
* *userId* (Optional) - Query Parameter - User identifier of the access key owner. If not specified then defaults to userId of the requester.

**Data Parameters**

This call does not require a request body.

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


JSON

    DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/6616KAAUK6L9HJGUT6Z7 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_4e9caa84e4b0ea896133e05e
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/3K3A3FJSC9YRX5LVJCES HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_4e81f502e4b078454c0c31bf
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

**Success Response**

**Status Code**

204 - No Content

**Response Data**

JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=06BB563F31C6543DE13C39F82290764C; Path=/v2.0; Secure
    Date: Mon, 17 Oct 2011 22:35:05 GMT

XML

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Set-Cookie: JSESSIONID=C1E6F9C41377350F6C6236CD0923BAC8; Path=/v2.0; Secure
    Date: Tue, 27 Sep 2011 16:22:36 GMT

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | The request for the operation is not well formed or missing the required parameters |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The key pair was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -X DELETE -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/HX6K62WXLNAMZCKKDJSM" 
    

**Additional Notes**


#### 4.4.15.3 Get User Key Pair#### {#get_user_key_pair}
#### GET /HP-IDM/v1.0/keypairs/{keypairId}
*Privilege Level: SA, DA, SS*

Get a user key pair by it's key pair identifier.

**Request Data**

The keypairId URL path parameter is required. The userId and export query parameters are optional. If userId is not specified then it defaults to the user identifier of the requester.

**URL Parameters**

* *export* (Optional) - Query Parameter - used to specify whether the public key value should be returned ("true" or "false")
* *keypairId* (Required) - URL path parameter - user key pair identifier.
* *userId* (Optional) - Query Parameter - user identifier. Defaults to the user identifier of the requester.


**Data Parameters**

This call does not require a request body.

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


JSON

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/ZZPADZV9LPZCLZJ1GDEK?export=true HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_4e9caa84e4b0ea896133e05e
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/3K3A3FJSC9YRX5LVJCES?export=false HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_4e815f48e4b0459717485fba
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | The request for the operation is not well formed or missing the required parameters |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The key pair was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/XX1ZH9BT8U4CK86ZWPVK?export=true"

**Additional Notes**



#### 4.4.15.4 Get User Key Pairs#### {#get_user_key_pairs}
#### GET /HP-IDM/v1.0/keypairs
*Privilege Level: SA, DA, SS*

Gets a list of selected user key pairs.

**Request Data**

The following query parameters are optional (domainId, export, status, userId). There are no required query parameters.

**URL Parameters**

* *domainId* (Optional) - Query Parameter - Domain identifier. Selects key pairs with matching domain identifier.
* *export* (Optional) - Query Parameter - Export public key value. Value is one of (true, false). If not specified the value is set to false.
* *status* (Optional) - Query Parameter - Key pair status. Selects key pairs with matching status. Value is one of (active, inactive, expired, revoked, deleted, purged).
* *userId* (Optional) - Query Parameter - User identifier. Selects key pairs with matching user identifier. If not specified the userId of the requester is used.


**Data Parameters**

This call does not require a request body.

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


JSON

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs?export=false HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_4e9caa84e4b0ea896133e05e
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs?export=false HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_4e815f48e4b0459717485fba
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | The request for the operation is not well formed or missing the required parameters |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs?export=true"

**Additional Notes**


#### 4.4.15.5 Import User Key Pair(s)#### {#import_user_key_pair}
#### PUT /HP-IDM/v1.0/keypairs
*Privilege Level: SA, DA, SS*

Import one or more user key pairs.

**Request Data**

The request data consists of a keyPairs data structure containing one or more keyPair elements. The userId attribute, publicKeyFile, and publicKeyAlgorithm elements are required in each keyPair object specified in the request body.  All other attributes and elements of each keyPair object are optional. 

**URL Parameters**

There are no URL parameters for this request.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *domainId* (Optional) - String - domain identifier of the owner of the key.
* *keyPairId* (Optional) - String - key pair identifier. If not provided a new identifier will be automatically generated.
* *publicKeyAlgorithm* - String - the public key algorithm. One of the values (RSA, DSA). Required only for Base64-DER encoded keys.
* *publicKeyFile* - String - the public key encoded in Base64-DER, OpenSSH, or SSHv2 format.
* *publicKeyLength* (Optional) - Integer - Length of the key in bits. 
* *status* (Optional) String - the key status. One the values (active, inactive). Defaults to active if not specified.
* *userId* (Optional) - String - User identifier of the owner of the key. If not specified the user identifier defaults to the user identifier of the requester.
* *validFrom* (Optional) - DateTime - The date the key pair becomes valid specified in the following form "YYYY-MM-DDThh:mm:ss". 
* *validTo* (Optional) - DateTime - The date the key pair becomes invalid specified in the following form "YYYY-MM-DDThh:mm:ss". 

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


JSON

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

XML

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

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | The request for the operation is not well formed or missing the required parameters |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The key pair was not found |
| 409 | Conflict | A key pair already exists with the specified key pair identifier |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -X PUT -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs" -d '{
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
          "domainId" : "11180052618906",
          "keyPairId" : "XPYXH98W782MYNPWR998",
          "otherAttributes" : {
          },
          "status" : "inactive",
          "userId" : "84463950217213",
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
          "domainId" : "11180052618906",
          "keyPairId" : "74HVY65RF5WTPS3KW999",
          "otherAttributes" : {
          },
          "status" : "inactive",
          "userId" : "84463950217213",
          "validFrom" : 1318638836000,
          "validTo" : 1633998836000
        }],
        "otherAttributes" : {
        }
      }
    }'

**Additional Notes**



#### 4.4.15.6 Update User Key Pair#### {#update_user_key_pair}
#### PUT /HP-IDM/v1.0/keypairs/{keypairId}
*Privilege Level: SA, DA, SS*

Update a user key pair. This operation is used to udpate the key pair status. See the schema or examples below for details.

**Request Data**

The keypairId url path parameter is required. The userId query parameter is optional. If the userId parameter is not specified then it defaults to the user identifer of the requester. The status attribute must be set to active or inactive in the request body.

**URL Parameters**

* *keypairId* - URL path parameter - user key pair identifier.
* *userId* (Optional) - Query Parameter - user identifier string. Defaults to user identifier of the requester if not specified.


**Data Parameters**

See schema file for more details on the request and response data structure.

* *status* - String - Key pair status. One of the values (active, inactive).

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


JSON

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

XML

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

**Success Response**


**Status Code**

200 - OK

**Response Data**

JSON

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

XML

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

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | The request for the operation is not well formed or missing the required parameters. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.  |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The key pair was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k -X PUT -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/keypairs/74HVY65RF5WTPS3KW999" -d '{
      "keyPair" : {
        "status" : "active"
      }
    }'

**Additional Notes**



# 5. Additional References

## 5.1 Resources

**Wiki Page**: {Link to Wiki page}

**Code Repo**:  {Link to the internal Github repo}

**API Lead Contact**: {Name of contact}

---

# 6. Glossary

{Put down definitions of terms and items that need explanation.}

---

# Appendix A: Available Actions # {#available_action}

| Actions |
| :------ |
| [Activate Block Storage](#activate_block_storage) |
| [ActivateCdn](#activatecdn) |
| [ActivateCompute](#activatecompute) |
| [ActivateImageService](#activateimageservice) |
| [ActivateObjectStorage](#activateobjectstorage) |
| [ActivateService](#activateservice) |
| [Cancel Account](#cancel_account) |
| [CreateDomain - SEVERELY DEPRECATED - TO BE REMOVED IN CONSER-4098](#createdomain_-_severely_deprecated_-_to_be_removed_in_conser-4098) |
| [Create Tenant](#create_tenant) |
| [CreateUser](#createuser) |
| [DeactivateBlockStorage](#deactivateblockstorage) |
| [DeactivateCdn](#deactivatecdn) |
| [DeactivateCompute](#deactivatecompute) |
| [DeactivateImageService](#deactivateimageservice) |
| [DeactivateObjectStorage](#deactivateobjectstorage) |
| [DeactivateService](#deactivateservice) |
| [DevexMigration](#devexmigration) |
| [EmailVerification](#emailverification) |
| [EnterpriseUserEmailVerification](#enterpriseuseremailverification) |
| [ForgotPasswordReset](#forgotpasswordreset) |
| [NocUserRegistration](#nocuserregistration) |
| [PurgeDomain](#purgedomain) |
| [PurgeTenant](#purgetenant) |
| [PurgeUser](#purgeuser) |
| [SelfRegistration](#selfregistration) |
| [SvcOnBoardingUserRegistration](#svconboardinguserregistration) |
| [UpdateDomain](#updatedomain) |
| [UpdateTenant](#updatetenant) |
| [UpdateUser](#updateuser) |
| [UserNameRecovery](#usernamerecovery) |

### Activate Block Storage ### {#activate_block_storage}
#### POST [HPKeystoneExtensionBaseURI]/action/activateblockstorage
*Privilege Level: System Administrators, Domain Administrators*  
*Constraints:*  
1. A service endpoint can be subscribed to only once by the same tenant. (FindUmsTenant)  
2. serviceName parameter must be valid (AuthorizeProvisioningAction)  
3. serviceName and regionCode parameters must be valid and must resolve a unique EndpointTemplate (CreateEndpointRef)  
4. serviceName must resolve to a RegisteredService object (AssociateRoles)  
5. serviceName and regionCode parameters must be valid and must resolve a unique EndpointTemplate (CreateProvisioningInfo)  

Activate specified (existing) Tenant to Block Storage service.

**Request Data**  

**URL Parameters**

None 

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|serviceName|xs:string|true|
|domainId|xs:string|false|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON
    POST http://host:port/v2.0/HP-IDM/v1.0/action/activateblockstorage HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    { "JobTicket" :
        { "actionParams" : {
            "serviceName":"block-storage",
            "regionCode":"az1:east:us",
            "tenantName":"Tenant1"
            }
        }
    }

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example
    curl -k -s -S --connect-timeout 2 --noproxy <proxy-exclusions> -m 30 -X POST -H 'User-Agent: Jakarta Commons-HttpClient/3.1' -H 'Content-Type: application/json' --cert <cert-path> --cacert <ca-cert-path> --data '{"JobTicket": {"actionParams":{"status": "SUSPENDED_3", "domainId": "92636548281306"}}}' -H 'X-Auth-Token: <auth-token>' [HPKeystoneExtensionBaseURI]/action/UpdateDomain?timeOut=20000  
**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|FindUmsTenant|Retrieve an existing Tenant from the UMS based on the Name of the Tenant|false|
|AuthorizeProvisioningAction|Perform authorisation checks prior to provisioning.  Essentially validate that the user attempting to provision the tenant is actually authorised to perform this action.  The *ITLSessionContext* associated with the incoming request thread is used for authorisation checks.|false|
|CreateZuoraSubscription|&nbsp;|false|
|CreateEndpointRef|Create an *EndpointRef* that links an endpoint via an *EndpointTemplate* to a Tenant.  The *EndpointRef* that links the tenant to the endpoint. This linkage, if it does not already exist, is setup in CS DB.|false|
|AssociateRoles|Assign service activation roles to a specified user and/or to a specified group|false|
|CreateProvisioningInfo|Create or update an existing *ProvisioningInfo* record to track a tenant's provisioned service.  The *ProvisioningInfo* that tracks the provisioning status of this tenant with the provisioned endpoint (via *serviceName* and regionCode) is setup.  The status of this *ProvisioningInfo* set to ENABLED and also the serviceAccountId field is set to the accountId (for now this is the tenantId) of the tenant.  If the ProvisioningInfo exists, then it will be reused and only the status will be marked ENABLED.  In the future this behaviour may change since the currentbehaviour retains the ProvisioningInfo record of a 'Deprovisioned' tenant since provisioning history has not been implemented yet.|false|





### ActivateCdn ### {#activatecdn}
#### POST [HPKeystoneExtensionBaseURI]/action/activatecdn
*Privilege Level: System Administrators, Domain Administrators*  
*Constraints:* 
 
1.  A service endpoint can be subscribed to only once by the same tenant. _(FindUmsTenant)_  
2.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_  
3.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(CreateEndpointRef)_  
4.  serviceName must resolve to a RegisteredService object _(AssociateRoles)_  
5.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(CreateProvisioningInfo)_  


Activate the specified (existing) Swift Tenant to CDN service.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|serviceName|xs:string|true|
|domainId|xs:string|false|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/activatecdn HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"cdn",
          "regionCode":"az1:east:us",
          "tenantName":"Tenant1"
        }
      }
    }
**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|FindUmsTenant|Retrieve an existing Tenant from the UMS based on the Name of the Tenant.|false|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning. Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action. The `ITLSessionContext` associated with the incoming request thread is used for authorization checks.|false|
|CreateZuoraSubscription| |false|
|CreateEndpointRef|Create an `EndpointRef` that links an endpoint via an `EndpointTemplate` to a Tenant. The `EndpointRef` that links the tenant to the endpoint. This linkage, if it does not already exist, is setup in CS DB. | false |
| AssociateRoles | Assign service activation roles to a specified user and/or to a specified group | false |
| CreateProvisioningInfo | Create or update an existing `ProvisioningInfo` record to track a tenant's provisioned service.  The `ProvisioningInfo` that tracks the provisioning status of this tenant with the provisioned endpoint (via `serviceName` and `regionCode`) is setup.  The status of this `ProvisioningInfo` set to `ENABLED` and also the `serviceAccountId` field is set to the accountId (for now this is the tenantId) of the tenant.  If the `ProvisioningInfo` exists, then it will be reused and only the status will be marked `ENABLED`.  In the future this behavior may change since the current behavior retains the `ProvisioningInfo` record of a 'Deprovisioned' tenant since provisioning history has not been implemented yet. | false |

**Notes**

1.  The `tenantName` must resolve to an existing tenant and must be provisioned to at least one `Object Storage` service.
2.  The `domainId` is neither required nor used.
3.  As part of activation the `Domain Administrators` group for the domain of the Tenant is added to the role `cdn-admin` for this tenant.



### ActivateCompute ### {#activatecompute}
#### POST [HPKeystoneExtensionBaseURI]/action/activatecompute
*Privilege Level: System Administrators, Domain Administrators*
  
*Constraints:*
  
1.  A service endpoint can be subscribed to only once by the same tenant. _(CreateUmsTenant)_
2.  If a tenant with {{tenantName}} exists then the domainId of that tenant must match the {{domainId}} parameter _(CreateUmsTenant)_
3.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
4.  {{serviceName}} and {{regionCode}} parameters must be valid and must resolve a unique `EndpointTemplate` _(CreateEndpointRef)_
5.  serviceName must resolve to a RegisteredService object _(AssociateRoles)_
6.  {{serviceName}} and {{regionCode}} parameters must be valid and must resolve a unique `EndpointTemplate` _(CreateProvisioningInfo)_

Activate specified Tenant to OpenStack Compute (Nova) service.

As part of activation the `Domain Administrators` group for the domain of the Tenant is added to the roles `netadmin` and `volume-manager` for this tenant.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|serviceName|xs:string|true|
|domainId|xs:string|true|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/activatecompute HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"compute",
          "regionCode":"az1:east:us",
          "domainId":"01234567890123",
          "tenantName":"Tenant1"
        }
      }
    }

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:-----------------------|:------------------------------|:--------------------------|
|CreateUmsTenant|Create a new or retrieve an existing Tenant from the UMS based on the Name of the Tenant.|false|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning. Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action. The `ITLSessionContext` associated with the incoming request thread is used for authorization checks.|false|
|CreateZuoraSubscription| |false|
|CreateZuoraSubscription| |false|
|CreateEndpointRef|Create an `EndpointRef` that links an endpoint via an `EndpointTemplate` to a Tenant. The `EndpointRef` that links the tenant to the endpoint. This linkage, if it does not already exist, is setup in CS DB.|false|
|AssociateRoles|Assign service activation roles to a specified user and/or to a specified group|false|
|CreateProvisioningInfo|Create or update an existing `ProvisioningInfo` record to track a tenant's provisioned service. The `ProvisioningInfo` that tracks the provisioning status of this tenant with the provisioned endpoint (via {{serviceName}} and {{regionCode}}) is setup. The status of this `ProvisioningInfo` set to `ENABLED` and also the {{serviceAccountId}} field is set to the accountId (for now this is the tenantId) of the tenant. If the `ProvisioningInfo` exists, then it will be reused and only the status will be marked `ENABLED`. In the future this behavior may change since the current behavior retains the `ProvisioningInfo` record of a 'Deprovisioned' tenant since provisioning history has not been implemented yet.|false|

**Notes**

1.  The `tenantName` must be globally unique.
2.  A `Block Storage` service must be available in the *same region* to which this tenant will automatically be provisioned to.




### ActivateImageService ### {#activateimageservice}
#### POST [HPKeystoneExtensionBaseURI]/action/activateimageservice
*Privilege Level: System Administrators, Domain Administrators*
  
*Constraints:*

1.  A service endpoint can be subscribed to only once by the same tenant. _(CreateUmsTenant)_
2.  If a tenant with `tenantName` exists then the domainId of that tenant must match the `domainId` parameter _(CreateUmsTenant)_
3.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
4.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(CreateEndpointRef)_
5.  serviceName must resolve to a RegisteredService object _(AssociateRoles)_
6.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(CreateProvisioningInfo)_


Activate specified Tenant to OpenStack Image Service (Glance). As part of activation certain `Service Roles` assignments are made for this tenant.



**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|domainId|xs:string|true|
|tenantId|xs:string|true|
|serviceName|xs:string|true|
|regionCode|xs:string|true|
|tenantName|xs:string|true|
|dryrun|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/activateimageservice HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"image-service",
          "regionCode":"az1:east:us",
          "domainId":"01234567890123",
          "tenantName":"Tenant1"
        }
      }
    }

    POST http://host:port/v2.0/HP-IDM/v1.0/action/activateimageservice HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"image-service",
          "regionCode":"az1:east:us",
          "domainId":"01234567890123",
          "tenantId":"12345678901234"
        }
      }
    }

**Success Response**

**Status Code**

{success http status code}

**Response Data**

JSON

{json response code formatted}

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**


|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|CreateUmsTenant|Create a new or retrieve an existing Tenant from the UMS based on the Name of the Tenant.|false|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning.Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action.The `ITLSessionContext` associated with the incoming request thread is used for authorization checks.|false|
|CreateZuoraSubscription||false|
|CreateEndpointRef|Create an `EndpointRef` that links an endpoint via an `EndpointTemplate` to a Tenant.The `EndpointRef` that links the tenant to the endpoint. This linkage, if it does not already exist, is setup in CS DB.|false|
|AssociateRoles|Assign service activation roles to a specified user and/or to a specified group|false|
|CreateProvisioningInfo|Create or update an existing `ProvisioningInfo` record to track a tenant's provisioned service.The `ProvisioningInfo` that tracks the provisioning status of this tenant with the provisioned endpoint (via `serviceName` and `regionCode`) is setup.The status of this `ProvisioningInfo` set to `ENABLED` and also the `serviceAccountId` field is set to the accountId (for now this is the tenantId) of the tenant.If the `ProvisioningInfo` exists, then it will be reused and only the status will be marked `ENABLED`.In the future this behavior may change since the current behavior retains the `ProvisioningInfo` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|

**Notes**

1.  The `tenantName` must be globally unique.
2.  EITHER `tenantName` OR `tenantId` are required.
3.  If only the `tenantName` is provided then, if the tenant with the specified name does not exist then a new tenant will be created.
4.  If only the `tenantId` is provided then the tenant with the specified `tenantId` must exist.
5.  If both are provided then `tenantId` takes precedence and the net effect is the same as if only the `tenantId` was provided.

### ActivateObjectStorage ### {#activateobjectstorage}
#### POST [HPKeystoneExtensionBaseURI]/action/activateobjectstorage
*Privilege Level: System Administrators, Domain Administrators*  
 
*Constraints:*  

1.  A service endpoint can be subscribed to only once by the same tenant. _(CreateUmsTenant)_
2.  If a tenant with `tenantName` exists then the domainId of that tenant must match the `domainId` parameter _(CreateUmsTenant)_
3.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
4.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(CreateEndpointRef)_
5.  serviceName must resolve to a RegisteredService object _(AssociateRoles)_
6.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(CreateProvisioningInfo)_

Activate specified Tenant to OpenStack Object Storage (Swift) service.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|serviceName|xs:string|true|
|domainId|xs:string|true|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/activateobjectstorage HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"object-storage",
          "regionCode":"az1:east:us",
          "domainId":"01234567890123",
          "tenantName":"Tenant1"
        }
      }
    }

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|CreateUmsTenant|Create a new or retrieve an existing Tenant from the UMS based on the Name of the Tenant.|false|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning.Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action.The `ITLSessionContext` associated with the incoming request thread is used for authorization checks.|false|
|CreateZuoraSubscription||false|
|CreateEndpointRef|Create an `EndpointRef` that links an endpoint via an `EndpointTemplate` to a Tenant.The `EndpointRef` that links the tenant to the endpoint. This linkage, if it does not already exist, is setup in CS DB.|false|
|AssociateRoles|Assign service activation roles to a specified user and/or to a specified group|false|
|CreateProvisioningInfo|Create or update an existing `ProvisioningInfo` record to track a tenant's provisioned service.The `ProvisioningInfo` that tracks the provisioning status of this tenant with the provisioned endpoint (via `serviceName` and `regionCode`) is setup.The status of this `ProvisioningInfo` set to `ENABLED` and also the `serviceAccountId` field is set to the accountId (for now this is the tenantId) of the tenant.If the `ProvisioningInfo` exists, then it will be reused and only the status will be marked `ENABLED`.In the future this behavior may change since the current behavior retains the `ProvisioningInfo` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|

**Notes**

1.  The `tenantName` must be globally unique.
2.  As part of activation the `Domain Administrators` group for the domain of the Tenant is added to the role `admin` for this tenant.

### ActivateService ### {#activateservice}
#### POST [HPKeystoneExtensionBaseURI]/action/activateservice
*Privilege Level: 
System Administrators, Domain Administrators*  

Apart from regular authorization requirement there are added authorization check on service activation call. Following are the new constraints added:

1.  Services and its endpoint template(s) has release state associated with it, by default customer has privilege to activate a service, as long as the service and endpoint template is/are in public state.
2.  Service releaseState takes higher presidency over endpoint template releaseState. (e.g. if service is in "beta" release state and its endpoint template is in "public", customer should not allowed to activate such services)
3.  If one of the endpoint template of a service is not in "public" state, service activation on that region should not be allowed.
4.  NOC and SA has privilege to activate any service does not matters what is the release state.
5.  To allow customer to activate a non public service, there should be special grant created on behalf of customer by NOC/Support
 
*Constraints:*  

1.  If a tenantId is provided, then a tenant with the specified tenantId must exist. In this case, the tenantName is ignored and no new tenant will be created. _(FindOrCreateUmsTenant)_
2.  If a tenant with tenantName exists then the domainId of that tenant must match the domainId parameter. _(FindOrCreateUmsTenant)_
3.  A service endpoint can be subscribed to only once by the same tenant. _(FindOrCreateUmsTenant)_
4.  The tenantId must be available (the UMS tenant must exist) at the time this is called. _(ProvisionService)_
5.  Service specific errors may be returned. _(ProvisionService)_
6.  `CDN` activation: Tenant being activated _must_ have an active subscription to Object Storage service. _(ProvisionService)_
7.  `Block Storage` activation: Tenant being activated _must_ have an active subscription to Compute service in the same region. _(ProvisionService)_
8.  serviceName and regionCode parameters must be valid and must resolve a unique EndpointTemplate _(CreateEndpointRef)_
9.  serviceName must resolve to a RegisteredService object _(AssociateRoles)_
10.  serviceName and regionCode parameters must be valid and must resolve a unique EndpointTemplate _(CreateProvisioningInfo)_

Activate specified Tenant to to the specified service.

**Request Data**  

**URL Parameters**

{parameters provided within the url}

**Data Parameters**


|Parameter Name|Parameter Type|Is Required|
|:-------------|:-------------|:----------|
|domainId|xs:string|true|
|tenantId|xs:string|true|
|serviceName|xs:string|true|
|regionCode|xs:string|false|
|tenantName|xs:string|true|
|dryrun|xs:string|false|


JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/activateservice HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"Object Storage",
          "regionCode":"az1:east:us",
          "domainId":"01234567890123",
          "tenantName":"Tenant1"
        }
      }
    }

    POST http://host:port/v2.0/HP-IDM/v1.0/action/activateservice HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"Compute",
          "regionCode":"az1:east:us",
          "domainId":"01234567890123",
          "tenantId":"12345678901234"
        }
      }
    }

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:--------|:---------------|:-----------|
|FindOrCreateUmsTenant|Create a new or retrieve an existing Tenant from the UMS based on the tenantName of the Tenant, *OR* retrieve an existing Tenant from the UMS based on the tenantId of the Tenant.|false|
|CreateZuoraSubscription|Create Zuora subscriptions for a service that is being activated.|false|
|ProvisionService|Provision the tenant to specified external service.Currently, the tenant is only provisioned to Object Storage (Swift). Other services do not require any provisioning actions beyond the CS DB.|false|
|CreateEndpointRef|Create an EndpointRef that links an endpoint via an EndpointTemplate to a Tenant.The EndpointRef that links the tenant to the endpoint is created if it does not exist in the CS DB|false|
|AssociateRoles|Assign service activation roles to a specified user and/or to a specified group|false|
|CreateProvisioningInfo|Create or update an existing ProvisioningInfo record to track a tenant's provisioned service.The ProvisioningInfo that tracks the provisioning status of this tenant with the provisioned endpoint (via serviceName and regionCode) is setup.The status of this ProvisioningInfo set to ENABLED and also the serviceAccountId field is set to the accountId (for now this is the tenantId) of the tenant.If the ProvisioningInfo exists, then it will be reused and only the status will be marked ENABLED.In the future this behavior may change since the current behavior retains the ProvisioningInfo record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|

**Notes**

1.  The tenantName must be globally unique.
2.  EITHER tenantName OR tenantId are required.
3.  If only the tenantName is provided then, if the tenant with the specified name does not exist then a new tenant will be created.
4.  If only the tenantId is provided then the tenant with the specified tenantId must exist.
5.  If both are provided then tenantId takes precedence and the net effect is the same as if only the tenantId was provided.
6.  As part of activation certain *Service Roles* assignments are made for this tenant. 

### Cancel Account ### {#cancel_account}
#### POST [HPKeystoneExtensionBaseURI]/action/cancelaccount
*Privilege Level: System Admin*  
 
*Constraints:*  

None

Mark a Domain and all connected objects are CANCELED or TERMINATED. A canceled account can later be re-enabled, but a terminated account can never be used again.

This action will also cancel subscriptions in Zuora and update status in Salesforce.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:-------------|:-------------|:----------|
|domainId|xs:string|true|
|terminate|xs:boolean|false|
|reason|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/cancelaccount HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "domainId":"44386614938865",
          "terminate":"true",
          "reason":"deadbeat"
        }
      }
    }

**Success Response**

**Status Code**

{success http status code}

**Response Data**

JSON

{json response code formatted}

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:--------|:---------------|:-----------|
|UpdateUmsDomain||false|
|UpdateKmsDomain|Update the state of a KMS Tenant to match that of its corresponding UMS Domain.|false|
|UpdateServicesForDomain||false|
|UpdateSalesforceAccount||false|
|DeactivateZuoraAccount|Update the Zuora Account that corresponds to the specified UMS Domain instance.|false|

**Notes**

None

### CreateDomain - SEVERELY DEPRECATED - TO BE REMOVED IN CONSER-4098 ### {#createdomain_-_severely_deprecated_-_to_be_removed_in_conser-4098}
#### POST [HPKeystoneExtensionBaseURI]/action/createdomain
*Privilege Level: System Admin*  
 
*Constraints:*  

1.  Domain name must be unique. _(CreateUmsDomain)_
2.  If Salesforce cannot be accessed than this Action Step will be retried at a future time. _(CreateSalesforceAccount)_

This Action is used to create a new Domain in Control Services. Once successfully created in CS, new Accounts are created in both Salesforce and Zuora which are linked to the Domain.

**Request Data**  

**URL Parameters**

TBD

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|name|xs:string|true|
|state|xs:string|false|
|addressLine1|xs:string|false|
|addressLine2|xs:string|false|
|city|xs:string|false|
|zip|xs:string|false|
|country|xs:string|false|
|phone|xs:string|false|
|company|xs:string|false|
|website|xs:string|false|
|emailAddress|xs:string|false|

JSON

TBD

**Success Response**

**Status Code**

TBD

**Response Data**

1.  The domainId for the created Domain. _(CreateUmsDomain)_
2.  KMS_TENANT holds the ID for the tenant created in KMS. _(CreateKmsDomain)_
3.  SALESFORCE_ACCOUNT will contain the Salesforce Account ID. _(CreateSalesforceAccount)_

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|CreateUmsDomain|Create a new UMS Domain object.|false|
|CreateKmsDomain|Create a new KMS Tenant corresponding to a UMS Domain.|false|
|CreateSalesforceAccount|Create a new Salesforce Account. No Salesforce Contact is created with the new Account.|true|
|CreateZuoraDomainAccount|Create a new Zuora account with no BillTo/SoldTo Contact.|true|


**Notes**

### Create Tenant {#create_tenant}
#### POST [HPKeystoneExtensionBaseURI]/action/createtenant
*Privilege Level: System Admin, Domain Admin*  
 
*Constraints:*  

1.  Tenant Name must be unique.
2.  If Zuora cannot be accessed than this Action Step will be retried at a future time.

This Action is used to create a new Tenant for an existing Domain in Control Services. Once successfully created in CS, a new Account is created in Zuora which is linked to the Tenant. Later, when the tenant activates services, the corresponding Zuora Account will subscribe to products in order to support customer billing.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|tenantName|xs:string|true|
|domainId|xs:string|true|
|description|xs:string|false|
|homeRegion|xs:string|false|

JSON

TBD

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**


#### Region Resolution ####
{{PRIVATE}} If homeRegion is specified in input data, then CS tenant is created in specified homeRegion. If home region is not specified in input data, then CS tenant is created in same region where tenant's domain region. Currently we are not propagating region to zuora side.

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|CreateUmsTenant|Create a new UMS Tenant object.|false|
|CreateZuoraTenantAccount|Create a Zuora Account that is a child of the Domain Account|true|

**Notes**

### CreateUser ### {#createuser}
#### POST [HPKeystoneExtensionBaseURI]/action/createuser
*Privilege Level: System Admin*

First, create a new User within the specified Domain in Control Services, and create accesskeys for the User. Next, create a new Contact for this user in Salesforce beneath the Salesforce Account of the Domain. Finally, if there is not already a Zuora Contact, then create one based on the user info.

In order to support MC IP address validation there are two additional parameters. ipCheckSucceeded store a boolean value indicating whether or not the IP address of the client is not blocked. ipAddress contains the actual address.


#### Validation Modes ####

**Default Mode**: In this mode the user is activated immediately. If **sendWelcomeEmail**=true the email is also sent immediately.

**Email Validation Mode**: In this mode, where **emailValidationType**!=None, the user is created in a suspended state and a validation email sent. See Action Parameters for the different validation modes. If **sendWelcomeEmail**=true and **emailValidationType**!=None then the welcome email is sent on successful validation.

Note that the **EnterpriseUserEmailVerification** action must handle validations from this action.

#### PrivilegeLevel ####

**System Admin, Domain Admin**

#### Examples ####

    http://host:port/v2.0/HP-IDM/v1.0/action/createuser

#### Action Parameters ####

| Parameter Name | Parameter Type | Is Required | Default |
| :------------- | :------------- | :---------- | :------ |
| state	| xs:string 	| false 	| 	|
| password 	| xs:string 	| **true**	| 	|
| domainId	| xs:string 	| **true** 	| 	|
| addressLine1	| xs:string 	| false 	| 	|
| addressLine2	| xs:string 	| false 	| 	|
| city	| xs:string 	| false 	| 	|
| zip	| xs:string 	| false 	| 	|
| country	| xs:string 	| false 	| 	|
| phone	| xs:string 	| false 	| 	|
| company	| xs:string 	| false 	| 	|
| website	| xs:string 	| false 	| 	|
| emailAddress	| xs:string 	| false 	| 	|
| username 	| xs:string 	| **true**	| 	|
| firstName	| xs:string 	| false 	| 	|
| lastName	| xs:string 	| false 	| 	|
| ipAddress	| xs:string 	| false 	| 	|
| promoCode	| xs:string	| false	| 	|
| partnerCode	| xs:string	| false	| 	|
| riskScore	| xs:int 	| false 	| 	| 
| phoneInBillingLocation	| xs:string 	| false 	| 	|
| ipBillingDistance	| xs:int 	| false 	| 	|
| ipCity	| xs:string 	| false 	| 	|
| ipRegion	| xs:string 	| false 	| 	|
| ipCountry	| xs:string 	| false 	| 	|
| anonymousProxy	| xs:boolean 	| false 	| 	|
| proxyScore	| xs:int 	| false 	| 	|
| transparentProxy	| xs:boolean 	| false 	| 	|
| corporateProxy	| xs:boolean 	| false 	| 	|
| highRiskCountry	| xs:boolean 	| false 	| 	|
| highRiskEmail	| xs:boolean 	| false 	| 	|
| sendWelcomeEmail 	| xs:boolean 	| false	| false	|
| emailValidationType 	| xs:string 	| false 	| None	|
| homeRegion	| xs:string 	| false 	| 	|

**emailValidationType Values**

| Value	| Effect 	|
| ------	| --------	|
| None 	| Perform no email validation. 	|
| EmailVerification 	| Send verification email with a link that activates the user.	|
| EmailVerificationWithPwdCollection 	| Send verification email with a link that activates the user and capture a password .	|

#### Action Steps ####

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| CreateUmsUser 	| Create a new UMS User object. 	| false 	|
| CreateKmsUser 	| Create a new KMS User Account corresponding to a UMS User. 	| false 	|
| CreateKmsUserKeys 	| Create a set of KMS Keys for the specified UMS User. 	| false 	|
| CreateSalesforceContact 	| Create a new or locate an existing Salesforce Contact. 	| **true** 	|
| CreateZuoraContact 	| Create a new Contact in Zuora only if there is not one already. 	| **true** 	|

#### Constraints ####

1. The UMS User and the User's Domain must be enabled. _(CreateKmsUserKeys)_
1. If Salesforce cannot be accessed than this Action Step will be retried at a future time. _(CreateSalesforceContact)_
1. If Zuora cannot be accessed than this Action Step will be retried at a future time. _(CreateZuoraContact)_

#### JobTicket Results ####

1. KMS_USER holds the ID for the UserAccount created in the KMS. _(CreateKmsUser)_
1. KMS_USER_KEY holds the ID for the UserAccessKeys created in KMS. _(CreateKmsUserKeys)_
1. SALESFORCE_CONTACT will contain the Salesforce Contact ID. _(CreateSalesforceContact)_
1. ZUORA_DOMAIN_ACCOUNT will contain the Zuora Account ID. _(CreateZuoraContact)_

#### Region Resolution ####
{{PRIVATE}} If homeRegion is specified in input data, then CS user, authz user grants, group refs are created in specified homeRegion. If home region is not specified in input data, then CS user and related entities are created in same region as domain's region. All user related authz grants, group ref are created in new user's region. The created user's geoRegion is passed to KMS steps (CreateKmsUser,  CreateKmsUserKeys) which is going to create related KMS entities in user's geoRegion. Currently we are not propagating region to salesforce and zuora side.

#### Email Integration ####

After submission of an email a **CtrlSvcsContactActivity** Salesforce object is created with **ActvityType** set to a value from the table below.

| Templates Used	| CtrlSvcsContactActivity Type 	|
| -------------- 	| ----------------------------- 	|
| WELCOME_TO_CLOUD_EMAIL_ID 	| WelcomeEmailSent	|
| EMAIL_ENTERPRISE_VERIFICATION_EMAIL_ID 	| EmailVerifEmailSent	|
| EMAIL_ENTERPRISE_VERIFICATION_WITH_PWD_COLLECT_EMAIL_ID 	| EntVerifEmailWithPwdCollectSent	|

Email messages are stored in the database. The email template is stored under the template name. Before being sent each email is processed by replacing text of the for %keyword% with a specific value. Replacement values available in the welcome email are listed in the following table.

| Email Text 	| Replaced With 	|
| ---------- 	| -------------- 	|
| %accountId% 	| user.accountId 	|
| %username% 	| user.username 	|
| %firstName% 	| user.firstName 	|
| %lastName% 	| user.lastName 	|
| %addressLine1% 	| user.addressLine1 	|
| %addressLine2% 	| user.addressLine2 	|
| %city% 	| user.city 	|
| %state% 	| user.state 	|
| %zip% 	| user.zip 	|
| %country% 	| user.country 	|
| %phone% 	| user.phone 	|
| %company% 	| user.company 	|
| %website% 	| user.website 	|
| %emailAddress% 	| user.emailAddress 	|
| %ResetToken%	| user.nonce	|

### DeactivateBlockStorage ### {#deactivateblockstorage}
#### POST [HPKeystoneExtensionBaseURI]/action/deactivateblockstorage
*Privilege Level: System Administrators, Domain Administrators*  
 
*Constraints:*  

1.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
2.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteEndpointRef)_
3.  serviceName must resolve to a RegisteredService object _(UnassociateRoles)_
4.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteProvisioningInfo)_

Deactivate specified Tenant from Block Storage service.

**Request Data**  

**URL Parameters**

{parameters provided within the url}

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|serviceName|xs:string|true|
|domainId|xs:string|false|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateblockstorage HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"block-storage",
          "regionCode":"az1:east:us",
          "tenantName":"Tenant1"
        }
      }
    }

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning.Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action.The `ITLSessionContext` associated with the incoming request thread is used for authorization checks.|false|
|DeleteEndpointRef|Remove an `EndpointRef` tthat links an endpoint via an `EndpointTemplate` to a Tenant.The `EndpointRef` that links the tenant to the endpoint is deleted if it exists from the CS DB|false|
|UnassociateRoles|Remove assigned service activation roles from a specified user and/or from a specified group|false|
|DeleteProvisioningInfo|Update an existing `ProvisioningInfo` record to `DELETED` status to mark a tenant's removal from a previously provisioned service.In the future this behavior may change since the current behavior retains the `ProvisioningInfo` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|


**Notes**

1.  `tenantName` must resolve to an existing tenant, and *{_}must not{_}* be provisioned for `Compute` service in the same region.
`domainId` is neither required nor used.
2.  As part of deactivation the `Domain Administrators` group for the domain of the Tenant is removed from the role `volume-manager` for this tenant.

### DeactivateCdn ### {#deactivatecdn}
#### POST [HPKeystoneExtensionBaseURI]/action/deactivatecdn
*Privilege Level: System Administrators, Domain Administrators*  
 
*Constraints:*  

1.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
2.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteEndpointRef)_
3.  serviceName must resolve to a RegisteredService object _(UnassociateRoles)_
4.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteProvisioningInfo)_

Deactivate the specified Tenant from CDN service.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|serviceName|xs:string|true|
|domainId|xs:string|false|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivatecdn HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"cdn",
          "regionCode":"az1:east:us",
          "tenantName":"Tenant1"
        }
      }
    }

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning.Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action.The `ITLSessionContext` associated with the incoming request thread is used for authorization checks.|false|
|DeleteEndpointRef|Remove an `EndpointRef` tthat links an endpoint via an `EndpointTemplate` to a Tenant.The `EndpointRef` that links the tenant to the endpoint is deleted if it exists from the CS DB|false|
|UnassociateRoles|Remove assigned service activation roles from a specified user and/or from a specified group|false|
|DeleteProvisioningInfo|Update an existing `ProvisioningInfo` record to `DELETED` status to mark a tenant's removal from a previously provisioned service.In the future this behavior may change since the current behavior retains the `ProvisioningInfo` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|

**Notes**

1.  `tenantName` must resolve to an existing tenant.
2.  `domainId` is neither required nor used.
3.  As part of deactivation the `Domain Administrators` group for the domain of the Tenant is removed from the role `cdn-admin` for this tenant.

### DeactivateCompute ### {#deactivatecompute}
#### POST [HPKeystoneExtensionBaseURI]/action/{action path}
*Privilege Level: System Administrators, Domain Administrators*  
 
*Constraints:*  

1.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
2.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteEndpointRef)_
3.  serviceName must resolve to a RegisteredService object _(UnassociateRoles)_
4.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteProvisioningInfo)_

Deactivate specified Tenant from OpenStack Compute (Nova) service.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|serviceName|xs:string|true|
|domainId|xs:string|false|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivatecompute HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"compute",
          "regionCode":"az1:east:us",
          "tenantName":"Tenant1"
        }
      }
    }

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning.Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action.The `ITLSessionContext` associated with the incoming request thread is used for authorization checks.|false|
|DeleteEndpointRef|Remove an `EndpointRef` tthat links an endpoint via an `EndpointTemplate` to a Tenant.The `EndpointRef` that links the tenant to the endpoint is deleted if it exists from the CS DB|false|
|UnassociateRoles|Remove assigned service activation roles from a specified user and/or from a specified group|false|
|DeleteProvisioningInfo|Update an existing `ProvisioningInfo` record to `DELETED` status to mark a tenant's removal from a previously provisioned service.In the future this behavior may change since the current behavior retains the `ProvisioningInfo` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|

**Notes**

1.  `tenantName` must resolve to an existing tenant.
2.  This tenant will automatically be de-provisioned  from the corresponding `Block Storage` service in the same region to which it was provisioned.
3.  `domainId` is neither required nor used.
4.  As part of deactivation the `Domain Administrators` group for the domain of the Tenant is removed from the roles `netadmin` and `volume-manager` for this tenant.

### DeactivateImageService ### {#deactivateimageservice}
#### POST [HPKeystoneExtensionBaseURI]/action/{action path}
*Privilege Level: System Administrators, Domain Administrators*  
 
*Constraints:*  

1.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
2.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteEndpointRef)_
3.  serviceName must resolve to a RegisteredService object _(UnassociateRoles)_
4.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteProvisioningInfo)_

Deactivate specified Tenant from OpenStack Image Service (Glance).

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type| Is Required|
|:----------------|:----------------|:----------------|
|domainId|xs:string|false|
|tenantId|xs:string|true|
|serviceName|xs:string|true|
|regionCode|xs:string|true|
|tenantName|xs:string|true|
|dryrun|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateimageservice HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"image-service",
          "regionCode":"az1:east:us",
          "tenantName":"Tenant1"
        }
      }
    }

    POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateimageservice HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"image-service",
          "regionCode":"az1:east:us",
          "tenantId":"12345678901234"
        }
      }
    }

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**


|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning.Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action.The `ITLSessionContext` associated with the incoming request thread is used for authorization checks.|false|
|DeactivateZuoraSubscription|Cancel Zuora subscriptions for a service that is being deactivated.|false|
|DeleteEndpointRef|Remove an `EndpointRef` tthat links an endpoint via an `EndpointTemplate` to a Tenant.The `EndpointRef` that links the tenant to the endpoint is deleted if it exists from the CS DB|false|
|UnassociateRoles|Remove assigned service activation roles from a specified user and/or from a specified group|false|
|DeleteProvisioningInfo|Update an existing `ProvisioningInfo` record to `DELETED` status to mark a tenant's removal from a previously provisioned service.In the future this behavior may change since the current behavior retains the `ProvisioningInfo` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|


**Notes**

1.  Either the `tenantName` OR `tenantId` is required and it must resolve to an existing tenant.
2.  As part of deactivation the *Service Roles* assigned at activation time are removed from the tenant. 
3.  `domainId` is neither required nor used.


### DeactivateObjectStorage ### {#deactivateobjectstorage}
#### POST [HPKeystoneExtensionBaseURI]/action/deactivateobjectstorage
*Privilege Level: System Administrators, Domain Administrators*  
 
*Constraints:*  

1.  serviceName parameter must be valid _(AuthorizeProvisioningAction)_
2.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteEndpointRef)_
3.  serviceName must resolve to a RegisteredService object _(UnassociateRoles)_
4.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteProvisioningInfo)_

Deactivate specified Tenant from OpenStack Object Storage (Swift) service.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|serviceName|xs:string|true|
|domainId|xs:string|false|
|tenantName|xs:string|true|
|regionCode|xs:string|true|
|dryrun|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateobjectstorage HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"object-storage",
          "regionCode":"az1:east:us",
          "tenantName":"Tenant1"
        }
      }
    }

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|AuthorizeProvisioningAction|Perform authorization checks prior to provisioning.Essentially validate that the user attempting to provision the tenant is actually authorized to perform this action.The `ITLSessionContext` associated with the incoming request thread is used for authorization checks.|false|
|DeleteEndpointRef|Remove an `EndpointRef` tthat links an endpoint via an `EndpointTemplate` to a Tenant.The `EndpointRef` that links the tenant to the endpoint is deleted if it exists from the CS DB|false|
|UnassociateRoles|Remove assigned service activation roles from a specified user and/or from a specified group|false|
|DeleteProvisioningInfo|Update an existing `ProvisioningInfo` record to `DELETED` status to mark a tenant's removal from a previously provisioned service.In the future this behavior may change since the current behavior retains the `ProvisioningInfo` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|


**Notes**

1.  `tenantName` must resolve to an existing tenant.
2.  As part of deactivation the `Domain Administrators` group for the domain of the Tenant is removed from the role `admin` for this tenant.
3.  `domainId` is neither required nor used.

### DeactivateService ### {#deactivateservice}
#### POST [HPKeystoneExtensionBaseURI]/action/deactivateservice
*Privilege Level: System Administrators, Domain Administrators*  
 
*Constraints:*  

1.  If a `tenantId` is provided, then a tenant with the specified `tenantId` must exist. In this case, the `tenantName` is ignored. _(FindUmsTenant)_
2.  A service endpoint can be subscribed to only once by the same tenant. _(FindUmsTenant)_
3.  The `tenantId` must be available (the UMS tenant must exist) at the time this is called. _(DeprovisionService)_
4.  Service specific errors may be returned. _(DeprovisionService)_
5.  `Block Storage` deactivation: Tenant being activated _must not_ have an active subscription to `Compute` service in the same region. _(DeprovisionService)_
6.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteEndpointRef)_
7.  serviceName must resolve to a RegisteredService object _(UnassociateRoles)_
8.  `serviceName` and `regionCode` parameters must be valid and must resolve a unique `EndpointTemplate` _(DeleteProvisioningInfo)_


Deactivate specified Tenant from the specified service.

**Request Data**  

**URL Parameters**

None

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------------------|:----------------------------|:-------------------------|
|tenantId|xs:string|true|
|serviceName|xs:string|true|
|regionCode|xs:string|false|
|tenantName|xs:string|true|
|dryrun|xs:string|false|

JSON

    POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateservice HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"Block Storage",
          "regionCode":"az1:east:us",
          "tenantName":"Tenant1"
        }
      }
    }

    POST http://host:port/v2.0/HP-IDM/v1.0/action/deactivateservice HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 512
    
    { "JobTicket" :
      { "actionParams" : {
          "serviceName":"CDN",
          "regionCode":"az1:east:us",
          "tenantId":"12345678901234"
        }
      }
    }

**Success Response**

**Status Code**

TBD

**Response Data**

JSON

TBD

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

`UMS_TENANT` holds the tenantId for the new or existing Tenant. _(FindUmsTenant)_

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:-----------------------|:------------------------------|:--------------------------|
|FindUmsTenant|Retrieve an existing Tenant from the UMS based on the `tenantId` or the `tenantName` of the Tenant.|false|
|DeactivateZuoraSubscription|Cancel Zuora subscriptions for a service that is being deactivated.|false|
|DeprovisionService|Deprovision the tenant to specified external service.Currently, the tenant is only deprovisioned from Object Storage (Swift). Other services do not require any provisioning actions beyond the CS DB.Note: Deprovisioning rollback from Object Storage is not supported.|false|
|DeleteEndpointRef|Remove an `EndpointRef` tthat links an endpoint via an `EndpointTemplate` to a Tenant.The `EndpointRef` that links the tenant to the endpoint is deleted if it exists from the CS DB|false|
|UnassociateRoles|Remove assigned service activation roles from a specified user and/or from a specified group|false|
|DeleteProvisioningInfo|Update an existing `ProvisioningInfo` record to `DELETED` status to mark a tenant's removal from a previously provisioned service.In the future this behavior may change since the current behavior retains the `ProvisioningInfo` record of a 'Deprovisioned' tenantsince provisioning history has not been implemented yet.|false|


**Notes**

1.  Either the `tenantName` OR `tenantId` is required and it must resolve to an existing tenant.
2.  As part of deactivation the *Service Roles* assigned at activation time are removed from the tenant.
3.  `domainId` is neither required nor used.

### DevexMigration ### {#devexmigration}
#### POST [HPKeystoneExtensionBaseURI]/action/NOT DOCUMENTED
*Privilege Level: System Administrator*  
 
*Constraints:*  

1. TBD

Description TO BE PROVIDED

**Request Data**  

**URL Parameters**

TBD

**Data Parameters**

|Parameter Name|Parameter Type|Is Required|
|:----------------|:----------------|:----------------|
|password|xs:string|true|
|secretKey|xs:string|false|
|tenantId|xs:string|false|
|accountId|xs:string|true|
|contactId|xs:string|false|
|billingId|xs:string|false|
|emailAddress|xs:string|true|
|username|xs:string|true|
|firstName|xs:string|true|
|lastName|xs:string|true|
|salt|xs:string|true|
|swiftEndpoint|xs:string|false|
|nova1Endpoint|xs:string|false|
|nova2Endpoint|xs:string|false|
|swiftHash|xs:string|false|
|swiftAccessKeyId|xs:string|false|
|novaAccessKeyId|xs:string|false|
|dryrun|xs:string|false|

JSON

TBD

**Success Response**

**Status Code**

TBD

**Response Data**

-  UMS_USER holds the accountId for the user created in the UMS. _(CreateUmsUserAndDomain)_
-  UMS_DOMAIN holds the domainId for the domain created in the UMS. _(CreateUmsUserAndDomain)_
-  KMS_TENANT holds the ID for the tenant created in KMS. _(CreateKmsDomain)_
-  KMS_USER holds the ID for the UserAccount created in the KMS. _(CreateKmsUser)_

JSON

{json response code formatted}

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

|Step Name|Step Description|Is Retryable|
|:----------------|:----------------|:----------------|
|CreateUmsUserAndDomain|Create a new UMS User and Domain. The User will be configured as the Administrator for the new Domain.|false|
|MigrateUmsUser|No description available.|false|
|CreateKmsDomain|Create a new KMS Tenant corresponding to a UMS Domain.|false|
|CreateKmsUser|Create a new KMS User Account corresponding to a UMS User.|false|
|ImportKmsUserKeys|No description available.|false|
|MigrateSalesforceAccount|No description available.|false|
|MigrateZuoraDomainAndContact|No description available.|false|
|MigrateProvisionedServices|No description available.|false|
|EnableMigratedDomain|No description available.|false|

**Notes**

### EmailVerification ### {#emailverification}
#### Description ####

This action will be used to validate email verification nonce which was sent to the customer as part of self registration process. After successful validation of the nonce this action will activate all the entities in CS and in SF.

#### PrivilegeLevel ####

**Anonymous**

#### Examples ####

**Request:**

	{"JobTicket" :
        {"actionParams" :
            {"emailVerificationNonce":"eTA3Tzc5dUg4dktWQmtnVVp3VEpIYkdXT2xsNkwya2g0K2h6c21LODJ6cz1DZQ"}
        }
    }

**Response**

	{"JobTicket":{
		"action": "EmailVerification",
		"actionParams": {},
		"actionResults":{
			"SALESFORCE_ACCOUNT": "001Q000000W5ttYIAR",
			"UMS_USER": "80761182701046",
			"UMS_DOMAIN": "84861700411934",
			"EMAIL_VERIFY_STATUS": "COMPLETE"
			},
		"completion": "2012-08-01T20:51:15.562Z",
		"errorCategory": "",
		"errorDescription": "",
		"status": "COMPLETE",
		"stepStatus":{
			"UpdateKmsDomain": "COMPLETE",
			"UpdateSalesforceAccount": "COMPLETE",
			"ValidateEmailVerificationNonce": "COMPLETE",
			"SendWelcomeEmail": "COMPLETE",
			"ActivateUmsUserAndDomain": "COMPLETE"
			},
		"submission": "2012-08-01T20:51:13.600Z",
		"ticketId": "501996c1529528c09f16e89e"
	}

#### Action Parameters ####

| Parameter Name	| Parameter Type 	| Is Required 	|
| :--	| :--	| :- 	|
| emailVerificationNonce 	| xs:string 	| **true** 	|
| password 	| xs:string 	| false 	|

#### Action Steps ####

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| ValidateEmailVerificationNonce 	| This step will verify the nonce and it validity.	| false 	|
| ActivateUmsUserAndDomain 	| This step will enable the UMS domain and user account 	| false 	|
| UpdateKmsDomain 	| This step will update KMS user and tenant accounts 	| false 	|
| UpdateSalesforceAccount 	| This step will update the SF Account and Contact and set these to Enabled state	| false 	|
| SendWelcomeEmail 	| Send welcome email 	| false 	|

#### Constraints ####

1. The verification mode chosen in SelfRegistration dictates whether the password parameter is required, it is an error to omit the password if it's use was indicated.

#### JobTicket Results ####

1. UMS_USER holds the ID for the UserAccount updated in UMS.
1. UMS_DOMAIN holds the ID for the Domain updated in UMS.
1. SALESFORCE_ACCOUNT will contain the Salesforce Account ID.
1. EMAIL_VERIFY_STATUS will contains the verification status.

### EnterpriseUserEmailVerification ### {#enterpriseuseremailverification}

#### Description ####

This action is used to validate and activate users created with the **CreateUser** action. After successful validation of the nonce this action will activate all the entities in CS and in SF.

See **CreateUser** action for email integration information. 

#### PrivilegeLevel ####

**Anonymous**

#### Examples ####

**Request:**

	{"JobTicket" :
        {"actionParams" :
            {"emailVerificationNonce":"eTA3Tzc5dUg4dktWQmtnVVp3VEpIYkdXT2xsNkwya2g0K2h6c21LODJ6cz1DZQ"}
        }
    }

#### Action Parameters ####

| Parameter Name	| Parameter Type 	| Is Required 	|
| :--	| :--	| :- 	|
| emailVerificationNonce 	| xs:string 	| **true** 	|
| password 	| xs:string 	| false 	|

#### Action Steps ####

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| ValidateEmailVerificationNonce 	| This step will verify the nonce and it validity.	| false 	|
| ActivateUmsUser	| This step will enable the UMS domain and user account 	| false 	|
| UpdateKmsUser 	| This step will update KMS user and tenant accounts 	| false 	|
| UpdateSalesforceAccount 	| This step will update the SF Account and Contact and set these to Enabled state	| false 	|
| SendWelcomeEmail 	| Send welcome email 	| false 	|

#### Constraints ####

1. The verification mode chosen in CreateUser dictates whether the password parameter is required, it is an error to omit the password if it's use was indicated.

#### JobTicket Results ####

1. UMS_USER holds the ID for the UserAccount updated in UMS.
1. SALESFORCE_ACCOUNT will contain the Salesforce Account ID.
1. EMAIL_VERIFY_STATUS will contains the verification status.

### ForgotPasswordReset ### {#forgotpasswordreset}
#### POST [HPKeystoneExtensionBaseURI]/action/ForgotPasswordReset
*Privilege Level: Anonymous*  
 
*Constraints:*  

None

This action causes a reset password email to be sent to the user specified by the username parameter. The nonce and passwordResetTime are set in the database and the nonce sent in a templated email to the users registered address.


**Request Data**  

**URL Parameters**

None

**Data Parameters**

| Parameter Name	| Parameter Type	| Is Required	|
| :--------------	| :--------------	| :-----------	|
| username	| xs:string	| true	|

XML

    POST http://host:port/v2.0/HP-IDM/v1.0/action/ForgotPasswordReset HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Exploder 12.3
    Host: localhost:9999
    Connection: keep-alive
    
    <JobTicket>
      <actionParams>
        <entry><key>username</key><value>demouser</value></entry>
      </actionParams>
    </JobTicket>

**Success Response**

**Status Code**

TBD

**Response Data**

No parameters are returned since the nonce is in the email and shouldn't be returned to the user by any other means.

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

TBD  

XML

TBD  

Curl Example

TBD 

**Action Steps**

| Step Name	| Step Description	| Is Retryable	|
| :---------	| :---------------	| :------------	|
| ForgotPasswordResetOnUmsUser	| Set a nonce in the UMS User and set passwordResetTime to the current time	| true	|
| SendForgotPasswordResetEmail	| Send the nonce to the user in a templated email.	| true	|

##Email Integration##

After submission of an email a **CtrlSvcsContactActivity** Salesforce object is created with **ActvityType** set to a value from the table below.

| Templates Used	| CtrlSvcsContactActivity Type 	|
| -------------- 	| ---------------------------- 	|
| PASSWORD_RESET_EMAIL_ID 	| PasswordRecoveryEmail	|

Email messages are stored in the database. The email template is stored under the template name. Before being sent each email is processed by replacing text of the for %keyword% with a specific value. Replacement values available in the welcome email are listed in the following table.

| Email Text 	| Replaced With 	|
| ---------- 	| --------------	|
| %accountId% 	| user.accountId 	|
| %username% 	| user.username 	|
| %firstName% 	| user.firstName 	|
| %lastName% 	| user.lastName 	|
| %addressLine1% 	| user.addressLine1 	|
| %addressLine2% 	| user.addressLine2 	|
| %city% 	| user.city 	|
| %state% 	| user.state 	|
| %zip% 	| user.zip 	|
| %country% 	| user.country 	|
| %phone% 	| user.phone 	|
| %company% 	| user.company 	|
| %website% 	| user.website 	|
| %emailAddress% 	| user.emailAddress 	|
| %ResetToken%	| user.nonce	|

### NocUserRegistration ### {#nocuserregistration}

#### Description ####

N/A

#### PrivilegeLevel ####

N/A

#### Examples ####

N/A

#### Action Parameters ####

| Parameter Name	| Parameter Type	| Is Required	|
| --------------	| ------------------	| -------------	|
| state 	| xs:string 	| false 	|
| password 	| xs:string 	| **true** 	|
| addressLine1 	| xs:string 	| false 	|
| addressLine2 	| xs:string 	| false 	|
| city 	| xs:string 	| false 	|
| zip 	| xs:string 	| false 	|
| country 	| xs:string 	| false 	|
| phone 	| xs:string 	| false 	|
| company 	| xs:string 	| false 	|
| website 	| xs:string 	| false 	|
| emailAddress 	| xs:string 	| false 	|
| username 	| xs:string 	| **true** 	|
| firstName 	| xs:string 	| false 	|
| lastName 	| xs:string 	| false 	|
| homeRegion 	| xs:string 	| false 	|


#### Action Steps ####
| Step Name 	| Step Description 	| Is Retryable 	|
| ---------- 	| ----------------- 	| ------------ 	|
| CreateUmsUser 	| Create a new UMS User object. 	| false 	|
| CreateKmsUser 	| Create a new KMS User Account corresponding to a UMS User. 	| false 	|
| CreateKmsUserKeys 	| Create a set of KMS Keys for the specified UMS User. 	| false 	|
| CreateSalesforceContactAndAccount 	| Create a new or a locate existing Salesforce Contact. A query is performed based on the User's email address. If an existing contact is found, then it is assumed to correspond to the UMS User. 	| false 	|

#### Constraints ####

1. The User's name and company are checked against the HP Restricted Parties List. If there is a hit then the new User and existing Domain are disabled after creation. _(CreateUmsUser)_
1. The UMS User and the User's Domain must be enabled. _(CreateKmsUserKeys)_
1. If Salesforce cannot be accessed than this Action Step will be retried at a future time. _(CreateSalesforceContactAndAccount)_


#### JobTicket Results ####

1. KMS_USER holds the ID for the UserAccount created in the KMS. _(CreateKmsUser)_
1. KMS_USER_KEY holds the ID for the UserAccessKeys created in KMS. _(CreateKmsUserKeys)_
1. SALESFORCE_CONTACT will contain the Salesforce Contact ID. _(CreateSalesforceContactAndAccount)_

#### Region Resolution ####
{{PRIVATE}} If homeRegion is specified in input data, then NOC user, authz user grants, group refs are created in specified homeRegion. If home region is not specified in input data, then CS user and related entities are created in same region as NOC domain's region. All user related authz grants, group ref are created in new user's region. The created user's geoRegion is passed to KMS steps (CreateKmsUser,  CreateKmsUserKeys) which is going to create related KMS entities in user's geoRegion. Currently we are not propagating region to salesforce side.
### PurgeDomain ### {#purgedomain}

#### Description ####

Completely remove the specified Domain from the system. Cascade removal to all subordinate Users, Tenants and Resources. Inactivate any associated accounts in Zuora and Salesforce.

#### PrivilegeLevel ####

**System Admin**

#### Examples ####

	http://host:port/v2.0/HP-IDM/v1.0/action/purgedomain

#### Action Parameters ####

| Parameter Name	| Parameter Type	| Is Required	|
| --------------	| ------------------	| -------------	|
| domainId 	| xs:string 	| **true** 	|
| dryrun 	| xs:string 	| false 	|

#### Action Steps ####
| Step Name 	| Step Description 	| Is Retryable 	|
| ---------- 	| ----------------- 	| ------------ 	|
| DeactivateZuoraAccount 	| When a domain is deleted we mark the corresponding Zuora Account as inactive by setting its state to 'Canceled' - with one Ell. 	| false 	|
| PurgeServicesForDomain 	| Find all domain tenants and attempt to purge (physically remove) all the services for every tenant by deprovisioning the tenant's services first. *Note:* Rollback is not supported. 	| false 	|
| DeleteKmsDomain 	| 	| false 	|
| DeleteUmsDomain 	| 	| false 	|

#### Constraints ####

N/A

#### JobTicket Results ####

N/A

### PurgeTenant ### {#purgetenant}

#### Description ####

Delete the specified Tenant from the UMS. Cancel all activated services and all Zuora subscriptions for the tenant.

#### PrivilegeLevel ####

**System Admin, Domain Admin**

#### Examples ####

	http://host:port/v2.0/HP-IDM/v1.0/action/purgetenant

#### Action Parameters ####

| Parameter Name	| Parameter Type	| Is Required	|
| ---------------	| ------------------	| -------------	|
| tenantId 	| xs:string 	| **true** 	|
| tenantName 	| xs:string 	| **true** 	|

**One or the other**

#### Action Steps ####
| Step Name 	| Step Description 	| Is Retryable 	|
| ---------- 	| ----------------- 	| ------------ 	|
| FindUmsTenant 	| Find the specified tenant 	| false 	|
| PurgeZuoraTenantAccount 	| Cancel all subscriptions in Zuora that are owned by this tenant. Do not remove tenant account. 	| false 	|
| PurgeServicesForTenant 	| Attempt to purge (physically remove) all the services for the tenant by de-provisioning the tenant's services first. *Note:* Rollback is not supported. 	| false 	|
| PurgeUmsTenant 	| Delete the tenant from the UMS. 	| false 	|

#### Constraints ####

1. tenantId or tenantName must be valid.

#### JobTicket Results ####

1. The tenantId for the purged Tenant.

### PurgeUser ### {#purgeuser}

#### Description ####

Completely remove the specified User from the system. Deallocate any services assigned to this user, and inactivate accounts in third party systems, such as Zuora and Salesforce.

#### PrivilegeLevel ####

N/A

#### Examples ####

	http://host:port/v2.0/HP-IDM/v1.0/action/purgeuser

#### Action Parameters ####

| Parameter Name	| Parameter Type	| Is Required	|
| -----------	| ------------------	| -------------	|
| accountId 	| xs:string 	| **true** 	|
| dryrun 	| xs:string 	| false 	|

#### Action Steps ####
| Step Name 	| Step Description 	| Is Retryable 	|
| -- 	| -- 	| -- 	|
| DeleteKmsUser 	| 	| false 	|
| DeleteUmsUser 	| 	| false 	|

#### Constraints ####

N/A

#### JobTicket Results ####

N/A
### SelfRegistration ### {#selfregistration}

#### Description ####

This action sets up a new Domain and User using minimal parameters. Keys are created for the user, and Accounts are created in both Salesforce and Zuora. In order to support MC IP address validation there are two additional parameters. ipCheckSucceeded store a boolean value indicating whether or not the IP address of the client is not blocked. ipAddress contains the actual address.

#### Validation Modes ####

**No Validation**: In this mode all the required entities (user, domain, etc....) are created in the mongodb and the Sales Force and they are set to \*enabled\* state. Welcome email will be sent to customer immediately after successful registration process.

In this mode the user is activated immediately. If **sendWelcomeEmail**=true the email is sent immediately.

**Email Validation Mode**: In this mode, where **emailValidationType**!=None, the user is created in a suspended state and a validation email sent. See Action Parameters for the different validation modes. If **sendWelcomeEmail**=true and **emailValidationType**!='None' then the welcome email is sent on successful validation.

The **emailValidationRequired** flag is retained for the time being for backward compatibility. If this flag is set then it's equivalent to an **emailValidationType** of 'EmailVerification'. If both these parameters are specified then **emailValidationType** takes precedence.

Note that the **EmailVerification** action must handle validations from this action.

**See: Self Registration & Email Validation Work Flow**

#### PrivilegeLevel ####

**Anonymous**

#### Examples ####

    POST http://host:port/v2.0/HP-IDM/v1.0/action/SelfRegistration HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	Content-Length: 512
	{"JobTicket" : {
		"actionParams" : {
			"username":"jason",
      		"password":"this4now",
      		"emailAddress":"jason@hp.com",
      		"emailValidationRequired":"true"
      		}
      	}
	}

#### Action Parameters ####

| Parameter Name	| Parameter Type 	| Is Required 	| Default 	|
| :--------------	| :--------------	| :---------- 	| :------- 	|
| state 	| xs:string 	| false 	| 	|
| password 	| xs:string 	| **true** 	| 	|
| addressLine1 	| xs:string 	| false 	| 	|
| addressLine2 	| xs:string 	| false 	| 	|
| city 	| xs:string 	| false 	| 	|
| zip 	| xs:string 	| false 	| 	|
| country 	| xs:string 	| false 	| 	|
| phone 	| xs:string 	| false 	| 	|
| company 	| xs:string 	| false 	| 	|
| website 	| xs:string 	| false 	| 	|
| emailAddress 	| xs:string 	| **true** 	| 	|
| username 	| xs:string 	| **true** 	| 	|
| firstName 	| xs:string 	| false 	| 	|
| lastName 	| xs:string 	| false 	| 	|
| ipAddress 	| xs:string 	| false 	| 	|
| promoCode 	| xs:string 	| false	| 	|
| partnerCode 	| xs:string 	| false 	| 	|
| riskScore 	| xs:int 	| false 	| 	|
| phoneInBillingLocation 	| xs:string 	| false 	| 	|
| ipBillingDistance	| xs:int 	| false 	| 	|
| ipCity 	| xs:string 	| false 	| 	|
| ipRegion 	| xs:string 	| false 	| 	|
| ipCountry 	| xs:string 	| false 	| 	|
| anonymousProxy 	| xs:boolean 	| false 	| 	|
| proxyScore 	| xs:int 	| false 	| 	|
| transparentProxy 	| xs:boolean 	| false 	| 	|
| corporateProxy 	| xs:boolean 	| false 	| 	|
| highRiskCountry 	| xs:boolean 	| false 	| 	|
| highRiskEmail 	| xs:boolean 	| false 	| 	|
| emailValidationRequired 	| xs:boolean 	| false 	| 	|
| referringUrl 	| xs:string 	| false 	| 	|
| useCase	| xs:string 	| false 	| 	|
| sendWelcomeEmail 	| xs:boolean 	| false 	| false	|
| emailValidationType 	| xs:string 	| false 	| None	|
| customerType 	| xs:string 	| false 	| Self Service 	|
| homeRegion	| xs:string 	| false 	| 	|


**emailValidationType Values**

| Value	| Effect 	|
| :--------------	| :---------------	|
| None 	| Perform no email validation. 	|
| EmailVerification 	| Send verification email with a link that activates the user.	|
| EmailVerificationWithPwdCollection 	| Send verification email with a link that activates the user and capture a password .	|

**customerType Values**

| Value	| Effect 	|
| :---------------	| :---------------	|
| Gratis Account	| 	|
| Self Service	| 	|
| HP Internal	| 	|
| Corporate	| Causes the Zuora defaultPaymentMethod to be set to "Other" and tax exemption to "No" on the Zuora account.	|

#### Action Steps ####

| Step Name 	| Step Description	| Is Retryable 	|
| :-----------	| :-----------------	| --------------	|
| CreateUmsUserAndDomain 	| Create a new UMS User and Domain. The User will be configured as the Administrator for the new Domain. 	| false 	|
| CreateKmsDomain 	| Create a new KMS Tenant corresponding to a UMS Domain. 	| false 	|
| CreateKmsUser 	| Create a new KMS User Account corresponding to a UMS User. 	| false 	|
| CreateKmsUserKeys 	| Create a set of KMS Keys for the specified UMS User. 	| false 	|
| CreateSalesforceAccount 	| Create a new Salesforce Account. No Salesforce Contact is created with the new Account. 	| false 	|
| CreateSalesforceContact 	| Create a new or a locate existing Salesforce Contact. A query is performed based on the User's email address. If an existing contact is found, then it is assumed to correspond to the UMS User. 	| false 	|
| CreateZuoraDomainAndContact 	| Create a new Account and Contact in Zuora that correspond with the given Domain and User. 	| false 	|

#### Constraints ####

1. The UMS User and the User's Domain must be enabled. _(CreateKmsUserKeys)_

#### JobTicket Results ####

1. UMS_USER holds the accountId for the user created in the UMS. _(CreateUmsUserAndDomain)_
1. UMS_DOMAIN holds the domainId for the domain created in the UMS. _CreateUmsUserAndDomain_
1. KMS_TENANT holds the ID for the tenant created in KMS. _(CreateKmsDomain)_
1. KMS_USER holds the ID for the UserAccount created in the KMS. _(CreateKmsUser)_
1. KMS_USER_KEY holds the ID for the UserAccessKeys created in KMS. _(CreateKmsUserKeys)_
1. SALESFORCE_ACCOUNT will contain the Salesforce Account ID. _(CreateSalesforceAccount)_
1. SALESFORCE_CONTACT will contain the Salesforce Contact ID. _(CreateSalesforceContact)_
1. ZUORA_DOMAIN_ACCOUNT will contain the Zuora Account ID. _(CreateZuoraDomainAndContact)_


#### Region Resolution ####
{{PRIVATE}} If homeRegion is specified in input data, then domain, user, groups, authz user grants, group refs are created in specified homeRegion. If home region is not specified in input data, then CS domain and user and related entities are created in region of CS instance where SelfRegistration action request was submitted. All user related authz grants, group ref are created in new user's region. The created user's geoRegion is passed to KMS steps (CreateKmsDomain, CreateKmsUser,  CreateKmsUserKeys) which is going to create related KMS entities in user's geoRegion. Currently we are not propagating region to salesforce and zuora side.

##Email Integration##

After submission of an email a **CtrlSvcsContactActivity** Salesforce object is created with **ActvityType** set to a value from the table below.

| Templates Used	| CtrlSvcsContactActivity Type 	|
| :--------------- 	| :---------------------------- 	|
| WELCOME_TO_CLOUD_EMAIL_ID 	| WelcomeEmailSent	|
| EMAIL_VERIFICATION_EMAIL_ID 	| VerificationEmailSent	|
| EMAIL_VERIFICATION_EMAIL_WITH_PWD_COLLECT_EMAIL_ID	| VerifEmailWithPwdCollectSent	|

Email messages are stored in the database. The email template is stored under the template name. Before being sent each email is processed by replacing text of the for %keyword% with a specific value. Replacement values available in the welcome email are listed in the following table.

| Email Text 	| Replaced With 	|
| :----------- 	| :--------------	|
| %accountId% 	| user.accountId 	|
| %username% 	| user.username 	|
| %firstName% 	| user.firstName 	|
| %lastName% 	| user.lastName 	|
| %addressLine1% 	| user.addressLine1 	|
| %addressLine2% 	| user.addressLine2 	|
| %city% 	| user.city 	|
| %state% 	| user.state 	|
| %zip% 	| user.zip 	|
| %country% 	| user.country 	|
| %phone% 	| user.phone 	|
| %company% 	| user.company 	|
| %website% 	| user.website 	|
| %emailAddress% 	| user.emailAddress 	|
| %ResetToken%	| user.nonce	|

### SvcOnBoardingUserRegistration ### {#svconboardinguserregistration}

#### Description ####

This action will create a user in system domain with required privilege to register a new service in CS infrastructure. Mostly this action would be called by NOC person using cs-manage script.

#### PrivilegeLevel ####

**Caller must have SuperAdmin or L3-plus-support role.**

#### Examples ####

#### Action Parameters ####

| Parameter Name	| Parameter Type 	| Is Required 	|
| :-------------	| :-------------	| :------------ 	|
| password 	| xs:string 	| **true**	|
| emailAddress 	| xs:string 	| **true** 	|
| username 	| xs:string 	| **true** 	|
| serviceId	| xs:string 	| **true** 	|

#### Action Steps ####

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| CheckForExistingService 	| This step will check if a service is specified serviceId already exist in system, if yes then it would not go further.	| false 	|
| CreateUmsUser 	| Create a new UMS User object. 	| false 	|
| CreateKmsUser 	| Create a new KMS User Account corresponding to a UMS User. 	| false 	|
| CreateKmsUserKeys 	| Create a set of KMS Keys for the specified UMS User. 	| false 	|
| CreateSalesforceContactAndAccount 	| Create a new or a locate existing Salesforce Contact. A query is performed based on the User's email address. If an existing contact is found, then it is assumed to correspond to the UMS User. 	| false 	|
| CreateSvcRegAuthzPolicies 	| This step would create required policy on the above created user account.	| false 	|

#### Constraints ####

1. Service with given serviceId should not exist in system, if exist there would be exception thrown.
1. The User's name and company are checked against the HP Restricted Parties List. If there is a hit then the new User and existing Domain are disabled after creation. _CreateUmsUser_
1. The UMS User and the User's Domain must be enabled. _CreateKmsUserKeys_
1. If Salesforce cannot be accessed than this Action Step will be retried at a future time. _CreateSalesforceContactAndAccount_

#### JobTicket Results ####

1. KMS_USER holds the ID for the UserAccount created in the KMS. _CreateKmsUser_
1. KMS_USER_KEY holds the ID for the UserAccessKeys created in KMS. _CreateKmsUserKeys_
1. SALESFORCE_CONTACT will contain the Salesforce Contact ID. _CreateSalesforceContactAndAccount_

### UpdateDomain ### {#updatedomain}

#### Description ####

Update the properties of the specified Domain. Property changes are propagated to all internal (UMS, KMS) and external (Salesforce) services.

In addition to set simple property values, the UpdateDomain action can also set the status for a Domain.

| Status Value 	| Privilege Level 	| Description 	|
| -------------	| ---------------------	| ------------------------------ |
| ENABLED 	| SA 	| Default state to an active account 	|
| SUSPENDED_3 	| SA 	| No user in a suspended domain can log into their account. 	|
| DELETED 	| SA 	| Soft delete. Domain data is not purged. Can be re-ENABLED only by SA. 	|

#### PrivilegeLevel ####

**System Administration, Domain Administration**

#### Examples ####

	POST http://host:port/v2.0/HP-IDM/v1.0/action/updatedomain HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	Content-Length: 512
	{ "JobTicket" : {
		"actionParams" : {
      		"domainId":"44386614938865",
      		"city":"Portland",
      		"state":"Oregon"
      		"zip":"97213"
    		}
		}
	}

	POST http://host:port/v2.0/HP-IDM/v1.0/action/updatedomain HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	Content-Length: 512
	{ "JobTicket" : {
		"actionParams" : {
      		"status":"SUSPENDED_3",
    		}
		}
	}

#### Action Parameters ####

| Parameter Name	| Parameter Type 	| Is Required 	|
| :--------------------- | :------------- | :------------- |
| name 	| xs:string 	| false 	|
| state 	| xs:string 	| false 	|
| status 	| xs:string 	| false 	|
| domainId 	| xs:string 	| **true** 	|
| addressLine1 	| xs:string 	| false 	|
| addressLine2 	| xs:string 	| false 	|
| city 	| xs:string 	| false 	|
| zip 	| xs:string 	| false 	|
| country 	| xs:string 	| false 	|
| phone 	| xs:string 	| false 	|
| company 	| xs:string 	| false 	|
| website 	| xs:string 	| false 	|
| emailAddress 	| xs:string 	| false 	|
| homeRegion 	| xs:string 	| false 	|

#### Action Steps ####

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------------------------------- | -------------	|
| UpdateUmsDomain 	| 	| false 	|
| UpdateKmsDomain 	| Update the state of a KMS Tenant to match that of its corresponding UMS Domain. 	| false 	|
| UpdateSalesforceAccount 	| 	| false 	|
| UpdateZuoraAccount 	| Update the Zuora Account that corresponds to the specified UMS Domain instance. 	| true 	|

#### Constraints ####

N/A

#### JobTicket Results ####

1. Following execution the KMS Tenant ID will be stored in the KMS_TENANT field. _(UpdateKmsDomain)_
1. ZUORA_DOMAIN_ACCOUNT is set with the Zuora AccountID for the corresponding Domain instance. _(UpdateZuoraAccount)_

### UpdateTenant ### {#updatetenant}

#### Description ####

Change the name and/or description for an existing Tenant in both UMS and Zuora.

#### PrivilegeLevel ####

**System Admin, Domain Admin**

#### Examples ####

	http://host:port/v2.0/HP-IDM/v1.0/action/updatetenant

#### Action Parameters ####

| Parameter Name	| Parameter Type	| Is Required	|
| ---------------	| ------------------	| -------------	|
| tenantId 	| xs:string 	| **true** 	|
| tenantName 	| xs:string 	| false 	|
| description 	| xs:string 	| false 	|
| status 	| xs:string 	| false	|

#### Action Steps ####
| Step Name 	| Step Description 	| Is Retryable 	|
| ---------- 	| ----------------- 	| ------------ 	|
| FindUmsTenant 	| 	| 	|
| UpdateUmsTenant 	| Update the tenant's name and/or description in the UMS. 	| false 	|
| UpdateZuoraTenantAccount 	| Update the tenant's name and/or description in Zuora. 	| **true** 	|


#### Constraints ####

1. tenantId must be valid.
1. tenantName must be unique.
1. If Zuora cannot be accessed than this Action Step will be retried at a future time.

#### JobTicket Results ####

1. The tenantId for the created Tenant.
1. ZUORA_TENANT_ACCOUNT will contain the Zuora Account ID.

### UpdateUser ### {#updateuser}

#### Description ####

Update the properties of the specified User. Property changes are propagated to all internal (UMS, KMS) and external (Salesforce) services.

In addition to set simple property values, the UpdateUser action can also set the status for a User. Now, update in password value is not allowed through 'UpdateUser' action. You will need to use UMS operation for password change.

If the user modified their email address then a notification email to the old and new address.

| Status Value 	| Privilege Level 	| Description 	|
| --------------|  ------------ 	| ----------------------- 	|
| ENABLED 	| SA 	| Default state to an active user. 	|
| DISABLED 	| DA 	| Disabled users can not log into their accounts. 	|
| SUSPENDED_3 	| SA 	| Disabled users can not log into their accounts. Can be re-ENABLED only by SA. 	|
| DELETED 	| SA 	| Soft delete. User data is not purged. Can be re-ENABLED only by SA. 	|



#### PrivilegeLevel ####

**System Administration, Domain Administration, Self-Service**

#### Examples ####

	POST http://host:port/v2.0/HP-IDM/v1.0/action/updateuser HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	Content-Length: 512
	{ "JobTicket" : {
		"actionParams" : {
      		"accountId":"44386614938865",
      		"firstName":"Kermit",
      		"lastName":"Melling"
      		"emailAddress":"kermit.melling@hp.com"
    		}
    	}
    }

	POST http://host:port/v2.0/HP-IDM/v1.0/action/updateuser HTTP/1.1
	Accept: application/json
	Content-Type: application/json
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	Content-Length: 512

	{ "JobTicket" : {
		"actionParams" : {
      		"status":"DISABLED",
    		}
		}
	}

#### Action Parameters ####

| Parameter Name	| Parameter Type	| Is Required 	|
| -----------	| ------------------	| -------------	|
| state 	| xs:string 	| false 	|
| status 	| xs:string 	| false 	|
| password **DISALLOWED**	| 	| 	|
| accountId 	| xs:string 	| **true**	|
| addressLine1 	| xs:string 	| false 	|
| addressLine2 	| xs:string 	| false 	|
| city 	| xs:string 	| false 	|
| zip 	| xs:string 	| false 	|
| country 	| xs:string 	| false 	|
| phone 	| xs:string 	| false 	|
| company 	| xs:string 	| false 	|
| website 	| xs:string 	| false 	|
| emailAddress 	| xs:string 	| false 	|
| username 	| xs:string 	| false 	|
| firstName 	| xs:string 	| false 	|
| lastName 	| xs:string 	| false 	|
| ipAddress 	| xs:string 	| false 	|
| promoCode 	| xs:string 	| false	|
| partnerCode 	| xs:string 	| false	|
| riskScore 	| xs:int 	| false 	|
| phoneInBillingLocation 	| xs:string 	| false 	|
| ipBillingDistance 	| xs:int 	| false 	|
| ipCity 	| xs:string 	| false 	|
| ipRegion 	| xs:string 	| false 	|
| ipCountry 	| xs:string 	| false 	|
| anonymousProxy 	| xs:boolean 	| false 	|
| proxyScore 	| xs:int 	| false 	|
| transparentProxy 	| xs:boolean 	| false 	|
| corporateProxy 	| xs:boolean 	| false 	|
| highRiskCountry 	| xs:boolean 	| false 	|
| highRiskEmail 	| xs:boolean 	| false 	|
| homeRegion 	| xs:string 	| false 	|

#### Action Steps ####
| Step Name 	| Step Description 	| Is Retryable 	|
| -- 	| -- 	|
| UpdateUmsUser 	| Update the property values for a given User in the UMS. 	| false 	|
| UpdateKmsUser 	| Update the state of a KMS User to match that of the UMS. 	| false 	|
| UpdateSalesforceContact 	| Update the appropriate Salesforce "Contact" object to match the UMS properties. 	| true 	|
| UpdateZuoraContact 	| If the given UMS User is also a Zuora Contact, then update the corresponding Zuora Contact with all the current User properties. By default, only the Domain Admin has a corresponding Zuora Contact. 	| true 	|
| SendEmailUpdateEmails 	| If the UMS user has modified their email address then send a notification email to the old and new email address. \\ 	| true 	|

#### Constraints ####

1. The user "status" value can only be updated by the SA or DA. _UpdateUmsUser_
1. Once a KMS User and Keys is marked as deleted it cannot be reenabled. _UpdateKmsUser_
1. Action is ignored if UMS User has no BillingID. _UpdateZuoraContact_

#### JobTicket Results ####

1. Following execution the KMS User ID will be stored in the KMS_USER field. _UpdateKmsUser_
1. Following execution the SF ContactID will be stored in the SALESFORCE_CONTACT field. _UpdateSalesforceContact_
1. If the users email address was changed then **mailToOldAddress** and **mailToNewAddress** will be set to the respective addresses.

#### Email Update Email ####

If the user changes their email address then a confirmation is sent to both the old and new address. Email messages are stored in the database. The email update email is stored under the identifier **"EMAIL_UPDATED_EMAIL_ID"**. Before being sent each email is processed by replacing text of the for %<keyword>% with a specific value. Replacement values available in the welcome email are listed in the following table.

| Email Text 	| Replaced With 	|
| -- 	| -- 	|
| %accountId% 	| user.accountId 	|
| %username% 	| user.username 	|
| %firstName% 	| user.firstName 	|
| %lastName% 	| user.lastName 	|
| %addressLine1% 	| user.addressLine1 	|
| %addressLine2% 	| user.addressLine2 	|
| %city% 	| user.city 	|
| %state% 	| user.state 	|
| %zip% 	| user.zip 	|
| %country% 	| user.country 	|
| %phone% 	| user.phone 	|
| %company% 	| user.company 	|
| %website% 	| user.website 	|
| %emailAddress% 	| user.emailAddress 	|

After submission of a each email a **CtrlSvcsContactActivity** Salesforce object is created. The first with **ActvityType**="EmailUpdatedToOldAddress", the second with **ActvityType**="EmailUpdatedToNewAddress".

### UserNameRecovery ### {#usernamerecovery}

#### Description ####

This action causes an email to be sent to the user that contains a list of all usernames associated with the provided email address.

#### PrivilegeLevel ####

Anonymous

#### Examples ####

	POST http://host:port/v2.0/HP-IDM/v1.0/action/UserNameRecovery HTTP/1.1
	Accept: application/json
	Content-Type: application/xml
	User-Agent: Exploder 12.3
	Host: localhost:9999
	Connection: keep-alive
	
	<JobTicket>
		<actionParams>
			<entry><key>email</key><value>demouser@nowhere.com</value></entry>
		</actionParams>
	</JobTicket>

#### Action Parameters ####

| Parameter Name	| Parameter Type 	| Is Required 	|
| :------------	| :--------	| :------- 	|
| email 	| xs:string 	| **true** 	|

#### Action Steps ####

| Step Name 	| Step Description 	| Is Retryable 	|
| -----------	| ------------------	| -------------	|
| SendUserNameRecoveryEmail	| Send the list of usernames by email. 	| true 	|

#### Constraints ####

1. There must be at least one username associated with the provided email address, or an error will be generated.

#### JobTicket Results ####

1. No parameters are returned since the username list is in the email.

#### Email Integration ####

After submission of an email a **CtrlSvcsContactActivity** Salesforce object is created with **ActvityType** set to a value from the table below.

| Templates Used	| CtrlSvcsContactActivity Type 	|
| -------------- 	| -------------- 	|
| USERNAME_RECOVERY_EMAIL_ID 	| UserNameRecoveryEmail	|

Email messages are stored in the database. The email template is stored under the template name. Before being sent each email is processed by replacing text of the for %keyword% with a specific value. Replacement values available in the welcome email are listed in the following table.

| Email Text 	| Replaced With 	|
| -------------- 	| -------------- 	|
| %accountId% 	| user.accountId 	|
| %username% 	| user.username 	|
| %firstName% 	| user.firstName 	|
| %lastName% 	| user.lastName 	|
| %addressLine1% 	| user.addressLine1 	|
| %addressLine2% 	| user.addressLine2 	|
| %city% 	| user.city 	|
| %state% 	| user.state 	|
| %zip% 	| user.zip 	|
| %country% 	| user.country 	|
| %phone% 	| user.phone 	|
| %company% 	| user.company 	|
| %website% 	| user.website 	|
| %emailAddress% 	| user.emailAddress 	|
| %ResetToken% 	| nonce value if required 	|
| %UsersForEmailAddress% 	| The HTML formatted list of usernames (see below) 	|
| %firstName% 	| The users first name (see below)	|

If there is more than one username returned the value of *firstName* will be provided as "Cloud User" since there may be multiple options for their name.

The value of **UsersForEmailAddress** is pre-formatted HTML, since there will be a list of at least one user. To make use of this field in the template use:

	<ul>
	%UsersForEmailAddress%
	</ul>

This will expand to:

	<ul>
	<li>username1</li><li>username2</li>...
	</ul>



---

