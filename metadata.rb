#!/bin/env ruby
# encoding: utf-8
name 'suphp'
maintainer 'Nico Nägele'
maintainer_email 'nixalio@gmail.com'
description 'installs suphp from source'
version '0.0.1'

%w{ ubuntu }.each do |os|
  supports os
end

%w{ apache2 apt }.each do |cb|
  depends cb
end
