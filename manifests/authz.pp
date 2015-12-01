# Authz-DN mappings

define openldap_slapd::authz (
  $match      = $name,
  $map,
  $order      = '60',
  $target     = $::openldap_slapd::conf_file,
) {


  concat::fragment { "openldap::authz::${name}":
    content => template('openldap_slapd/_authz.erb'),
    target  => $target,
    order   => $order,
  }
}

