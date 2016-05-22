## [![DebOps project](http://debops.org/images/debops-small.png)](http://debops.org) checkmk_server

This role installs and manages [Check_MK](http://mathias-kettner.com/check_mk.html),
a Nagios-based system monitoring solution.

### Installation

This role requires at least Ansible `v1.9.0`. To install it, clone it
into your DebOps project roles directory or `/etc/ansible/roles`:

    git clone https://github.com/debops-contrib/ansible-checkmk_server.git debops.checkmk_server


### Role dependencies

- `debops.ferm`


### Are you using this as a standalone role without DebOps?

You may need to include missing roles from the [DebOps common
playbook](https://github.com/debops/debops-playbooks/blob/master/playbooks/common.yml)
into your playbook.

[Try DebOps now](https://github.com/debops/debops) for a complete solution to run your Debian-based infrastructure.


### Authors and license

`checkmk_server` role was written by:
- Reto Gantenbein | [e-mail](mailto:reto.gantenbein@linuxmonk.ch) | [GitHub](https://github.com/ganto)

License: [GPLv3](https://tldrlegal.com/license/gnu-general-public-license-v3-%28gpl-3%29)
