#!c:/ruby/bin/ruby.exe
#
# This file was generated by RubyGems.
#
# The application 's4t-utils' is installed as part of a gem, and
# this file is here to facilitate running it.
#

require 'rubygems'

version = ">= 0"

if ARGV.first =~ /^_(.*)_$/ and Gem::Version.correct? $1 then
  version = $1
  ARGV.shift
end

gem 's4t-utils', version
load Gem.bin_path('s4t-utils', 'make-s4t-project.rb', version)