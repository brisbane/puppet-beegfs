# Class: beegfs::repo
#
# This module manages beegfs repository installation
#
#
# This class file is not called directly
class beegfs::repo(
  Beegfs::Release $release,
  $manage_repo    = $beegfs::manage_repo,
  $package_source = $beegfs::package_source,
) inherits beegfs {
  anchor { 'beegfs::repo::begin': }
  anchor { 'beegfs::repo::end': }

  case $facts['os']['family'] {
    'Debian': {
      class { '::beegfs::repo::debian':
        release => $release,
        require => Anchor['beegfs::repo::begin'],
        before  => Anchor['beegfs::repo::end'],
        manage_repo => $manage_repo
      }
    }
    'RedHat': {
      class { '::beegfs::repo::redhat':
        require => Anchor['beegfs::repo::begin'],
        before  => Anchor['beegfs::repo::end'],
        manage_repo => $manage_repo
      }
    }
    default: {
      fail("Module '${module_name}' is not supported on OS: '${facts['os']['name']}', family: '${facts['os']['family']}'")
    }
  }
}
