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
