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

    doval={}
    doval['do']=ie.radio(:name=>'rdDashboardOptimzer',:checked=>"checked").value
    File.open("InputRepository/do_settings_exec.yml","w"){|file| YAML.dump(doval,file)}#storing Dashboard Optimization value for later use
    ppval={}
    ppval['pp']=ie.radio(:name=>'rdProgressiveAPI',:checked=>"checked").value
    File.open("InputRepository/pp_settings_exec.yml","w"){|file| YAML.dump(ppval,file)}#Storing Progressive Profiling value for later use
    ie.radio(:name=>'rdDashboardOptimzer',:value => 'Disable').set
    ie.radio(:name=>'rdProgressiveAPI',:value => 'Disable').set
    ie.button(:value, "UPDATE").click
    ie.driver.manage.timeouts.implicit_wait = 10 
    ie.goto('http://p.usampadmin.com/add_site.php?site_id=Mg==')
    ie.driver.manage.timeouts.implicit_wait = 10 
    ie.radio(:name=>'rdDashboardVersion',:value=>'V1').set
    ie.button(:value, "Update").click
    ie.driver.manage.timeouts.implicit_wait = 10 
    ie.goto('http://p.usampadmin.com/login.php?hdMode=logout')
    ie.close
