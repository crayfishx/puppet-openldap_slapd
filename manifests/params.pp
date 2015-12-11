class openldap_slapd::params {


  $conf_file  = '/etc/openldap/slapd.conf'
  $schema_dir = '/etc/openldap/schema'

  ## Global settings

  $server_id   = '01'
  $threads     = '04'
  $pidfile     = '/var/run/openldap/slapd.pid'
  $argsfile    = '/var/run/openldap/slapd.args'
  $log_level   = 'stats'
  $tls_enabled = true

  ## TLS options
  $tls_protocol_min        = '3.1'
  $tls_cipher_suite        = 'HIGH:!SSLv3:!SSLv2:!ADH'
  $tls_certificate_file    = '/etc/openldap/ssl.crt/server.crt'
  $tls_key_file            = '/etc/openldap/ssl.key/server.key'
  $tls_ca_certificate_file = '/etc/ssl/ca-bundle.pem'
  $tls_dh_param_file       = '/etc/openldap/ssl.key/dhparam'
  $password_hash           = '{CRYPT}'
  $password_salt_format    = '$6$%.12s'
  $sec_disallow            = 'bind_anon'
  $sec_allow               = ''
  $sec_require             = undef
  $security                = 'ssf=1 update_ssf=112 simple_bind=64'
  $local_ssf               = '256'
  
  $global_acls = {
    
    'dn.base=""'  => {
      rules       => [
        { 'by'    => '*', 'action' => 'read' },
      ],
    },

    'db.base="cn=Subschema"' => {
      rules       => [
        { 'by'    => '*', 'action' => 'read' },
      ],
    } 
  }



}


