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

describe "Test 02: Group creation" do

  before(:all) do
      #create an object of the UsampLib
      @obj = Usamp_lib.new
      @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end
  


  it "Test to confirm if the language and country criteria are present by default" do

      @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
      project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
      @browser.link(:text,/#{project_name['project']}/).click
      sleep 2
      @browser.link(:text,/GROUP SETUP/).click
      Country_value = @browser.select_list(:id,"optCountryId").text
      Language_value = @browser.select_list(:id,"optLanguageId").text
      Country_value.should include("United States")
      Language_value.should include("English")
  end
  
  it "Test to check if an error is reported when the group name, number of completes and Incidence estimate fields are left blank" do
	  sleep 2
	  @browser.checkbox(:id,"PL[40]").set
	  @browser.checkbox(:id,"PL[13]").set
	  @browser.checkbox(:id,"PL[2]").set
	  @browser.checkbox(:id,"PL[0]").set
	  @browser.link(:text,"Get Sample Counts").click
	  sleep 2
	  body_text = @browser.text
	  body_text.should include("The following fields must be corrected before you can continue:")
	  body_text.should include("Group Name is required.")
	  body_text.should include("Number of Completes Needed (N=) is required and must be a numeric value.")
	  body_text.should include("Incidence Estimate is required and must be in percentage format.")
  end
  

  it "Test to check if a user is allowed to save group with demographic criteria" do
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
      @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
      @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
      @browser.link(:text,/Done/).click
      @browser.link(:text,/50-75/).should exist
  end


  it "Test to check if a user is allowed to save group with Geo Targeting  criteria" do
      @browser.link(:text,/Geographic Targeting/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 1
          puts "waiting for element"
  end
  sleep 4
      @browser.link(:text,/Area Code/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 1
          puts "waiting for element"
      end
      sleep 3
      @browser.text_field(:id,"txtAreaCodeList").set("90001")
      @browser.link(:text,/Done/).click
      @browser.link(:text,/90001/).should exist
  end
  

  it "Test to check if a user is allowed to save group with  Profile criteria" do
      @browser.link(:text,/Profile Questions/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
      end
      @browser.select_list(:id,"profileSelOption").select("Travel")
      while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
      end
      sleep 4
      @browser.link(:text,/Which rental car companies have you used?/).click
      sleep 3
      @browser.checkbox(:title,"ACE Rent A Car").set
      @browser.checkbox(:title,"Advantage Rent A Car").set
      @browser.link(:text,/Done/).click
      sleep 2
      @browser.link(:text,/Which rental car companies have you used?/).should exist
  end
  
  it "Test to check if exlusion rules are displayed on selecting Yes option for Would you like to set Exclusion / Inclusion Rules?" do
      @browser.radio(:id,"ruleYes").set
      @browser.checkbox(:id,"chkSurveyCompleteExclude").should exist
      @browser.checkbox(:id,"chkEmailReceivedExclude").should exist
      @browser.checkbox(:id,"chkMemberCategoryExclude").should exist
      @browser.checkbox(:id,"chkMemberGroupsExclude").should exist
      @browser.checkbox(:id,"exMemberRegisteredChk").should exist
      @browser.radio(:id,"ruleNo").set
  end
  
  it "Test to check if user can add a group with recontact member ids,recontact tokens and recontact completed groups" do
      @browser.radio(:id,"recontactStudyOptionY").set
      @browser.text_field(:id,"membersTokens").should exist
      @browser.radio(:id,"recontactTypeOptionGroup").set
      @browser.radio(:id,"recontactTypeOptionGroup").should exist
      @browser.link(:id,"selQGhref").should exist
      @browser.radio(:id,"recontactStudyOptionN").set
  end

  it "Test to check if the test link options are displayed in case data is entered correctly" do
      grp_name= Time.now
      grp_name = grp_name.to_s
      grp_name = grp_name.slice(0..18)
      grp_name = "Test Automation Project_"+grp_name
      @browser.text_field(:id,"txtGroupName").set(grp_name)
      @browser.text_field(:id,"txtSampleSize").set("20")
      @browser.text_field(:id,"txtIncidenceEst").set("50")
      @browser.checkbox(:id,"PL[40]").set
      @browser.checkbox(:id,"PL[13]").set
      @browser.checkbox(:id,"PL[2]").set
      @browser.checkbox(:id,"PL[0]").set
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
      sleep 1
      @browser.text_field(:id,"textfield").set(BasicData::USAMP_NAME)
      sleep 1
      @browser.link(:text,"Finish").click
      sleep 5
      body_text = @browser.text
      body_text.should include("Your groups have been defined")
      
      #@browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=project/list&prid=NDcwMTE=#groups")
      #@browser.link(:text,"Prepare to go live").click
      
      @browser.link(:class,"prepare-go-live").click
      sleep 8
      @browser.link(:id,"btnApply").click
      @browser.checkbox(:id,"chkClicksAllowed").set(false)
      @browser.checkbox(:id,"chkGeoIP").set(false)
      @browser.checkbox(:id,"chkRejProxy").set(false)
      @browser.checkbox(:id,"chkRejSpeeder").set(false)
      @browser.link(:text,"Next").click
      sleep 3
      @browser.checkbox(:index,1).set(false)
      @browser.checkbox(:index,2).set(false)
      #@browser.checkbox(:id,"multiple_clicks_allowed").set
      @browser.text_field(:id,"survey_name").set("Test Automation Survey")
      @browser.link(:id,"btnNext").click
      sleep 4
      @browser.checkbox(:id,"multiple_clicks_allowed").set
      sleep 2
      @browser.link(:text,"Next").click
      @browser.text_field(:id,"txtSurveyUrl").set("http://www.s.instant.ly/s/XRtQG?id=%%Token%%")
      sleep 2
      @browser.link(:id,"btnSaveURL").click
      sleep 3
      @browser.link(:id,"succes_status").should exist
  end
 
  it "Test to check if the success links works" do
      sleep 3
      @browser.link(:id,"succes_status").click
      sleep 2
      @browser.window(:title => /Survey/).use do
          @browser.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
          body_text = @browser.text
          body_text.should include("The success redirect has passed for this URL!")
          sleep 2
          @browser.button(:id,"btnClose").click
      end
      sleep 2
  end
  
  it "Test to check if the failure link works" do
      sleep 3
      @browser.link(:id,"fail_status").click
      sleep 2
      @browser.window(:title => /Survey/).use do
          @browser.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
          body_text = @browser.text
          body_text.should include("The fail redirect has passed for this URL!")
          sleep 2
          @browser.button(:id,"btnClose").click 
      end
      sleep 2
  end
  

  it "Test to check if a project is allowed to go live once all the data is entered" do
      @browser.link(:id,"finishBtn").click
      sleep 7
      body_text = @browser.text
      body_text.should include("Congratulations")
      body_text.should include("You have successfully prepared your groups to go live.")
  end
  
  it "Test to check if a client is able to make a group live" do
      sleep 3
      @browser.link(:text,/Go to Project Page/).click
      sleep 5
      @browser.link(:text,/Go Live/).click
      sleep 2
      body_text = @browser.text
      body_text.should include("You are about to go live with these groups/channels.")
      @browser.link(:text,/golive/).click
      sleep 7
      @browser.link(:text,"Pause").should exist
      @browser.link(:text,"Close").should exist
  end
  
it "To successfully close a project" do
        @browser.link(:text,"Close").click
        sleep 3
        @browser.driver.switch_to.alert.accept
 end

  after(:all) do
      @browser.close
      puts "Test case 2 has completed"
  end
  end