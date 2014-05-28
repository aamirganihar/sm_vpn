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
require 'win32/screenshot'

require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 40: Supplier workflow" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "Test to create a project on network site with multiple publisher channels and also a supplier" do
	    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=project/list&prid=NTgzNDQ=#groups")
    end
    

    
    
    it "To check if the Supplier channel is allowed to go live once the redirect links are added" do
	    sleep 5
	    @browser.link(:text,/Test Automation Group/).click
	    sleep 4
	    #@browser.link(:text,"Test Sup 1").flash
	    #@browser.link(:text,"Test Sup 1").flash
	    #@browser.link(:text,"Test Sup 1").flash
	    @browser.link(:text,"Test Sup 1").click
	    @browser.link(:text,"Test Sup 1").click
	    @browser.link(:text,"Test Sup 1").click
	    #@browser.link(:text,/Test Sup 1/).click
	    #@browser.link(:text,/Test Sup 1/).click
	    #@browser.div(:id,"groupSnapShotPane_67307").link(:text,"Test Sup 1").click
	    sleep 2
	    sleep 2
	    if (@browser.div(:id=>"fancybox-loading").exists?)
		    while @browser.div(:id=>"fancybox-loading").visible? do
			    sleep 0.5
			    puts "waiting for element"
		    end
	    end
	    sleep 5
	    #@browser.radio(:id,"redirect_options_3").flash
	    @browser.radio(:name =>"redirectSetting", :value => "does_not_use").flash
	    @browser.radio(:name =>"redirectSetting", :value => "does_not_use").flash
	    @browser.radio(:name =>"redirectSetting", :value => "does_not_use").flash
	    @browser.radio(:name =>"redirectSetting", :value => "does_not_use").set
	    @browser.radio(:name =>"redirectSetting", :value => "does_not_use").set
	    #@browser.radio(:id,"redirect_options_3").flash
	    @browser.radio(:id,"redirect_options_3").set
	    sleep 3
	    @browser.link(:text,"Save").click
	    sleep 2
	    #sleep 2
	    if (@browser.div(:id=>"fancybox-loading").exists?)
		    while @browser.div(:id=>"fancybox-loading").visible? do
			    sleep 0.5
			    puts "waiting for element"
		    end
	    end
	    sleep 4
	    #puts @browser.text
	    @browser.text.should_not include("You have added supplier channels")
	    @browser.text.should_not include("You cannot go live with a supplier channel until you have entered the supplier redirect links. Supplier channels with missing redirect links are marked with a red asterisk.")
    end
=begin    
      it "To Get Project and group details for IDs" do
