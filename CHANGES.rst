Changelog
=========

.. include:: includes/all.rst

**debops-contrib.checkmk_server**

This project adheres to `Semantic Versioning <http://semver.org/spec/v2.0.0.html>`__
and `human-readable changelog <http://keepachangelog.com/en/0.3.0/>`__.

The current role maintainer_ is ganto.


debops-contrib.checkmk_server master - unreleased
--------------------------------------------------

Added
~~~~~

- Initial release [ganto_]

Fixed
~~~~~

- Fix ``checkmk_server__ssh_command`` which would have been wrongly generated
  with ``checkmk_server__ssh_user`` set to ``root``. [ypid_]
