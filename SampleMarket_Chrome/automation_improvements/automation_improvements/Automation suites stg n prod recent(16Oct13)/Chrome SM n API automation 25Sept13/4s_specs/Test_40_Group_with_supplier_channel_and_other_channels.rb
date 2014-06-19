require 'rubygems'
require './automation'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
#require 'win32/clipboard'
#include Win32 
require 'YAML'
#require 'win32/screenshot'

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
	    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
	    @browser.link(:text,"Add a new project").click
	    prj_name= Time.now
	    prj_name = prj_name.to_s
	    prj_name = prj_name.slice(0..18)

	    @date=Time.now.strftime("%m/%d/%Y")
	    @SECONDS_PER_DAY = 60 * 60 * 24
	    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
	    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
	    prj_name = "Test Automation Project_"+prj_name
	    project_name = {}
	    project_name['project'] = prj_name
	    File.open("InputRepository/projectname.yml","w"){|file| YAML.dump(project_name,file)}
	    @browser.text_field(:id, "txtPrjName").set(prj_name)
	    @browser.select_list(:id,"optPM").select("Nitin Kumar")
	    @date=Time.now.strftime("%m/%d/%Y")
	    @SECONDS_PER_DAY = 60 * 60 * 24
	    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
	    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
	    @browser.text_field(:name ,'txtStartDate').set @date_added_1
	    @browser.text_field(:name ,'txtEndDate').set @date_added_10
	    @browser.select_list(:id,"optPrjCat").select("Business")
	    @browser.text_field(:id, "txtSurveyLength").set("10")
	    @browser.checkbox(:name,"chkRelvantId").set(false)
	    @browser.checkbox(:name,"chkRelvantId").set(false)
	    #@browser.link(:text,'Create Project').click
	    @browser.link(:text,'Create Project').click
	    sleep 5
	    body_text = @browser.text
	    body_text.should include("Your project has been created")
	#    it "To create a survey with a specific Demographic criteria" do
	#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
	#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
	#    @browser.link(:text,/#{project_name['project'][1]}/).click
	    @browser.link(:text,/Group Setup/).click
	    sleep 5
	    #@browser.checkbox(:id,"PL[40]").set
	    #@browser.checkbox(:id,"PL[13]").set
	    @browser.checkbox(:id,"PL[2]").set
	    @browser.checkbox(:id,"PL[0]").set
=begin
	    @browser.link(:text,/Demographic Targeting/).click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 3
	    @browser.link(:text,/Age/).click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 5
	    @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
	    @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
	    @browser.link(:text,/Done/).click
	    @browser.link(:text,/50-75/).should exist
=end 

	    grp_name= Time.now
	    grp_name = grp_name.to_s
	    grp_name = grp_name.slice(0..18)
	    grp_name = "Test Automation Group_"+grp_name
	    @browser.text_field(:id,"txtGroupName").set(grp_name)
	    @browser.text_field(:id,"txtSampleSize").set("20")
	    @browser.text_field(:id,"txtIncidenceEst").set("50")
	    #@browser.checkbox(:id,"PL[40]").set
	    #@browser.checkbox(:id,"PL[13]").set
	    @browser.checkbox(:id,"PL[2]").set
	    @browser.checkbox(:id,"PL[0]").set
	    @browser.link(:text,"Get Sample Counts").click
	    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
		    sleep 1
		    puts "Waiting for counts to load"
	    end
	    @browser.link(:id,"next").click
	    @browser.driver.manage.timeouts.implicit_wait = 30 
	
    end
    
    it "Test to check if an existing supplier can be added to the group and also check if the CPI values are correctly shown" do
	    @browser.link(:id,"supplierLink0").click
	    #while @browser.div(:id=>"fancybox-loading").visible? do
		#    sleep 0.5
		  #  puts "waiting for element"
	    #end
	    #sleep 4
Watir::Wait.until { @browser.text.include? 'Add a new supplier' }#explicit wait:default timeout :30sec
@browser.link(:text,"Add an existing supplier").click
#	    while @browser.div(:id=>"fancybox-loading").visible? do
#		    sleep 0.5
#		    puts "waiting for element"

