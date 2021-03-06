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

require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 15: Panel Dashboard Settings" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
    @prj_name= Time.now
    @prj_name = @prj_name.to_s
    @prj_name = @prj_name.slice(0..18)
    @prj_name = "Test Automation Project_"+@prj_name
    @survey_name = "Test Automation Survey for Panel Dashboard"+@prj_name
  end

    it "To create a project and setting it not to be displayed on some sites" do
    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
    @browser.link(:text,"Add a new project").click


    @date=Time.now.strftime("%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")


    @browser.text_field(:id, "txtPrjName").set(@prj_name)
    @browser.select_list(:id,"optPrjCat").select("Business")
    @date=Time.now.strftime("%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @browser.text_field(:name ,'txtStartDate').set @date_added_1
    @browser.text_field(:name ,'txtEndDate').set @date_added_10
    @browser.select_list(:id,"optPM").select("Nitin Kumar")
    @browser.text_field(:id, "txtSurveyLength").set("10")
    #@browser.link(:text,'Create Project').click
    @browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")
#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
#    @browser.link(:text,/#{project_name['project'][1]}/).click
    @browser.link(:text,/Group Setup/).click
    sleep 5
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.link(:text,/Demographic Targeting/).click
   # while @browser.div(:id=>"fancybox-loading").visible? do
     #   sleep 0.5
       # puts "waiting for element"
	#end
	#sleep 4
	Watir::Wait.until { @browser.text.include? 'Age' }#explicit wait:default timeout :30sec:HRISHI
    @browser.link(:text,/Age/).click
    #while @browser.div(:id=>"fancybox-loading").visible? do
      #  sleep 0.5
        #puts "waiting for element"
	#end
	#sleep 4
	Watir::Wait.until { @browser.text.include? 'Age Range' }#explicit wait:default timeout :30sec:HRISHI
    @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
    @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
    @browser.link(:text,/Done/).click
    @browser.link(:text,/50-75/).should exist
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
    @browser.text_field(:index,0).set("5")
    @browser.text_field(:index,2).set("5")
    @browser.text_field(:index,4).set("5")
    @browser.text_field(:index,6).set("5")
    @browser.text_field(:index,8).set("5")
    @browser.link(:id,"groupChannelRewardDisplay0").click
    sleep 3
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
    Watir::Wait.until { @browser.text.include? 'Enter survey name' }#explicit wait:default timeout :30sec:HRISHI
    @browser.link(:text,"Back").click
    sleep 5
    body_text = @browser.text
    body_text.should include("Security settings")
    @browser.link(:text,"Next").click
    sleep 5
    body_text = @browser.text
    body_text.should include("PANEL DASHBOARD")
    @browser.checkbox(:index,1).set(false)
    @browser.checkbox(:index,2).set(false)
    @browser.checkbox(:index,3).set(false)
    #@browser.checkbox(:id,"multiple_clicks_allowed").set
    @browser.text_field(:id,"survey_name").set(@survey_name)

    @browser.link(:id,"btnNext").click
    @browser.checkbox(:id,"multiple_clicks_allowed").set
    @browser.link(:text,"Next").click
    @browser.text_field(:id,"txtSurveyUrl").set(BasicData::SURVEY_URL)
    sleep 2
    @browser.link(:id,"btnSaveURL").click
    sleep 7
    @browser.link(:id,"succes_status").should exist
    @browser.link(:id,"succes_status").click
    @browser.window(:title => /Survey/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
    sleep 5
    body_text = @browser.text
    body_text.should include("The success redirect has passed for this URL!")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
    @browser.link(:id,"fail_status").click
    @browser.window(:title => /Survey/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
    sleep 5
    body_text = @browser.text
    body_text.should include("The fail redirect has passed for this URL!")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
    @browser.link(:id,"finishBtn").click
    sleep 5
    body_text = @browser.text
    body_text.should include("Congratulations")
    body_text.should include("You have successfully prepared your groups to go live.")
    sleep 3
    @browser.link(:text,/Go to Project Page/).click
    sleep 5
    @browser.link(:text,/Go Live/).click
    sleep 5
    body_text = @browser.text
    body_text.should include("You are about to go live with these groups/channels.")
    @browser.link(:text,/golive/).click
    sleep 15
    @browser.link(:text,"Pause").should exist
    @browser.link(:text,"Close").should exist
    end

    it "Test to check if a member is not able to see a survey if the panel dashboard settings are set not to display on a particular site" do
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      @browser = @obj.Surveyhead_sm_login("test22.des09@mailop.com","test22.des09@mailop.com")
      sleep 8
      body_text = @browser.text
      body_text.should_not include("#{@survey_name}")
      @browser.link(:text,"Logout").click
      @browser.close
    end


    after(:all) do
      @browser.close
      puts "test 15 has completed"      
    end

end