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
require 'win32/screenshot'

require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 38: Adding a new supplier" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "Test to create a project on network site and add supplier information for a new Supplier" do
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
	    @browser.select_list(:id,"optPM").select("Nitin Kumar")
	    @date=Time.now.strftime("%m/%d/%Y")
	    @SECONDS_PER_DAY = 60 * 60 * 24
	    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
	    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
	    @browser.text_field(:name ,'txtStartDate').set @date_added_1
	    @browser.text_field(:name ,'txtEndDate').set @date_added_10
	    @browser.select_list(:id,"optPrjCat").select("Business")
	    @browser.text_field(:id, "txtSurveyLength").set("10")
	    #@browser.link(:text,'Create Project').click
	    @browser.link(:text,'Create Project').click
	    sleep 5
	    body_text = @browser.text
	    body_text.should include("Your project has been created")
	#    it "To create a survey with a specific Demographic criteria" do
	#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
	#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
	#    @browser.link(:text,/#{project_name['project'][1]}/).click
	    @browser.link(:text,/Group Setup/).click
	    sleep 5
	    #@browser.checkbox(:id,"PL[40]").set
	    #@browser.checkbox(:id,"PL[13]").set
	    @browser.checkbox(:id,"PL[2]").set
	    @browser.checkbox(:id,"PL[0]").set
=begin
	    @browser.link(:text,/Demographic Targeting/).click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 3
	    @browser.link(:text,/Age/).click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 5
	    @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
	    @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
	    @browser.link(:text,/Done/).click
	    @browser.link(:text,/50-75/).should exist
=end    
	    grp_name= Time.now
	    grp_name = grp_name.to_s
	    grp_name = grp_name.slice(0..18)
	    grp_name = "Test Automation Group_"+grp_name
	    @browser.text_field(:id,"txtGroupName").set(grp_name)
	    @browser.text_field(:id,"txtSampleSize").set("20")
	    @browser.text_field(:id,"txtIncidenceEst").set("50")
	    #@browser.checkbox(:id,"PL[40]").set
	    #@browser.checkbox(:id,"PL[13]").set
	    @browser.checkbox(:id,"PL[2]").set
	    @browser.checkbox(:id,"PL[0]").set
	    @browser.link(:text,"Get Sample Counts").click
	    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
	      sleep 1
	    end
	    @browser.link(:id,"next").click
	    sleep 1
	    @browser.link(:id,"supplierLink0").click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 4
	    #Win32::Screenshot::Take.of(:foreground).write("Screenshot/Test_38_S1.jpg")
	    @browser.link(:id,"addSupplierOverlay").click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 2
	    supplier_name= Time.now
	    supplier_name = supplier_name.to_s
	    supplier_name = supplier_name.slice(0..18)
	    supplier_name = supplier_name.gsub(" ","")
	    supplier_name = supplier_name.gsub(":","")
	    supplier_name = supplier_name.gsub("-","")    
	    supplier_mail = "autosup"+supplier_name+"@mailop.com"
	    supplier_name="Automation Supplier_"+supplier_name
	    @browser.text_field(:id,"supplierName").set(supplier_name)
	    @browser.text_field(:id,"contactName").set(supplier_name)
	    @browser.text_field(:id,"contactEmail").set(supplier_mail)
    end
    
    it "Test to check if the option to enter redirect links is shown when This supplier gave me redirect links for this group option is selected" do
	    @browser.radio(:id,"redirect_options_2").set
	    #Win32::Screenshot::Take.of(:foreground).write("Screenshot\\Test_38_S2.jpg")
	    @browser.text_field(:id,"completeRedirectLink").should exist
	    @browser.text_field(:id,"failRedirectLink").should exist
	    @browser.text_field(:id,"oqRedirectLink").should exist
    end

    it "Test to check if the user is allowed to enter the redirect links when This supplier gave me redirect links for this group option is selected" do
	    @browser.text_field(:id,"completeRedirectLink").set("http://www.google.com")
	    @browser.text_field(:id,"failRedirectLink").set("http://www.yahoo.com")
	    @browser.text_field(:id,"oqRedirectLink").set("http://www.gmail.com")
	    @browser.checkbox(:id,"isGlobalRedirectLink").set
	    sleep 1
	    #@browser.div(:id => "overlayWrap").link(:text =>"Next").click
	    @browser.link(:text=>"Next", :index=>2).click
	    #@browser.link(:text,"Next").click
	    sleep 4
	    #puts @browser.text
	    @browser.text.should include("Please provide CPI and N= (number of completes) for each supplier.")
	    @browser.text.should include("A unique survey URL for each supplier is provided below.")
	    @browser.text.should include("You will need to give this URL to each supplier and in return your supplier needs to provide you with their redirect links")
	    @browser.text.should include("We will also send you an email with survey URLs and instructions you can forward to your suppliers.")
	    #@browser.text.should include ("You do not need to reveal your supplier CPI. If you do, it will not be visible to uSamp. Providing the CPI allows SampleMarket to keep a history of your CPIs with each supplier")
    end
    
    it "Test to check if the user clicks on cancel button, no junk characters are shown <b>(Test case to monitor defect DE1767)</b>" do
	    @browser.link(:id,"back").click
	    sleep 3
	    @browser.text.should_not include("**$NaN")
	    #puts @browser.text
    end
    
    it "Test to check if we add a value for N for a supplier, if the cost gets updated automatically <b>(Test case to monitor defect DE1768)</b>" do
	    @browser.link(:id,"supplierLink0").click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 4
	    @browser.radio(:value,"guaranteed").set
	    @browser.text_field(:id,"suppChannelCpi0").set("0.01")
	    @browser.link(:text,"Save").click
	    sleep 3
	    @browser.link(:id,"groupChannelRewardDisplay0").click
	    @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
	    sleep 2
    	    @browser.text_field(:index,5).set("5")
	    sleep 3
	    @browser.text.should include("$0.01 $0.05")
	    #@browser.text.should include("-- -- N= -- $0.01 --")
	    #@browser.text.should include("Total assigned N= 5   **$0.05")
	    sleep 2
	    
    end
    
    it "Test to check if the values are retained once we edit the supplier and save again" do
	    
	    @browser.link(:id,"supplierLink0").click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 4
	     @browser.link(:text,"Save").click
	    sleep 3
	    @browser.text.should include("$0.01 $0.05")
    end
    
    it "Test to check if we can add an existing supplier" do
	    @browser.link(:id,"supplierLink0").click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 4
	    @browser.link(:text,"Add an existing supplier").click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 4
	    @browser.select_list(:id,"optExistingSuppliersId").select("Test Sup 1")
	    @browser.link(:text,"Add").click
	    sleep 5
	    @browser.link(:text=>"Next",:index=>2).click
	    @browser.link(:text=>"Next",:index=>2).click
	    while @browser.div(:id=>"fancybox-loading").visible? do
	      sleep 0.5
	      puts "waiting for element"
	    end
	    sleep 4
	    #puts @browser.text
	    
    end
    
	    
	    
    
    
    
    
    
    
