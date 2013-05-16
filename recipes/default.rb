#
# Cookbook Name:: pureftpd
# Recipe:: default
#
# Copyright 2012, Railslove GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

pureftpd_service = ["pure-ftpd", node['pureftpd']['auth_addon']].join("-")

package "pure-ftpd"

package "pure-ftpd-#{node['pureftpd']['auth_addon']}" if node['pureftpd']['auth_addon']

service pureftpd_service do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

cookbook_file "#{node['pureftpd']['private_key_path']}/pure-ftpd.pem" do
  owner 'root'
  group 'root'
  mode 0600
end

file "#{node['pureftpd']['dir']}/conf/TLS" do
  content node['pureftpd']['tls'].to_s
  notifies :restart, resources(:service => pureftpd_service), :delayed
end

file "#{node['pureftpd']['dir']}/conf/ChrootEveryone" do
  content node['pureftpd']['chroot_everyone']
  notifies :restart, resources(:service => pureftpd_service), :delayed
end

file "#{node['pureftpd']['dir']}/conf/CreateHomeDir" do
  content node['pureftpd']['create_home_dir']
  notifies :restart, resources(:service => pureftpd_service), :delayed
end

file "#{node['pureftpd']['dir']}/conf/PassivePortRange" do
  content node['pureftpd']['passive_port_range']
  notifies :restart, resources(:service => pureftpd_service), :delayed
end

file "#{node['pureftpd']['dir']}/conf/ForcePassiveIP" do
  content { node['cloud']['public_ipv4'] }
  notifies :restart, resources(:service => pureftpd_service), :delayed
  only_if { node['pureftpd']['force_passive_ip'] }
end
