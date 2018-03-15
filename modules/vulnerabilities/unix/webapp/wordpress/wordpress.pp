$secgen_parameters = ::secgen_functions::get_parameters($::base64_inputs_file)
$version = $secgen_parameters['version'][0]

class { 'mysql::server': }
class { 'mysql::bindings': php_enable => true, }

class { '::apache':
  default_vhost => false,
  overwrite_ports => false,
  default_mods => ['rewrite', 'php'],
}

apache::vhost { 'wordpress':
  docroot => '/var/www/wordpress',
  port    => '80',
}

class { 'wordpress':
  install_dir => '/var/www/wordpress',
  version => $version,
}


# TODO:
# Configuration
## Pass an account in?
# HTTPS true/false
#


# wordpress conf

# 2.0


# 3.0


# 4.2
#
# POST /wp-admin/install.php?step=2 HTTP/1.1
# Host: 172.16.0.2
# User-Agent: Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
# Accept-Language: en-US,en;q=0.5
# Accept-Encoding: gzip, deflate
# Referer: http://172.16.0.2/wp-admin/install.php
# Content-Type: application/x-www-form-urlencoded
# Content-Length: 159
# Cookie: wp-settings-time-1=1521034877
# Connection: close
# Upgrade-Insecure-Requests: 1
#
# weblog_title=test&user_name=user&admin_password=password&admin_password2=password&admin_email=test%40email.com&blog_public=1&Submit=Install+WordPress&language=


# 4.3 (default generated password)
#
# POST /wp-admin/install.php?step=2 HTTP/1.1
# Host: 172.16.0.2
# User-Agent: Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
# Accept-Language: en-US,en;q=0.5
# Accept-Encoding: gzip, deflate
# Referer: http://172.16.0.2/wp-admin/install.php
# Content-Type: application/x-www-form-urlencoded
# Content-Length: 181
# Cookie: wp-settings-time-1=1521034877
# Connection: close
# Upgrade-Insecure-Requests: 1
#
# weblog_title=test&user_name=test&admin_password=test&pass1-text=QjqKmEYBWqQ4LLTp5D&admin_password2=test&admin_email=test%40test.test&blog_public=1&Submit=Install+WordPress&language=


# 4.3 (user supplied weak password)
#
# POST /wp-admin/install.php?step=2 HTTP/1.1
# Host: 172.16.0.2
# User-Agent: Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
# Accept-Language: en-US,en;q=0.5
# Accept-Encoding: gzip, deflate
# Referer: http://172.16.0.2/wp-admin/install.php
# Content-Type: application/x-www-form-urlencoded
# Content-Length: 177
# Cookie: wp-settings-time-1=1521034877
# Connection: close
# Upgrade-Insecure-Requests: 1
#
# weblog_title=test&user_name=user&admin_password=test&pass1-text=test&admin_password2=test&pw_weak=on&admin_email=test%40test.com&blog_public=1&Submit=Install+WordPress&language=


# 4.3 (secure password with pw_weak=on)

