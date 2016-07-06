Testing Jinja Macros for Check_MK Variables
===========================================

The Check_MK configuration file format mainly consists of Python objects
which are serialized through `pprint.pprint()`. This doesn't always makes
it easy to template the configuration files from Ansible variables.

Some of the challenges:

* Ansible or JSON/YAML respecively doesn't know tuple as a native data type

* The Jinja `pprint` filter serializes every string as Unicode string

Therefore a number of macros were written to allow templating Check_MK
configuration variables. 

To simplify refactoring and integration of new variables, a small script
can be used to generate the `rules.mk` using the Jinja macros shipped with
the Ansible role.


Test Rule Templates
-------------------

The `vars/main.yml` file contains a dictionary with Check_MK variable to
Jinja template mappings (`checkmk_server__confd_variable_map`). This is a
constantly growing list as more and more Check_MK features will be integrated.

If you want to test the templating of a new rule variable proceed as
following:

* Use the WATO GUI to configure the rule you want to integrate

* Copy the generated variable definition from the `etc/check_mk/conf.d/wato/rules.mk` file to the `reference.mk`

* Define the rule with help of the Jinja macros in the `test_templates.yml`

* Run the `test_templates.sh` script and visually check how appropriate the macro was able to format the Check_MK configuration variable


----------

Currently the templates are tested against the latest Check_MK 1.2.8 version
and don't always correspond exactly with the formatting done by Check_MK.
E.g. dictionary elements might have different order, normal strings are
Unicode strings and so on. Only manual testing will show if the generated
variable is recognized correctly by WATO.

If you have a better idea how to test or generate these configs, please leave
a note in the [issues](https://github.com/debops-contrib/ansible-checkmk_server/issues)
section or send a pull request.
