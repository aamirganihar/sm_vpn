require 'rubygems'
require './automation'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
require 'win32/clipboard'
require 'digest/md5'
#require 'base64'
require "base64"
include Win32 
require 'YAML'


require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 18: Dashboard, Email invite survey cases and reward checking" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@browser = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    #@browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
     
  end

   
  it "To Get Project and group details for survey Taking and Get IDs" do

     #@enc_group_name="79978"
     #puts @enc_group_name
     #@dec_group_id=Base64.decode64(@enc_group_name)
     #@dec_group_id=Base64.decode64(@enc_group_name.to_s)
     #puts @dec_group_id
     @dec_group_link="linkNzk5Nzg="
     puts @dec_group_link
     
     #@browser.link(:text,/SampleMarket/).click
     #p "#{@prj_name}"
     #p "one:#{@dec_group_link}"
     #body_text = @browser.text
     #body_text.should include("#{@prj_name}")
     i=0
    while i<1 do
    driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
    @browser = Watir::Browser.new driver
    #ff.maximize

	    @browser.goto('http://www.surveyhead.com')
	    # Setting login credentials (email/password)
	    @browser.text_field(:name, "txtEmail").set("sangeeta19@mailinator.com")
	    @browser.text_field(:name, "txtPassword").set("sangeeta19@mailinator.com")

	    @browser.button(:value,"login").click
	    sleep 6
	    #if(@browser.link(:id,"sb-nav-close").exists?)
		      #@browser.link(:id,"sb-nav-close").click
	      #end
	      #sleep 5
	      
	      if(@browser.div(:id=>"loadingSurveys").exists?)
		      while @browser.div(:id=>"loadingSurveys").visible? do
			      sleep 0.5
			      puts "waiting for surveys to load"
		      end
	      end
	      

	      sleep 3
	      #body_text = @browser.text
	      #body_text.should include("#{@dec_group_id}")
	      @browser.link(:id,"#{@dec_group_link}").click
	      @browser.button(:name,'Submit').click
	      sleep 5
	      @browser.close
	#loop for completes      
=begin      
	      @browser1.window(:title => /TEST_AUTOMATION_SURVEY/).use do
	      @browser1.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
	      body_text = @browser1.text
	      body_text.should include("CONGRATULATIONS")
	      @browser1.close
=end      
		i+=1
	end
end

