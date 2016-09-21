# == Class: snmpd
#
class snmpd {

  include ::snmpd::params

  package { 'snmpd':
    ensure => present,
    name   => $::snmpd::params::package_name,
  }
  case $::osfamily {
    'Debian':
      file { '/etc/default/snmpd':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0444',
        source  => 'puppet:///modules/ubuntu/default',
      }
  }
  service { 'snmpd':
    ensure     => running,
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
