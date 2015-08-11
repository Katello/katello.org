---
layout: documentation
title: How to Release Katello
sidebar: sidebars/developer_guide.html
---

# How to Release Katello

This guide covers how to peform a community release of Katello. The guide will reference the term 'X.Y' which reprsents the major and minor version that you are releasing. Throughout the guide we will use 2.0 and 2.1 as examples to represent the currently released community version (2.0) and the version that you are working on releasing (2.1).

### Step 0: Code Name

Pick a release code name based on a style of beer previously unused. Examples from previous releases are Oktoberfest and Winter Warmer.

### Step 1: Warn Community of Branching

The first step to any release is warning the community of impending branching prior to the branch date to give them time to push on any pull requests that are pending. The email should be sent no less than 2 weeks prior to the intended branch date and ideally when Foreman sends their branching announcement.

### Step 2: Stable Pulp Build

Prior to branching the Katello repositories, the release nanny should figure out what the current stable version of Pulp is and if not already tagged and built, do so. Please see the [Upgrading Pulp Guide](http://www.katello.org/developers/upgrade_pulp.html).

### Step 3: Setup Your Environment

There are a number of repositories that will need to be tagged and branched throughout the process. We recommend organizing this before hand so that you have a common place to reference and work through these tasks within throughout the release process. Clone the following:

```
git clone https://github.com/Katello/katello
git clone https://github.com/Katello/katello-installer.git
git clone https://github.com/Katello/katello-misc
git clone https://github.com/Katello/katello-agent
git clone https://github.com/Katello/hammer-cli-katello
```

Note that some repositories contain multiple spec-files and thus packages:

```
katello
  rubygem-katello.spec
  deploy/katello.spec

katello-misc
  certs-tools/katello-certs-tools.spec
  repos/katello-repos.spec
  utils/katello-utils.spec

katello-agent
  katello-agent.spec

katello-installer
  katello-installer.spec

hammer-cli-katello
  rubygem-hammer_cli_katello.spec
```

### Step 4: Get Your Branch On

On the date and time you previously warned the community branching would occur on, do the following for each repository EXCEPT `hammer-cli-katelo`.

The first step is to create the X.Y branch. Take a moment to review the layout of each repository from Step 3. The idea with this step is to checkout the master branch for a given repository, ensure its set to the current upstream master, set a tag point for where you are going to branch for EACH spec file (aka package) that lives in a given repository and then create the branch. For example, the katello repository contains two packages (spec files) at `/` and `/deploy` (likewise, again, looking back at Step 3, katello-misc contains multiple packages):

```
cd katello
git fetch origin
git checkout master
git reset origin/master --hard
tito tag
cd deploy/
tito tag
git checkout -b KATELLO-X.Y
```

Update the releasers and tito configuration for each package (some repositories contain multiple packages, see Step 3 for list):

```
VER=X.Y sed -i "s#/katello-nightly-rhel/#/katello-$VER-rhel/#g" rel-eng/*
git commit -a -m 'Updating rel-eng for X.Y'
git push origin KATELLO-X.Y
```

Now we set master to start from the version after the one we are working on releasing X.Y+1, for each package, ensuring you are in the directory the spec file exists:

```
git checkout master
```

For any of the gems, update the gem version file and the spec file to X.Y.0 and make sure to reset the release to 1. For example,

```
vim lib/katello/version.rb
vim rubygem-katello.spec
git commit -a -m 'Version bump to X.Y.0'
```

Now for all of the repositories including the gems, tag and push the starting place for the next version:

```
tito tag --use-version=X.Y+1.0
git push origin master && git push --tags
```

For `hammer-cli-katello`:

1. If there are no changes since last version do nothing
2. If there are changes, bump the version, release the gem, tag and build in koji

Lastly, branch documentation

Now we are ready to branch the documentation. This is done separately from the other branching due to the fact that we do not tag or generate an RPM of the documentation website.

```
git clone https://github.com/Katello/katello.org
cd katello.org
git checkout -b KATELLO-X.Y
git push origin KATELLO-X.Y
```

Check that the CI job that builds the site (http://ci.theforeman.org/job/deploy_katello_site/) has been kicked off or kick it off manually if needed. Once it passes, visit [http://www.katello.org](http://www.katello.org) and check that X.Y is available from the drop down list. If it did not build correctly, you will need to checkout the `deploy` branch and test it locally.

Congratulations, you have successfully branched all of the repositories and prepared them for release. We recommend double checking each repository ensuring that the branch exists in the upstream repository, that the top of the commit stack in that branch includes the tag you created prior to branching (so that you have an initial tag point that represents the branch point) and that the tag itself exists. The last part of this step is to send to a follow up email letting the community know that everything has been branched.

### Step 5. Pin katello-installer puppet modules for release

On the katello-installer's KATELLO-X.Y branch, we need to pin the modules to a minor release.

First, we take the pinned Foreman modules in the Puppetfile from the most current release, e.g. https://github.com/theforeman/foreman-installer/blob/1.9-stable/Puppetfile.  Overwrite the Foreman section in katello-installer's Puppetfile with these locked down versions.

Next, we'll lock down the Katello modules. First, Check out all the puppet modules:

```bash
for module in candlepin certs capsule common elasticsearch gutterball katello crane service_wait pulp
do
  git clone git@github.com:Katello/puppet-${module}.git
done
```

Review the modules for releasing - we should be keeping them up to date when making incompatible changes, but do any need bumps of the major or minor version? If so, do so now.

Consider the changes that have been made to the module since the last release, do we need a new release?
Use [blacksmith](https://github.com/maestrodev/puppet-blacksmith) to push to forge.

```bash
rake module:release
```

Now, lock down Katello versions to the appropriate minor, e.g. if you release `puppet-katello 0.2.0` or the latest is 0.2.0, then in the Puppetfile

```
mod 'katello',   '>= 0.2.0 < 0.3.0'
```

### Step 6: Configure Koji

Note that to perform this step, Foreman must have generated it's Koji build targets for the targeted Foreman release. This is due to how Katello tags inherit from some Foreman tags. Coordinate with the Foreman release nanny on when they plan to do that step and wait to do this step until then. Koji needs to have configuration added specific to the tags that the release will occur under. The first step is to add new build roots and tags using the following script:

```
https://github.com/Katello/katello-misc/blob/master/rel-eng/koji_create_buildroots.sh
```

We recommend running this script in logical chunks instead of attempting to run the entire thing at once.

### Step 7: Setup Mash Scripts

In order to generate the release repositories on Koji, a mash script for the version being released needs to be added. If you do not have direct access to the koji.katello.org box, you can request access or ask someone who does to perform this step for you.

Copy previous mash script to new one

```
cp /usr/local/bin/katello-mash-split.py /usr/local/bin/katello-mash-split-2.1.py
```

Open new mash script and replace the version with the new one

```
sed -i "s#/nightly/#/2.1/#g" /usr/local/bin/katello-mash-split-2.1.py
```

Now do the same for all of the 2.0 mash files in `/etc/mash`, copying them to 2.1 files and updating the contents from 2.0 to 2.1. Finally, generate the first set of X.Y repositories on koji:

```
/usr/local/bin/katello-mash-split-2.1.py
```

The mash can be run via the release_mash_katello Jenkins job. However, the job first needs to be updated for the new version you are building by adding the Foreman and Katello versions to the configuration of the job through the Jenkins Web UI.

### Step 8: Verify Repos

At this point we want to verify the updates we made to the version branches by mashing and checking the repositories generated on koji.

```
/usr/local/bin/katello-mash-split-X.Y.py
```

View the generated repositories at `http://koji.katello.org/releases/yum/katello-X.Y` and ensure none of the packages have a git hash within the package name.

### Step 9: Build Fresh X.Y Packages

For each repository that was branched, and for each package within a given repository (e.g. katello has both the katello and rubygem-katello packages) we do a tito release koji. For example, the Katello repository:

```
cd katello/
tito release koji
cd deploy/
tito release koji
```

NOTE: This step can only be done after you have created the X.Y tags.

### Step 10: Update Repos RPM

Now we update the repos file to point at where the released version of the repositories will exist for the X.Y release. 

```
cd katello-misc/repos
export VER=X.Y
sed -i "s#/[Nn]ightly/#/$VER/#g" katello*.repo
git commit -a -m 'Updating repository URL to X.Y'
tito tag
tito release koji
/usr/local/bin/katello-mash-split-X.Y.py
```

### Step 11: Release X.Y Release Candidate RPMs

For this step we'll need to update the Jenkins job that pushes RPMs to fedorapeople and run the job. Go to `http://ci.theforeman.org/view/Katello%20Pipeline/job/release_push_rpm_katello/configure` and add X.Y to the list of RELEASE choices and save the configuration. Now head to `http://ci.theforeman.org/view/Katello%20Pipeline/job/release_push_rpm_katello/build?delay=0sec`, choose the X.Y version you just added and click `Build`. This will run a script that copies the RPMs from Koji to fedorapeople.

### Step 12: Update katello-deploy

We maintain a deployment tool, katello-deploy, for easily testing and deploying Katello versions. You'll want to clone the repository (https://github.com/Katello/katello-deploy.git) and update the following:

1. Edit the README to indicate the new version and the OSes it works with.
1. Update the foreman version matcher - https://github.com/Katello/katello-deploy/blob/master/setup.rb#L10
1. Add new boxes for X.Y - https://github.com/Katello/katello-deploy/blob/master/Vagrantfile#L28

### Step 13: Test

Use the newly updated katello-deploy to spin up an X.Y box and test for the following:

* Installation
* UI
* Repository sync and content view publish
* Can install katello-agent for el5,6, 7 from the client repo (without the need of the main katello repo enabled)
* Run a full bats test with content

### Step 14: Announce RC

Now you are ready to announce the RC by sending an email to the foreman-users and foreman-dev mailing lists pointing users at the installation instructions. You should also open a PR to `katello.org` to update the news section with an announcement of the RC release.

### Step 15: Fix Bugs

As users test the RC, they may find and file issues. In addition, the RC may have been released with issues still to be fixed. As these issues are identified and fixed, they will need to be backported. The tool_belt tooling can be used to identify issues that need cherry picking across the various repositories. See the tool belt [README](https://github.com/ehelms/tool_belt/blob/master/README.md) for information on how to setup and configure it.

### Step 16: Release!

After iterating through Step 15 a few times over the course of roughly a month, and in sync with Foreman's release date decide that you are ready to release.

```
cd katello-misc/repos
sed -i "s#/gpgcheck=0/#/gpgcheck=1/#g" katello*.repo
git commit -a -m 'Turning on GPG key checking for X.Y'
tito tag
tito release koji
```

##### Download Unsigned RPMs

Now sign the RPMs (or ask someone who can to do this part for you), mash and release. Those you can ask are lzap, mmccune, jsherrill, bkearney. 

The first step when signing is to download all of the unsigned RPMs from tags that you will be releasing. We are using the .src.rpm to decide if the build as whole is signed or not. For example, if the key was D5A88496:

```
cd some empty directory
VERSION=2.3
for j in rhel5 rhel6 rhel7 fedora20 fedora21 ; do
  for i in "katello-$VERSION-$j" "katello-$VERSION-thirdparty-candlepin-$j" "katello-$VERSION-thirdparty-pulp-$j" ; do
    koji -c ~/.koji/katello-config list-tagged --latest --quiet --inherit --sigs $i ; done \
    | sed 's!^!:!' \
    | perl -ane '$F[1] =~ s!\.src$!! or next; $R{$F[1]} = 1; $S{$F[1]} = 1 if $F[0] eq ":D5A88496";
      END { print map "$_\n", grep { not exists $S{$_} } sort keys %R }' \
    | while read i ; do koji -c ~/.koji/katello-config download-build --debuginfo $i ; 
  done;
done;
```

##### Sign the RPMs

Get (decrypt) Katello key and gpg --import it. Of course, you need to be a person who knows how to decrypt the key. Decrypt the passphrase as well. The key that we've used starting with Katello 1.0 is D5A88496. Before doing the first sign, import katello key. In our git repo with keys do this:

```
cd gpg-keys/katello-private
decrypt.sh
gpg --import katello.private.asc
cat katello-passphrase.txt
```

This passphrase will be used for signing the packages. Into ~/.rpmmacros put:

```
%signature gpg
%_gpg_name Katello
%__gpg_sign_cmd %{__gpg} \
    gpg --force-v3-sigs --digest-algo=sha1 --batch --no-verbose --no-armor \
    --passphrase-fd 3 --no-secmem-warning -u "%{_gpg_name}" \
    -sbo %{__signature_filename} %{__plaintext_filename}
```

Now run:

```
rpmsign --addsign *.rpm
```

##### Import Signatures back to Koji

This step will import only signatures, not packages.

```
koji -c ~/.koji/katello-config import-sig *.rpm
```

As list-signed does not seem to work, do a random check in ​http://koji.katello.org/packages/ that http://koji.katello.org/packages/<name>/<version>/<release>/data/sigcache/d5a88496/ exists and has some content in it.

##### Create Back Signed RPMs in Koji

```
# in that directory where you've signed the rpms
ls *.src.rpm | sed 's!\.src\.rpm$!!' | xargs koji -c ~/.koji/katello-config write-signed-rpm bc62d13f
```

Do a random check at http://koji.katello.org/packages/<name>/<version>/<release>/data/signed/d5a88496/ to see if the rpms are there. This step will import whole package.

Finally, the signed packages can be mashed and a final test of the signed RPMs performed to ensure nothng was missed. When doing a .Y release this is especially important. The X.Y branch may need some backported documentation changes. After backporting, you will need to do the following:

 * Update latest in _config.yml to X.Y
 * GA release announcement
