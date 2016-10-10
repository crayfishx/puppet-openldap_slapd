# Define: openldap_slapd::schema
# ==============================
#
# Create list of schemas to include.
define openldap_slapd::schema (
  $position   = 0,
  $files      = [],
  $order      = '20',
  $directory  = $name,
  $target     = $::openldap_slapd::conf_file,
) {
  concat::fragment { "openldap::schema::${name}":
    content => template('openldap_slapd/_schema.erb'),
    target  => $target,
    order   => "${order}_${position}",
  }
}

