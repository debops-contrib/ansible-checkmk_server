Default variables: configuration
================================

.. include:: includes/all.rst

Some of the ``debops.checkmk_server`` default variables have more extensive
configuration than simple strings or lists, here you can find documentation
and examples for them.

.. contents::
   :local:
   :depth: 1


.. _checkmk_server__ref_omd_config:

checkmk_server__omd_config
--------------------------

:program:`omd` is a command line utility which is used to manage Check_MK
monitoring sites. Some basic configuration options of the site will be
set via this tool. These options are defined in
:envvar:`checkmk_server__omd_config` which is a list of YAML dictionaries,
each with two key/value pairs defining the OMD property to be set. One key
has to be ``var`` with the variable name to be set as value. The other
key has to be ``value`` with the variable value to be set as value.

See :envvar:`checkmk_server__omd_config_core` for an example.


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


.. _checkmk_server__site_packages:

checkmk_server__site_packages
-----------------------------

Check_MK has a plugin system where site customizations such as additional
checks can be installed. This is done via ``.mkp`` packages. For more
information see the upstream documentation about `Check_MK extension packages`_.

.. _Check_MK extension packages: https://mathias-kettner.com/cms_mkps.html

Packages which should be installed for the current Check_MK site are defined
as a list of YAML dictionaries with the following configuration keys. One of
``path`` or ``url`` must be given:

``name``
  Name of the package, required.

``path``
  Optional. Local file system path of the ``.mkp`` package archive on the
  Ansible controller. Cannot be combined with the ``url`` parameter.

``url``
  Optional. Download URL of the ``.mkp`` package archive. Cannot be combined
  with the ``path`` parameter.

``checksum``
  Optional. Checksum of the download archive given in the ``url`` parameter.
  Cannot be combined with the ``path`` parameter. Refer to the `Ansible get_url
  module`_ for the accepted parameter format.


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

``automation_secret``
  Optional. Automation secret for machine accounts. Set this instead of
  ``item.password`` if the account is used for authentication of `WebAPI`_
  calls.

.. _WebAPI: https://mathias-kettner.com/checkmk_wato_webapi.html

``contactgroups``
  Optional. List of contact groups the user is a member of. Defaults to ``[]``.

``disable_notifications``
  Optional. Temporarily disable all notifications for this user. Defaults to
  ``False``.

``email``
  Optional. Email address.

``force_authuser``
  Optional. Only show hosts and services the user is a contact for. Defaults
  to ``False``.

``force_authuser_webservice``
  Optional. Export only hosts and services the user is a contact for.
  Defaults to ``False``.

``host_notification_options``
  Optional. Host events which should be notified. String combined of the
  following letters:
  ``d``: Host goes down
  ``u``: Host get unreachable
  ``r``: Host goes up again
  ``f``: Start or end of flapping state
  ``s``: Start or end of a scheduled downtime
  Defaults to ``durfs``.

``locked``
  Optional. Disable login to this account. Defaults to ``False``.

``notification_method``
  Optional. Event notification method. Defaults to ``email`` (currently only
  supported method).

``notification_period``
  Optional. Notification time period. Default to ``24x7`` (currently only
  supported period).

``notifications_enabled``
  Optional. Generally enable notifications for this user. Defaults to
  ``False``.

``pager``
  Optional. Pager address.

``password``
  Optional. Set given password in Apache :file:`htpasswd` file. Can be used
  for form-based authentication in WATO and HTTP basic authentication in
  Icinga, PNP4Nagios and NagVis.

``roles``
  Optional. List of permission roles defined in
  :envvar:`checkmk_server__multisite_cfg_roles`. Defaults to ``[ 'user' ]``.

``service_notification_options``
  Optional. Service events which should be notified. String combined of the
  following letters:
  ``w``: Service goes into warning state
  ``u``: Service goes into unknown state
  ``c``: Service goes into critical state
  ``r``: Service recovers to OK
  ``f``: Start or end of flapping state
  ``s``: Start or end of a scheduled downtime
  Defaults to ``wucrfs``.

``start_url``
  Optional. Start URL to display in main frame. Defaults to ``dashboard.py``.


.. _checkmk_server__multisite_users_example:

Example
~~~~~~~

Create custom administrator account with random password::

    checkmk_server__multisite_users:

      bob:
        alias: 'Bob Admin'
        password: '{{ lookup("password", secret + "/credentials/" + ansible_fqdn + "/checkmk_server/" + checkmk_server__site + "/bob/password length=15") }}'
        roles: [ 'admin' ]


.. _checkmk_server__multisite_user_connections:

checkmk_server__multisite_user_connections
------------------------------------------

List of LDAP user synchronization connection definitions. Multiple connection
definitions are allowed. Each connection can define the following properties
via Ansible inventory:

