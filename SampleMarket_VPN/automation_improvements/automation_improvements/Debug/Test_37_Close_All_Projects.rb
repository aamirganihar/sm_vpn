require 'rubygems'
require './automation'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
require 'win32/clipboard'
include Win32 
require 'YAML'

require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Open projects

describe "Test 37: Close All Live Projects" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end
  
  it "Test to close all live projects " do
	  
   @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/viewprojects&s=4")
  
   #body_text = @browser.text
      
   while @browser.link(:text,/Test Automation Project/).exists? do
	@browser.link(:text,/Test Automation Project/).click
        @browser.link(:text,"Close").click
        sleep 3
        @browser.driver.switch_to.alert.accept
	sleep 2
	@browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/viewprojects&s=4")
   end
 end
 
    after(:all) do
        @browser.link(:text,"Log Out").click
        @browser.close
        puts "Test case for production has completed"
    end
end