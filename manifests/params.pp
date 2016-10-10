# Class: openldap_slapd::params
# =============================
#
# Default parameters
class openldap_slapd::params {

  $conf_file  = '/etc/openldap/slapd.conf'

  ## Global settings

  $server_id   = '01'
  $threads     = '16'
  $pidfile     = '/var/run/openldap/slapd.pid'
  $argsfile    = '/var/run/openldap/slapd.args'
  $log_level   = 'stats'
}
