package {
  [
    'vim',
    'git',
    'curl',
    'nfs-common',
    'screen',
    'htop',
    'ntp'
  ] :
    ensure => present
}

include meteor
include mongodb

$mongo_url_sh = '/etc/profile.d/mongo_url_for_meteor.sh'

file { $mongo_url_sh:
  ensure => present,
  content => "export MONGO_URL=mongodb://localhost",
  owner => "root",
  group => "root",
  mode => 644
}
