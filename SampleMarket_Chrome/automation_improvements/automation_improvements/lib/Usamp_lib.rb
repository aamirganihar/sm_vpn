require 'rubygems'
require 'test/unit'
#Load WATIR
require "selenium_support"
require 'fileutils'
# Load WIN32OLE library
require 'win32ole' 
require 'Win32API'
gem "selenium-client"
require "selenium/client"
#require "watir-webdriver"
#require "watir"
class Usamp_lib 
        
  # Method to login to Usampadmin site
  # Parameters passed : email and password
  # Parameters returned : IE instance
          
  def Usampadmin_login(email,passwd)
                
#    capabilities = Selenium::WebDriver::Remote::Capabilities.firefox #(:javascript_enabled => true, :proxy=> Selenium::WebDriver::Proxy.new(:http => "localhost:5865"))
#    ie = Watir::Browser.new(:remote, :url => "http://127.0.0.1:4444/wd/hub", :desired_capabilities => capabilities)
    #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
    #ie = Watir::Browser.new driver
    ie = Watir::Browser.new :chrome
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

    raise("Sorry! System Failed to login to Usampadmin") unless ie.link(:text,'Logout').exists?
    return ie
  end
  
          
  # Method to login to Surveyhead site
  # Parameters passed : email and password
  # Parameters returned : IE instance
          
  def Surveyhead_login(email,passwd)

   # New IE instance creation
    #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
    #ff = Watir::Browser.new driver
    ff = Watir::Browser.new :chrome
    #ff.maximize
 #Timeout::timeout(120) do
#ff.goto('http://www.p.ipoll.com')
#end
#rescue Timeout::Error => e
#puts “Page load timed out: #{e}”
  ff.goto('http://www.p.ipoll.com')
    #puts "hi"
    # Setting login credentials (email/password)
    #sleep 3     #==SAISH==   commented the sleep
ff.driver.manage.timeouts.implicit_wait = 120  
    #if(ff.div(:id=>"desktopCover").exists?)			
	#		ff.div(:id=>"desktopCover").click			
	#	end
	#	sleep 5
    ff.link(:id,"memLogin").click
    #puts "hello"
    ff.text_field(:name, "txtEmail").set(email)
    ff.text_field(:name, "txtPassword").set(passwd)

    ff.button(:value,"Login").click
    # sleep 15
    # if(ff.link(:id,"sb-nav-close").exists?)
	      # ff.link(:id,"sb-nav-close").click
      # end
      # sleep 5
      
      # if(ff.div(:id=>"loadingSurveys").exists?)
	      # while ff.div(:id=>"loadingSurveys").visible? do
		      # sleep 0.5
		      # puts "waiting for surveys to load"
	      # end
      # end
	  Watir::Wait.until { ff.text.include? 'Survey Number' }#explicit wait:default timeout :30sec
      
    raise("Sorry! System Failed to login to Usampadmin") unless ff.link(:text,'Logout').exists?
    return ff

  end
        
  # Method to login to sm.p.Surveyhead site
  # Parameters passed : email and password
  # Parameters returned : IE instance
          
  def Surveyhead_sm_login(email,passwd)
                
    # New IE instance creation
    #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
    #ff = Watir::Browser.new driver
    ff = Watir::Browser.new :chrome
    #ff.maximize

    # Opening Usampadmin site
    ff.goto('http://www.sm.p.surveyhead.com')
    #ff.goto('s.pl1.ipoll.com')
    	ff.driver.manage.timeouts.implicit_wait = 8  #==SAISH==
    # Setting login credentials (email/password)
    ff.text_field(:name, "txtEmail").set(email)
    ff.text_field(:name, "txtPassword").set(passwd)
    #Click login button
    ff.button(:value, "Login").click
    
    #if(ff.link(:id,"sb-nav-close").exists?)                              
	#    ff.link(:id,"sb-nav-close").click
      #end
    # sleep 5
      
     # if(ff.div(:id=>"loadingSurveys").exists?)
      #while ff.div(:id=>"loadingSurveys").visible? do
      #sleep 0.5
   #puts "waiting for surveys to load"
