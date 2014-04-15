#
# Cookbook Name:: demo-app
# Recipe:: static
#
# Copyright 2014, Chef Software, Inc.
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

directory "/var/www/demo_app/appd/static" do
  mode 0755
  recursive true
end

#put the images in the apache directory
%w{chef.png vmware.jpg}.each do |image|
  cookbook_file "/var/www/demo_app/appd/static/#{image}" do
    source image
    mode '0644'
  end
end

db = search(:node, 'run_list:database') || []

# mysql -u root -pilikerandompasswords -P 3309 -h 172.31.6.23 show databases;

#write out the webpage
template '/var/www/demo_app/appd/static/index.html' do
  source 'index.html.erb'
  mode '0644'
  variables(
    :mysql => db.uniq
    )
end