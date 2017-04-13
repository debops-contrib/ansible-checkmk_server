Introduction
============

.. include:: includes/all.rst

debops-contrib.checkmk_server_ is an Ansible_ role which installs and manages
Check_MK_, a Nagios-based system monitoring solution. Check_MK supports
different monitoring backends such as Nagios_ or Icinga_ (v1.x) and features
a powerful configuration language for creating check inventories.


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
