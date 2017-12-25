ansible-role-firefox
====================

[![Build Status](https://travis-ci.org/030/ansible-role-firefox.svg?branch=master)](https://travis-ci.org/030/ansible-role-firefox)

Install the latest [Firefox](https://www.mozilla.org/en-US/firefox/). Please test the role before creating a Pull Request by issuing:

```
chmod +x ./tests/geerlingguy.test/ansible-role-test.sh
./tests/geerlingguy.test/ansible-role-test.sh
```

Requirements
------------

None.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

None.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

This role was created by [030](https://stackexchange.com/users/3302040/030) in 2017.
