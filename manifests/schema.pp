define openldap_slapd::schema (
  $schemaname = $name,
  $order      = '20',
  $directory  = $::openldap_slapd::schema_dir,
  $target     = $::openldap_slapd::conf_file,
) {


  concat::fragment { "openldap::schema::${name}":
    content => template('openldap_slapd/_schema.erb'),
    target  => $target,
    order   => $order,
  }
}