#end
#end
 
      Watir::Wait.until { ff.text.include? 'Survey Name' }#explicit wait:default timeout :30sec:HRISHI
      
     
          sleep 10      
    # Checkpoint to verify that login was successful
    raise("Sorry! System Failed to login to Usampadmin") unless ff.link(:text,'Logout').exists?
    return ff
  end
              
              
  #Parameters : IE instance
  def Network_site_login(email,passwd,type)
                
    # New Firefox instance creation
    #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
    #driver = Selenium::WebDriver.for 
    #driver = Selenium::WebDriver.for :chrome, :profile => "Selenium"
    download_directory = "D:\\SampleMarket_Downloads\\"
    #download_directory.gsub!("/", "\\") if  Selenium::WebDriver::Platform.windows?
    profile = Selenium::WebDriver::Chrome::Profile.new
    profile['download.prompt_for_download'] = false
    profile['download.default_directory'] = download_directory
    ENV['HTTP_PROXY'] = ENV['http_proxy'] = nil
    ff = Watir::Browser.new :chrome#, :profile => profile
    #ff = Watir::Browser.new :chrome
    #ff = Watir::Browser.new driver
    #ff.window.resize_to(800, 600)
    #ff.maximize()
    
    #capabilities = Selenium::WebDriver::Remote::Capabilities.firefox #(:javascript_enabled => true, :proxy=> Selenium::WebDriver::Proxy.new(:http => "localhost:5865"))
    #driver = Selenium::WebDriver::Remote::Capabilities.firefox(:profile => "Selenium")
    #ff = Watir::Browser.new(:remote, :url => "http://127.0.0.1:4444/wd/hub", :desired_capabilities => capabilities)
#    ff = Selenium::Client::Driver.new \
#      :host => "localhost",
#      :port => 4444,
#      :browser => "*chrome",
#      :timeout_in_second => 60,
#      :url => "https://p.network.u-samp.com/"
#
#    ff.driver.start_new_browser_session(:captureNetworkTraffic => true)
    #firefox.exe -P Selenium
    #ff = custom C:\Program Files\Mozilla Firefox\firefox.exe -P firefox_browser
    #ff.clear_cookies
    # Opening Usampadmin site
    #capabilities = Selenium::WebDriver::Remote::Capabilities.firefox #(:javascript_enabled => true, :proxy=> Selenium::WebDriver::Proxy.new(:http => "localhost:5865"))
    #ff = Watir::Browser.new(:remote, :url => "http://127.0.0.1:4444/wd/hub", :desired_capabilities => capabilities)
    #ff = Watir::Browser.new(:remote, :url => "http://127.0.0.1:4444/wd/hub", :desired_capabilities => capabilities)
    #ff = Watir::Browser.new(:remote, :desired_capabilities => capabilities)
    #ff = Watir::Browser.start("http://127.0.0.1:4444/wd/hub", :firefox, :remote)
    ff.goto('https://p.network.u-samp.com/login.php')
	ff.driver.manage.timeouts.implicit_wait = 8  #==SAISH==
    #ff.clear_cookies
    # Setting login credentials (email/password)
    if (type == 'Client')
      ff.radio(:value, "Client").set
    else
      ff.radio(:value,"Publisher").set
    end
    ff.text_field(:id, "txtEmail").set(email)
    ff.text_field(:id, "txtPassword").set(passwd)
    #Click login button
    #puts "Before loging to Network site"
    ff.link(:id,"btnLogin").click
    sleep 5
    
    #puts "After loging to Network site"
    
    # Checkpoint to verify that login was successful
    #ff.frame(:id,"iframebox").link(:text, "Click Menu Item").click ...
    #iframe id="iframebox"
    #ff.text.should include("welcome")
#    if (ff.contains_text('Welcome'))
#      puts "Logged it to Network site"
#    else
#      puts "Sorry! System Failed to login to Network site"
#    end
    return ff
  end
  end