``binddn``
  Distinguished name used for authenticating against the LDAP server, required.

``bindpw``
  Password used for authenticating against the LDAP server, required.

``server``
  LDAP server host name, required.

``group_dn``
  Base DN for LDAP group queries, required.

``userdn``
  Base DN for LDAP user queries, required.

``active_plugins``
  Optional. Configuration dictionary of attribute synchronization plugins. See
  :ref:`checkmk_server__multisite_ldap_plugins` for more details.

``cache_livetime``
  Optional. Time in seconds how long to cache LDAP user information. Defaults
  to: ``300``.

``comment``
  Optional. Comment about user connection definition.

``connect_timeout``
  Optional. Connect timeout.

``debug_log``
  Optional. Enable debug logging for LDAP user synchronization. Allowed values
  are ``True`` or ``False``. Defaults to: ``False``

``description``
  Optional. Short description of user connection definition being displayed
  in the connection list.

``directory_type``
  Optional. LDAP directory type used to set default user and group attributes.
  Allowed values are ``openldap``, ``389directoryserver`` or ``ad``. Defaults
  to: ``openldap``.

``disabled``
  Optional. Do not enable user connection. Allowed values are ``True`` or
  ``False``. Defaults to: ``False``

``docu_url``
  Optional. Documentation URL.

``failover_servers``
  Optional. List of failover LDAP host names.

``group_filter``
  Optional. Group search filter (e.g. ``(objectclass=groupOfNames)``). This
  will overwrite the default set by ``item.directory_type``.

``group_member``
  Optional. Group member attribute name (e.g. ``member``).

``group_scope``
  Optional. Group search scope. Allowed values are ``sub`` (search whole
  subtree below base DN), ``base`` (search only the entry at the base DN) or
  ``one`` (search all entries one level below the base DN). Defaults to:
  ``sub``.

``id``
  Optional. Connection identifier. Defaults to ``default``.

``lower_user_ids``
  Optional. Set lower case user IDs. Allowed values are ``True`` or ``False``.
  Defaults to: ``False``

``no_persistent``
  Optional. Don't use persistent LDAP connections. Allowed values are ``True``
  or ``False``. Defaults to: ``False``

``port``
  Optional. TCP port. Defaults to: ``389``

``response_timeout``
  Optional. Response timeout.

``suffix``
  Optional. LDAP connection suffix.

``use_ssl``
  Optional. Encrypt the network connection using SSL. Allowed values are
  ``True`` or ``False``. Defaults to: ``False``

``user_filter``
  Optional. User search filter (e.g. ``(objectclass=account)``). This
  will overwrite the default set by ``item.directory_type``.

``user_filter_group``
  Optional. Filter users by group.

``user_id``
  Optional. User ID attribute name (e.g. ``uid``).

``user_id_umlauts``
  Optional. Translate Umlauts in user IDs (deprecated). Allowed values are
  ``keep`` or ``replace``. Defaults to ``keep``.

``user_scope``
  Optional. User search scope. Allowed values are ``sub`` (search whole
  subtree below base DN), ``base`` (search only the entry at the base DN) or
  ``one`` (search all entries one level below the base DN). Defaults to:
  ``sub``.


.. _checkmk_server__multisite_ldap_plugins:

LDAP Attribute Synchronization Plugins
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The LDAP user synchronization connector supports various plugins for setting
WATO user properties based on LDAP attributes and filters. Each plugin is
a configuration dictionary with the plugin name as key.

``alias``
  Set user alias based on LDAP attribute.

  ``attr``
    Optional. LDAP attribute to sync. Defaults to ``cn``.

``auth_expire``
  Checks wether or not the user auth must be invalidated.

  ``attr``
    Optional. LDAP attribute to be used as indicator. Defaults to
    ``krbpasswordexpiration``.

``disable_notifications``
  Disable notifications based on LDAP attribute.

  ``attr``
    Optional. LDAP attribute to sync.

``email``
  Set email address based on LDAP attribute.

  ``attr``
  Optional. LDAP attribute to sync. Default to ``mail``.

``force_authuser``
  Set visibility of host/services based on LDAP attribute.

  ``attr``
    Optional. LDAP attribute to sync.

``force_authuser_webservice``
  Set visibility of host/services for WebAPI access based on LDAP attribute.

  ``attr``
    Optional. LDAP attribute to sync.

``groups_to_attributes``
  Set custom user attributes based on the group memberships in LDAP.

  ``nested``
    Optional. Handle nested group memberships (Active Directory only at the
    moment)

  ``other_connections``
    Optional. List of alternative LDAP connection IDs to sync group membership.

``groups_to_contactgroups``
  Add the user to contactgroups based on the group memberships in LDAP.

  ``nested``
    Optional. Handle nested group memberships (Active Directory only at the
    moment)

  ``other_connections``
    Optional. List of alternative LDAP connection IDs to sync contactgroup
    membership.

