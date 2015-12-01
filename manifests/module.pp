define openldap_slapd::module (
  $modulename = $name,
  $order      = '10',
  $target     = $::openldap_slapd::conf_file,
) {


  concat::fragment { "openldap::module::${name}":
    content => template('openldap_slapd/_module.erb'),
    target  => $target,
    order   => $order,
  }
}

