class openldap_slapd::params {


  $conf_file  = '/etc/openldap/slapd.conf'
  $schema_dir = '/etc/openldap/schema'

  ## Global settings

  $server_id   = '01'
  $threads     = '4'
  $pidfile     = '/var/run/openldap/slapd.pid'
  $argsfile    = '/var/run/openldap/slapd.args'
  $log_level   = 'stats'
  $tls_enabled = true

  ## TLS options
  #$tls_protocol_min        = '3.1'
  #$tls_cipher_suite        = 'HIGH:!SSLv3:!SSLv2:!ADH'
  $tls_certificate_file    = ''
  $tls_key_file            = ''
  $tls_ca_certificate_file = ''
  #$tls_dh_param_file       = '/etc/openldap/ssl.key/dhparam'
  $password_hash           = '{CRYPT}'
  $password_salt_format    = '$6$%.12s'
  $sec_disallow            = ''
  $sec_allow               = ''
  $sec_require             = ''
  $security                = ''
  $local_ssf               = ''
  
  $global_acls = {
    
    'dn.base=""'  => {
      rules       => [
        { 'by'    => '*', 'action' => 'read' },
      ],
      position       => 1,
    },

    'dn.base="cn=Subschema"' => {
      rules       => [
        { 'by'    => '*', 'action' => 'read' },
      ],
      position       => 2,
    }
  }
}
