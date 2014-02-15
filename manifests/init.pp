# == Class: ppm_zsh_arch
#
# This class install zsh package if needed and configure it
# using archlinux iso image default configuration
#
# === Authors
#
# Jacopo Binosi <b4inoz@gmail.com>
#
class ppm_zsh_arch {
  if $::osfamily != 'windows' {

    notify {'who_am_i':
      message => "Hi! I'm ${::modulename} puppet module (:",
    }

    $rootgroup = $::operatingsystem ? {
      'Solaris' => 'wheel',
      default   => 'root',
    }

    #
    # === Package
    #
    package { 'zsh':
          ensure => 'installed',
    }

    #
    # === Zsh global conf
    #
    $zsh_conf = $::operatingsystem ? {
      default   => '/etc/zsh',
    }

    $keephack = $::operatingsystem ? {
      default   => '/etc/zsh/keephack',
    }

    $zprofile = $::operatingsystem ? {
      default   => '/etc/zsh/zprofile',
    }

    $zshrc = $::operatingsystem ? {
      default   => '/etc/zsh/zshrc',
    }

    file {'zsh_conf':
      ensure => directory,
      path   => $zsh_conf,
      mode   => '0644',
      owner  => 'root',
      group  => $rootgroup,
    }

    file { 'keephack':
      ensure => present,
      path   => $keephack,
      mode   => '0644',
      owner  => 'root',
      group  => $rootgroup,
      source => "puppet://${servername}/modules/zsh_arch/keephack",
    }

    file { 'zprofile':
      ensure => present,
      path   => $zprofile,
      mode   => '0644',
      owner  => 'root',
      group  => $rootgroup,
      source => "puppet://${servername}/modules/zsh_arch/zprofile",
    }

    file { 'zshrc':
      ensure => present,
      path   => $zshrc,
      mode   => '0644',
      owner  => 'root',
      group  => $rootgroup,
      source => "puppet://${servername}/modules/zsh_arch/zshrc",
    }

    #
    # === Skel directory
    #
    $etc_skel = $::operatingsystem ? {
      default   => '/etc/skel',
    }

    $skel_automated_script = $::operatingsystem ? {
      default   => '/etc/skel/.automated_script.sh',
    }

    $skel_zlogin = $::operatingsystem ? {
      default   => '/etc/skel/.zlogin',
    }

    $skel_zshrc = $::operatingsystem ? {
      default   => '/etc/skel/.zshrc',
    }

    file {'etc_skel':
      ensure => directory,
      path   => $etc_skel,
      mode   => '0644',
      owner  => 'root',
      group  => $rootgroup,
    }

    file { 'skel_automated_script':
      ensure => present,
      path   => $skel_automated_script,
      mode   => '0744',
      owner  => 'root',
      group  => $rootgroup,
      source => "puppet://${servername}/modules/zsh_arch/skel_automated_script.sh",
    }

    file { 'skel_zlogin':
      ensure => present,
      path   => $skel_zlogin,
      mode   => '0644',
      owner  => 'root',
      group  => $rootgroup,
      source => "puppet://${servername}/modules/zsh_arch/skel_zlogin",
    }

    file { 'skel_zshrc':
      ensure => present,
      path   => $skel_zshrc,
      mode   => '0644',
      owner  => 'root',
      group  => $rootgroup,
      source => "puppet://${servername}/modules/zsh_arch/skel_zshrc",
    }

  }
}