#	    end
#	    sleep 4
 Watir::Wait.until { @browser.text.include? 'Existing Suppliers' }#explicit wait:default timeout :30sec
	    @browser.select_list(:id,"optExistingSuppliersId").select("Test Sup")
	    @browser.link(:text,"Add").click
	    sleep 5
	    @browser.link(:text=>"Next",:index=>2).click
	    #@browser.link(:text=>"Next",:index=>2).click
	    #@browser.link(:text,"Next").click
	    sleep 2
	    
	    while @browser.div(:id=>"fancybox-loading").visible? do
		    sleep 0.5
		    puts "waiting for element"
	    end
	    @browser.text_field(:id,"suppChannelCpi0").set("1.25")
	    @browser.radio(:name,"supChSampleOpt0").set
	    @browser.text_field(:id,"supChSampleSize0").set("10")
	    
	    @browser.link(:text,"Save").click
	    #@browser.link(:text,"Add an existing supplier").click
	    while @browser.div(:id=>"fancybox-loading").visible? do
		    sleep 0.5
		    puts "waiting for element"
	    end
	    sleep 4
	    @browser.text.should include ("Test Sup -- -- N= -- $1.25 $12.50")
    end
    
    it "Test to check if the supplier channel does not go live if the redirect links are not entered" do
	    @browser.text_field(:index,0).set("5")
		    
	    @browser.text_field(:index,2).set("5")
	    @browser.text_field(:index,4).set("5")
	    @browser.link(:id,"groupChannelRewardDisplay0").click
	    @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
	    @browser.link(:id,"addCostsNextButton").click
	    @browser.checkbox(:id,"tc").set
	    @browser.text_field(:id,"textfield").set(BasicData::USAMP_NAME)
	    sleep 1
	    @browser.link(:text,"Finish").click
	    sleep 5
	    body_text = @browser.text
	    body_text.should include("Your groups have been defined")
	    @browser.link(:text,"Prepare to go live").click
	    sleep 8
	    @browser.link(:id,"btnApply").click
	    sleep 2
	    #@browser.link(:id,"btnApply").click
	    sleep 2
	    @browser.checkbox(:id,"chkClicksAllowed").set(false)
	    @browser.checkbox(:id,"chkGeoIP").set(false)
	    @browser.checkbox(:id,"chkRejProxy").set(false)
	    @browser.checkbox(:id,"chkRejSpeeder").set(false)
	    @browser.link(:text,"Next").click

	    @grp_name= Time.now
	    @grp_name = @grp_name.to_s
	    @grp_name = @grp_name.slice(0..18)
	    @grp_name = "Demographic"+@grp_name
	    @browser.text_field(:id,"survey_name").set(@grp_name)
	    group_name = {}
	    group_name['group'] = @grp_name
	    File.open("InputRepository/groupname_Sup.yml","w"){|file| YAML.dump(group_name,file)}
	    @browser.link(:id,"btnNext").click
	    @browser.checkbox(:id,"multiple_clicks_allowed").set
	    @browser.link(:text,"Next").click
	    @browser.text_field(:id,"txtSurveyUrl").set(BasicData::SURVEY_URL)
	    sleep 2
	    @browser.link(:id,"btnSaveURL").click
	    sleep 5
	    @browser.link(:id,"succes_status").should exist
	    @browser.link(:id,"succes_status").click
	    @browser.window(:title => /Survey/).use do
	    @browser.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
	    sleep 2
	    @browser.button(:id,"btnClose").click
	    end
	    sleep 2
	    @browser.link(:id,"fail_status").click
	    @browser.window(:title => /Survey/).use do
	    @browser.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
	    body_text = @browser.text
	    body_text.should include("The fail redirect has passed for this URL!")
	    sleep 2
	    @browser.button(:id,"btnClose").click
	    end
	    sleep 2
	    @browser.link(:id,"finishBtn").click
	    sleep 2
	    @browser.link(:text,/Go to Project Page/).click
	    sleep 5
	    @browser.link(:text,/Go Live/).click
	    sleep 5
	    body_text = @browser.text
	    body_text.should include("You are about to go live with these groups/channels.")
	    @browser.link(:text,/golive/).click
	    #sleep 2
	    #if (@browser.div(:id=>"fancybox-loading").exists?)
		#    while @browser.div(:id=>"fancybox-loading").visible? do
		#	    sleep 0.5
		#	    puts "waiting for element"
		  #  end
	    #end
	   Watir::Wait.until { @browser.text.include? 'Live' }#explicit wait:default timeout :30sec:HRISHI
	    sleep 4
	    @browser.link(:text,"Pause").should exist
	    @browser.link(:text,"Close").should exist
	    sleep 4
	    @browser.text.should include("You have added supplier channels")
	    @browser.text.should include("You cannot go live with a supplier channel until you have entered the supplier redirect links. Supplier channels with missing redirect links are marked with a red asterisk.")
    end
    
    
    it "To check if the Supplier channel is allowed to go live once the redirect links are added" do
	    sleep 5
	    @browser.link(:text,/Test Automation Group/).click
	    sleep 6
	    #@browser.link(:text,"testsup").flash
	    #@browser.link(:text,"testsup").flash
	    #@browser.link(:text,"testsup").flash
	    Watir::Wait.until { @browser.text.include? 'Group Snapshot' }#explicit wait:default timeout :30sec:HRISHI
	    
	    @browser.link(:text,'Test Sup').click
	    #@browser.link(:text,/Test Sup 1/).click
	    #@browser.div(:id,"groupSnapShotPane_67307").link(:text,"Test Sup 1").click
	    sleep 4
	    
	    if (@browser.div(:id=>"fancybox-loading").exists?)
		    while @browser.div(:id=>"fancybox-loading").visible? do
			    sleep 0.5
			    puts "waiting for element"
		    end
	    end
	    sleep 5
	    #@browser.radio(:id,"redirect_options_3").flash
	    #@browser.radio(:name =>"redirectSetting", :value => "does_not_use").flash
	    #@browser.radio(:name =>"redirectSetting", :value => "does_not_use").flash
	    #@browser.radio(:name =>"redirectSetting", :value => "does_not_use").flash
	    #@browser.radio(:name =>"redirectSetting", :value => "does_not_use").set
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
     @enc_group_name=/groupid=(\w+)/.match(@group_url)
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
	    #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new :chrome
	    puts "http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg0"
	    @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg2")
	    sleep 5
	    @browser1.text.should include("The survey you have attempted is now closed.")
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
	    #sleep 4
	    Watir::Wait.until { @browser.text.include? 'Live' }#explicit wait:default timeout :30sec:HRISHI
	    @browser.link(:text,"Pause").should exist
	    @browser.link(:text,"Close").should exist
    end
    
    
    it "Test to check if a member can see the survey on dashboard" do
  	      sleep 2
	      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
	      #@browser1 = @obj.Surveyhead_sm_login("test22.des00@mailop.com","test22.des00@mailop.com")
	      @browser1 = @obj.Surveyhead_sm_login("test22.des06@mailop.com","test22.des06@mailop.com")
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
	      #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	      @browser1 = Watir::Browser.new :chrome
	      puts "actual"
	      puts "http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg2"
	      @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg0")
	      Watir::Wait.until(100){ @browser1.text.include? 'Test question'}
	      @browser1.text.should include("Test question")
	      @browser1.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
	      @browser1.driver.manage.timeouts.implicit_wait = 30 
	      @browser1.text.should include("Congratulations,")
	      @browser1.text.should include("just completed the survey!")
	      @browser1.close
       end
       
      
      it "Test to check if a user can fail a survey using a supplier link" do
	        group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	    @enc_group_name =  group['group_name']
	    #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new :chrome
	    @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg0")
	        Watir::Wait.until(100){ @browser1.text.include? 'Test question'}
	       @browser1.text.should include("Test question")
	       @browser1.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
	       @browser1.driver.manage.timeouts.implicit_wait = 30 
	       @browser1.text.should include("Thank you for your interest. Unfortunately, you did not qualify for this survey.")
	       #@browser1.text.should include("Thank you for your participation. This survey transaction will be reviewed and verified within 4-6 weeks.")
	       
	       @browser1.close
      end
      
      it "Test to check if a user can over quota a survey using a supplier link" do
	        group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	    @enc_group_name =  group['group_name']
	    #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new :chrome
	    @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg0")
	        Watir::Wait.until(100){ @browser1.text.include? 'Test question'}
	       @browser1.text.should include("Test question")
	       @browser1.goto("http://p.sm1mr.com/ssred.php?S=3&ID=")
	       @browser1.driver.manage.timeouts.implicit_wait = 30 
	       @browser1.text.should include("Thank you for your interest. Unfortunately, the survey you attempted has already reached the required number of participants.")
	       @browser1.close	      
       end
       
       it "Test to check if the stats are correctly updated for the supplier" do
	       @browser.refresh
	       sleep 10
	       @browser.text.should include("Test Sup")
		@browser.text.should include("10 3 1 1 1 33.3% -- --")
	       #puts @browser.text
       end
       
       it "Test to simulate test clicks for a supplier" do
	       group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	       @enc_group_name =  group['group_name']
	       #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	       @browser1 = Watir::Browser.new :chrome
	       @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg0&test=1")
	        Watir::Wait.until(100){ @browser1.text.include? 'Test question'}
	       @browser1.text.should include("Test question")
	       @browser1.close
       end
       
      it "Test to check if a user can successfully complete a survey using a supplier TEST link" do
	      group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	      @enc_group_name =  group['group_name']
	       #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	       @browser1 = Watir::Browser.new :chrome
	       @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg0&test=1")
	        Watir::Wait.until(100){ @browser1.text.include? 'Test question'}
	       @browser1.text.should include("Test question")
	       @browser1.goto("http://p.sm1mr.com/smsup_red.php?S=1")
	       @browser1.driver.manage.timeouts.implicit_wait = 30 
	       @browser1.text.should include("Congratulations,")
	       @browser1.text.should include("just completed the survey!")
	       @browser1.close
       end
       
      
      it "Test to check if a user can fail a survey using a supplier TEST link" do
	      group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	      @enc_group_name =  group['group_name']
	      #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	      @browser1 = Watir::Browser.new :chrome
	      @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg0&test=1")
	        Watir::Wait.until(100){ @browser1.text.include? 'Test question'}
	       @browser1.text.should include("Test question")
	       @browser1.goto("http://p.sm1mr.com/smsup_red.php?S=2")
	       @browser1.driver.manage.timeouts.implicit_wait = 30 
	       @browser1.text.should include("Thank you for your interest. Unfortunately, you did not qualify for this survey.")
	       @browser1.close
      end
      
      it "Test to check if a user can over quota a survey using a supplier TEST link" do
	        group = File.open("InputRepository/Group_Id_supplier.yml"){|file| YAML::load(file)}
	    @enc_group_name =  group['group_name']
	    #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new :chrome
	    @browser1.goto("http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg0&test=1")
	    puts "http://p.sm1mr.com/smsup.php?grpId=#{@enc_group_name}&supId=Nzg2&test=1"
	        Watir::Wait.until(100){ @browser1.text.include? 'Test question'}
	       @browser1.text.should include("Test question")
	       @browser1.goto("http://p.sm1mr.com/smsup_red.php?S=3")
	       @browser1.driver.manage.timeouts.implicit_wait = 30 
	       @browser1.text.should include("Thank you for your interest. Unfortunately, the survey you attempted has already reached the required number of participants.")
	       @browser1.close	      
       end       
       
       it "Test to check if the test stats are not updated in the supplier stats" do
	       @browser.refresh
	       @browser.driver.manage.timeouts.implicit_wait = 30 
	       #puts "11111111111111111111111111111111"
	       #puts "11111111111111111111111111111111"
	       @browser.text.should include("Test Sup")
		@browser.text.should include("10 3 1 1 1 33.3% -- --")
       end       
	       
      
      
      

      #@browser.link(:text,"Logout").click
      #@browser.close



    after(:all) do
    @browser.close
    puts "Test case 40 has completed"
    end

end
