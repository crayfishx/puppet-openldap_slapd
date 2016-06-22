define openldap_slapd::database (
  $acls = {},
  $add_content_acl = undef,
  $backend = undef,
  $checkpoint = undef,
  $dbnosync = false,
  $directory = undef,
  $envflags = undef,
  $indexes = [],
  $lastmod = undef,
  $limits = undef,
  $maxsize = undef,
  $mirrormode = true,
  $mode = undef,
  $monitoring = undef,
  $order  = '80',
  $overlays = {},
  $rebind_as_user = undef,
  $rootdn = undef,
  $rootpw = undef,
  $sizelimit = undef,
  $suffix = undef,
  $syncrepl = {},
  $target = $::openldap_slapd::conf_file,
  $timelimit = undef,
  $uri = undef,
) {

  if $directory {
    file { $directory:
      ensure  => 'directory',
      owner   => 'ldap',
      group   => 'ldap',
      mode    => '0700',
      require => Package['openldap-servers'],
    } 
  }

  # List databases alphabetically
  concat::fragment { "openldap::database::${name}":
    content => template('openldap_slapd/_database.erb'),
    target  => $target,
    order   => "${order}_${name}_0",
  }

  # Append the database's name to order to get the acls under the correct db.
  create_resources('openldap_slapd::acl', $acls, { "order" => "${order}_${name}_9" })
}

