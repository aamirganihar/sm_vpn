require 'rubygems'
require 'test/unit'
#Load WATIR
require 'watir'
require 'fileutils'
# Load WIN32OLE library
require 'win32ole' 
require 'Win32API'



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
			
			def Usampadmin_login(email,passwd)
                
                # New IE instance creation
                ie = Watir::IE.new
                # Opening Usampadmin site
                ie.speed = :zippy
                ie.goto('http://p.usampadmin.com')
                ie.maximize
                sleep(4)
                if ie.contains_text('Logout')
                  #ie.goto("#{url}?hdMode=logout")
				  return ie
				  break
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
                ff = FireWatir::Firefox.new
                ff.maximize
                # Opening Surveyhead site
                ff.goto('http://www.p.surveyhead.com')
                if (ff.contains_text('Logout'))
                  #ff.link(:text,'Logout').click
				  ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
                end
                            
                # Setting login credentials (email/password)
                ff.text_field(:name, "txtEmail").set(email)
                ff.text_field(:name, "txtPassword").set(passwd)
                
                #Click login button
                if(ff.button(:value, "login").exists?)
                ff.button(:value, "login").click
                end
                sleep 15
                # Checkpoint to verify that login was successful
                if (ff.link(:text,'Dashboard').exists?)
                      puts "Successful Login to Surveyhead site"
                else
                      puts "Sorry! System Failed to login to Surveyhead site"
                end
                return ff
            end
		  
		    def Focusline_login(email,passwd)
                
                
                ff = FireWatir::Firefox.new
                ff.maximize
                # Opening Usampadmin site
                ff.goto('http://www.sm.p.surveyhead.com')
                if ff.contains_text('Logout')
                  #ff.link(:text,'Logout').click
				  ff.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
                end              
                # Setting login credentials (email/password)
                ff.text_field(:name, "txtEmail").set(email)
                ff.text_field(:name, "txtPassword").set(passwd)
                ff.button(:value, "Login").click
                sleep 15
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
                ff = FireWatir::Firefox.new
                ff.maximize
                # Opening Usampadmin site
                ff.goto('https://p.network.u-samp.com/login.php')
                  
                if(ff.contains_text('Welcome'))
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
                if (ff.contains_text('Welcome'))
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
                          Watir::IE.attach(:url, /http(s)?:\/\/(.)*/).close
                      rescue Watir::Exception::NoMatchingWindowFoundException
                          break
                      rescue
                          retry
                      end
                  end
                end
		  
  
end