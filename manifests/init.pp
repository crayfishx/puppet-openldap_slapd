# Class: openldap_slapd
# ===========================
#
# Full description of class openldap_slapd here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'openldap_slapd':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class openldap_slapd (
  $argsfile                = $openldap_slapd::params::argsfile,
  $authz_regexp            = {},
  $conf_file               = $openldap_slapd::params::conf_file,
  $databases               = {},
  $global_acls             = undef,
  $local_ssf               = undef,
  $log_level               = $openldap_slapd::params::log_level,
  $modules                 = [],
  $password_hash           = undef,
  $password_salt_format    = undef,
  $pidfile                 = $openldap_slapd::params::pidfile,
  $schemas                 = {},
  $sec_allow               = undef,
  $sec_disallow            = undef,
  $sec_require             = undef,
  $security                = undef,
  $server_id               = $openldap_slapd::params::server_id,
  $sizelimit               = undef,
  $threads                 = $openldap_slapd::params::threads,
  $timelimit               = undef,
  $tls_ca_certificate_file = undef,
  $tls_ca_certificate_path = undef,
  $tls_certificate_file    = undef,
  $tls_cipher_suite        = undef,
  $tls_dh_param_file       = undef,
  $tls_enabled             = undef,
  $tls_key_file            = undef,
  $tls_protocol_min        = undef,
) inherits openldap_slapd::params {

  package { 'openldap-servers':
    ensure => installed,
  }

  file { '/etc/sysconfig/slapd':
    ensure => file,
    source => 'puppet:///modules/openldap_slapd/slapd',
  }

  concat { $conf_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['openldap-servers'],
  }

  # Concat fragments order
  #
  # 00: Global
  # 10: Modules
  # 20: Schemas
  # 30: TLS
  # 40: Security settings
  # 50: Global ACL
  # 60: Authz-DN settings
  # 70: Database (config)
  # 80: Database (custom)

  Concat::Fragment {
    target => $conf_file,
  }

  concat::fragment { 'openldap_slapd::global':
    order   => '00',
    content => template('openldap_slapd/_global.erb')
  }

  concat::fragment { 'openldap_slapd::security':
    order   => '40',
    content => template('openldap_slapd/_security.erb')
  }

  if str2bool("$tls_enabled") {
    concat::fragment { 'openldap_slapd::tls':
      order   => '30',
      content => template('openldap_slapd/_tls.erb')
    }
  }

  openldap_slapd::module { $modules: }

  create_resources('openldap_slapd::database', $databases)
  create_resources('openldap_slapd::schema', $schemas)
  create_resources('openldap_slapd::authz', $authz_regexp)

  if $global_acls {
    create_resources('openldap_slapd::acl', $global_acls)
  }
}
