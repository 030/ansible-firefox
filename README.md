ansible role firefox
====================

[![Build Status](https://travis-ci.org/030/ansible-firefox.svg?branch=master)](https://travis-ci.org/030/ansible-firefox)
[![Ansible Galaxy](https://img.shields.io/ansible/role/29226.svg)](https://galaxy.ansible.com/030/ansible_firefox)

Install the latest [Firefox](https://www.mozilla.org/en-US/firefox/).

Troubleshooting
---------------

Add the following code to the tasks/main.yml in order to debug some variables.

```
- debug:
    msg: "{{ firefox_latest_version_info_url }} {{ firefox_latest_version_info }} {{ firefox_version_latest }} {{ firefox_checksum_latest }}"
```

Requirements
------------

None.

Role Variables
--------------

In order to create a desktop icon:

```
firefox_desktop_icon: true
```

By default, the latest Firefox will be installed. In order to install a
specific version, one could define a specific version:

```
firefox_version: 57.0.2
```

[The checksum of the to be downloaded version](https://ftp.mozilla.org/pub/firefox/releases/57.0.2/SHA512SUMS
) has to be defined:

```
firefox_checksum: sha512:b696fe306e84927407f0c216fb8672beb33c7bf000abf6e390df52f8eeae9373d2764c6ec9678302f57fae34f7fdfb986577823528a48ee2972e13c8970382ca
```

Search for `linux-x86_64/en-US/firefox-`

The directory where firefox will be deployed could be overwritten:

```
firefox_home: /opt/firefox-{{ firefox_version }}
```

Dependencies
------------

None.

Example Playbook
----------------

    - hosts: servers
      roles:
         - role: 030.ansible_firefox

License
-------

MIT / BSD

Author Information
------------------

This role was created by [030](https://stackexchange.com/users/3302040/030) in 2017.
