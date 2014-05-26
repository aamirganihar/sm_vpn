require 'rubygems'
require 'test/unit'
#Load WATIR
#require 'watir'
require 'fileutils'
# Load WIN32OLE library
require 'win32ole' 
require 'Win32API'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"




class Usamp_lib 
  
            def Delete_cookies
              
                  $cookie_Dir= "C:\\Documents and Settings\\#{ENV['USERNAME']}\\Local Settings\\Temporary Internet Files"
                  $flash_cookie_Dir="C:\\Documents and Settings\\#{ENV['USERNAME']}\\Application Data\\Macromedia\\Flash Player\\#SharedObjects"
                  $flash_cookie_Dir_sys="C:\\Documents and Settings\\#{ENV['USERNAME']}\\Application Data\\Macromedia\\Flash Player"
                  #Delete the cookies
                  FileUtils.rm_rf $cookie_Dir 
                  FileUtils.rm_rf $flash_cookie_Dir
                  FileUtils.rm_rf $flash_cookie_Dir_sys
              
            end
			
			def Usampadmin1_login(email,passwd)
                
                # New IE instance creation
                #ie = Watir::IE.new
		 driver = Selenium::WebDriver.for :firefox #, #:profile => "Selenium"
                 ie = Watir::Browser.new driver
		#ie = Watir::Browser.new :firefox
                # Opening Usampadmin site
                #ie.speed = :zippy
                ie.goto('http://q.usampadmin.com')
                #ie.maximize
                sleep(4)
                if ie.text.include?('Logout')
                  ie.goto("#{url}?hdMode=logout")
				  return ie
				  #break
                end
                  # Setting login credentials (email/password)
                  ie.text_field(:name, "txtEmail").set(email)
                  ie.text_field(:name, "txtPassword").set(passwd)
                  #Click login button
				  sleep 2
                  ie.button(:value, "Login").click
                  # Checkpoint to verify that login was successful
                sleep 2
                if (ie.link(:text,'Logout').exists?)
                      puts "Successful Login to Usampadmin"
					  return ie
                else
                      puts "Sorry! System Failed to login to Usampadmin"
	      end
	      end
                                
			
			
			def Usampadmin_login(email,passwd)
                
                # New IE instance creation
                #ie = Watir::IE.new
		 driver = Selenium::WebDriver.for :ie #, #:profile => "Selenium"
                 ie = Watir::Browser.new driver
		#ie = Watir::Browser.new :firefox
                # Opening Usampadmin site
                #ie.speed = :zippy
                ie.goto('http://q.usampadmin.com')
                #ie.maximize
                sleep(4)
                if ie.text.include?('Logout')
                  ie.goto("#{url}?hdMode=logout")
				  return ie
				  #break
                end
                  # Setting login credentials (email/password)
                  ie.text_field(:name, "txtEmail").set(email)
                  ie.text_field(:name, "txtPassword").set(passwd)
                  #Click login button
				  sleep 2
                  ie.button(:value, "Login").click
                  # Checkpoint to verify that login was successful
                sleep 2
                if (ie.link(:text,'Logout').exists?)
                      puts "Successful Login to Usampadmin"
					  return ie
                else
                      puts "Sorry! System Failed to login to Usampadmin"
                end
                                
            end
			
			def Surveyhead_login(email,passwd)
                
                # New FireFox instance creation
                #ff = FireWatir::Firefox.new
		 driver = Selenium::WebDriver.for :firefox #, #:profile => "Selenium"
                 ff = Watir::Browser.new driver
                #ff.maximize
                # Opening Surveyhead site
                ff.goto('http://www.q.ipoll.com')
                     if ff.text.include?('Logout')
                  ff.link(:text,'Logout').click
                  ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
                end
                ff.link(:id,"memLogin").click
                # Setting login credentials (email/password)
                ff.text_field(:name, "txtEmail").set(email)
                ff.text_field(:name, "txtPassword").set(passwd)
                #Click login button
                if(ff.button(:value, "Login").exists?)
                  ff.button(:value, "Login").click
                end
                if(ff.link(:id,"sb-nav-close").exists?)
                  ff.link(:id,"sb-nav-close").click
                end
                sleep 5
                timeout = 45
                start_time = Time.now
                if(ff.div(:id=>"loadingSurveys").exists?)
                  while ff.div(:id=>"loadingSurveys").visible? do
                  sleep 0.5
                  puts "waiting for surveys to load"
                  if Time.now - start_time> timeout    
                  puts "Timed out after #{timeout} seconds"
                  raise RuntimeError, "Timed out after #{timeout} seconds"   
                end
              end
            end
            sleep 10
            # Checkpoint to verify that login was successful
            if (ff.link(:text,'Dashboard').exists?)
              puts "Successful Login to ipoll site"
              else
                puts "Sorry! System Failed to login to ipoll site"
              end
              return ff
            end
            
		  
		    def Focusline_login(email,passwd)
                
                
                @driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
		@driver.assume_untrusted_certificate_issuer=false
		@driver.secure_ssl = true
		ff = Watir::Browser.new :firefox, :profile => @driver
                #ff.maximize
                # Opening Usampadmin site
                #ff.goto('http://s.pl1.ipoll.com/')
				ff.goto('http://www.sm.q.surveyhead.com/')
                if ff.text.include?('Logout')
                  ff.link(:text,'Logout').click
                  #ff.goto("http://s.pl1.ipoll.com/index.php?mode=logout")
				  ff.goto("http://www.sm.q.surveyhead.com/index.php?mode=logout")
                end
                # Setting login credentials (email/password)
                ff.text_field(:name, "txtEmail").set(email)
                ff.text_field(:name, "txtPassword").set(passwd)
                ff.button(:value, "Login").click
              
              if(ff.link(:id,"sb-nav-close").exists?)
                ff.link(:id,"sb-nav-close").click
              end
              sleep 5
              timeout = 45
              start_time = Time.now
              if(ff.div(:id=>"loadingSurveys").exists?)
                while ff.div(:id=>"loadingSurveys").visible? do
                sleep 0.5
                puts "waiting for surveys to load"
                if Time.now - start_time> timeout    
                  puts "Timed out after #{timeout} seconds"
                raise RuntimeError, "Timed out after #{timeout} seconds"   
              end
            end
          end
            
                # Checkpoint to verify that login was successful
                if (ff.link(:text,'Dashboard').exists?)
                      puts "Successful Login to Focusline site"
                else
                      puts "Sorry! System Failed to login to Focusline site"
	      end
                return ff
            end
			
			def Network_site_login(email,passwd,type)
                
                # New Firefox instance creation
                #ff = FireWatir::Firefox.new
		 driver = Selenium::WebDriver.for :firefox #, #:profile => "Selenium"
                 ff = Watir::Browser.new driver
                #ff.maximize
                # Opening Usampadmin site
                ff.goto('https://q.network.u-samp.com/login.php')
                  
                if(ff.text.include?('Log Out'))
                   ff.link(:text,'Log Out').click
                end
                               
                # Setting login credentials (email/password)
                if (type == 'Client')
                        ff.radio(:value, "Client").set
                else
                        ff.radio(:value,"Publisher").set
                end
                ff.text_field(:id, "txtEmail").set(email)
                ff.text_field(:id, "txtPassword").set(passwd)
                #Click login button
                ff.link(:id,"btnLogin").click
                # Checkpoint to verify that login was successful
                #ff.frame(:id,"iframebox").link(:text, "Click Menu Item").click ...
                #iframe id="iframebox"
                if (ff.text.include?('Welcome'))
                      puts "Logged it to Network site"
                else
                      puts "Sorry! System Failed to login to Network site"
                end
                return ff                             
	end

			
			def Test_report(test_description)
                $myfile = File.open($out_fl_path, 'a')
                $myfile.print "<col span=\"2\" /><col />"
                $myfile.print "<tr>"
                $myfile.print "<th colspan=\"3\" align=\"left\">"
                $myfile.print "<font align=\"left\">"+test_description+"</font></th>"
                $myfile.print "</tr><tr><td class=\"td1\"><strong>Test ID</strong></td>"
                $myfile.print "<td class=\"td2\"><strong>Test Case Description</strong></td>"
                $myfile.print "<td class=\"td3\"><strong>Result</strong></td></tr>"
           end
		   
		   def Close_all_windows
                  loop do
                      begin
                          #Watir::IE.attach(:url, /http(s)?:\/\/(.)*/).close
			   driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                            ie = Watir::Browser.new driver
			    ie.window(:url, "http(s)?:\/\/(.)*").use do
				    #ie.window(:text, "WebDriver").use do
				    ie.close
			    end
			    
                      rescue Watir::Exception::NoMatchingWindowFoundException, Watir::Exception::UnknownObjectException, Timeout::Error
                          break
                      rescue
                          retry
                      end
                  end
                end
		  
  
end