``groups_to_roles``
  Set user roles based on distinguished names from LDAP. This is a
  configuration dictionary with the role name defined in
  :envvar:`checkmk_server__multisite_cfg_roles` as key and a list of group
  references as value. Each group reference supports the following properties.

  ``group_dn``
    Group DN used for role assignment.

  ``connection``
    Optional. Alternative connection ID used for group query.

``pager``
  Set pager number based on LDAP attribute.

  ``attr``
    Optional. LDAP attribute to be used as indicator. Defaults to ``mobile``.

``start_url``
  Set WATO start URL based on LDAP attribute.

  ``attr``
    Optional. LDAP attribute to sync. Defaults to ``start_url``.


.. _checkmk_server__multisite_user_connections_example:

Example
~~~~~~~

Small example configuration for user authentication via LDAP showing the use
of some LDAP plugins:

.. code-block:: yaml

   checkmk_server__multisite_user_connections:
     - server: 'localhost'
       binddn: 'cn=admin,dc=example,dc=com'
       bindpw: 'secret'
       group_dn: 'ou=groups,dc=example,dc=com'
       user_dn: 'ou=users,dc=example,dc=com'
       user_filter: '(objectclass=posixAccount)'
       active_plugins:
         alias:
           attr: 'gecos'
         groups_to_roles:
           admin:
             - group_dn: 'cn=wato-admin,ou=groups,dc=example,dc=com'

This will synchronize all users in from the DN ``ou=users,dc=example,dc=com``
to WATO, fills the user's alias property with the value from the ``gecos``
LDAP attribute and assign the admin role to the members of the 'wato-admin'
group.


.. _checkmk_server__ref_distributed_sites:

checkmk_server__distributed_sites
---------------------------------

This setting will define Check_MK Multisite connections to other Check_MK
monitoring sites. Each site entry is a nested YAML dictionary with the site
name as top key. The following sub keys are supported as site properties.

``alias``
  An alias or description of the site, required.

``disabled``
  Optional. Temporarily disable this connection. Defaults to ``False``.

``disable_wato``
  Optional. Disable configuration via WATO on this site. Defaults to ``True``.

``insecure``
  Optional. Ignore SSL certificate errors. Defaults to ``False``.

``multisiteurl``
  Optional. URL of the remote Check_MK site including ``/check_mk/``. This
  will be used by the main site to fetch resources from this site.

``password``
  Optional. User password for user defined in ``item.username`` used for
  authentication on this site.

``persist``
  Optional. Use persistent connections to this site. Defaults to ``False``.

``replicate_ec``
  Optional. Replicate Event Console configuration to this site. Defaults to
  ``False``.

``replicate_mkps``
  Optional. Replicate extensions (MKPs and files in :file:`~/local/`).
  Defaults to ``True``.

``replication``
  Optional. WATO replication allows you to manage several monitoring sites
  with a logically centralized WATO. Slave sites receive their configuration
  from master sites. By default this value is unset which means that the there
  is no replication with this site. Set this to ``slave`` to enable
  configuration push to this site.

``socket``
  Optional. Livestatus connection socket. By default this value is unset which
  corresponds to the local site. In case this is a foreign site on localhost
  or a remote site, this value must be set to a TCP or UNIX socket such as
  ``tcp:<hostname>:<port>`` or ``unix:<path>``. When connecting to remote site
  make sure that Livestatus over TCP is activated there.

``status_host``
  Optional. By specifying a status host for each non-local connection you
  prevent Multisite from running into timeouts when remote sites do not
  respond. The value must be specified as ``[ '<site>', '<hostname>' ]``.
  By default this value is unset. Check the `upstream documentation`_ for
  more information.

.. _upstream documentation: https://mathias-kettner.com/checkmk_multisite_statushost.html

``timeout``
  Optional. Connect timeout in seconds before this site is considered to be
  unreachable. Defaults to ``10``.

``url_prefix``
  Optional. The URL prefix will be prepended to links of addons like
  PNP4Nagios or the classical Icinga GUI when a link to such applications
  points to a host or service on that site.

``username``
  Optional. User name used to synchronize configuration data with this site
  in case ``item.replication`` is set to ``slave``. Defaults to ``sitesync``.

``user_login``
  Optional. Allow users to directly directly login into the Web GUI of this
  site. Defaults to ``True``.

The default values for the distributed sites configuration are defined in
:envvar:`checkmk_server__distributed_sites_defaults` and can be overwritten
via Ansible inventory.

....

A lot of parameter descriptions are copied from the upstream source code which is copyrighted
by `Mathias Kettner <mk@mathias-kettner.de>`_ and released under the
`GPL-2.0 <https://tldrlegal.com/license/gnu-general-public-license,-version2-%28gpl-2%29>`_.
