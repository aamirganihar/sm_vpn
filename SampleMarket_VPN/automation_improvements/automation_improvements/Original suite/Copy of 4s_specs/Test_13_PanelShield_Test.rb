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
#Login Credentials, Project Creation data

describe "Test 13: Group creation for PanelShield test" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

  it "Test to check if a client can successfully create a Panelsheild group on network site" do
    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
    @browser.link(:text,"Add a new project").click
    prj_name= Time.now
    prj_name = prj_name.to_s
    prj_name = prj_name.slice(0..18)
    #@date=Time.now.strftime(#"%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    prj_name = "Test Automation Project_"+prj_name
    project_name = {}
    project_name['project'] = prj_name
    File.open("InputRepository/Projectname_Panelshield.yml","w"){|file| YAML.dump(project_name,file)}
    @browser.text_field(:id, "txtPrjName").set(prj_name)
    @browser.select_list(:id,"optPrjCat").select("Business")
    @date=Time.now.strftime("%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @browser.text_field(:name ,'txtStartDate').set @date_added_1
    @browser.text_field(:name ,'txtEndDate').set @date_added_10
    @browser.select_list(:id,"optPM").select("Nitin Kumar")
    @browser.text_field(:id, "txtSurveyLength").set("10")
    #sleep 3
    #@browser.link(:text,'Create Project').click
    @browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")
	
	@browser.link(:text,/Group Setup/).click
	sleep 5
	Country_value = @browser.select_list(:id,"optCountryId").text
	Language_value = @browser.select_list(:id,"optLanguageId").text
	Country_value.should include("United States")
	Language_value.should include("English")
   
      @browser.checkbox(:id,"PL[40]").set
      @browser.checkbox(:id,"PL[13]").set
      @browser.checkbox(:id,"PL[2]").set
      @browser.checkbox(:id,"PL[0]").set
      sleep 1
      @browser.link(:text,/Demographic Targeting/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
	end
	sleep 4
      @browser.link(:text,/Age/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
  end
  sleep 3
      @browser.text_field(:id,"txtAgeRangeLower_1").set("44")
      @browser.text_field(:id,"txtAgeRangeUpper_1").set("54")
      @browser.link(:text,/Done/).click
      @browser.link(:text,/Geographic Targeting/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 1
          puts "waiting for element"
      end
      sleep 4
      @browser.link(:text,/Zip Code/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 1
          puts "waiting for element"
	end
	sleep 4
      @browser.text_field(:id,"txtZipList").set("90001")
      @browser.link(:text,/Done/).click
      sleep 4
      @browser.link(:text,/90001/).should exist

      #Creating and Entering the group name into yaml files
      grp_name= Time.now
      grp_name = grp_name.to_s
      grp_name = grp_name.slice(0..18)
      @grp_name = "Test Automation Group_"+grp_name
      group_name = {}
      group_name['group'] = @grp_name
      File.open("InputRepository/Groupname_Panelshield.yml","w"){|file| YAML.dump(group_name,file)}

      @browser.text_field(:id,"txtGroupName").set("#{@grp_name}")
      @browser.text_field(:id,"txtSampleSize").set("20")
      @browser.text_field(:id,"txtIncidenceEst").set("50")
      @browser.link(:text,"Get Sample Counts").click
      while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
          sleep 1
      end
      @browser.link(:id,"next").click
      @browser.text_field(:index,0).set("5")
      @browser.text_field(:index,2).set("5")
      @browser.text_field(:index,4).set("5")
      @browser.text_field(:index,6).set("5")
      @browser.text_field(:index,8).set("5")
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
      @browser.link(:text,/Prepare to go live/).click
      sleep 3
      @browser.link(:id,"btnApply").click

      @browser.checkbox(:id,"chkClicksAllowed").set(false)
      @browser.checkbox(:id,"chkGeoIP").set(false)
      @browser.checkbox(:id,"chkRejProxy").set(false)
      @browser.checkbox(:id,"chkRejSpeeder").set(false)
    end

  it "Test to check for Save for Later and the Exit functionality on Panelshield page" do
      @browser.checkbox(:id,"chkClicksAllowed").set(false)
      @browser.checkbox(:id,"chkGeoIP").set(true)
      @browser.checkbox(:id,"chkRejProxy").set(false)
      @browser.checkbox(:id,"chkRejSpeeder").set(false)
      @browser.link(:text,"Save for later").click
      @browser.link(:text,"Prepare to GO Live").click
      sleep 4
      @browser.link(:text,"Ok").click
      sleep 3
       if(@browser.link(:text,"Ok").exists?)
        @browser.link(:text,"Ok").click
      end
      @browser.checkbox(:id,"chkGeoIP").should exist
      @browser.link(:text,"Cancel").click
      sleep(4)
      @browser.driver.switch_to.alert.accept
      sleep(2)
      #@browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=project/list&prid=MzI0Mw==#groups")
      
      #Clicking twice as it shows inconsistency
      @browser.link(:class,"prepare-go-live").click
      if(@browser.link(:class,"prepare-go-live").exists?)
        @browser.link(:class,"prepare-go-live").click
      end
        
      sleep(7)
      @browser.link(:text,"Ok").click
      @browser.checkbox(:id,"chkGeoIP").set(false)
      @browser.checkbox(:id,"chkClicksAllowed").set(false)
      @browser.link(:text,"Next").click
    end

   it "Test to check if client is allowed to enter survey name and live close settings" do
    #@browser.checkbox(:id,"multiple_clicks_allowed").set
    sleep 1
    group_name = File.open("InputRepository/Groupname_Panelshield.yml"){|file| YAML::load(file)}
    @grp_name = group_name['group']
    @browser.text_field(:id,"survey_name").set("#{@grp_name}")
    @browser.link(:id,"btnNext").click
    @browser.checkbox(:id,"multiple_clicks_allowed").set
    sleep(1)
    @browser.link(:text,"Next").click
    @browser.text_field(:id,"txtSurveyUrl").set("http://203.199.26.75/usamp/TEST_SURVEY.php?id=%%Token%%")
    sleep 2
    @browser.link(:id,"btnSaveURL").click
    sleep 5
    @browser.link(:id,"succes_status").should exist
   end

  it "Test to check if the success links works for a group with Panelsheild settings" do
    @browser.link(:id,"succes_status").click
    sleep 5
    @browser.window(:title => /TEST_AUTOMATION_SURVEY/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
     body_text = @browser.text
    body_text.should include("The success redirect has passed for this URL!")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
  end

  it "Test to check if the failure links works for a group with Panelsheild settings" do
    @browser.link(:id,"fail_status").click
    @browser.window(:title => /TEST_AUTOMATION_SURVEY/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
    sleep 3
    body_text = @browser.text
    body_text.should include("The fail redirect has passed for this URL!")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
  end

  it "Test to check if once all the data is entered, the project is allowed to go live" do
    @browser.link(:id,"finishBtn").click
    sleep 5
    body_text = @browser.text
    body_text.should include("Congratulations")
    body_text.should include("You have successfully prepared your groups to go live.")
  end

  it "Check if client is able to create and save a group" do
    sleep 2
    @browser.link(:text,/Go to Project Page/).click
    sleep 5
    @browser.link(:text,/Go Live/).click
    sleep 5
    body_text = @browser.text
    body_text.should include("You are about to go live with these groups/channels.")
    @browser.link(:text,/golive/).click
    sleep 7
    @browser.link(:text,"Pause").should exist
    @browser.link(:text,"Close").should exist
 end

 it "Test to check if a member is able to see a survey without any PanelShield setting applied" do
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      group_name = File.open("InputRepository/Groupname_Panelshield.yml"){|file| YAML::load(file)}
      @grp_name = group_name['group']

      @browser1 = @obj.Surveyhead_sm_login("test22.des01@mailop.com","test22.des01@mailop.com")
      sleep 10
      body_text = @browser1.text
      body_text.should include("#{@grp_name}")
      @browser1.link(:text,"Logout").click
      @browser1.close
    end

  it "Test to check if PanelShield setting of Geo-ip is successfully applier for a QG" do
    #@browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=group/run&prid=MzMwNw==&groupid=NTI4MA==#dashboard")
    @browser.link(:text,/Test Automation Group/).click
    sleep 5
    #body_text = @browser.text
    #puts body_text

    #Inconsistency sen in clicking the group details hence clicking twice
    @browser.link(:text,/Group Details/).click
    @browser.link(:text,/Group Details/).click
    sleep 5
    @browser.link(:id,/panelShieldEditLink/).click
    sleep 10
    @browser.checkbox(:id,'chkGeoIP').set
    @browser.checkbox(:id,'chkRejProxy').set(false)
    @browser.link(:text,/Save/).click
    sleep
  end

   it "Test to check if a member is not able to see the survey as he does satisfy the panelShield settings for Geo-ip" do
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      group_name = File.open("InputRepository/Groupname_Panelshield.yml"){|file| YAML::load(file)}
      @grp_name = group_name['group']

      #@browser1.window(:title =>/Paid/).use do
      @browser1 = @obj.Surveyhead_sm_login("test22.des06@mailop.com","test22.des06@mailop.com")
      sleep 3
      body_text = @browser1.text
      
      body_text.should_not include("#{@grp_name}")
      @browser1.link(:text,"Logout").click
      @browser1.close
   end

   it "Test to check if PanelShield setting of Proxies is set for the QG" do
    
    #@browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=project/list&prid=MzA3MQ==#groups")
    #@browser.link(:text,/Test Automation Group/).click
    #@browser.link(:text,/Group Details/).click
    # Use one among the following test ips 111.90.172.165, 111.93.2.210
    sleep(5)
    @browser.link(:id,/panelShieldEditLink/).click
    @browser.checkbox(:id,'chkGeoIP').set(false)
    @browser.checkbox(:id,'chkRejProxy').set
    @browser.link(:text,/Save/).click
  end

   it "Test to check if a member is not able to see the survey as he does satisfy the panelShield settings for Proxies" do
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      group_name = File.open("InputRepository/Groupname_Panelshield.yml"){|file| YAML::load(file)}
      @grp_name = group_name['group']

      #@browser1.window(:title =>/Paid/).use do
      @browser1 = @obj.Surveyhead_sm_login("test22.des06@mailop.com","test22.des06@mailop.com")
      sleep 3
      body_text = @browser1.text
      body_text.should_not include("#{@grp_name}")
      @browser1.link(:text,"Logout").click
      @browser1.close
   end


  #  # Tests for Max click needs to be integrated later
  #
  #  it "To check if PanelShield setting of Speeders is set for the QG" do
  #    #@browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=project/list&prid=MzA3MQ==#groups")
  #    @browser.link(:text,/Test Automation Group/).click
  #    @browser.link(:text,/Group Details/).click
  #    sleep(5)
  #    @browser.link(:id,/panelShieldEditLink/).click
  #    @browser.checkbox(:id,'chkGeoIP').set
  #    @browser.link(:text,/Save/).click
  #  end

   after(:all) do
    
    @browser.link(:id,/panelShieldEditLink/).click
    @browser.checkbox(:id,'chkGeoIP').set(false)
    @browser.checkbox(:id,'chkRejProxy').set(false)
    @browser.link(:text,/Save/).click
    sleep(1)
    @browser.close
    @browser1.window(:title => /Paid Surveys/).use do
        @browser1.link(:text,"Logout").click
        @browser1.close
     end
	puts "test 13 has completed"
   end

end
