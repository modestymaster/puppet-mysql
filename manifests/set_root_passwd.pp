# Public: Set MySQL Database root user password
#
# namevar - The value of the root user's password.
#
# Examples
#
#   mysql::set_root_passwd { 'd0ntBsn00pinMyPwd': }
define mysql::set_root_passwd() {
  require mysql

  exec { "Setting mysql root user's password to: ${name}":
    command => "mysqladmin -u root password ${name}",
    require => Exec['wait-for-mysql']
  }
}
