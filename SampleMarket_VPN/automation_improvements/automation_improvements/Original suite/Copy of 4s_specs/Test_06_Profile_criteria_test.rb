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

describe "Test 06: Group creation with Profile Criteria" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "Test to create a project on network site and add a Profile criteria" do
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
    #@browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")

#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
#    @browser.link(:text,/#{project_name['project'][1]}/).click
    @browser.link(:text,/Group Setup/).click
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.link(:text,/Profile Questions/).click
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 4
    @browser.select_list(:id,"profileSelOption").select("Sel_Automation")
    #sleep 4
    #@browser.select_list(:id,"profileSelOption").select("Travel")
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 4
    #@browser.link(:text,/Which rental car companies have you used?/).click
    @browser.link(:text,/Select a number/).click
    sleep 2
    @browser.checkbox(:title,"1").set
    sleep 2
    @browser.link(:text,/Select an alphabet/).click
    sleep 3
    @browser.checkbox(:title,"a").set
    
	
#    @browser.checkbox(:title,"Advantage Rent A Car").set
    @browser.link(:text,/Done/).click
    @browser.link(:text,/Select a number/).should exist
end

    it "Test to check if client can successfully complete creating the survey with a specific Profile criteria" do
    grp_name= Time.now
    grp_name = grp_name.to_s
    grp_name = grp_name.slice(0..18)
    grp_name = "Test Automation Group_"+grp_name
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
    sleep 3
    @browser.text_field(:index,0).set("5")
    @browser.text_field(:index,2).set("5")
    @browser.text_field(:index,4).set("5")
    @browser.text_field(:index,6).set("5")
    @browser.text_field(:index,8).set("5")
    #@browser.text_field(:index,8).set("5")
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
    @browser.checkbox(:id,"chkClicksAllowed").set(false)
    @browser.checkbox(:id,"chkGeoIP").set(false)
    @browser.checkbox(:id,"chkRejProxy").set(false)
    @browser.checkbox(:id,"chkRejSpeeder").set(false)
    @browser.link(:text,"Next").click
    #@browser.checkbox(:index,0).set(false)
    #@browser.checkbox(:index,1).set(false)
    #@browser.checkbox(:id,"multiple_clicks_allowed").set
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
    @grp_name = "Profile_criteria"+@grp_name
    @browser.text_field(:id,"survey_name").set(@grp_name)
    group_name = {}
    group_name['group'] = @grp_name
    File.open("InputRepository/groupname_Geo.yml","w"){|file| YAML.dump(group_name,file)}
    @browser.link(:id,"btnNext").click
	sleep 2
    @browser.checkbox(:id,"multiple_clicks_allowed").set
	sleep 1
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
    sleep 5
    @browser.link(:text,/Go to Project Page/).click
    sleep 7
    @browser.link(:text,/Go Live/).click
    sleep 2
    body_text = @browser.text
    body_text.should include("You are about to go live with these groups/channels.")
    @browser.link(:text,/golive/).click
    sleep 7
    @browser.link(:text,"Pause").should exist
    @browser.link(:text,"Close").should exist
    @browser.link(:text,"Log Out").click
    @browser.close
  end

    it "Test to check if a member satisfying the Profile criteria is able to see the survey" do
      
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      group_name = File.open("InputRepository/groupname_Geo.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']

      @browser = @obj.Surveyhead_sm_login("test22.des00@mailinator.com","test22.des00@mailinator.com")
      sleep 15
      body_text = @browser.text
      body_text.should include("#{grp_name}")
      @browser.link(:text,"Logout").click
      @browser.close
    end

      #@browser.link(:text,"Logout").click
      #@browser.close

      it "Test to check if a member who does not satisfy the Profile criteria is unable to see the survey" do
      @browser = @obj.Surveyhead_sm_login("test22.des02@mailop.com","test22.des02@mailop.com")
      sleep 3
      group_name = File.open("InputRepository/groupname_Geo.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']
      body_text = @browser.text
      body_text.should_not include("#{grp_name}")
      @browser.link(:text,"Logout").click
      @browser.close

      #Userrname['demographic']

    end

    after(:all) do
    @browser.close
    puts "test 6 has completed"
    end

end
