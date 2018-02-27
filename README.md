ansible role firefox
====================

[![Build Status](https://travis-ci.org/030/ansible-firefox.svg?branch=master)](https://travis-ci.org/030/ansible-firefox)
[![Ansible Galaxy](https://img.shields.io/ansible/role/22979.svg)](https://galaxy.ansible.com/030/firefox)

Install the latest [Firefox](https://www.mozilla.org/en-US/firefox/). Please test the role before creating a Pull Request by issuing:

```
./tests/geerlingguy.test/ansible-role-test.sh
```

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

Specify what Firefox version has to be installed:

```
firefox_version: 57.0.2
```

[The checksum of the to be downloaded version](https://ftp.mozilla.org/pub/firefox/releases/57.0.2/SHA512SUMS
) has to be defined:

```
firefox_checksum: sha512:b696fe306e84927407f0c216fb8672beb33c7bf000abf6e390df52f8eeae9373d2764c6ec9678302f57fae34f7fdfb986577823528a48ee2972e13c8970382ca
```

The directory where firefox will be deployed could be overwritten:

```
firefox_home: /usr/lib64/firefox-{{ firefox_version }}
```

Dependencies
------------

None.

Example Playbook
----------------

    - hosts: servers
      roles:
         - role: 030.firefox

License
-------

MIT / BSD

Author Information
------------------

This role was created by [030](https://stackexchange.com/users/3302040/030) in 2017.
