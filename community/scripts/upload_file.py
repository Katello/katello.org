#!/usr/bin/env python2

import requests
import argparse
import sys
import hashlib

def getorganization(foremansettings, org_name):
    request_url = foremansettings.url + '/katello/api/organizations'

    r = requests.get(request_url, verify=foremansettings.verifyssl,
                     headers={'Content-Type': 'application/json'},
                     auth=foremansettings.auth)

    response = r.json()

    for result in response['results']:
        if result['name'].lower() == org_name.lower():
            return result['id']

    print "Organization not found."
    sys.exit(-1)

def getrepositories(foremansettings, org_id, repo_name):
    request_url = foremansettings.url + '/katello/api/repositories'

    r = requests.get(request_url, verify=foremansettings.verifyssl,
                     headers={'Content-Type': 'application/json'},
                     auth=foremansettings.auth,
                     params={'organization_id': org_id})

    response = r.json()

    for result in response['results']:
        if result['name'].lower() == repo_name.lower():
            return result['id']

    print "Repository not found"
    sys.exit(-1)

def getupload_id(foremansettings, repository_id):
    request_url = foremansettings.url + '/katello/api/repositories/{0}/content_uploads'.format(repository_id)

    r = requests.post(request_url,
                      verify=foremansettings.verifyssl,
                      headers={'Content-Type': 'application/json'},
                      auth=foremansettings.auth)

    return r.json()['upload_id']

def upload_package(foremansettings, repository_id, upload_id, package):
    request_url = foremansettings.url + '/katello/api/repositories/{0}/content_uploads/{1}'.format(repository_id, upload_id)

    offset = 0
    chunksize = 20*1024*1024

    print "Uploading with upload_id {0}".format(upload_id)

    with open(package, 'r') as f:
        chunk = f.read(chunksize)

        while len(chunk) > 0:
            r = requests.put(request_url,
                              verify=foremansettings.verifyssl,
                              headers={'Multipart': True,
                                       'Accept': 'application/json;version=2',
                                       'Content-Type': 'multipart/form-data' },
                              data={'offset': offset,
                                    'content': chunk },
                              auth=foremansettings.auth)

            offset += len(chunk)
            chunk = f.read(chunksize)

def import_package(foremansettings, repository_id, upload_id, package):
    request_url = foremansettings.url + '/katello/api/repositories/{0}/import_uploads'.format(repository_id)

    size = 0
    checksum = hashlib.sha256()
    with open(package, 'r') as f:
        contents = f.read()
        size = len(contents)
        checksum.update(contents)

    r = requests.put(request_url,
                      headers={'Content-Type': 'application/json'},
                      json={'uploads': [{'id': upload_id, 'size': size, 'name': package, 'checksum': checksum.hexdigest()}]},
                      verify=foremansettings.verifyssl,
                      auth=foremansettings.auth)

    print "Importing {0} returned {1}".format(upload_id, r.status_code)

def delete_upload_id(foremansettings, repository_id, upload_id=True):
    request_url = foremansettings.url + '/katello/api/repositories/{0}/content_uploads/{1}'.format(repository_id, upload_id)

    r = requests.delete(request_url,
                        verify=foremansettings.verifyssl,
                        headers={'Content-Type': 'application/json'},
                        auth=foremansettings.auth)

    print "Deleting {0} returned {1}.".format(upload_id, r.status_code)

def getargs():
    parser = argparse.ArgumentParser(description="Upload large packages to Katello repository.")

    parser.add_argument('--noverifyssl', dest='verifyssl', action='store_false',
                        default=True, help='Disable certificate check')
    parser.add_argument('--org', dest='orgname', required=True,
                        help='Organization name')
    parser.add_argument('--repo', dest='reponame', required=True,
                        help='Repository name')
    parser.add_argument('url',
                        help='Foreman host ex: https://myforemanserver.internal')
    parser.add_argument('-u', dest='user', required=True,
                        help='User for Foreman user')
    parser.add_argument('-p', dest='password', required=True,
                        help='Password for Foreman user')
    parser.add_argument('pkgname',
                        help='Package file to upload')

    return parser.parse_args()

if __name__ == '__main__':
    foremansettings = getargs()

    if foremansettings.verifyssl == False:
        requests.packages.urllib3.disable_warnings()

    orgname = foremansettings.orgname
    reponame = foremansettings.reponame
    pkgname = foremansettings.pkgname

    foremansettings.auth = (foremansettings.user, foremansettings.password)

    org_id = getorganization(foremansettings, orgname)
    repository_id = getrepositories(foremansettings, org_id, reponame)

    upload_id = getupload_id(foremansettings, repository_id)

    upload_package(foremansettings, repository_id, upload_id, pkgname)

    import_package(foremansettings, repository_id, upload_id, pkgname)

    delete_upload_id(foremansettings, repository_id, upload_id)
