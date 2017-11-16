# -*- encoding: utf-8 -*-

require 'serverspec'

# Required by serverspec
set :backend, :exec

#############################################################################
# TODO: make the code more general
require 'json'
chef_data = JSON.parse(IO.read('/tmp/kitchen/dna.json'))
buildrepo_dir = chef_data.fetch('jenkins_mdm').fetch('buildrepo_dir')

describe command('java -version') do
  its(:stderr) { should contain 'java version \"1.8' }
end

%w(8080).each do |port|
  describe port(port) do
    it { should be_listening }
  end
end
