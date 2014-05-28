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
require 'digest/md5'
require 'base64'

require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 32: Fielding limits spread evenly" do

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
    @browser.text_field(:id, "txtSurveyLength").set("1")
    @browser.link(:text,'Create Project').click
    sleep 2
    body_text = @browser.text
    body_text.should include("Your project has been created")
  end

  it "To check if fielding limits are set as spread evenly, the usamp channel must only close when N has been achieved after waiting period." do
#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
#    @browser.link(:text,/#{project_name['project'][1]}/).click
    @browser.link(:text,/Group Setup/).click
    sleep 5
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    grp_name= Time.now
    grp_name = grp_name.to_s
    grp_name = grp_name.slice(0..18)
    grp_name = "Test Automation Group_"+grp_name
    @browser.text_field(:id,"txtGroupName").set(grp_name)
    @browser.text_field(:id,"txtSampleSize").set("25")
    @browser.text_field(:id,"txtIncidenceEst").set("50")
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    sleep 2
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
    sleep 2
    @browser.link(:text,"Prepare to go live").click
    sleep 4
    #@browser.link(:id,"btnApply").click
    sleep 2
    @browser.link(:id,"btnApply").click
    @browser.checkbox(:id,"chkClicksAllowed").set(false)
    @browser.checkbox(:id,"chkGeoIP").set(false)
    @browser.checkbox(:id,"chkRejProxy").set(false)
    @browser.checkbox(:id,"chkRejSpeeder").set(false)
    @browser.link(:text,"Next").click
    @browser.checkbox(:index,0).set(false)
    @browser.checkbox(:index,1).set(false)
    
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
    @browser.text_field(:id,"survey_name").set(@grp_name)
    @browser.link(:id,"btnNext").click
    sleep 2
    @browser.checkbox(:id,"chkAutoCloseClicks").set
    @browser.checkbox(:id,"chkAutoCloseCompletes").set(false)
    @browser.text_field(:index,1).set("4")
    @browser.checkbox(:id,"multiple_clicks_allowed").set
    @browser.radio(:id,"fieldingLimitTypePeriod").set
    @browser.link(:text,"Next").click
    @browser.text_field(:id,"txtSurveyUrl").set("http://203.199.26.75/usamp/TEST_SURVEY.php?id=%%Token%%")
    sleep 2
    @browser.link(:id,"btnSaveURL").click
    sleep 5
    @browser.link(:id,"succes_status").should exist
    @browser.link(:id,"succes_status").click
    sleep 5
    @browser.window(:title => /TEST_AUTOMATION_SURVEY/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
    @browser.link(:id,"fail_status").click
    sleep 5
    @browser.window(:title => /TEST_AUTOMATION_SURVEY/).use do
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
    @browser.link(:text,/Go Live/).click
    sleep 2
    body_text = @browser.text
    body_text.should include("You are about to go live with these groups/channels.")
    @browser.link(:text,/golive/).click
    sleep 7
    @browser.link(:text,"Pause").should exist
    @browser.link(:text,"Close").should exist
    #@browser.link(:text,"Log Out").click
    @browser.link(:text,/Test Automation Group/).click
     sleep 4
     @group_url=@browser.url
     #puts @group_url
     @enc_group_name=/groupid=(\w+)=/.match(@group_url)
     # @enc_group_name=/groupid=([A-Za-z])+==/
     @enc_group_name=@enc_group_name.to_s()
     # puts @enc_group_name
     @enc_group_name=@enc_group_name[8..15]
     @dec_group_id=Base64.decode64(@enc_group_name)
     #puts @dec_group_id
     @dec_group_link="link"+@enc_group_name
     #@browser.link(:text,/SampleMarket/).click
     #p "#{@prj_name}"
     #p "one:#{@dec_group_link}"
     #body_text = @browser.text
     #body_text.should include("#{@prj_name}")
     group_id = {}
     group_id['group_id'] = @dec_group_id
     group_id['group_link'] = @dec_group_link

     File.open("InputRepository/Group_Ids_limits_se.yml","w"){|file| YAML.dump(group_id,file)}

    #@browser.close
  end
   it "To click on a survey link 1" do
     group_id = File.open("InputRepository/Group_Ids_limits.yml"){|file| YAML::load(file)}
     @dec_group_id =  group_id['group_id']
     group_id = File.open("InputRepository/Group_Ids_limits.yml"){|file| YAML::load(file)}
     @dec_group_link = group_id['group_link']
     @browser1 = @obj.Surveyhead_sm_login("test22.des02@mailop.com","test22.des02@mailop.com")
     sleep 10
     body_text = @browser1.text
     #body_text.should include("#{@dec_group_id}")
     @browser1.link(:id,"#{@dec_group_link}").click
     @browser1.button(:name,'Submit').click
     sleep 5
     @browser1.window(:title => /TEST_AUTOMATION_SURVEY/).use do
       @browser1.goto("http://203.199.26.75/usamp/TEST_SURVEY.php")
   end
   #system("cookies.bat")
     @browser1.close
   end

=begin
  it "To click on a survey link 2" do
    group_id = File.open("InputRepository/Group_Ids_limits.yml"){|file| YAML::load(file)}
    @dec_group_id =  group_id['group_id']
    group_id = File.open("InputRepository/Group_Ids_limits.yml"){|file| YAML::load(file)}
    @dec_group_link = group_id['group_link']
    @browser1 = @obj.Surveyhead_sm_login("test22.des09@mailop.com","test22.des09@mailop.com")
    sleep 2
    body_text = @browser1.text
    sleep 10
    #body_text.should include("#{@dec_group_id}")
    @browser1.link(:id,"#{@dec_group_link}").click
    @browser1.button(:name,'Submit').click
    sleep 5
    @browser1.window(:title => /TEST_AUTOMATION_SURVEY/).use do
      @browser1.goto("http://203.199.26.75/usamp/TEST_SURVEY.php")
    end
    @browser1.close
  end
=end

  it "To check if the state of the project changes to closed after the waiting period" do
    sleep 90
    @browser.refresh
    @browser.link(:text,"Go Live").should exist
  end

   

  
  after(:all) do
    puts "Test 32 has completed"
    @browser.close
    @browser1.close
  end
end