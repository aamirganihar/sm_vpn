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

describe "Test 28: Usamp Admin Self serve client" do

  before(:all) do
    #create an object of the UsampLib
    @company_name= Time.now
    @company_name = @company_name.to_s
    @company_name = @company_name.slice(13..18)
    #user = @company_name.gsub(//, "")
    @company_name = @company_name.gsub(/:/,"")
    @company_name = "Automation_SSuser_"+@company_name
    @user_name = @company_name+"@mailop.com"
    @obj = Usamp_lib.new
    @browser = @obj.Usampadmin_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD)
  end

  it "To Check if Usamp admin user is able to add a new Self service client" do
    @browser.goto("http://p.usampadmin.com/add_client.php")
    #@browser.link(:href,"add_client.php").click
    sleep 2
    @browser.text_field(:name,"txtCompany").set(@company_name)
    @browser.select_list(:name,"optCountryId").select("United States")
    @browser.text_field(:name,"txtTerms").set("365")
    @browser.select_list(:name,"optAllEmpRep").select("Abhijit Fadte")
    @browser.select_list(:name,"optAccountExec").select("akshata shanbhag")
    @browser.select_list(:name,"optPrimaryPM").select("Nitin Kumar")
    @browser.select_list(:name,"optSecondaryPM").select("Abhijit Fadte")
    @browser.checkbox(:id,"chkSelfServe").set
    sleep 2
    @browser.checkbox(:id,"chk4sAPI").set
    sleep 2
    @browser.driver.switch_to.alert.accept
    sleep 5
    @browser.radio(:id=>"smClientSelfServe",:value=>"1").set
    @browser.text_field(:id,"txtSelfServeAPIUserName").set(@user_name)
    @browser.text_field(:id,"txtSelfServeAPIPassword").set("test")

    @browser.text_field(:id,"txtClientContactFName").set("Test")
    @browser.text_field(:id,"txtClientContactLName").set(@user_name)
    #@browser.select_list(:id,"role").select("Project Manager")
    #@browser.checkbox(:id,"chbRole").set
    @browser.text_field(:id,"txtClientContactEmail").set(@user_name)
    @browser.text_field(:id,"txtClientContactPass").set("test")
    @browser.button(:id,"bt_submit").click
    @browser.text.should include("Client details have been added successfully.")
  end

  it "To check if Usamp admin user is able to save Self service cost terms" do
    @browser.link(:text,/C(\d+)/).click
    @browser.link(:href,/selfserve_cost_terms.php/).click
    @browser.text_field(:id,"txtUsageFee").set("10.00")
    sleep 1
    #@browser.text_field(:id,"txtRewardDiscount").set("1")
    @browser.text_field(:id,"txtEmailFee").set("10.000")
    @browser.text_field(:id,"txtCompleteFee").set("1.00")
    @browser.text_field(:id,"txtProjectFee").set("10.00")
    @browser.text_field(:id,"txtTerms").set("30")
    @browser.button(:name,"btnSave").click
    sleep 3
    @browser.text.should include("Client details have been updated successfully.")

    @number1 = @browser.text_field(:id,"txtUsageFee").value.to_i
    #@number2 = @browser.text_field(:id,"txtRewardDiscount").value.to_i
    @number3 = @browser.text_field(:id,"txtEmailFee").value.to_i
    @number4 = @browser.text_field(:id,"txtCompleteFee").value.to_i
    @number5 = @browser.text_field(:id,"txtProjectFee").value.to_i
    @number6 = @browser.text_field(:id,"txtTerms").value.to_i
    
    @number1.should == 10
    #@number2.should == 1
    @number3.should == 10
    @number4.should == 1
    @number5.should == 10
    @number6.should == 30
  end
  
  it "To check if Publisher associated to client is listed on Self service Panel settings." do
    @url = @browser.url
    @browser.goto("http://p.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=UFUz")
    @browser.checkbox(:id,"chbAssociatePub").set
    @browser.select_list(:id,"optAllUnassocClient").select("#{@company_name}")
    @browser.button(:id,"btnAddCli").click
    @browser.button(:id,"btnSave").click
    @browser.goto(@url)
    @browser.link(:href,/selfserve_panel.php/).click
    @browser.image(:id,"IMGPU[3]").click
    #@browser.button(:id,"IMGPU[3]").click
    @browser.button(:id,"button2").click
    sleep 3
    @browser.text.should include("These are the Publishers and their Private label Sites which are currently associated with this client")
    @browser.text.should include("PU3:Focusline")
  end

  it "To check if PL sites associated with the Publisher are listed after Publisher is added to the client" do
    @browser.text.should include("BuzzBack")
    #@browser.text.should include("DemoSurvey Test")
    @browser.text.should include("ERGSurvey.com")
    @browser.text.should include("FocuslineSurveys")
    @browser.text.should include("Surveyhead")
  end

  it "To check id Client is able to view and edit account details." do
    @browser.link(:text,"Main").click
    @text = @browser.text_field(:name,"txtTerms").value.to_i
    @text.should == 365
    @browser.text_field(:name,"txtTerms").set("10")
    @browser.button(:id,"bt_submit").click
    sleep 2
    @text = @browser.text_field(:name,"txtTerms").value.to_i
    @text.should == 10
  end
  
  it "To revert all changes" do
    @browser.goto("http://p.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=UFUz")
    @browser.select_list(:id,"optAllassocClient").select("#{@company_name}")
    @browser.button(:id,"btnRemoveCli").click
    @browser.button(:id,"btnSave").click
    sleep 3
    @browser.text.should include("Publisher Settings have been updated successfully.")
  end

  after(:all) do
    puts "Test 27 has completed"
    @browser.close
  end
  
end