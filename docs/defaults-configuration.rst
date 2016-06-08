Default variables: configuration
================================

Some of the ``debops.checkmk_server`` default variables have more extensive
configuration than simple strings or lists, here you can find documentation
and examples for them.

.. contents::
   :local:
   :depth: 1

.. _checkmk_server__sshkeys:

checkmk_server__sshkeys
-----------------------

This configuration variable indicates if SSH keys should be configured for
accessing the Check_MK agent. If set to a non-empty value a additional
Check_MK host tag "Check_MK Agent via SSH" is configured and the SSH public
key is set as Ansible fact, so that it can be used by the
``debops.checkmk_agent`` role to configure SSH-based agent access. The
``checkmk_server__sshkeys`` variable is a dictionary which support the
following keys:

``generate_keypair``
  Generate a new SSH keypair for the Check_MK site user. Possible values:
  ``True`` or ``False``

``keysize``
  Specify the number of bits used when generating a new keypair. Only valid
  when ``generate_keypair`` is set to ``True``. Defaults to ``4096``.

``privatekey_file``
  Pre-generated SSH private key file which should be configured for SSH-based
  Check_MK agent access.

``publickey_file``
  Pre-generated SSH public key file. Must be the public key of the private
  key set with ``privatekey_file``.


.. _checkmk_server__multisite_users:

checkmk_server__multisite_users
-------------------------------

Configuration dictionary to define local WATO users. When running Ansible
they are merged into the :file:`users.mk` user database of Check_MK. Users
already defined in WATO or synchronized from an identity management system
such as LDAP won't be overwritten.

The dictionary key has to be the user name to create or manage. The following
properties can be set via Ansible inventory:

``alias``
  Full name, required.

``password``
  Optional. Set given password in Apache :file:`htpasswd` file. Can be used
  for form-based authentication in WATO and HTTP basic authentication in
  Icinga, PNP4Nagios and NagVis.

``automation_secret``
  Optional. Automation secret for machine accounts. Set this instead of
  ``item.password`` if the account is used for authentication of `WebAPI`_
  calls.

.. _WebAPI: https://mathias-kettner.com/checkmk_wato_webapi.html

``locked``
  Optional. Disable login to this account. Defaults to ``False``.

``roles``
  Optional. List of permission roles defined in
  :envvar:`checkmk_server__multisite_roles`. Defaults to ``[ 'user' ]``.

``force_authuser``
  Optional. Only show hosts and services the user is a contact for. Defaults
  to ``False``.

``force_authuser_webservice``
  Optional. Export only hosts and services the user is a contact for.
  Defaults to ``False``.

``start_url``
  Optional. Start URL to display in main frame. Defaults to ``dashboard.py``.


.. _checkmk_server__multisite_users_example:

Example
~~~~~~~

Create custom administrator account with random password::

    checkmk_server__multisite_users:

      bob:
        alias: 'Bob Admin'
        password: '{{ lookup("password", "credentials/check_mk/" + checkmk_server__site + "/bob/password length=15") }}'
        roles: [ 'admin' ]
