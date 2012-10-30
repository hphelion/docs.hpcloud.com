---
layout: default
title: Using multiple accounts to navigate availability zones
permalink: /cli/unix/tutorial/multiple-accounts-navigate-availability-zones/
product:
  - unix-cli

---

# Unix CLI: Using multiple accounts to navigate availability zones

Although the UNIX CLi has the ability to modify your credentials directly to switch availability zones or by using the `-z` switch to specify a zone for a single operation, using the multiple accounts feature in UNIX CLI can allow you to pre-create account profiles to make switching availability zones and regions all that easier.

The UNIX CLI always references the account profile set as the *default*, and uses its setup when performing normal operations. For example:

    $ hpcloud containers

This command references the credentials and availability zones of the account profile that is currently set as *default*. 

By performing the `account <account_name>` operation, I can see that the availability zone for Object-Storage is set to **az-2.region-a.geo-1**:

    $ hpcloud account default
    zones:
      compute_availability_zone: az-2.region-a.geo-1
      storage_availability_zone: region-a.geo-1
      cdn_availability_zone: region-a.geo-1
      block_availability_zone: az-2.region-a.geo-1

So going back to my first example, `hpcloud containers` would only show containers in the availability zone **az-2.region-a.geo-1**.

So what if I have containers in other availability zones, like **az-1.region-a.geo-1**? To go further, what if I have server instances in other AZs or even other regions. It can get hard to remember what AZs your default account is tied too and can get cumbersome to constantly define the zone with each operation or manually modify your credentials.

Take this scenario: Suppose you have servers and containers/objects in AZ1 in both region-a (west) and region-b (east) and you want to easily navigate and send commands to each. A solution is to create two account profiles, one with availability zones pointed to region-a, and the other pointed to region-b. Here are the steps:

1. Use the `account:copy` command to create a new account profile using the *default* account as the source. Lets called this profile *acct_regiona*:

		$ hpcloud account:copy default acct_regiona
        Account 'default' copied to 'acct_regiona'

2. Use the `account:edit` command to modify the availability zones for the profile, setting them to **az-1.region-a.geo-1**. Only the zones need to be modified. The Access_Key, Secret_Key and Tenant_ID would remain the same.

		$ hpcloud account:edit acct_regiona

3. Repeat steps #1 and #2, but create a new profile called *acct_regionb* and set the zones to **az-1.region-b-geo-1**.

Now you can do one simple command to switch between regions easily. When you need to work in regiona, simply copy the profile to the *default* by using the `account:use` command

	$ hpcloud account:use acct_regiona
	Account 'acct_regiona' copied to 'default'

This one command now makes all commands that don't reference a specific zone or account to point to **az-1.region-a-geo-1**. So now when I perform `hpcloud containers`, I know I'm pointing to the correct region, **az-1.region-a-geo-1**.

Need to switch regions? Just repeat the above command and select your regionb account:

	$ hpcloud account:use acct_regionb
	Account 'acct_regionb' copied to 'default'

It's that simple. 

The real power of this method comes in writing shell scripts with the CLI. You now can perform similar actions on both regions by only pre-cursing the set of operations with the `account:use` command, making writing shell scripts much less confusing and allowing lots of reusability.

You can also extend this technique to create profiles for specific availability zone and region combinations.

See our entire list of [UNIX CLI documentation](https://docs.hpcloud.com/cli/unix) for more info.
	


	







    
  