=begin
    it "Test to check if client can successfully complete creating the survey with a specific Demographic criteria" do

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
    sleep 5
    body_text = @browser.text
    body_text.should include("Your groups have been defined")
    @browser.link(:text,"Prepare to go live").click
    sleep 8
    @browser.link(:id,"btnApply").click
    sleep 2
    #@browser.link(:id,"btnApply").click
    sleep 2
    @browser.checkbox(:id,"chkClicksAllowed").set(false)
    @browser.checkbox(:id,"chkGeoIP").set(false)
    @browser.checkbox(:id,"chkRejProxy").set(false)
    @browser.checkbox(:id,"chkRejSpeeder").set(false)
    @browser.link(:text,"Next").click
    @browser.checkbox(:index,0).set(false)
    @browser.checkbox(:index,1).set(false)
    #@browser.checkbox(:id,"multiple_clicks_allowed").set
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
    @grp_name = "Demographic"+@grp_name
    @browser.text_field(:id,"survey_name").set(@grp_name)
    group_name = {}
    group_name['group'] = @grp_name
    File.open("InputRepository/groupname_Demo.yml","w"){|file| YAML.dump(group_name,file)}
    @browser.link(:id,"btnNext").click
    @browser.checkbox(:id,"multiple_clicks_allowed").set
    @browser.link(:text,"Next").click
    @browser.text_field(:id,"txtSurveyUrl").set("http://www.s.instant.ly/s/XRtQG?id=%%Token%%")
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
    sleep 4
    @browser.link(:text,"Pause").should exist
    @browser.link(:text,"Close").should exist
    @browser.link(:text,"Log Out").click
    @browser.close
  end

    it "Test to check if a member satisfying the demographic criteria is able to see the survey" do
      
      sleep 2
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      @browser = @obj.Surveyhead_sm_login("test22.des00@mailop.com","test22.des00@mailop.com")
      sleep 3
      group_name = File.open("InputRepository/groupname_Demo.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']
      sleep 3
      body_text = @browser.text
      body_text.should include("#{grp_name}")
      @browser.link(:text,"Logout").click
      @browser.close
    end

      #@browser.link(:text,"Logout").click
      #@browser.close

      it "Test to check if a member who does not satisfy the demographic criteria is unable to see the survey" do
      
      sleep 2
      @browser = @obj.Surveyhead_sm_login("test22.des02@mailop.com","test22.des02@mailop.com")
      sleep 3
      group_name = File.open("InputRepository/groupname_Demo.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']
      body_text = @browser.text
      body_text.should_not include("#{grp_name}")
      @browser.link(:text,"Logout").click
      @browser.close

      #Userrname['demographic']

    end
=end
    after(:all) do
    @browser.close
    puts "Test case 38 has completed"
    end

end
