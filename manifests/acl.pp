define openldap_slapd::acl (
  $to = $name,
  $rules,
  $order = '50',
  $position = '',
  $target = $::openldap_slapd::conf_file,
) {

  concat::fragment { "openldap_slapd::acl::${name}":
    target  => $target,
    order   => "${order}_${position}",
    content => template('openldap_slapd/_acl.erb')
  }
}

