require 'rubygems'
require './automation'
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
#require 'win32/clipboard'
#include Win32 
require 'YAML'
require './InputRepository/Basic_data'


describe "Test 01: Project creation" do

  before(:all) do
      #create an object of the UsampLib
      @obj = Usamp_lib.new
      @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end
  

  it "Test to confirm if an error is reported in case the mandatory fields which includes date and survey length are left blank on the project creation page" do
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
      @browser.link(:text,'Create Project').click
      body_text = @browser.text
      body_text.should include("The following fields must be corrected before you can continue:")
      body_text.should include("Estimated Start Date is required.")
      body_text.should include("Estimated End Date is required.")
      body_text.should include("Survey Length is required and must be numeric value.")
  end
  

  it "Test to check if an error is reported if the project start date is greater than end date on the project creation page" do
      @date=Time.now.strftime("%m/%d/%Y")
      @SECONDS_PER_DAY = 60 * 60 * 24
      @date_added_1=(Time.now - 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      #puts @date_added_1
      @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      #puts @date_added_10
      @browser.text_field(:name ,'txtStartDate').set @date_added_1
      @browser.text_field(:name ,'txtEndDate').set @date_added_10
      @browser.select_list(:id,"optPrjCat").select("Business")
      @browser.text_field(:id, "txtSurveyLength").set("10")
      @browser.select_list(:id,"optPM").select("Nitin Kumar")
      @browser.link(:text,'Create Project').click
      #@browser.link(:text,'Create Project').click
      sleep 5
      body_text = @browser.text
      body_text.should include("The following fields must be corrected before you can continue:")
      body_text.should include(" Estimated Start Date must be greater than current date.")
  end


  it "Test to check if time in field are correctly displayed based on the start and end dates on the project creation page" do
      @date=Time.now.strftime("%m/%d/%Y")
      @SECONDS_PER_DAY = 60 * 60 * 24
      @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      @date=Time.now.strftime("%m/%d/%Y")
      @SECONDS_PER_DAY = 60 * 60 * 24
      @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      @browser.text_field(:name ,'txtStartDate').set @date_added_1
      @browser.text_field(:name ,'txtEndDate').set @date_added_10
      @browser.text_field(:id, "txtSurveyLength").set("10")
      @browser.select_list(:id,"optPM").select("Nitin Kumar")
      sleep 5
      body_text = @browser.text
      body_text.should include("Time in Field: 9 days 0 hour 0 minute")  #uncomment when Day light saving is done
     #  body_text.should include("Time in Field: 9 days 1 hour 0 minute")
  end


  it "Test to check if a project is successfully created on the network site" do
      @date=Time.now.strftime("%m/%d/%Y")
      @SECONDS_PER_DAY = 60 * 60 * 24
      @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      @browser.text_field(:id, "txtSurveyLength").set("10")
      @browser.select_list(:id,"optPM").select("Nitin Kumar")
      @browser.text_field(:name ,'txtStartDate').set @date_added_1
      @browser.text_field(:name ,'txtEndDate').set @date_added_10
      @browser.text_field(:id, "txtSurveyLength").set("10")
      @browser.select_list(:id,"optPM").select("Nitin Kumar")
      #@browser.link(:text,'Create Project').click
      #sleep 3
      @browser.link(:text,'Create Project').click
      #@browser.link(:text,'Create Project').click
      sleep 5
      body_text = @browser.text
      body_text.should include("Your project has been created")
  end

  after(:all) do
      @browser.close
      puts "Test case 1 has completed"
  end
  end