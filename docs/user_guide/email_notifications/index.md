---
layout: documentation
title: Email Notifications
sidebar: sidebars/documentation.html
---

# Email Notifications

## Types of Email Notifications

In addition to the Email Notifications that Foreman provides:

* Puppet run summary (Daily/Weekly/Monthly)
* Puppet errors

Katello provides a few addition reports:

* Katello Host Advisory (Daily/Weekly/Monthly) - A report of all of the Errata applicable to all readable Content Hosts
* Katello Promote Errata - A report generated at Content View promotion time showing Content Hosts from the promoted view that need errata, and a summary of each erratum needed
* Katello Sync Errata - A report generated after each Repository sync listing new Errata synced and how many Content Hosts are applicable.

## Configuring the Foreman/Katello to send emails:

The configuration on how the Foreman/Katello service sends email is located in /etc/foreman/email.yaml:

```
production:
   delivery_method: :smtp
   smtp_settings:
     address: smtp.example.com
     port: 25
     domain: example.com
     authentication: :none
```

For more information see [configuration of email.yaml](http://theforeman.org/manuals/latest/index.html#3.5.2ConfigurationOptions)

## Opting in to the emails

By default a user will receive no email notifications.  Each notification must be opted into.

To opt in for your own user, at the very top right of the web interface, hover over your Username, click "My Account" and then click the "Mail Preferences" tab.

To opt in for other users, navigate to "Administer" > "Users" > Click the desired User > click the "Mail Preferences" tab.

Select which emails and frequency you would like the user to have and click "Submit".

![Editing email preferences](./user_edit.png)
