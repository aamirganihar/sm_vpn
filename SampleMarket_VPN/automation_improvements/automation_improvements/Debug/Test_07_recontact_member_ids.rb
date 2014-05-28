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
require "watir-webdriver/extensions/wait"

require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 07: Group creation with recontact member id" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "Test to create a project on network site and add recontact member id to it" do
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
    @browser.select_list(:id,"optPM").select("Nitin Kumar")
    @date=Time.now.strftime("%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @browser.text_field(:id, "txtSurveyLength").set("10")
    @browser.text_field(:name ,'txtStartDate').set @date_added_1
    @browser.text_field(:name ,'txtEndDate').set @date_added_10
    sleep 3
    @browser.link(:text,'Create Project').click
    @browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")



#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
#    @browser.link(:text,/#{project_name['project'][1]}/).click
    @browser.link(:text,/Group Setup/).click
    sleep 2
    @browser.radio(:id,"recontactStudyOptionY").set
    @browser.select_list(:name,"recontactIncludeType").select("IDs")
    @browser.text_field(:name,"membersTokens").set("7641248,10648478,10596419")
    #path_value = @browser.text(:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[2]/td[2]").value
end


    it "Test to check if client can successfully complete creating the survey with a specific recontact id" do
        grp_name= Time.now
        grp_name = grp_name.to_s
        grp_name = grp_name.slice(0..18)
        grp_name = "Test Automation Group_"+grp_name
        @browser.text_field(:id,"txtGroupName").set(grp_name)
        group_name = {}
        group_name['group'] = grp_name
        File.open("InputRepository/groupname_id.yml","w"){|file| YAML.dump(group_name,file)}

        @browser.text_field(:id,"txtIncidenceEst").set("50")
        @browser.link(:text,"Get Sample Counts").click
        while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
            sleep 1
        end
        @browser.link(:id,"next").click
        sleep 3
        @browser.link(:id,"groupChannelRewardDisplay0").click
        @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
      @browser.link(:id,"addCostsNextButton").click
      @browser.checkbox(:id,"tc").set
      @browser.text_field(:id,"textfield").set(BasicData::USAMP_NAME)
      sleep 1
      @browser.link(:text,"Finish").click
      sleep 4
      body_text = @browser.text
      body_text.should include("Your groups have been defined")
      @browser.link(:text,"Prepare to go live").click

	sleep 8
       @browser.link(:id,"btnApply").click
      
        @browser.checkbox(:id,"chkClicksAllowed").set(false)
        #@browser.checkbox(:id,"chkGeoIP").set(false)
        @browser.checkbox(:id,"chkRejProxy").set(false)
        @browser.checkbox(:id,"chkRejSpeeder").set(false)
        @browser.link(:text,"Next").click
        sleep 5
        #@browser.checkbox(:index,1).set
        #@browser.checkbox(:index,2).set(false)
	@grp_name= Time.now
        @grp_name = @grp_name.to_s
        @grp_name = @grp_name.slice(0..18)
        @browser.checkbox(:id,"multiple_clicks_allowed").set
        @browser.text_field(:id,"survey_name").set grp_name
        @browser.link(:id,"btnNext").click
        sleep 4
        
        @browser.link(:text,"Next").click
        @browser.text_field(:id,"txtSurveyUrl").set("http://www.google.com/??recontact=%%oldToken%%&id=%%Token%%")
        sleep 2
        @browser.link(:id,"btnSaveURL").click
        sleep 5
        @browser.link(:id,"succes_status").should exist
        @browser.link(:id,"succes_status").click
        @browser.window(:title => /Google/).use do
            @browser.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
            sleep 2
            @browser.button(:id,"btnClose").click
        end
        sleep 2
        @browser.link(:id,"fail_status").click
        @browser.window(:title => /Google/).use do
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
        sleep 10
        @browser.link(:text,/Go Live/).click
        sleep 4
        body_text = @browser.text
        body_text.should include("You are about to go live with these groups/channels.")
        sleep 2
        @browser.link(:text,/golive/).click
        sleep 7
        @browser.link(:text,"Pause").should exist
        @browser.link(:text,"Close").should exist
        @browser.link(:text,"Log Out").click
        @browser.close
  end

    it "Test to check if a member is able to see a survey only if he is the member with the added recontact id" do
        #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
        group_name = File.open("InputRepository/groupname_id.yml"){|file| YAML::load(file)}
        grp_name = group_name['group']

        @browser = @obj.Surveyhead_sm_login("test22.des00@mailop.com","test22.des00@mailop.com")
        sleep 3
        body_text = @browser.text
        body_text.should include("#{grp_name}")
        @browser.link(:text,"Logout").click
        @browser.close
    end

#      @browser.link(:text,"Logout").click
#      @browser.close

      it "Test to check if a member is not able to see a survey if he is not the member with the added recontact id" do
          sleep 3
          @browser = @obj.Surveyhead_sm_login("test22.des02@mailop.com","test22.des02@mailop.com")
          sleep 3
          group_name = File.open("InputRepository/groupname_id.yml"){|file| YAML::load(file)}
          grp_name = group_name['group']
          body_text = @browser.text
          body_text.should_not include("#{grp_name}")
          @browser.link(:text,"Logout").click
          @browser.close

      #Userrname['demographic']

    end

    after(:all) do
        @browser.close
        puts "Test 7 has completed"
    end

end

