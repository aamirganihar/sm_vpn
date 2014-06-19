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
#require 'watir'
#require 'watir-webdriver'
require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 03: Copying an existing project" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end


    it "Test to check if client is able to copy an existing project using the Copy Project option" do
    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
    @browser.link(:text,/#{project_name['project']}/).click
    sleep 3
    @browser.link(:text,"Copy this project").click
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    @browser.link(:text,/Save/).click
    #sleep 10
    Watir::Wait.until {@browser.text.include? 'Copy of Existing Project'}#explicit wait
    #@browser.link(:text,/Save/).click
    #sleep 3
    body_text = @browser.text
    body_text.should include("Project has been copied. Please review the Project Description below and adjust the project parameters to fit the requirements of your new project.")
    body_text.should include("Copy of Existing Project")
    end

  it "Test to check if a client is able to successfully save a copied project" do
    @date=Time.now.strftime("%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @browser.text_field(:name ,'txtStartDate').set @date_added_1
    @browser.text_field(:name ,'txtEndDate').set @date_added_10
    sleep 5
    @browser.link(:text,'Save').flash
    @browser.link(:text,'Save').flash
    @browser.link(:text,'Save').flash
    #@browser.link(:text,'Save').click
    @browser.link(:text,'Save').click
    @browser.link(:text,'Save').click
    sleep 10
    body_text = @browser.text
    body_text.should include("Your project has been copied")
  end
  
 
  it "Test to check if the group setting for a copied project are copied successfully" do
    @browser.link(:text,"Group Setup").click
    sleep 2
    body_text = @browser.text
    body_text.should include("CHANNELS, REWARDS AND GROUP COSTS")
    while @browser.div(:id=>/grpCountSamRefreshStatus/).visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 3
    @browser.link(:id,"addCostsNextButton").click
    @browser.checkbox(:id,"tc").set
    @browser.text_field(:id,"textfield").set(BasicData::USAMP_NAME)
    sleep 1
    @browser.link(:text,"Finish").click
    sleep 7
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
    @browser.checkbox(:index,0).set(false)
    @browser.checkbox(:index,1).set(false)
    #@browser.checkbox(:id,"multiple_clicks_allowed").set
    @browser.text_field(:id,"survey_name").set("Test Automation Survey")
    @browser.link(:id,"btnNext").click
    @browser.checkbox(:id,"multiple_clicks_allowed").set
    @browser.link(:text,"Next").click
    @browser.text_field(:id,"txtSurveyUrl").set(BasicData::SURVEY_URL)
    sleep 2
    @browser.link(:id,"btnSaveURL").click
    sleep 5
    @browser.link(:id,"succes_status").should exist
  end


  it "Test to check if a project is allowed to go live once all the data is entered for a copied project" do
    @browser.link(:id,"finishBtn").click
    sleep 5
    body_text = @browser.text
    body_text.should include("Congratulations")
    body_text.should include("You have successfully prepared your groups to go live.")
  end

  it "Test to confirm if a client is able to make a copied project live" do
    @browser.link(:text,/Go to Project Page/).click
    sleep 5
    @browser.link(:text,/Go Live/).click
    sleep 2
    body_text = @browser.text
    body_text.should include("You are about to go live with these groups/channels.")
    @browser.link(:text,/golive/).click
   
    sleep 15
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
    puts "Test case 3 has completed"
    end


end

