
bulkwalk_hosts = [
  ( ['snmp', '!snmp-v1', ], ALL_HOSTS, {'description': u'Hosts with the tag "snmp-v1" must not use bulkwalk'} ),
] + bulkwalk_hosts


host_groups = [
  ( 'monitoring-servers', [], ['localhost'], {'comment': u'this is a comment!!\n', 'docu_url': 'http://localhost', 'description': u'Assign localhost to monitoring-servers'} ),
] + host_groups


host_contactgroups = [
  ( 'all', [], ALL_HOSTS, {'description': u'Put all hosts into the contact group "all"'} ),
] + host_contactgroups


service_groups = [
  ( 'disk-checks', [], ['localhost'], [u'Filesystem .*'], {'description': u'Assign disk checks'} ),
] + service_groups


ignored_services = [
  ( [], ALL_HOSTS, [u'Interface veth.*$', u'Interface vnet.*$'], {'description': u"Don't check local bridge ports"} ),
] + ignored_services


if only_hosts == None:
    only_hosts = []

only_hosts = [
  ( ['!offline', ], ALL_HOSTS, {'description': u'Do not monitor hosts with the tag "offline"'} ),
] + only_hosts


active_checks.setdefault('cmk_inv', [])

active_checks['cmk_inv'] = [
  ( {}, [], ALL_HOSTS, {'description': u'Enable collection of hardware/software information'} ),
] + active_checks['cmk_inv']


extra_service_conf.setdefault('check_interval', [])

extra_service_conf['check_interval'] = [
  ( 1440, [], ALL_HOSTS, ['Check_MK HW/SW Inventory$'], {'description': u'Restrict HW/SW-Inventory to once a day'} ),
] + extra_service_conf['check_interval']


host_check_commands = [
  ( 'agent', ['cmk-agent', 'dmz', ], ALL_HOSTS, {'comment': u"Ping doesn't work for DMZ hosts, use agent status"} ),
] + host_check_commands


ping_levels = [
  ( {'loss': (80.0, 100.0), 'packets': 6, 'timeout': 20, 'rta': (1500.0, 3000.0)}, ['wan', ], ALL_HOSTS, {'description': u'Allow longer round trip times when pinging WAN hosts'} ),
] + ping_levels


checkgroup_parameters.setdefault('filesystem', [])

checkgroup_parameters['filesystem'] = [
  ( {'trend_range': 48, 'magic_normsize': 5, 'trend_showtimeleft': True, 'levels': (90.0, 95.0), 'magic': 0.8, 'trend_timeleft': (72, 24), 'trend_perfdata': True}, [], ALL_HOSTS, ALL_SERVICES ),
] + checkgroup_parameters['filesystem']


snmp_timing = [
  ( {'timeout': 15.0}, ['snmp', ], ALL_HOSTS ),
] + snmp_timing


checkgroup_parameters.setdefault('cpu_load', [])

checkgroup_parameters['cpu_load'] = [
  ( {'levels_upper': ('absolute', (2.0, 4.0)), 'period': 'wday', 'horizon': 90}, [], ALL_HOSTS ),
] + checkgroup_parameters['cpu_load']


snmp_communities = [
  ( ('authPriv', 'md5', 'snmpuser', 'snmppass', 'DES', 'snmppass'), ['imm', 'snmp', ], ALL_HOSTS, {'description': u'IBM IMM SNMP Credentials'} ),
] + snmp_communities
