# openldap_slapd


## Summary

This module manages OpenLDAP using convensional slapd.conf configuration.

## Classes

### `openldap_slapd`

```
include openldap_slapd
```

### Parameters for class `openldap_slapd`

* `argsfile`: OpenLDAP args file, default `/var/run/openldap/slapd.args`
* `pidfile`: Location of slapd pidfile that will hold the slapd server's process ID
* `conf_file`: Configuration file location, default `/etc/openldap/slapd.conf`
* `loglevel`: OpenLDAP loglevel, default `stats` 
* `threads`: Maximum size of the primary thread pool, default 16
* `idletimeout`: Maximum time of seconds to leave an idle connection open, default 600.

#### Custom configuration settings
* `global_acls`: A hash containing global ACL's, see `params.pp` for default settings
* `authz_regexp`: A hash of authz-regexp entries, default `{}`
* `databases`: A hash of custom databases, default `{}`
* `modules`: An array of modules to load
* `schemas`: A hash of schemas to include

#### Security settings
* `local_ssf`: Configures the localSSF setting
* `password_hash`: Password hash, must be one of `{SSHA}`, `{SHA}`, `{SMD5}`, `{MD5}`, `{CRYPT}`, or `{CLEARTEXT}`, default `{CRYPT}`
* `password_salt_format`: default `$6$%.12s`
* `sec_allow`: An array of `allow` entries
* `sec_disallow`: An array of `disallow` entries
* `sec_require`: An array of `require` entries
* `security`: Specify a set of required security strength factors.

#### TLS Options
* `tls_enabled`: Enable TLS configuration, default `true`
* `tls_certificate_file`: Location of TLS cert
* `tls_key_file`: Location of TLS key
* `tls_ca_certificate_file`: Location of TLS CA cert
* `tlc_cipher_suite`: Accepted ciphers and the preference order.
* `tls_dh_param_file`: Location of parameters file for Diffie-Hellman ephemeral key exchange
* `tls_protocol_min`: Minimum  SSL/TLS  protocol version that will be negotiated, default none


### Parameters for define `openldap_slapd::acl`

Creates one access control rule set 

* `to`: A set of entries or attributes to which access if granted. If omitted, $name will be used instead.
* `rules`: A hash of rules. Each rule must contain key `by` (requestor) and `action`
* `position`: Position number for the acl. Acls are ordered in the slapd.conf ascending order based on the position value

Example for configuring global acls in slapd.conf. ACL configuration is read from parameter hash ::openldap_slapd::global_acls.

```YAML
::openldap_slapd::global_acls:
  attrs=userPassword:
    to: attrs=userPassword
    position: 1
    rules:
      - by: 'group.base="cn=replica,ou=groups,dc=example,dc=com"'
        action: read
      - by: 'group.base="cn=admins,ou=groups,dc=example,dc=ch"'
        action: =sw
      - by: '*'
        action: auth
```

would create the following configuration

```Shell
access to
  attrs=userPassword
  by group.base="cn=replica,ou=groups,dc=example,dc=com" read
  by group.base="cn=admins,ou=groups,dc=example,dc=ch" =sw
  by * auth
```

### Parameters for define `openldap_slapd::database`

* `order`: Order number for the database. Databases are ordered in the slapd.conf ascending order based on the order value
* `acls`: A hash of ACLs. See the section for parameters for define `openldap_slapd::acl`
* `add_content_acl`: Controls whether Add operations will perform ACL checks on the content of the entry being added
* `backend`: The database type
* `checkpoint`: The frequency for flushing the database disk buffers or checkpointing the database transaction logs. Depends on the used database type
* `dbnosync`: If true, on-disk database contents are not be immediately synchronized with in memory changes
* `directory`: The database directory. If the directory does not exist it is created with mode 700 and ldap:ldap (owner:group)
* `envflags`: Envflags for a database with type `mdb`. Possible values: nosync, nometasync, writemap, mapasync, nordahead
* `indexes`: Indexes to maintain
* `lastmod`: Controls whether slapd will automatically maintain certain timestamp attributes for entries
* `limits`: Time and size limits based on the operation's initiator or base DN.
* `maxsize`: The maximum size of the database in bytes. Only applicable for databases with type `mdb`
* `mirrormode`: Enable / disable mirrormode
* `mode`: The file protection mode that newly created database files should have. Only applicable for certain database types
* `monitoring`: Controls database-specific monitoring. Only applicable for databases with type `bdb` or `hdb`
* `overlays`: A hash of overlays added for the database.
* `rebind_as_user`: If set to true, the client's bind credentials are remembered for rebinds, when trying to re-establish a broken connection. Only applicable for databases with type `ldap`
* `rootdn`: The DN that is not subject to access control or administrative limit restrictions for operations on this database
* `rootpw`: A password (or hash of the password) for the rootdn
* `sizelimit`: The  maximum  number  of entries to return from a search operation
* `suffix`: The DN suffix of queries that will be passed to this backend database
* `syncrepl`: A hash of syncrepl attributes
* `timelimit`: The  maximum  number  of  seconds slapd will spend answering a search request
* `uri`: LDAP uri for `ldap` type database

## Todo:
* More documentation on available options!
* Tests
* Puppet 4.x compatibility


