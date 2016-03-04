---
layout: documentation
title: FAQ
sidebar: sidebars/troubleshooting.html
---

# Frequently Asked Questions

### Can I use pulp-admin with Katello?

We do not encourage the use of pulp-admin because it has the potential to get data out of sync. However, pulp-admin can be useful when troubleshooting Katello.

1.  Install needed packages

    ```
    yum install -y pulp-admin-client pulp-rpm-admin-extensions
    ```
1.  Edit /etc/pulp/admin/admin.conf
1.  Uncomment the 'host:' line and add your server's hostname: 

    ```
    host: katello-hostname.example.com
    ```
1.  Run `grep default_password /etc/pulp/server.conf` to lookup the admin password

    ```
    #$ sudo grep default_password /etc/pulp/server.conf
    # default_password: default password for admin when it is first created; this
    default_password: rGox3G9QhfCRD8fTsNR7FxqdgbvfJfSJ
    ```
1.  Use pulp-admin by specifying the admin username and password:

    ```
    pulp-admin -u admin -p rGox3G9QhfCRD8fTsNR7FxqdgbvfJfSJ repo list
    ```

#### Using pulp-admin without password #####

Using the 'pulp-admin login' command does not function and is not supported with Katello in an attempt to limit access to the certificate authoriity generated at installation time.

Katello 3.0 generates a client cert at installation time which allows usage of pulp-admin without specifying the username and password.  To use this:

1.  mkdir ~/.pulp/
1.  Copy the public client cert and private key to a file together:

    ```
    # sudo cat /etc/pki/katello/certs/pulp-client.crt /etc/pki/katello/private/pulp-client.key > ~/.pulp/user-cert.pem
   ```
1.  Run pulp-admin without username and password:

    ```
    pulp-admin repo list
    ```

### How can I sync a repository like Katello does directly from the console?

Sometimes you want to debug why a synchronization of a repository from Katello is failing and rather than dig through log files and error messages it can often be easier to try to sync the repo with the ''grinder'' tool which is what Katello uses to download repositories.  The tool can be ran from a terminal on your Katello server:

```
$ grinder yum --label=sync-test --url=http://fedorapeople.org/groups/katello/releases/yum/1.0/RHEL/6Server/x86_64/
grinder.RepoFetch: INFO     fetchYumRepo() repo_label = sync-test, repo_url = 
http://fedorapeople.org/groups/katello/releases/yum/1.0/RHEL/6Server/x86_64/, basepath = ./, verify_options = {}
grinder.RepoFetch: INFO     sync-test, http://fedorapeople.org/groups/katello/releases/yum/1.0/RHEL/6Server/x86_64/, 
Calling RepoFetch with: cacert=<None>, clicert=<None>, clikey=<None>, proxy_url=<None>, proxy_port=<3128>, proxy_user=<None>, 
proxy_pass=<NOT_LOGGED>, sslverify=<1>, max_speed=<None>, verify_options=<{}>, filter=<None>
....
grinder.ParallelFetch: INFO     5 threads are active. 8 items left to be fetched
grinder.ParallelFetch: INFO     4 threads are active. 4 items left to be fetched
grinder.ParallelFetch: INFO     WorkerThread deleting ActiveObject
grinder.ParallelFetch: INFO     Thread ending
grinder.ParallelFetch: INFO     3 threads are active. 3 items left to be fetched
grinder.ParallelFetch: INFO     WorkerThread deleting ActiveObject
grinder.ParallelFetch: INFO     Thread ending
```

You now have a directory called sync-test off of your current working directory:

```
$ ls sync-test/
converge-ui-devel-0.8.3-1.el6.noarch.rpm
elasticsearch-0.18.4-13.el6.noarch.rpm
katello-1.0.6-1.el6.noarch.rpm
katello-agent-1.0.6-1.el6.noarch.rpm
katello-all-1.0.6-1.el6.noarch.rpm
katello-certs-tools-1.1.7-1.el6.noarch.rpm
lucene3-contrib-3.4.0-2.el6.noarch.rpm
repodata
rubygem-actionmailer-3.0.10-3.el6.noarch.rpm
...

```