#
#     project_name = File.open("InputRepository/Projectname_Stats.yml"){|file| YAML::load(file)}
#     @prj_name =  project_name['project']
#     group_name = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
#     @grp_name = group_name['group']
#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=group/run&prid=NDQ3NA==&groupid=NjY4OQ==#dashboard")
##     @browser.link(:text,/SampleMarket/).click
##
##      until(@browser.link(:text,/#{@prj_name}/).exists?)
##       @browser.link(:text,'Next').click
##        sleep(2)
##      end
#
#     @browser.link(:text,/#{@prj_name}/).click
     @browser.link(:text,/Test Automation Group/).click
     sleep 5
     @group_url=@browser.url
     puts @group_url
     @enc_group_name=/groupid=(\w+)=/.match(@group_url)
     # @enc_group_name=/groupid=([A-Za-z])+==/
     @enc_group_name=@enc_group_name.to_s()
     # puts @enc_group_name
     @enc_group_name=@enc_group_name[8..15]
     puts @enc_group_name
     #@dec_group_id=Base64.decode64(@enc_group_name)
     #puts @dec_group_id
     #@dec_group_link="link"+@enc_group_name
     #@browser.link(:text,/SampleMarket/).click
     #p "#{@prj_name}"
     p "one:#{@enc_group_name}"
     #body_text = @browser.text
     #body_text.should include("#{@prj_name}")
    group = {}
    group['group_name'] = @enc_group_name
    #group_id['group_link'] = @dec_group_link

    File.open("InputRepository/Group_Id_supplier.yml","w"){|file| YAML.dump(group,file)}

    #@browser.close
    end

    
    it "Test to check if the supplier link cannot be used before the supplier channel is made live <b>(Test to monitor the defect DE1705)</b>" do
	    group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	    @enc_group_name =  group['group_name']
	    driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new driver
	    @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=NjI=")
	    sleep 2
	    @browser1.text.should_not include("THIS IS A TEST AUTOMATION SURVEY")
	    @browser1.close
    end
    
    it "Test to make all the channels live" do
	    @browser.link(:text,"Pause").click
	    sleep 3
	    @browser.driver.switch_to.alert.accept
	    sleep 2
	    while @browser.div(:id=>"fancybox-loading").visible? do
		    sleep 0.5
		    puts "waiting for element"
	    end
	    sleep 4
	    @browser.link(:text,"Go Live").click
	    sleep 4
	    @browser.link(:text,"golive").click
	    sleep 4
	    @browser.link(:text,"Pause").should exist
	    @browser.link(:text,"Close").should exist
    end
    
    
    it "Test to check if a member can see the survey on dashboard" do
  	      sleep 2
	      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
	      @browser1 = @obj.Surveyhead_sm_login("test22.des00@mailop.com","test22.des00@mailop.com")
	      sleep 3
	      group_name = File.open("InputRepository/groupname_Sup.yml"){|file| YAML::load(file)}
	      grp_name = group_name['group']
	      sleep 3
	      body_text = @browser1.text
	      body_text.should include("#{grp_name}")
	      @browser1.link(:text,"Logout").click
	      @browser1.close
      end
      
      it "Test to check if a user can successfully complete a survey using a supplier link" do
	      group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	      @enc_group_name =  group['group_name']
	      driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	      @browser1 = Watir::Browser.new driver
	      @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=NjI=")
	      sleep 2
	      @browser1.text.should include("THIS IS A TEST AUTOMATION SURVEY")
	      @browser1.goto("http://p.sm1mr.com/smsup_red.php?S=1")
	      @browser1.text.should include("Congratulations,")
	      @browser1.text.should include("just completed the survey!")
	      @browser1.close
       end
       
      
      it "Test to check if a user can fail a survey using a supplier link" do
	        group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	    @enc_group_name =  group['group_name']
	    driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new driver
	    @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=NjI=")
	       sleep 2
	       @browser1.text.should include("THIS IS A TEST AUTOMATION SURVEY")
	       @browser1.goto("http://p.sm1mr.com/smsup_red.php?S=2")
	       @browser1.text.should include("Thank you for your interest. Unfortunately, you did not qualify for this survey.")
	       @browser1.close
      end
      
      it "Test to check if a user can over quota a survey using a supplier link" do
	        group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	    @enc_group_name =  group['group_name']
	    driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new driver
	    @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=NjI=")
	       sleep 2
	       @browser1.text.should include("THIS IS A TEST AUTOMATION SURVEY")
	       @browser1.goto("http://p.sm1mr.com/smsup_red.php?S=3")
	       @browser1.text.should include("Thank you for your interest. Unfortunately, the survey you attempted has already reached the required number of participants.")
	       @browser1.close	      
       end
       
       it "Test to check if the stats are correctly updated for the supplier" do
	       @browser.refresh
	       sleep 5
	       puts @browser.text
       end
       
       it "Test to simulate test clicks for a supplier" do
	       driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	       @browser1 = Watir::Browser.new driver
	       @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=NjczMDc=&supId=NjI=&test=1")
	       sleep 2
	       @browser1.text.should include("THIS IS A TEST AUTOMATION SURVEY")
	       @browser1.close
       end
       
      it "Test to check if a user can successfully complete a survey using a supplier TEST link" do
	       driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	       @browser1 = Watir::Browser.new driver
	       @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=NjczMDc=&supId=NjI=")
	       sleep 2
	       @browser1.text.should include("THIS IS A TEST AUTOMATION SURVEY")
	       @browser1.goto("http://p.sm1mr.com/smsup_red.php?S=1")
	       @browser1.text.should include("Congratulations,")
	       @browser1.text.should include("just completed the survey!")
	       @browser1.close
       end
       
      
      it "Test to check if a user can fail a survey using a supplier TEST link" do
	        group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	    @enc_group_name =  group['group_name']
	    driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new driver
	    @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=NjI=&test=1")
	       sleep 2
	       @browser1.text.should include("THIS IS A TEST AUTOMATION SURVEY")
	       @browser1.goto("http://p.sm1mr.com/smsup_red.php?S=2")
	       @browser1.text.should include("Thank you for your interest. Unfortunately, you did not qualify for this survey.")
	       @browser1.close
      end
      
      it "Test to check if a user can over quota a survey using a supplier TEST link" do
	        group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	    @enc_group_name =  group['group_name']
	    driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new driver
	    @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=NjI=&test=1")
	    puts "http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=NjI=&test=1"
	       sleep 2
	       @browser1.text.should include("THIS IS A TEST AUTOMATION SURVEY")
	       @browser1.goto("http://p.sm1mr.com/smsup_red.php?S=3")
	       @browser1.text.should include("Thank you for your interest. Unfortunately, the survey you attempted has already reached the required number of participants.")
	       @browser1.close	      
       end       
       
       it "Test to check if the test stats are not updated in the supplier stats" do
	       @browser.refresh
	       sleep 5
	       puts "11111111111111111111111111111111"
	       puts "11111111111111111111111111111111"
	       puts @browser.text
       end       
	       
      
      
      

      #@browser.link(:text,"Logout").click
      #@browser.close

=end

    after(:all) do
    #@browser.close
    puts "Test case 40 has completed"
    end

end