=begin
    it "Test to check if the survey is not shown to a member on the dashboard if the project is paused" do
      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']

      @browser.link(:text,"Pause").click

      sleep(2)
      @browser.driver.switch_to.alert.accept
      #@browser.link(:text,"Close").should exist

      @browser1 = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
      sleep 3
      body_text = @browser1.text
      body_text.should_not include("#{@dec_group_id}")
      @browser1.close
   end

  it "Test to check if a member is not able to Not See a survey on dashboard for a Closed project" do

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']

      @browser.link(:text,"Close").click
      sleep(2)
      @browser.driver.switch_to.alert.accept

      @browser1 = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
      sleep 3
       body_text = @browser1.text
       body_text.should_not include("#{@dec_group_id}")
      @browser1.close
   end

   it "Test to check if a member is able to Complete a survey and check for reward" do

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']


      @browser.link(:text,"Go Live").click
      @browser.link(:text,"golive").click
      sleep(2)

      @browser1 = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
      sleep 3
      body_text = @browser1.text
      body_text.should include("#{@dec_group_id}")
      @browser1.link(:id,"#{@dec_group_link}").click
      @browser1.button(:name,'Submit').click
      sleep 10
      @browser1.window(:title => /TEST_AUTOMATION_SURVEY/).use do
      @browser1.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
      body_text = @browser1.text
      body_text.should include("CONGRATULATIONS")
      @browser1.link(:text,"Rewards").click
      sleep 7

        #Check for reward updation on surveyhead site
        @html_contents=@browser1.html
              @html_array = @html_contents.split(/\n/)
                0.upto(@html_array.size - 1) { |index|

                  if(@html_array[index] =~ /#{@dec_group_id}/)

                      @html_array[index+5].should include("1.50")

                        next
                  else
                end
                }
        end

      @browser1.link(:text,"Logout").click
      system("cookies.bat")
      @browser1.close
      sleep 2

   end


   it "Test to check if a member is able to Fail a survey" do

      sleep(95)
      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']

      @browser.link(:text,"Pause").click
      sleep(2)
      @browser.driver.switch_to.alert.accept
      @browser.link(:text,"Pause").click

      @browser.link(:text,"Go Live").click
      @browser.link(:text,"golive").click

      @browser1 = @obj.Surveyhead_login("test22.des04@mailop.com","test22.des04@mailop.com")
      sleep 15
      if(@browser1.button(:name,"btnDashboard").exists?)
	      @browser1.button(:name,"btnDashboard").click
      end
    
      body_text = @browser1.text
      body_text.should include("#{@dec_group_id}")
      sleep 10
      @browser1.link(:id,"#{@dec_group_link}").click
      @browser1.button(:name,'Submit').click
      sleep 5
      @browser1.window(:title => /TEST_AUTOMATION_SURVEY/).use do
      @browser1.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
      body_text = @browser1.text
      body_text.should_not include("CONGRATULATIONS")

      @browser1.link(:text,"Rewards").click

      #Check for the group not seen on rewards page
      
      body_text.should_not include("#{@dec_group_id}")
      end
      sleep 10
      @browser1.link(:text,"Logout").click
      
      system("cookies.bat")
      @browser1.close

    end

    it "Test to check if a member is able to fire the Over quota redirect" do

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']

      group_name = File.open("InputRepository/Groupname_Dashboard.yml"){|file| YAML::load(file)}
      @grp_name = group_name['group']

      @browser1 = @obj.Surveyhead_sm_login("test22.des01@mailop.com","test22.des01@mailop.com")
      sleep 15
      body_text = @browser1.text
      body_text.should include("#{@grp_name}")
      @browser1.link(:id,"#{@dec_group_link}").click
      @browser1.button(:name,'Submit').click
      sleep 5
      @browser1.window(:title => /TEST_AUTOMATION_SURVEY/).use do
      @browser1.goto("http://p.sm1mr.com/ssred.php?S=3&ID=")
      body_text = @browser1.text
      body_text.should_not include("Congratulations")

      @browser1.link(:text,"My Rewards").click
      #Check for the group not seen on rewards page
      body_text.should_not include("#{@dec_group_id}")
      
      end
      @browser1.link(:text,"Logout").click
      system("cookies.bat")
      @browser1.close

      sleep 2
      
    end

  it "Test to check if a member is not able to see a survey on dashboard for a Completed project and Check member data review" do

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']
#      @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=group/run&prid=Mzc2OQ==&groupid=NTgxMg==#dashboard")

      @browser.link(:text,"Close").click
      sleep(2)
      @browser.driver.switch_to.alert.accept
      @browser.link(:text,/Test Automation Project/).click
      sleep(1)
      #@browser.link(:text,/Member Data/).click
      sleep(5)
      #@browser.link(:text,/Select All/).click
    
      @browser.link(:text,/Submit Valid Completes/).click
=begin      
      sleep 5
      @url = @browser.url
      @browser.close
      sleep 3
      @browser = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
      @browser.goto(@url)
      #@browser.refresh
#=end      
      sleep 120
      @browser.refresh
      sleep 5
      @browser.checkbox(:id,"chkChaPrjStatus").set(true)
      @browser.link(:text,/Complete Project/).click
      sleep 8
      @browser.link(:text,/Done/).click
      sleep 5

      body_text = @browser.text
      body_text.should include("COMPLETED")
      body_text.should include("Project is COMPLETED and members have been rewarded.")

      sleep(2)

      @browser1 = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
      sleep 3
       body_text = @browser1.text
       body_text.should_not include("#{@dec_group_id}")

      if (@browser1.link(:text,"Rewards").exists?)
        @browser1.link(:text,"Rewards").click
      end
      
      #Check for reward updation on surveyhead site
      @html_contents=@browser1.html
            @html_array = @html_contents.split(/\n/)
              0.upto(@html_array.size - 1) { |index|

                if(@html_array[index] =~ /#{@dec_group_id}/)

                    @html_array[index+5].should include("1.50")
                    @html_array[index+7].should include("earned")

                else
                      next
              end
              }

      @browser1.link(:text,"Logout").click
      @browser1.close
      sleep 2
#

   end
=end
   after(:all) do
     #@browser.close

    #@browser1.window(:title => /Paid Surveys/).use do
        #@browser1.link(:text,"Logout").click
        #@browser1.close
    #end

   puts "test 18 has completed" 
   end

end

