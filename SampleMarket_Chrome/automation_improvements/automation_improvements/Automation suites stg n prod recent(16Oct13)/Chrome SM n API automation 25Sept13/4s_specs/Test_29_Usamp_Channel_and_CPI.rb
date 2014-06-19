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

describe "Test 29: Usamp channel and CPI" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "should create a project on network site" do
    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
	@browser.driver.manage.timeouts.implicit_wait = 8
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
    @browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")
  end

  it "To check that uSamp channel is by default selected when creating a group with US as country." do
#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
#    @browser.link(:text,/#{project_name['project'][1]}/).click
    @browser.link(:text,/Group Setup/).click
    sleep 5
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.select_list(:id,"optCountryId").select("Samoa")
    grp_name= Time.now
    grp_name = grp_name.to_s
    grp_name = grp_name.slice(0..18)
    grp_name = "Test Automation Group_"+grp_name
    @browser.text_field(:id,"txtGroupName").set(grp_name)
    @browser.text_field(:id,"txtSampleSize").set("20")
    @browser.text_field(:id,"txtIncidenceEst").set("50")
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    sleep 5
    @browser.text.should include("uSamp is not available")# for the criteria you selected.")
    @browser.select_list(:id,"optCountryId").select("United States")
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    sleep 3
    #puts @browser.text
    #puts "************************"
    #puts @browser.html
    #@browser.text.should include("uSamp ?")
    @browser.text.should include("uSamp")
    @browser.text.should include("$5.85 --- 20 5,000+")
    #@browser.text.should include("(Estimated CPI:")
  end
  
  it "To check to see if client can set fielding limits,if usamp channel is selected for the group." do
    @browser.link(:id,"next").click
    sleep 5
    @browser.text_field(:index,0).set("5")
    @browser.text_field(:index,2).set("5")
    @browser.text_field(:index,4).set("5")
    @browser.text_field(:index,6).set("5")
    @browser.text_field(:index,8).set("5")
    sleep 2
    @browser.link(:id,"groupChannelRewardDisplay0").click
    sleep 2
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
    #@browser.link(:id,"btnApply").click
    sleep 2
    @browser.link(:id,"btnApply").click
    @browser.checkbox(:id,"chkClicksAllowed").set(false)
    @browser.checkbox(:id,"chkGeoIP").set(false)
    @browser.checkbox(:id,"chkRejProxy").set(false)
    @browser.checkbox(:id,"chkRejSpeeder").set(false)
    @browser.link(:text,"Next").click
    sleep 3
    @browser.checkbox(:index,0).set(false)
    @browser.checkbox(:index,1).set(false)
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
    @browser.text_field(:id,"survey_name").set(@grp_name)
    @browser.link(:id,"btnNext").click
    sleep 2
    @browser.text.should include("Set fielding limits for uSamp channel")
    @browser.text.should include("Complete as soon as possible") 
    @browser.text.should include("Completes need to be spread evenly over the field period")
    @browser.text.should include("NOTE: Choosing the second option may affect feasibility and lengthen field time for hard to reach audiences.")
    @browser.link(:text,"Cancel").click
    sleep 2
    @browser.driver.switch_to.alert.accept
    sleep 8
    @browser.link(:text,"Trash").click
    sleep 4
    @browser.driver.switch_to.alert.accept
    sleep 4
  end
  
  it "To check if the client is not allowed to set fielding limits,if usamp channel is not selected for the group " do
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 1
      puts "Waiting for deletion to complete"
    end
    sleep 5
    @browser.link(:text,"GROUP SETUP").click
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
    @browser.text_field(:id,"txtSampleSize").set("20")
    @browser.text_field(:id,"txtIncidenceEst").set("50")
    @browser.select_list(:id,"optCountryId").select("United States")
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    @browser.link(:id,"next").click
    @browser.text_field(:index,0).set("5")
    @browser.text_field(:index,2).set("5")
    @browser.text_field(:index,4).set("5")
    @browser.text_field(:index,6).set("5")
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
    @browser.link(:id,"btnApply").click
    @browser.checkbox(:id,"chkClicksAllowed").set(false)
    @browser.checkbox(:id,"chkGeoIP").set(false)
    @browser.checkbox(:id,"chkRejProxy").set(false)
    @browser.checkbox(:id,"chkRejSpeeder").set(false)
    @browser.link(:text,"Next").click
    sleep 3
    @browser.checkbox(:index,0).set(false)
    @browser.checkbox(:index,1).set(false)
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
    @browser.text_field(:id,"survey_name").set(@grp_name)
    @browser.link(:id,"btnNext").click
    sleep 2
    @browser.text.should_not include("Set fielding limits for uSamp channel Complete as soon as possible Completes need to be spread evenly over the field period NOTE: Choosing the second option may affect feasibility and lengthen field time for hard to reach audiences.")
    @browser.link(:text,"Cancel").click
    sleep 2
    @browser.driver.switch_to.alert.accept
    sleep 8
    @browser.link(:text,"Trash").click
    sleep 4
    @browser.driver.switch_to.alert.accept
    sleep 4
  end
  it "To check if client can set Max CPI value and correct associated Incidence must be auto generated, if usamp channel is selected for the group." do
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 1
      puts "Waiting for deletion to complete"
    end
    sleep 5
    @browser.link(:text,"GROUP SETUP").click
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    grp_name= Time.now
    grp_name = grp_name.to_s
    grp_name = grp_name.slice(0..18)
    grp_name = "Test Automation Group_"+grp_name
    @browser.text_field(:id,"txtGroupName").set(grp_name)
    @browser.text_field(:id,"txtSampleSize").set("20")
    @browser.text_field(:id,"txtIncidenceEst").set("50")
    @browser.select_list(:id,"optCountryId").select("United States")
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
    @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
    @browser.link(:id,"addCostsNextButton").click
    @browser.checkbox(:id,"tc").set
    @browser.text_field(:id,"textfield").set(BasicData::USAMP_NAME)
    sleep 1
    @browser.link(:text,"Finish").click
    sleep 2
    @browser.link(:text,"Prepare to go live").click
    sleep 4
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
    sleep 1
    @browser.checkbox(:index,4).set
	  sleep 3
      @browser.text_field(:index,4).set("10")
      @browser.select_list(:id,"additional_contacts1").select("Nitin Kumar")
      sleep 1
      @browser.text_field(:index,2).set("25")
      sleep 5
      body_text = @browser.text
      #puts body_text
      #body_text=ff.html
      html_array = body_text.split(/\n/)
      #html_array = body_text.split(/td><td/)
      #puts     $html_array
      0.upto(html_array.size - 1) { |index|
      if(html_array[index] =~ /CPI Incidence Associated with Max/)
      #if(html_array[index] =~ //)
        #puts "***"
        #puts html_array[index]
        #puts html_array[index+1]
        @code = html_array[index+1]
	#puts html_array[index]
	puts html_array[index+1]
	#puts html_array[index+2]
        #puts html_array[index+2]
        break
          else
            next
          end
          }

    @code2 = @code.slice(93..95)
    @code3 = @code.slice(15..17)
    @code1 = @code.slice(54..57)
    puts "Code1(In use):"
    puts @code1
    puts "Code2:"
    puts @code2
    puts "Code2:"
    puts @code3
    @number = @code1.to_i
    @number.should == 14
  end
  
  after(:all) do
    puts "Test 29 has completed"
    @browser.close
  end
end