# -*- encoding: utf-8 -*-

name 'jenkins-demo'
maintainer 'DennyZhang'
maintainer_email 'contact@dennyzhang.com'
license 'All rights reserved'
description 'Setup and configure jenkins'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'
source_url 'https://www.dennyzhang.com'
issues_url 'https://www.dennyzhang.com'

supports 'ubuntu', '>= 14.04'
depends 'apt', '=2.6.1'
depends 'java'
depends 'jenkins', '=5.0.4'
