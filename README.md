# openldap_slapd


## Summary

This module manages OpenLDAP using convensional slapd.conf configuration.

## Classes

### `openldap_slapd`

```
include openldap_slapd
```

### Parameters

* `argsfile`: OpenLDAP args file, default `/var/run/openldap/slapd.args`
* `conf_file`: Configuration file location, default `/etc/openldap/slapd.conf`

#### Custom configuration settings
* `global_acls`: A hash containing global ACL's, see `params.pp` for default settings
* `authz_regexp`: A hash of authz-regexp entries, default `{}`
* `databases`: A hash of custom databases, default `{}`
* `modules`: Array of modules to load
* `schemas`: Hash of schemas to configure


#### Security settings
* `local_ssf`: Configures the localSSF setting
* `password_hash`: Password hash, default `{CRYPT}`
* `password_salt_format`: default `$6$%.12s`
* `sec_allow`: An array of `allow` entries
* `sec_disallow`: An array of `disallow` entries
* `sec_require`: An array of `require` entries
* `security`: Minimum required SSF value
* `tls_certificate_file`: Location of TLS cert
* `tls_key_file`: Location of TLS key
* `tls_ca_certificate_file`: Location of TLS CA cert


## Todo:
* More documentation on available options!
* Tests
* Puppet 4.x compatibility


