define openldap_slapd::database (
  $acls = {},
  $rootpw = undef,
  $order  = '80',
  $target = $::openldap_slapd::conf_file,
  $acls = {},
  $suffix = undef,
  $rootdn = undef,
  $directory = undef,
  $mode = undef,
  $monitoring = undef,
  $add_content_acl = undef,
  $dbnosync = false,
  $checkpoint = undef,
  $maxsize = undef,
  $indexes = [],
  $syncrepl = {},
  $overlays = {},
  $mirrormode = true,


) {

  ## If database is config we force a order of 70
  $concat_order = $name ? {
    'config'  => '70',
    'monitor' => '99',
    default   => $order,
  }

  concat::fragment { "openldap::database::${name}":
    content => template('openldap_slapd/_database.erb'),
    target  => $target,
    order   => "${concat_order}_0",
  }

  create_resources('openldap_slapd::acl', $acls, { "order" => "${concat_order}_9" })
}

