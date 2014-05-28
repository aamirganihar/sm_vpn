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

describe "Test 12: Insertion Order page" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
    @grp_name = "Test Automation Group_"+@grp_name
    sleep 1
    @grp_name1= Time.now
    @grp_name1 = @grp_name1.to_s
    @grp_name1 = @grp_name1.slice(0..18)
    @grp_name1 = "Test Automation Group_"+@grp_name1
    sleep 1
    @grp_name2= Time.now
    @grp_name2 = @grp_name2.to_s
    @grp_name2 = @grp_name2.slice(0..18)
    @grp_name2 = "Test Automation Group_"+@grp_name2
    @prj_name= Time.now
    @prj_name = @prj_name.to_s
    @prj_name = @prj_name.slice(0..18)
    @prj_name = "Test Automation Project_"+@prj_name
    @date=Time.now.strftime("%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
  end

    it "To create a new project for checing Insertion Order" do
      @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
      @browser.link(:text,"Add a new project").click
      @date=Time.now.strftime("%m/%d/%Y")
      @SECONDS_PER_DAY = 60 * 60 * 24
      @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      @browser.text_field(:id, "txtPrjName").set(@prj_name)
      @browser.select_list(:id,"optPrjCat").select("Business")
      @browser.text_field(:name ,'txtStartDate').set @date_added_1
      @browser.text_field(:name ,'txtEndDate').set @date_added_10
      @browser.select_list(:id,"optPM").select("Nitin Kumar")
      @browser.text_field(:id, "txtSurveyLength").set("10")
      #sleep 3
    #@browser.link(:text,'Create Project').click
    @browser.link(:text,'Create Project').click
    sleep 5
      body_text = @browser.text
      body_text.should include("Your project has been created")
    end

    it "Test to check if user can create a group" do
      @browser.link(:text,/Group Setup/).click
      sleep 5
      @browser.checkbox(:id,"PL[40]").set
      @browser.checkbox(:id,"PL[13]").set
      @browser.checkbox(:id,"PL[2]").set
      @browser.checkbox(:id,"PL[0]").set
      @browser.link(:text,/Demographic Targeting/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
      end
      @browser.link(:text,/Age/).click
      sleep 3
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
      end
      @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
      @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
      @browser.link(:text,/Done/).click
      @browser.link(:text,/50-75/).should exist

      @browser.text_field(:id,"txtGroupName").set(@grp_name)
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
      sleep 5
      body_text = @browser.text
      body_text.should include("#{@grp_name}")
      @browser.text_field(:index,0).set("5")
      @browser.text_field(:index,2).set("5")
      @browser.text_field(:index,4).set("5")
      @browser.text_field(:index,6).set("5")
      @browser.text_field(:index,8).set("5")
      @browser.link(:id,"groupChannelRewardDisplay0").click
      @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
      @browser.link(:id,"addCostsNextButton").click
    end

    it "Test to check if Client Information section is displayed correctly from usamp Admin on the Insertion Order page" do
      sleep 5
      body_text = @browser.text
      body_text.should include("Client Information:")
      body_text.should include("Company: Test Automation Client")
      body_text.should include("Contacts: Nitin Kumar")
      body_text.should include("Address: n/a")
      body_text.should include("Tax ID: n/a")
      body_text.should include("Phone: n/a")
      body_text.should include("Fax: n/a")
    end

    it "Test to check if Project Information section is displayed as per data from Basic info of Project on the Insertion Order page" do
      
      body_text = @browser.text
      body_text.should include("Project Details")
      body_text.should include("Project Name: #{@prj_name}")
      body_text.should include("Category: Business")
      body_text.should include("Survey Length: 10")
      body_text.should include("Estimated Start Date: #{@date_added_1} 01:00 AM PDT")
      body_text.should include("Estimated End Date: #{@date_added_10} 01:00 AM PDT")
      body_text.should include("Estimated End Date: #{@date_added_10} 01:00 AM PDT")
      body_text.should include("Estimated Field Period: 9 days 0 hour 0 minute")
      body_text.should include("Project Notes: n/a")
    end

    it "Test to check if Group information section displays correct data for all groups and the reward amount on the Insertion Order page" do
      body_text = @browser.text
      body_text.should include("Completes Needed (N=): 25")
      body_text.should include("Channel Completes Needed (N=) Reward Amount Estimated CPI Cost")
	body_text.should include("BuzzBack 5 $1.50 $1.00 $5.00") 
	body_text.should include("FocuslineSurveys 5 $1.50 $1.00 $5.00")
	body_text.should include("iPoll 5 $1.50 $1.00 $5.00") 
	body_text.should include("[Your Panel Site] 5 $1.50 $1.00 $5.00")
	body_text.should include("uSamp 5 included $5.85 *$29.25")
      body_text.should include("ESTIMATED COSTS FOR ALL GROUPS **$49.25")
      body_text.should include("* The costs described for uSamp panelists are an estimate based upon the information provided (Incidence (IR), length of interview (LOI) and any targeting used. Final cost will be based on the actual incidence (calculated as # of completes divided by # of completes + # of terminates/overquotas), and actual length of interview and may be higher/lower than the estimate described above. Any changes to targeting may also affect the final CPI as well" )
      body_text.should include("** Final costs are calculated based on actual incidence and final completes.")

    end

    it "Test to check if project terms section should display data from Self service Cost and terms in usamp admin on the Insertion Order page" do
      body_text = @browser.text
      body_text.should include("Project Terms:")
      body_text.should include("The client agrees to the following fees and amounts for this project") 
      body_text.should include("CPI and Reward Costs: $49.25 (estimated)") 
      body_text.should include("Email Costs: $10.00 / email") 
      body_text.should include("Project Fee: $1.00")
      body_text.should include("Terms of payment: Net 30 days from time of invoice.")
    end

    it "Test to check if IO is submitted only when valid signature and terms checkbox is selected on the Insertion Order page" do
      @browser.link(:text,"Finish").click
      sleep 5
      body_text = @browser.text
      #body_text.should include("")
      body_text.should include("The following fields must be corrected before you can continue:")
      body_text.should include("The name does not match the name on file for this project.")
      body_text.should include("The Terms and Conditions must be accepted for the signature to be accepted. If you have a question")
      body_text.should include("regarding the Terms and Conditions please contact your Account Executive")
    end

    it "Test to check if a user is taken to an intermediate page, check next actions on the Insertion Order page" do
      @browser.checkbox(:id,"tc").set
      @browser.text_field(:id,"textfield").set(BasicData::USAMP_NAME)
      sleep 1
      @browser.link(:text,"Finish").click
      sleep 5
      body_text = @browser.text
      body_text.should include("Your groups have been defined")
      body_text.should include("Use the links in the left navigation to view your project and group pages.")

    end

    it "Test to check if project status changes to setup and directed to IO accepted page on submitting IO" do
      @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/viewprojects&s=2")
      @browser.link(:text,/#{@prj_name}/).click
      sleep 5
      body_text = @browser.text
      #Test Automation Project_Thu Mar 17 10:21:36 - PR2938 Setting Up
      body_text.should include("Setting Up")

    end


    after(:all) do
      sleep 2
      @browser.close
      puts "test 12 has completed"
    end
    
end
