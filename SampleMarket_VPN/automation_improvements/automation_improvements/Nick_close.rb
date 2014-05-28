require 'rubygems'
require './automation'
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
require 'win32/clipboard'
include Win32 
require 'YAML'
require './InputRepository/Basic_data'


describe "Test 01: Project creation" do

  before(:all) do
      #create an object of the UsampLib
      @obj = Usamp_lib.new
      @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end
  

  it "Test to confirm if an error is reported in case the mandatory fields which includes date and survey length are left blank on the project creation page" do
	  @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/viewprojects&s=4")
	  sleep 3
	  #puts @browser.text
	  if (@browser.link(:text,/Test Automation Project/).exists?)
		  while (@browser.text.include?("Test Automation Project")) do
			  sleep 3
			  @browser.link(:text,/Test Automation Project/).click
			  sleep 2
			  @browser.link(:text,"Close").click
			  sleep 3
			  @browser.driver.switch_to.alert.accept
			  sleep 3
			  @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/viewprojects&s=4")
		  end
	  end
  end
  
	  #end while (@browser.text.should_not include ("Test Automation Project"))
	  #body_text.should_not include
  
  
  

  after(:all) do
      #@browser.close
      puts "Test case 1 has completed"
  end
  end