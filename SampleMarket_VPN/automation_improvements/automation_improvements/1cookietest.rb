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


describe "Geo IP Tests on SB1, SB2, SB3, SB4, SB5, SB6, SB7 and SB8 on PRODUCTION" do

  before(:all) do
      #create an object of the UsampLib
      #@obj = Usamp_lib.new
      #@browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end
  

  it "Test to check if the GEO IP check and login works correctly on SB1" do
	  #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	  @browser = Watir::Browser.new :chrome
	  #@browser.goto('http://www.ipoll.com')
	  cookie1 = CGI::Cookie::new("name" => "SERVERID", "value" => "SB1")
	  @browser.goto('http://www.ipoll.com/registration_step1.php')
	  name = cookie1.name
	  value = cookie1.value
	  #puts name
	  #puts value
	  Country_value = @browser.select_list(:id,"optCountryId").text
	  Country_value.should include("United States")
	  @browser.goto('http://www.ipoll.com/')
	  sleep 3
	  if(@browser.div(:id=>"desktopCover").exists?)
		  #puts "before click -overquota"
		  @browser.div(:id=>"desktopCover").click
		  #puts "after click -overquota"
	  end
	  sleep 5
	  @browser.link(:id,"memLogin").click
	  sleep 3
	  @browser.text_field(:name, "txtEmail").set("sangeeta1@mailinator.com")
	  @browser.text_field(:name, "txtPassword").set("sangeeta1@mailinator.com")
	  @browser.button(:value,"Login").click
	  sleep 5
	  if(@browser.div(:id=>"loadingSurveys").exists?)
		  while @browser.div(:id=>"loadingSurveys").visible? do
			  sleep 0.5
			  puts "waiting for surveys to load"
		  end
	  end
	  @browser.text.should include("Welcome back, sangeeta. If you are not sangeeta")
	  @browser.goto("http://www.ipoll.com/?mode=logout")
	  @browser.close
  end


    it "Test to check if the GEO IP check and login works correctly on SB2" do
	  #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	  @browser = Watir::Browser.new :chrome
	  #@browser.goto('http://www.ipoll.com')
	  cookie1 = CGI::Cookie::new("name" => "SERVERID", "value" => "SB2")
	  @browser.goto('http://www.ipoll.com/registration_step1.php')
	  name = cookie1.name
	  value = cookie1.value
	  #puts name
	  #puts value
	  Country_value = @browser.select_list(:id,"optCountryId").text
	  Country_value.should include("United States")
	  @browser.goto('http://www.ipoll.com/')
	  sleep 3
	  if(@browser.div(:id=>"desktopCover").exists?)
		  #puts "before click -overquota"
		  @browser.div(:id=>"desktopCover").click
		  #puts "after click -overquota"
	  end
	  sleep 5
	  @browser.link(:id,"memLogin").click
	  sleep 3
	  @browser.text_field(:name, "txtEmail").set("sangeeta1@mailinator.com")
	  @browser.text_field(:name, "txtPassword").set("sangeeta1@mailinator.com")
	  @browser.button(:value,"Login").click
	  sleep 5
	  if(@browser.div(:id=>"loadingSurveys").exists?)
		  while @browser.div(:id=>"loadingSurveys").visible? do
			  sleep 0.5
			  puts "waiting for surveys to load"
		  end
	  end
	  @browser.text.should include("Welcome back, sangeeta. If you are not sangeeta")
	  @browser.goto("http://www.ipoll.com/?mode=logout")
	  @browser.close
  end
  
  
    it "Test to check if the GEO IP check and login works correctly on SB3" do
	  #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	  @browser = Watir::Browser.new :chrome
	  #@browser.goto('http://www.ipoll.com')
	  cookie1 = CGI::Cookie::new("name" => "SERVERID", "value" => "SB3")
	  @browser.goto('http://www.ipoll.com/registration_step1.php')
	  name = cookie1.name
	  value = cookie1.value
	  #puts name
	  #puts value
	  Country_value = @browser.select_list(:id,"optCountryId").text
	  Country_value.should include("United States")
	  @browser.goto('http://www.ipoll.com/')
	  sleep 3
	  if(@browser.div(:id=>"desktopCover").exists?)
		  #puts "before click -overquota"
		  @browser.div(:id=>"desktopCover").click
		  #puts "after click -overquota"
	  end
	  sleep 5
	  @browser.link(:id,"memLogin").click
	  sleep 3
	  @browser.text_field(:name, "txtEmail").set("sangeeta1@mailinator.com")
	  @browser.text_field(:name, "txtPassword").set("sangeeta1@mailinator.com")
	  @browser.button(:value,"Login").click
	  sleep 5
	  if(@browser.div(:id=>"loadingSurveys").exists?)
		  while @browser.div(:id=>"loadingSurveys").visible? do
			  sleep 0.5
			  puts "waiting for surveys to load"
		  end
	  end
	  @browser.text.should include("Welcome back, sangeeta. If you are not sangeeta")
	  @browser.goto("http://www.ipoll.com/?mode=logout")
	  @browser.close
  end
  
  
    it "Test to check if the GEO IP check and login works correctly on SB4" do
	  #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	  @browser = Watir::Browser.new :chrome
	  #@browser.goto('http://www.ipoll.com')
	  cookie1 = CGI::Cookie::new("name" => "SERVERID", "value" => "SB4")
	  @browser.goto('http://www.ipoll.com/registration_step1.php')
	  name = cookie1.name
	  value = cookie1.value
	  #puts name
	  #puts value
	  Country_value = @browser.select_list(:id,"optCountryId").text
	  Country_value.should include("United States")
	  @browser.goto('http://www.ipoll.com/')
	  sleep 3
	  if(@browser.div(:id=>"desktopCover").exists?)
		  #puts "before click -overquota"
		  @browser.div(:id=>"desktopCover").click
		  #puts "after click -overquota"
	  end
	  sleep 5
	  @browser.link(:id,"memLogin").click
	  sleep 3
	  @browser.text_field(:name, "txtEmail").set("sangeeta1@mailinator.com")
	  @browser.text_field(:name, "txtPassword").set("sangeeta1@mailinator.com")
	  @browser.button(:value,"Login").click
	  sleep 5
	  if(@browser.div(:id=>"loadingSurveys").exists?)
		  while @browser.div(:id=>"loadingSurveys").visible? do
			  sleep 0.5
			  puts "waiting for surveys to load"
		  end
	  end
	  @browser.text.should include("Welcome back, sangeeta. If you are not sangeeta")
	  @browser.goto("http://www.ipoll.com/?mode=logout")
	  @browser.close
  end
  
    it "Test to check if the GEO IP check and login works correctly on SB5" do
	  #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	  @browser = Watir::Browser.new :chrome
	  #@browser.goto('http://www.ipoll.com')
	  cookie1 = CGI::Cookie::new("name" => "SERVERID", "value" => "SB5")
	  @browser.goto('http://www.ipoll.com/registration_step1.php')
	  name = cookie1.name
	  value = cookie1.value
	  #puts name
	  #puts value
	  Country_value = @browser.select_list(:id,"optCountryId").text
	  Country_value.should include("United States")
	  @browser.goto('http://www.ipoll.com/')
	  sleep 3
	  if(@browser.div(:id=>"desktopCover").exists?)
		  #puts "before click -overquota"
		  @browser.div(:id=>"desktopCover").click
		  #puts "after click -overquota"
	  end
	  sleep 5
	  @browser.link(:id,"memLogin").click
	  sleep 3
	  @browser.text_field(:name, "txtEmail").set("sangeeta1@mailinator.com")
	  @browser.text_field(:name, "txtPassword").set("sangeeta1@mailinator.com")
	  @browser.button(:value,"Login").click
	  sleep 5
	  if(@browser.div(:id=>"loadingSurveys").exists?)
		  while @browser.div(:id=>"loadingSurveys").visible? do
			  sleep 0.5
			  puts "waiting for surveys to load"
		  end
	  end
	  @browser.text.should include("Welcome back, sangeeta. If you are not sangeeta")
	  @browser.goto("http://www.ipoll.com/?mode=logout")
	  @browser.close
  end
  
    it "Test to check if the GEO IP check and login works correctly on SB6" do
	  #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	  @browser = Watir::Browser.new :chrome
	  #@browser.goto('http://www.ipoll.com')
	  cookie1 = CGI::Cookie::new("name" => "SERVERID", "value" => "SB6")
	  @browser.goto('http://www.ipoll.com/registration_step1.php')
	  name = cookie1.name
	  value = cookie1.value
	  #puts name
	  #puts value
	  Country_value = @browser.select_list(:id,"optCountryId").text
	  Country_value.should include("United States")
	  @browser.goto('http://www.ipoll.com/')
	  sleep 3
	  if(@browser.div(:id=>"desktopCover").exists?)
		  #puts "before click -overquota"
		  @browser.div(:id=>"desktopCover").click
		  #puts "after click -overquota"
	  end
	  sleep 5
	  @browser.link(:id,"memLogin").click
	  sleep 3
	  @browser.text_field(:name, "txtEmail").set("sangeeta1@mailinator.com")
	  @browser.text_field(:name, "txtPassword").set("sangeeta1@mailinator.com")
	  @browser.button(:value,"Login").click
	  sleep 5
	  if(@browser.div(:id=>"loadingSurveys").exists?)
		  while @browser.div(:id=>"loadingSurveys").visible? do
			  sleep 0.5
			  puts "waiting for surveys to load"
		  end
	  end
	  @browser.text.should include("Welcome back, sangeeta. If you are not sangeeta")
	  @browser.goto("http://www.ipoll.com/?mode=logout")
	  @browser.close
  end
  
    it "Test to check if the GEO IP check and login works correctly on SB7" do
	  #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	  @browser = Watir::Browser.new :chrome
	  #@browser.goto('http://www.ipoll.com')
	  cookie1 = CGI::Cookie::new("name" => "SERVERID", "value" => "SB7")
	  @browser.goto('http://www.ipoll.com/registration_step1.php')
	  name = cookie1.name
	  value = cookie1.value
	  #puts name
	  #puts value
	  Country_value = @browser.select_list(:id,"optCountryId").text
	  Country_value.should include("United States")
	  @browser.goto('http://www.ipoll.com/')
	  sleep 3
	  if(@browser.div(:id=>"desktopCover").exists?)
		  #puts "before click -overquota"
		  @browser.div(:id=>"desktopCover").click
		  #puts "after click -overquota"
	  end
	  sleep 5
	  @browser.link(:id,"memLogin").click
	  sleep 3
	  @browser.text_field(:name, "txtEmail").set("sangeeta1@mailinator.com")
	  @browser.text_field(:name, "txtPassword").set("sangeeta1@mailinator.com")
	  @browser.button(:value,"Login").click
	  sleep 5
	  if(@browser.div(:id=>"loadingSurveys").exists?)
		  while @browser.div(:id=>"loadingSurveys").visible? do
			  sleep 0.5
			  puts "waiting for surveys to load"
		  end
	  end
	  @browser.text.should include("Welcome back, sangeeta. If you are not sangeeta")
	  @browser.goto("http://www.ipoll.com/?mode=logout")
	  @browser.close
  end
  	  
  it "Test to check if the GEO IP check and login works correctly on SB8" do
	  #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	  @browser = Watir::Browser.new :chrome
	  #@browser.goto('http://www.ipoll.com')
	  cookie1 = CGI::Cookie::new("name" => "SERVERID", "value" => "SB8")
	  @browser.goto('http://www.ipoll.com/registration_step1.php')
	  name = cookie1.name
	  value = cookie1.value
	  #puts name
	  #puts value
	  Country_value1 = @browser.select_list(:id,"optCountryId").text
	  Country_value1.should include("United States")
	  @browser.goto('http://www.ipoll.com/')
	  sleep 3
	  if(@browser.div(:id=>"desktopCover").exists?)
		  #puts "before click -overquota"
		  @browser.div(:id=>"desktopCover").click
		  #puts "after click -overquota"
	  end
	  sleep 5
	  @browser.link(:id,"memLogin").click
	  sleep 3
	  @browser.text_field(:name, "txtEmail").set("sangeeta1@mailinator.com")
	  @browser.text_field(:name, "txtPassword").set("sangeeta1@mailinator.com")
	  @browser.button(:value,"Login").click
	  sleep 5
	  if(@browser.div(:id=>"loadingSurveys").exists?)
		  while @browser.div(:id=>"loadingSurveys").visible? do
			  sleep 0.5
			  puts "waiting for surveys to load"
		  end
	  end
	  @browser.text.should include("Welcome back, sangeeta. If you are not sangeeta")
	  @browser.goto("http://www.ipoll.com/?mode=logout")
	  @browser.close
  end
  
  
	  #end while (@browser.text.should_not include ("Test Automation Project"))
	  #body_text.should_not include
	  #Country_value = @browser.select_list(:id,"optCountryId").text
      #Language_value = @browser.select_list(:id,"optLanguageId").text
      #
  
  after(:all) do
      #@browser.close
      puts "Test case has completed"
  end
  end