# -*- encoding: utf-8 -*-

name 'jenkins-demo'
maintainer 'DennyZhang'
maintainer_email 'denny.zhang@totvs.com'
license 'All rights reserved'
description 'Setup and configure jenkins for mdm project'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'
source_url 'http://www.totvslabs.com'
issues_url 'http://www.totvslabs.com'

supports 'ubuntu', '>= 14.04'
depends 'apt', '=2.6.1'
depends 'apache2', '=3.2.2'
depends 'jenkins', '=2.2.2'
depends 'ssh', '=0.10.0'

depends 'build-essential', '=2.4.0'
depends 'iptables', '=2.1.1'
depends 'windows', '=1.38.2'
depends 'yum', '=3.8.1'
depends 'yum-epel', '=0.6.3'
depends 'chef_changereport_handler', '=1.0.5'

depends 'common-basic', '=0.0.1'
depends 'os-basic', '=0.0.1'
depends 'general_security', '=0.0.1'

depends 'devops_basic'
depends 'devops_library'
