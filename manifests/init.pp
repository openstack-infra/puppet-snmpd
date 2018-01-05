# == Class: snmpd
#
class snmpd {

  include ::snmpd::params

  package { 'snmpd':
    ensure => present,
    name   => $::snmpd::params::package_name,
  }
  service { 'snmpd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    subscribe  => File['/etc/snmp/snmpd.conf'],
  }
  file { '/etc/snmp/snmpd.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/snmpd/snmpd.conf',
    replace => true,
  }
}
