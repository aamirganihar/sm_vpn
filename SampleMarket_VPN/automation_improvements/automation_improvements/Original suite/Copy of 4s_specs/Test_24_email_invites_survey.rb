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

describe "Test 24: Group creation with recontact member id" do

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
    @browser.text_field(:id, "txtSurveyLength").set("10")
    #@browser.link(:text,'Create Project').click
    @browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")
  end

    it "To create a survey with a specific recontact token" do
#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
#    @browser.link(:text,/#{project_name['project'][1]}/).click
    @browser.link(:text,/Group Setup/).click
    sleep 2
    @browser.radio(:id,"recontactStudyOptionY").set
    @browser.select_list(:name,"recontactIncludeType").select("IDs")
    #@browser.text_field(:name,"membersTokens").set("7641248,10601577")
    @browser.text_field(:name,"membersTokens").set("10601577")
    #@browser.text_field(:name,"membersTokens").set("5557569")
    #path_value = @browser.text(:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[2]/td[2]").value
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

    @browser.link(:id,"addCostsNextButton").click
    @browser.checkbox(:id,"tc").set
    @browser.text_field(:id,"textfield").set(BasicData::USAMP_NAME)
    sleep 1
    @browser.link(:text,"Finish").click
    sleep 2
    body_text = @browser.text
    body_text.should include("Your groups have been defined")
    @browser.link(:text,"Prepare to go live").click
    sleep 5
    @browser.link(:id,"btnApply").click
    #@browser.link(:id,"btnApply").click
    #@browser.link(:id,"btnApply").click
    @browser.checkbox(:id,"chkClicksAllowed").set(false)
    @browser.checkbox(:id,"chkRejProxy").set(false)
    @browser.checkbox(:id,"chkRejSpeeder").set(false)
    @browser.link(:text,"Next").click
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
    @browser.text_field(:id,"survey_name").set(@grp_name)
    @browser.link(:id,"btnNext").click
    @browser.checkbox(:id,"multiple_clicks_allowed").set
    @browser.link(:text,"Next").click
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
    sleep 2
    #@browser.link(:text,"Next").click
    @browser.text_field(:id,"txtSurveyUrl").set("http://203.199.26.75/usamp/TEST_SURVEY.php/??recontact=%%oldToken%%&id=%%Token%%")
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
    sleep 2
    @browser.link(:text,/Go to Project Page/).click
    sleep 7
    @browser.link(:text,/compose invites/).click
    @browser.text_field(:id,"txtSubject").set("Subject: Test automation broadcast")
    @browser.text_field(:id,"texHeadline").set("Headline: Test automation headline")
    @browser.text_field(:id,"texSubHead").set("Subhead: Test automation headline")
    @browser.text_field(:id,"txtMsg").set("Message: This is a test automation broadcast mail")
    @browser.link(:text,"Next").click

    sleep 1
    @browser.text_field(:id,"totEmailToSend0").set("1")
    sleep 1
    @browser.checkbox(:name,"chkSendMe").set
    @browser.link(:text,"Next").click
    sleep 2
    @browser.radio(:id,"rdSendNow").set
    @browser.link(:text,"Next").click
    sleep 3
    @browser.checkbox(:name,"chkAcceptCost").set
    @browser.link(:text,"Finish").click
    sleep 3
    @browser.link(:text,"Go Live").click
    sleep 3
    @browser.link(:text,"golive").click
    sleep 2
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 4
    @browser.link(:text,"Pause").should exist
    @browser.link(:text,"Close").should exist
    @browser.close
 
  end

    it "To click on the email invitation link for a survey" do
      driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
      @browser1 = Watir::Browser.new driver
      @browser1.goto('http://test22.des0091.mailinator.com')
      sleep 150
      #@browser1.text_field(:name,"email").set("test22.des0091")
      #@browser1.button(:value,"Check!").click
        
        
      sleep 2
      body_text = @browser1.html
      #puts body_text
      #body_text=ff.html
      html_array = body_text.split(/\n/)
      #html_array = body_text.split(/td><td/)
      #puts     $html_array
      0.upto(html_array.size - 1) { |index|
      if(html_array[index] =~ /p\.ipoll/)
      #if(html_array[index] =~ /\.p\.ipoll/)
      #if(html_array[index] =~ //)
        #puts "***"
        #puts html_array[index]
        #puts "***"
        #puts html_array[index+1]
        #puts "***"
         @code = html_array[index]
        #puts html_array[index+2]
        #puts "***"
        break
          else
            next
          end
          }
        puts @code
        @code1 = @code.slice(34..465)
      #puts @code1
      @code1 = @code1.gsub(/amp;/, "")
      #puts @code1
      @browser1.goto("#{@code1}")
      sleep 5
      @browser1.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
      sleep 5
      @browser1.text.should include("Congratulations, you've just completed the survey!") or ("Thank you for your participation. This survey transaction will be reviewed within 4-6 weeks.")
     end

    after(:all) do
      @browser.close
      @browser1.close
      puts "Test 23 has completed"
    end
    
end

