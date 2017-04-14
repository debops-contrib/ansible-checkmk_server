Guides and examples
===================

.. contents::
   :local:
   :depth: 2

.. _checkmk_server_package_source:

Alternative Package Source
--------------------------

Unfortunately Mathias Kettner, the upstream packager of Check_MK, doesn't
provide a Apt repository for the ``check-mk-raw`` Debian package. By
default the role will therefore download the package from the official
download URL before installing it.

However, it is possible to define an alternative installation sources for
the ``check-mk-raw`` package:

* In case the package is managed in a custom Apt repository the package
  name can be specified. E.g.:

  .. code-block:: yaml

     checkmk_server__raw_package: 'check-mk-raw-{{ checkmk_server__version }}'

.. topic:: Important

   The application version is always part of the package name. This will
   allow multiple versions to be installed at once.

* If no direct Internet connection and no local repository is available,
  for example in a simple Vagrant environment, a local file path can be
  defined. E.g.:

  .. code-block:: yaml

     checkmk_server__raw_package: '/vagrant/check-mk-raw-{{ checkmk_server__version }}_0.{{ ansible_distribution_release }}_amd64.deb'


.. _checkmk_server_manual_site:

Manually setup Monitoring Site
------------------------------

By default the role will setup a monitoring site named according to
:envvar:`checkmk_server__site`. Sometimes it might be desired to not let
Ansible generate a site configuration by itself but use the :program:`omd`
tool manually instead. This can be achieved by simply setting:

.. code-block:: yaml

   checkmk_server__site: False

When not managing the site configuration through Ansible, the
``debops-contrib.checkmk_agent`` role won't be able to auto-detect the server
properties. They need to be specified manually in the Ansible inventory.
For more details check the agent role documentation.
