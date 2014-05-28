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

describe "Test 22: Exclusion rules for dashboard" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "should create a project on network site" do
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
    #project_name = {}
    #project_name['project'] = prj_name
    #File.open("InputRepository/projectname.yml","w"){|file| YAML.dump(project_name,file)}
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
    @browser.link(:text,'Create Project').click
    sleep 4
    body_text = @browser.text
    body_text.should include("Your project has been created")
  end

  it "To change settings of a survey to ensure that surveys is visible only if the member is able to see the survey if he has answered a survey in the last 30 days" do
    @browser.link(:text,/Group Setup/).click
    sleep 5
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.radio(:id,"ruleYes").set
    grp_name= Time.now
    grp_name = grp_name.to_s
    grp_name = grp_name.slice(0..18)
    grp_name = "Test Automation Group_"+grp_name
    @browser.text_field(:id,"txtGroupName").set(grp_name)
    @browser.text_field(:id,"txtSampleSize").set("20")
    @browser.text_field(:id,"txtIncidenceEst").set("50")
    @browser.checkbox(:id,"chkSurveyCompleteInclude").set
    @browser.select_list(:id,"optSurveyComplete").select("30")
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
    sleep 1
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
    sleep 4
    @browser.link(:id,"btnApply").click
    sleep 2
    #@browser.link(:id,"btnApply").click
    @browser.checkbox(:id,"chkClicksAllowed").set(false)
    @browser.checkbox(:id,"chkGeoIP").set(false)
    @browser.checkbox(:id,"chkRejProxy").set(false)
    @browser.checkbox(:id,"chkRejSpeeder").set(false)
    @browser.link(:text,"Next").click
    sleep 3
    #@browser.checkbox(:index,0).set(false)
    #@browser.checkbox(:index,1).set(false)
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
    @browser.text_field(:id,"survey_name").set(@grp_name)
    group_name = {}
    group_name['group'] = @grp_name
    File.open("InputRepository/groupname_Demo.yml","w"){|file| YAML.dump(group_name,file)}
    @browser.link(:id,"btnNext").click
    @browser.checkbox(:id,"multiple_clicks_allowed").set
    @browser.link(:text,"Next").click
    @browser.text_field(:id,"txtSurveyUrl").set("http://203.199.26.75/usamp/TEST_SURVEY.php?id=%%Token%%")
    sleep 2
    @browser.link(:id,"btnSaveURL").click
    sleep 5
    @browser.link(:id,"succes_status").should exist
    @browser.link(:id,"succes_status").click
    @browser.window(:title => /TEST_AUTOMATION_SURVEY/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
    @browser.link(:id,"fail_status").click
    @browser.window(:title => /TEST_AUTOMATION_SURVEY/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
    body_text = @browser.text
    body_text.should include("The fail redirect has passed for this URL!")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
    @browser.link(:id,"finishBtn").click
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
    #@browser.link(:text,"Log Out").click
    end
    
    it "To check if a member is able to see a survey only if he has answered a survey in the last 30 days" do
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      group_name = File.open("InputRepository/groupname_Demo.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']

      @browser1 = @obj.Surveyhead_sm_login("test22.des00@mailinator.com","test22.des00@mailinator.com")
      sleep 3
      body_text = @browser1.text
      body_text.should include("#{grp_name}")
      sleep 2
      @browser1.goto("http://sm.p.surveyhead.com/index.php?mode=logout")
      @browser1.close
    end

    it "To change settings of a survey to ensure that surveys is visible only if the member has not answered a survey in the last 30 days" do
      @browser.link(:text,/Test Automation Group_/).click
      sleep 3
      @browser.link(:text,/Group Details/).click
      sleep 2
      @browser.link(:text,/Edit/).click
      sleep 2
      @browser.checkbox(:id,"chkSurveyCompleteInclude").set(false)
      @browser.checkbox(:id,"chkSurveyCompleteExclude").set
      @browser.select_list(:id,"optSurveyComplete").select("30")
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
      sleep 3
      @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
      sleep 2
      @browser.link(:id,"addCostsFinishButton").click
      sleep 5
=begin      
      #@browser.checkbox(:id,"tc").set
      #@browser.text_field(:id,"textfield").set(BasicData::USAMP_NAME)
     # sleep 1
      #@browser.link(:text,"Finish").click
      #sleep 2
=end      
      body_text = @browser.text
      sleep 4
      @browser.link(:text,"Pause").should exist
      @browser.link(:text,"Close").should exist
    end
    
 
    it "To check if a member is able to see a survey only if a member has not answered a survey in the last 30 days" do
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      group_name = File.open("InputRepository/groupname_Demo.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']

      @browser1 = @obj.Surveyhead_sm_login("test22.des00@mailinator.com","test22.des00@mailinator.com")
      sleep 3
      body_text = @browser1.text
      body_text.should_not include("#{grp_name}")
      @browser1.goto("http://sm.p.surveyhead.com/index.php?mode=logout")
      @browser1.close
    end

    it "To change settings of a survey to ensure that surveys is visible only if the member matches the exclusion criteria -Member Category include" do
      @browser.link(:text,/Edit/).click
      sleep 2
      @browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
      @browser.checkbox(:id,"chkMemberCategoryInclude").set
      @browser.select_list(:id,"optMemberCategory").select("30")
      @browser.link(:id,"selCategoryhref").click
      sleep 15
      @browser.select_list(:id,"optCategoryId").select("Business")
      @browser.link(:text,"Add").click
      @browser.link(:text,"Done").click
      sleep 2
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
      sleep 1
      @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
      @browser.link(:id,"addCostsFinishButton").click
=begin      
      @browser.checkbox(:id,"tc").set
      @browser.text_field(:id,"textfield").set(BasicData::USAMP_NAME)
      sleep 1
      @browser.link(:text,"Finish").click
      sleep 2
=end      
      body_text = @browser.text
      sleep 4
      @browser.link(:text,"Pause").should exist
      @browser.link(:text,"Close").should exist
    end

  it "To check if a member is able to see a survey only if he satisfies the Member Category inclusion criteria" do
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      group_name = File.open("InputRepository/groupname_Demo.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']

      @browser1 = @obj.Surveyhead_sm_login("test22.des00@mailinator.com","test22.des00@mailinator.com")
      sleep 3
      body_text = @browser1.text
      body_text.should include("#{grp_name}")
      sleep 2
      @browser1.goto("http://sm.p.surveyhead.com/index.php?mode=logout")
      @browser1.close
    end

    it "To change settings of a survey to ensure that surveys is visible only if the member matches the exclusion criteria -Member Category exclude" do
      @browser.link(:text,/Edit/).click
      sleep 2
      @browser.checkbox(:id,"chkMemberCategoryInclude").set(false)
      @browser.checkbox(:id,"chkMemberCategoryExclude").set
      @browser.select_list(:id,"optMemberCategory").select("30")
      @browser.link(:id,"selCategoryhref").click
      while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
  end
  sleep 2
      @browser.select_list(:id,"optCategoryId").select("Business")
      @browser.link(:text,"Add").click
      @browser.link(:text,"Done").click
      sleep 2
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
      sleep 1
      @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
      @browser.link(:id,"addCostsFinishButton").click
=begin      
      @browser.link(:id,"addCostsNextButton").click
      @browser.checkbox(:id,"tc").set
      @browser.text_field(:id,"textfield").set(BasicData::USAMP_NAME)
      sleep 1
      @browser.link(:text,"Finish").click
      sleep 2
=end      
      body_text = @browser.text
      sleep 4
      @browser.link(:text,"Pause").should exist
      @browser.link(:text,"Close").should exist
    end
    
    it "To check if a member is able to see a survey only if he satisfies the Member Category exclusion criteria" do
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      group_name = File.open("InputRepository/groupname_Demo.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']

      @browser1 = @obj.Surveyhead_sm_login("test22.des00@mailinator.com","test22.des00@mailinator.com")
      sleep 3
      body_text = @browser1.text
      body_text.should_not include("#{grp_name}")
      @browser1.goto("http://sm.p.surveyhead.com/index.php?mode=logout")
      @browser1.close
  end

  
    after(:all) do
    @browser.close
    puts "test 22 has completed"
    end
  
end