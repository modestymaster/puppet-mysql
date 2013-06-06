# Public: Create MySQL Databases
#
# namevar - The value of the root user's password.
#
# Examples
#
#   mysql::db { 'd0ntBsn00pinMyPwd': }
define mysql::set_root_passwd {
  require mysql

  exec { "create mysql db ${name}":
    command => "mysqladmin -u root password ${name}",
    require => Exec['wait-for-mysql']
  }
}
