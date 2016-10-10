# Define: openldap_slapd::authz
# =============================
#
# authz-regexp mappings
# Creates a configuration block:
# authz-regexp
#   "$name"
#   "$map"
define openldap_slapd::authz (
  $map,
  $match      = $name,
  $order      = '60',
  $target     = $::openldap_slapd::conf_file,
) {

  concat::fragment { "openldap::authz::${name}":
    content => template('openldap_slapd/_authz.erb'),
    target  => $target,
    order   => $order,
  }
}

