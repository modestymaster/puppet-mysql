# Public: Create MySQL Databases
#
# namevar - The name of the database.
#
# Examples
#
#   mysql::db { 'foo': }
define mysql::db($ensure = present) {
  require mysql
  require mysql::config
 
  $passwd = getvar(mysql::config::rootpasswd)

  if empty($passwd) {
    $basecmd = "mysqladmin -u root"
  } else {
    $basecmd = "mysqladmin -u root -p${passwd}"
  }

  if $ensure == 'present' {
    exec { "create mysql db ${name}":
      command => "${basecmd} create ${name}",
      creates => "${mysql::config::datadir}/${name}",
      require => Exec['wait-for-mysql']
    }
  } elsif $ensure == 'absent' {
    exec { "delete mysql db ${name}":
      command => "${basecmd} -f drop ${name}",
      require => Exec['wait-for-mysql']
    }
  }
}
