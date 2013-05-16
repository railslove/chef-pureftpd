default['pureftpd']['auth_addon'] = "mysql" # specifiy addons eg mysql, postgresql or ldap
default['pureftpd']['dir'] = "/etc/pure-ftpd"
default['pureftpd']['private_key_path'] = "/etc/ssl/private"
default['pureftpd']['tls'] = 1
default['pureftpd']['chroot_everyone'] = "yes"
default['pureftpd']['create_home_dir'] = "yes"
default['pureftpd']['passive_port_range'] = "29799 29899"
default['pureftpd']['force_passive_ip'] = false
