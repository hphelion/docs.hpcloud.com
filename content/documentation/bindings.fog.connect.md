---
layout: default
title: "Connecting to the HP Cloud Service"
permalink: /bindings/fog/connect/
product: fog

---
#Ruby Fog Bindings: Connecting to the HP Cloud Service

This page gives you details on how to connect to the HP Cloud service and contains the following sections:

* [Initial Connection](#InitialConnection)
* [Supplying Your Credentials](#SupplyingyourCredentials)
<!--* [Using the Owner Account to Grant Access](#UsingtheOwnerAccounttoGrantAccess)
* [Setting Up the Connection for the User Account](#SettingUptheConnectionfortheUserAccount)-->
* [Availability Zones](#AvailabilityZones)
* [Optional Parameters](#OptionalParameters)

##Initial Connection## {#InitialConnection}

To connect to the HP Cloud Service, follow these steps:

1. Enter IRB

        irb

2. Require the Fog library

        require 'fog'

3. Establish a connection to the desired HP Cloud service

        conn = Fog::<SERVICE-NAME>.new(
               :provider      => "HP",
               :hp_account_id  => "<your_ACCESS_KEY>",
               :hp_secret_key => "<your_SECRET_KEY>",
               :hp_auth_uri   => "<IDENTITY_ENDPOINT_URL>",
               :hp_tenant_id => "<your_TENANT_ID>",
               :hp_avl_zone => "<your_AVAILABILITY_ZONE>")

Where `Service-Name` can be [Compute](/bindings/fog/compute), [Storage](/bindings/fog/object-storage), [CDN](/bindings/fog/cdn), or [BlockStorage](/bindings/fog/block-storage).  You can find the values by clicking the [`API Keys`](https://console.hpcloud.com/account/api_keys) button in the [Console Dashboard](https://console.hpcloud.com/dashboard).

<!--[[{"type":"media","view_mode":"media_large","fid":"141","attributes":{}}]]
insert screen shot here-->

<!--##Using the Owner Account to Grant Access## {#UsingtheOwnerAccounttoGrantAccess}

You can use the owner account to grant access.  To set up the connections for the owner account:

    conn = Fog::Storage.new( 
           :provider => 'HP', 
           :hp_auth_uri => "https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/tokens", 
           :hp_account_id => "11111111", :hp_secret_key => "xxxxxx", 
           :hp_tenant_id => "12121212", 
           :hp_avl_zone => "region-a.geo-1", 
           :connection_options => {:ssl_verify_peer => false})

To grant access:

    mydir = conn.directories.get('rgtest2')  # Note: grant uses username. in my case it is email as my username is email address
    mydir.grant("rw", ["rupakg+fog2@gmail.com"])
    mydir.save                               # share the url for access to container
    mydir.public_url
     => "https://objects.rndd.aw1.hpcloud.net:443/v1/91545177658759/rgtest2"
     
    myfile = mydir.files.get("sample.txt")   # share the url for access to object
    myfile.public_url
     => "https://objects.rndd.aw1.hpcloud.net:443/v1/91545177658759/rgtest2/sample.txt"

##Setting Up the Connection for the User Account## {#SettingUptheConnectionfortheUserAccount}

To set up the connection for the user account:

    conn2 = Fog::Storage.new( 
            :provider => 'HP', 
            :hp_auth_uri => "https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/tokens", 
            :hp_account_id => "22222222", :hp_secret_key => "xxxxxx", 
            :hp_tenant_id => "21212121", 
            :hp_avl_zone => "region-a.geo-1", 
            :connection_options => {:ssl_verify_peer => false})-->

##Availability Zones## {#AvailabilityZones}

You cannot specify an availability zone if you have not activated it.  To activate an availability zone, go to the [Management Console dashboard](https://console.hpcloud.com/) and click the `**Activate`** button.  You are required to set an availability zone to establish a connection; there is no default availability zone value.

The current usable availability zones for the compute service:

* `az-1.region-a.geo-1`
* `az-2.region-a.geo-1`
* `az-3.region-a.geo-1`

The current usable availability zones for the storage service:

* `region-a.geo-1`
* `region-b.geo-1`

The current usable availability zones for the CDN:

* `region-a.geo-1`
* `region-b.geo-1`

The current usable availability zones for the block storage service:

* `az-1.region-a.geo-1`
* `az-2.region-a.geo-1`
* `az-3.region-a.geo-1`

##Optional Parameters## {#OptionalParameters}

This section describes the optional parameters that you can use when connecting to the HP Cloud service.

The `user_agent` parameter allows you to specify a string to pass as a `user_agent` header for the connection.  You can use this to track the caller of the operations.  You can set the `user_agent` parameter as follows:

        conn = Fog::Compute.new(
               :user_agent => "MyApp/x.x.x")

This inserts a `user_agent` string such as `hpfog/x.x.x (MyApp/x.x.x)` into the header.

In addition to the `user_agent` parameter, there are several additional parameters you can set using the `connection_options` parameter.  These options are provided by the Excon library and allow you to modify the underlying connection to a service.  These options are [Instrumentation](#Instrumentation), [Timeouts](#Timeouts), [Proxy](#Proxy), and [HTTPS/SSL](#HTTPS).

###Instrumentation### {#Instrumentation}

Use this parameter for debugging purposes.  When you use the basic parameter `Excon::StandardInstrumentor`, all events are output to `stderr`.  You can also designate your own instrumentor.  You can set the instrumentation parameter as follows:

        conn = Fog::Compute.new(
               :connection_options => {:instrumentor => Excon::StandardInstrumentor})

###Timeouts### {#Timeouts}

Use this parameter to set different timeout values.  You can set the timeouts parameter as follows:

        conn = Fog::Compute.new(
               :connection_options => {
                      :connect_timeout => <time_in_secs>, 
                      :read_timeout => <time_in_secs>, 
                      :write_timeout => <time_in_secs>})

###Proxy### {#Proxy}

Use this parameter to specify a proxy URL for both  HTTP and HTTPS connections.  You can set the proxy parameter as follows:

        conn = Fog::Compute.new(
               :connection_options => {:proxy => 'http://myproxyurl:4444'})
               
###HTTPS/SSL### {#HTTPS}

By default, peer certificates are verified when you use secure socket layer (SSL) for HTTPS.  Sometimes this does not work due to configurations in different operating systems, causing connection errors. To help avoid this, you can set  HTTPS/SSL parameters.  To set the path to the certificates:

        conn = Fog::Compute.new(
               :connection_options => {:ssl_ca_path => "/path/to/certs"})              
             
To set the path to a certificate file:

        conn = Fog::Compute.new(
               :connection_options => {:ssl_ca_file => "/path/to/certificate_file"})              

To set turn off peer verification:

        conn = Fog::Compute.new(
               :connection_options => {:ssl_verify_peer => false})              

**Note**: This makes your connection less secure.

For further information on these options, please see [the Excon documentation](http://github.com/geemus/excon).