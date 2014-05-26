require 'rubygems'
#require 'watir'
#require 'firewatir'
require './Usamp_lib.rb'
require 'test/unit'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole' 
require 'Win32API'
require 'net/smtp'
require 'fileutils'
require 'net/imap' 
require 'net/pop'
#run gem install tlsmail and gem install mail before requiring tlsmail
#require 'tlsmail'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"





#if __FILE__==$0
	#dir = File.dirname(__FILE__)
	#tests= Dir["Test_0*.rb"]
	#tests.concat Dir["Test_1*.rb"]
	#tests.sort.each do |file|
		#load file, true
	#end
#end
#test_order = :defined
#Dir.glob(File.join(File.dirname(__FILE__), 'Test_*_*.rb')).each {|f| require f }
Dir[File.join(File.dirname(__FILE__), 'Tests') + "Test_**_*.rb"].each {|f| require f }

#require File.join(File.dirname(__FILE__), "Test_01_Project_QG_Create.rb")
#require File.join(File.dirname(__FILE__), "Test_02_Auto_Open_QG.rb")
#require File.join(File.dirname(__FILE__), "Test_03_Auto_Close_QG.rb")
#require File.join(File.dirname(__FILE__), "Test_04_Non_member_survey_complete.rb")