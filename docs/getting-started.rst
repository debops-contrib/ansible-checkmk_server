Getting started
===============

.. include:: includes/all.rst

.. contents::
   :local:

By default Check_MK server is installed from the `check-mk-raw` Debian package
as provided by Mathias Kettner upstream. It includes the :program:`omd` tool
which is used for managing the monitoring sites. The role will create a default
site called 'debops'. After the setup it can be reached by accessing
``https://<fqdn>/check_mk/debops``.

Example inventory
-----------------

You can install Check_MK server on a host by adding it to the
``[debops_service_checkmk_server]`` host group in your Ansible inventory::

    [debops_service_checkmk_server]
    hostname

Example playbook
----------------

Here's an example playbook that uses the ``debops-contrib.checkmk_server`` role
to install Check_MK server:

.. literalinclude:: playbooks/checkmk_server.yml
   :language: yaml

The inclusion of the debops.ferm_ is optional. This playbooks is shipped
with this role under :file:`docs/playbooks/checkmk_server.yml` from which you
can symlink it to your playbook directory.


Ansible tags
------------

You can use Ansible ``--tags`` or ``--skip-tags`` parameters to limit what
tasks are performed during Ansible run. This can be used after a host was first
configured to speed up playbook execution, when you are sure that most of the
configuration is already in the desired state.

Available role tags:

``role::checkmk_server``
  Main role tag, should be used in the playbook to execute all of the role
  tasks as well as role dependencies.

``role::checkmk_server:rules``
  Execute tasks which are generating the monitoring rules definitions.

``role::checkmk_server:multisite``
  Execute tasks which configure the Check_MK multisite Web interface.

``role::checkmk_server:mkp``
  Execute tasks to install Check_MK packages.
