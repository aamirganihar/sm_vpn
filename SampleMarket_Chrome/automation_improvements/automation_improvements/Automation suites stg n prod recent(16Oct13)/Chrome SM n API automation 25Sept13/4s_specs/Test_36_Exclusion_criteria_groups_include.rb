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

describe "Test 36: Inclusion criteria based on Projects" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "Test to create a project on network site for exclusion criteria" do
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
    @browser.checkbox(:name,"chkRelvantId").set(false)
    @browser.checkbox(:name,"chkRelvantId").set(false)
    @browser.link(:text,'Create Project').click
    sleep 2
    body_text = @browser.text
    body_text.should include("Your project has been created")
end

#    it "To create a survey with a specific Demographic criteria" do
#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
#    @browser.link(:text,/#{project_name['project'][1]}/).click
    it "Test to check if a client can successfully add a exclusion criteria for a member not to see a survey based on his previvious clicks/completes" do
        @browser.link(:text,/Group Setup/).click
        sleep 2
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
        @browser.radio(:id,"ruleYes").set
        @browser.checkbox(:id,"chkMemberGroupsInclude").set
        sleep 2
        @browser.checkbox(:id,"chkIncludeClicks").set
        @browser.checkbox(:id,"chkIncludeCompletes").set
        @browser.checkbox(:id,"chkIncludeFails").set
        @browser.checkbox(:id,"chkIncludeOverQuota").set
        @browser.link(:id,"selIncludeQGhref").click
       # while @browser.div(:id=>"fancybox-loading").visible? do
         # sleep 0.5
          #puts "waiting for element"
      #end
            Watir::Wait.until { @browser.text.include? 'Selected' }#explicit wait:default timeout :30sec:HRISHI
      sleep 5
      project_name = File.open("InputRepository/projectname_asap.yml"){|file| YAML::load(file)}
      puts "#{project_name['project']}"
      sleep 5
      @browser.link(:text,/#{project_name['project']}/).click
      sleep 2
      #-------------------------------------------------
      group_id = File.open("InputRepository/Group_Ids_limits_asap.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']
      sleep 10
      puts @dec_group_id
      @browser.checkbox(:value,/#{@dec_group_id}/).set
     # ---------------------------------------------------
      @browser.link(:name,"addToRecontact").click
      
      @browser.link(:text,"Get Sample Counts").click
        while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
          sleep 1
        end
        @browser.link(:id,"next").click
        sleep 1
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
        sleep 2
        body_text = @browser.text
        body_text.should include("Your groups have been defined")
        @browser.link(:text,"Prepare to go live").click
        sleep 8
        #@browser.link(:id,"btnApply").click
	sleep 2
        @browser.link(:id,"btnApply").click
	
        @browser.checkbox(:id,"chkClicksAllowed").set(false)
        @browser.checkbox(:id,"chkGeoIP").set(false)
        @browser.checkbox(:id,"chkRejProxy").set(false)
        @browser.checkbox(:id,"chkRejSpeeder").set(false)
        #@browser.checkbox(:id,"chkRelevantId").set(false)
        @browser.link(:text,"Next").click
        @browser.checkbox(:index,0).set(false)
        #@browser.checkbox(:index,1).set(false)
        @grp_name= Time.now
        @grp_name = @grp_name.to_s
        @grp_name = @grp_name.slice(0..18)
        @grp_name = "Demographic"+@grp_name
        @browser.text_field(:id,"survey_name").set(@grp_name)
        group_name = {}
        group_name['group'] = @grp_name
        File.open("InputRepository/groupname_exclusion.yml","w"){|file| YAML.dump(group_name,file)}
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
        sleep 2
        body_text = @browser.text
        body_text.should include("You are about to go live with these groups/channels.")
        @browser.link(:text,/golive/).click
	 Watir::Wait.until { @browser.text.include? 'Live' }#explicit wait:default timeout :30sec:HRISHI
        sleep 10
        @browser.link(:text,"Pause").should exist
        @browser.link(:text,"Close").should exist
        #@browser.link(:text,"Log Out").click
        #@browser.close
    end
    


    it "Test to check if a is shown a survey if he is set to be included on the basis of exclusion criteria" do
      sleep 2
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      @browser1 = @obj.Surveyhead_sm_login("test22.des02@mailop.com","test22.des02@mailop.com")
      sleep 3
      group_name = File.open("InputRepository/groupname_exclusion.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']
      sleep 3
      body_text = @browser1.text
      body_text.should include("#{grp_name}")
      @browser1.link(:text,"Logout").click
      @browser1.close
  end
  
  it "Test to check if a is not shown a survey if he is not set to be included on the basis of exclusion criteria" do
      sleep 2
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      @browser1 = @obj.Surveyhead_sm_login("test22.des00@mailinator.com","test22.des00@mailinator.com")
      sleep 3
      group_name = File.open("InputRepository/groupname_exclusion.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']
      sleep 3
      body_text = @browser1.text
      body_text.should_not include("#{grp_name}")
      @browser1.link(:text,"Logout").click
      @browser1.close
    end
    
    after(:all) do
    @browser.link(:text,"Log Out").click
    @browser.close
    puts "Test case 36 has completed"
    end

end
