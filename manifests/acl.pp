# Define: openldap_slapd::acl
# ===========================
#
# Access control block
# Creates a configuration block:
# access to
#   $name
#   by $rules[0]['by'] $rules[0]['action']
#   by $rules[1]['by'] $rules[1]['action']
#   ...
define openldap_slapd::acl (
  $rules,
  $to = $name,
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

