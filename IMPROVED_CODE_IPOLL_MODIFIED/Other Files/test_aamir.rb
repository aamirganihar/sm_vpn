require 'rubygems'
require 'test/unit'
#Load WATIR
#require 'watir'
#require "selenium_support"
require 'fileutils'
# Load WIN32OLE library
require 'win32ole' 
require 'Win32API'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"



        
  # Method to login to Usampadmin site
  # Parameters passed : email and password
  # Parameters returned : IE instance
          

                
#    capabilities = Selenium::WebDriver::Remote::Capabilities.firefox #(:javascript_enabled => true, :proxy=> Selenium::WebDriver::Proxy.new(:http => "localhost:5865"))
#    ie = Watir::Browser.new(:remote, :url => "http://127.0.0.1:4444/wd/hub", :desired_capabilities => capabilities)
    driver = Selenium::WebDriver.for :ie #, #:profile => "Selenium"
   ie = Watir::Browser.new driver
     #Watir.driver = :webdriver
     #ie = Watir::Browser.new(:internet_explorer)
     #Watir.driver = :webdriver
     #ie = Watir::Browser.new :ie
    ie.goto('http://p.usampadmin.com')
    if ie.text.include?('Logout')
      ie.goto("http://p.usampadmin.com/login.php?hdMode=logout")
    end
    # Setting login credentials (email/password)

    ie.text_field(:name,"txtEmail").set email
    ie.text_field(:name,"txtPassword").set passwd

    #Click login button
    ie.button(:value, "Login").click
    # Checkpoint to verify that login was successful

  
