require 'rubygems'
require "selenium-webdriver"# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
require 'YAML'
require './automation'
require 'fileutils'

ie = Watir::Browser.new :chrome
    ie.goto('http://p.usampadmin.com')
    if ie.text.include?('Logout')
      ie.goto("http://p.usampadmin.com/login.php?hdMode=logout")
    end
    # Setting login credentials (email/password)

    ie.text_field(:name,"txtEmail").set('mayuri_rivankar@persistent.co.in')
    ie.text_field(:name,"txtPassword").set('test')
    ie.button(:value, "Login").click
    raise("Sorry! System Failed to login to Usampadmin") unless ie.link(:text,'Logout').exists?
    Watir::Wait.until { ie.text.include? 'Welcome Mayuri Rivankar!!' }#explicit wait:default timeout :30sec:HRISHI

   ie.goto('http://p.usampadmin.com/configuration_settings.php')
   #Watir::Wait.until { ie.text.include? 'CONFIGURATION SETTINGS ' }#explicit wait:default timeout :30sec:HRISHI
   do_val=File.open("InputRepository/do_settings_exec.yml"){|file| YAML::load(file)}
   pp_val=File.open("InputRepository/pp_settings_exec.yml"){|file| YAML::load(file)}
   ie.radio(:name=>'rdDashboardOptimzer',:value => "#{do_val['do']}").set
 
  
   ie.radio(:name=>'rdProgressiveAPI',:value => "#{pp_val['pp']}").set
  ie.button(:value, "UPDATE").click
  sleep 5
  
  #set Focusline site to V2 dashbaord
   ie.driver.manage.timeouts.implicit_wait = 10 
    ie.goto('http://p.usampadmin.com/add_site.php?site_id=Mg==')
    ie.driver.manage.timeouts.implicit_wait = 10 
    ie.radio(:name=>'rdDashboardVersion',:value=>'V2').set
    ie.button(:value, "Update").click
    ie.driver.manage.timeouts.implicit_wait = 10 
    
  ie.goto('http://p.usampadmin.com/login.php?hdMode=logout')
  
  
ie.close
  