Introduction
============

debops.checkmk_server_ is an Ansible_ role which installs and manages
Check_MK_, a Nagios-based system monitoring solution. Check_MK supports
different monitoring backends such as Nagios_ or Icinga_ (v1.x) and features
a powerful configuration language for creating check inventories.

.. _Ansible: https://www.ansible.com/
.. _Check_MK: http://mathias-kettner.com/check_mk.html
.. _Nagios: https://www.nagios.org/
.. _Icinga: https://www.icinga.org/

Installation
~~~~~~~~~~~~

This role requires at least Ansible ``v2.1.1``. To install it, run:

.. code-block:: console

    ansible-galaxy install debops-contrib.checkmk_server

..
 Local Variables:
 mode: rst
 ispell-local-dictionary: "american"
 End:
