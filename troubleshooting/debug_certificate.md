---
layout: documentation
title: Debug Certificate
sidebar: sidebars/troubleshooting.html
---

# Debug Certificate

Debug certificates (also called Ueber Certificates) can be used to unlock all the content for a given Organization. These are meant to be used by sysadmins who are debugging issues with the Katello install.

## Generating a Debug Certificate

To generate a debug certificate for a given Organization from the UI, navigate to the organizations page and click on the organization for which you want a debug certificate. Click on the button to generate and download the certificate as highlighted below:

![Generate Debug Certificate](./debug_certificate.png)

To generate a debug certificate using the API, see [Debug Certificate API](http://www.katello.org/docs/nightly/api/apidoc/organizations.html#description-download_debug_certificate).

In either case, you will get the Private Key and Certificate returned to you in a format such as :

```
Key:  -----BEGIN RSA PRIVATE KEY-----
<<<<DER ENCODED TEXT>>>>
-----END RSA PRIVATE KEY-----

Cert: -----BEGIN CERTIFICATE-----
<<<<DER ENCODED TEXT>>>>
-----END CERTIFICATE-----
```

## Using Firefox to browse content

If you wish to use the certificate to browse content via Firefox, do the following:

 1. Copy the output of the above command from {{{-----BEGIN RSA PRIVATE KEY-----}}} to {{{-----END RSA PRIVATE KEY-----}}} inclusive to a file called key.pem
 1. Copy the output of the above command from {{{-----BEGIN CERTIFICATE-----}}} to {{{-----END CERTIFICATE-----}}} inclusive to a file called cert.pem
 1. Run the following command to create a pkcs12 file:
```
openssl pkcs12 -keypbe PBE-SHA1-3DES -certpbe PBE-SHA1-3DES -export -in cert.pem -inkey key.pem -out [NAME].pfx -name [NAME]
```
 1. Provide a password when prompted.
 1. Using the preferences tab, import the resulting pfx file into your browser (Edit->Preferences->Advanced Tab -> View Certificates -> Import)
 1. On the Katello server, edit the /etc/httpd/conf.d/pulp.conf file. Add the following line in the {{{<Directory /var/www/pub/repos>}}} Stanza:
```
    Options +Indexes
```
 1. Restart Apache on the server.
 1. Point your browser at http://[FQDN]/pulp/repos/[ORG_NAME]

To use curl to access the repository, you can provide --cert and --key options. Provided the cert is in {{{~/cert.pem}}} and key in {{{~/key.cert}}}, the following command will let you access any repository data in the organization. To check the access to a repository, checking the availability of repodata/repomd.xml is usually a good idea (make sure key.pem and cert.pem are '''absolute paths''' otherwise it silently fails):

```
curl -k --cert ~/cert.pem --key ~/key.pem https://katello.example.com/pulp/repos/test/Dev/custom/zoo/base-two/repodata/repomd.xml
```
