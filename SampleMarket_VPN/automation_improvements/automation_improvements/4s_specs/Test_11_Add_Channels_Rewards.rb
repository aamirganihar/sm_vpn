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

describe "Test 11: Adding multiple groups and ensuring that the reward values that are entered are stored after page navigation" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
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

  end

    it "Test to check if user can add more than one group using the +Add Another Quota Group button" do
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
      #sleep 3
    #@browser.link(:text,'Create Project').click
      @browser.link(:text,'Create Project').click
    sleep 5
      body_text = @browser.text
      body_text.should include("Your project has been created")
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
	sleep 4
      @browser.link(:text,/Age/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
	end
	sleep 2
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
      sleep 4
      @browser.text_field(:index,0).set("5")
      @browser.text_field(:index,2).set("5")
      @browser.text_field(:index,4).set("5")
      @browser.text_field(:index,6).set("5")
      @browser.text_field(:index,8).set("5")
      @browser.link(:id,"groupChannelRewardDisplay0").click
      @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
      #@browser.link(:id,"addCostsNextButton").click
      @browser.link(:text,"Add another group").click
      @browser.checkbox(:id,"PL[40]").set
      @browser.checkbox(:id,"PL[13]").set
      @browser.checkbox(:id,"PL[2]").set
      @browser.checkbox(:id,"PL[0]").set
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
      @browser.text_field(:id,"txtGroupName").set(@grp_name1)
      @browser.text_field(:id,"txtSampleSize").set("20")
      @browser.text_field(:id,"txtIncidenceEst").set("50")
      @browser.checkbox(:id,"PL[40]").set
      @browser.checkbox(:id,"PL[13]").set
      @browser.checkbox(:id,"PL[2]").set
      @browser.checkbox(:id,"PL[0]").set
      @browser.link(:text,"Get Sample Counts").click
      while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
        sleep 3
      end
      @browser.link(:text,"Save").click
      sleep 5
      body_text = @browser.text
      body_text.should include("#{@grp_name}")
      body_text.should include("#{@grp_name1}")
    end
    
    it "To check if user can add more than one group by using the copy group feature" do
      sleep 3
      @browser.link(:text,"Copy").click
      sleep 10
      @browser.text_field(:id,"txtGroupName").set(@grp_name2)
      sleep 5
      @browser.link(:text,"Get Sample Counts").click
      while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
        sleep 1
      end
      @browser.link(:id,"next").click
      sleep 5
      body_text = @browser.text
      body_text.should include("#{@grp_name}")
      body_text.should include("#{@grp_name1}")
      body_text.should include("#{@grp_name2}")
    end

    it "Test to check if a user can delete a group" do
      @browser.link(:text,"Trash").click
      sleep 2
      @browser.driver.switch_to.alert.accept
      while @browser.div(:id=>"fancybox-loading").visible? do#hrishi:waiting for deletion to be complete else asertion for @grp_name fails
        sleep 0.5
        puts "waiting for delete"
    end
      sleep 5
      body_text = @browser.text
      body_text.should_not include("#{@grp_name}")
      body_text.should include("#{@grp_name1}")
      body_text.should include("#{@grp_name2}")
  end
  
    it "Test to check if a user can edit a group" do
      @browser.link(:text,"Edit").click
      sleep 2
      @browser.link(:text,"Trash").click
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
sleep 3

      @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
      @browser.text_field(:id,"txtAgeRangeUpper_1").set("60")
      @browser.link(:text,/Done/).click
      sleep 1
      @browser.text_field(:id,"txtGroupName").set(@grp_name)
      @browser.link(:text,"Get Sample Counts").click
      while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
        sleep 1
      end
      @browser.link(:text,"Save").click
      sleep 5
      body_text = @browser.text
      body_text.should include("#{@grp_name}")
    end

    it "Test to check if user is able to add N value for selected channels" do
      sleep 2
      @browser.text_field(:index,0).set("5")
      sleep 2
      @browser.text_field(:index,2).set("5")
      sleep 2
      @browser.text_field(:index,4).set("5")
      sleep 2
      @browser.text_field(:index,6).set("5")
      sleep 2
      @browser.text_field(:index,8).set("5")
      sleep 2
      @browser.text_field(:index,9).set("5")
      sleep 2
      @browser.text_field(:index,11).set("5")
      sleep 2
      @browser.text_field(:index,13).set("5")
      sleep 2
      @browser.text_field(:index,15).set("5")
      sleep 2
      @browser.text_field(:index,17).set("5")
      sleep 4
      @browser.text_field(:index,0).value.should include("5")
      @browser.text_field(:index,2).value.should include("5")
      @browser.text_field(:index,4).value.should include("5")
      @browser.text_field(:index,6).value.should include("5")
      @browser.text_field(:index,8).value.should include("5")
      @browser.text_field(:index,9).value.should include("5")
      @browser.text_field(:index,11).value.should include("5")
      @browser.text_field(:index,13).value.should include("5")
      @browser.text_field(:index,15).value.should include("5")
      @browser.text_field(:index,17).value.should include("5")
    end
    

    it "Test to check if user is allowed to enter the reward amount" do
      @browser.text_field(:index,1).set("5")
      @browser.text_field(:index,3).set("5")
      @browser.text_field(:index,5).set("5")
      @browser.text_field(:index,7).set("5")
      sleep 3
  end
    it "Test to check if user is allowed to enter the reward amount using the pre-fill feature" do  
      @browser.link(:id,"groupChannelRewardDisplay1").click
      @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
      @browser.text_field(:index,1).value.should include("5")
      @browser.text_field(:index,3).value.should include("5")
      @browser.text_field(:index,5).value.should include("5")
      @browser.text_field(:index,7).value.should include("5")
      @browser.text_field(:index,9).value.should include("5")
      @browser.text_field(:index,10).value.should include("1.50")
      @browser.text_field(:index,12).value.should include("1.50")
      @browser.text_field(:index,14).value.should include("1.50")
      @browser.text_field(:index,16).value.should include("1.50")
    end

    it "Test to check if the values entered for N and reward values entered manually are stored when navigated through pages" do
      sleep 3
      @browser.link(:id,"addCostsNextButton").click
      sleep 2
      @browser.link(:text,"Back").click
      sleep 2
      @browser.text_field(:index,0).value.should include("5")
      @browser.text_field(:index,2).value.should include("5")
      @browser.text_field(:index,4).value.should include("5")
      @browser.text_field(:index,6).value.should include("5")
      @browser.text_field(:index,8).value.should include("5")
      @browser.text_field(:index,9).value.should include("5")
      @browser.text_field(:index,11).value.should include("5")
      @browser.text_field(:index,13).value.should include("5")
      @browser.text_field(:index,15).value.should include("5")
      @browser.text_field(:index,17).value.should include("5")
      @browser.text_field(:index,3).value.should include("5")
      @browser.text_field(:index,5).value.should include("5")
      @browser.text_field(:index,7).value.should include("5")
      @browser.text_field(:index,9).value.should include("5")
      @browser.text_field(:index,10).value.should include("1.50")
      @browser.text_field(:index,12).value.should include("1.50")
      @browser.text_field(:index,14).value.should include("1.50")
      @browser.text_field(:index,16).value.should include("1.50")

    end

    it "Test to check if the reward values entered using prefill the reward amount are retained when navigated through pages" do
      sleep 2
      @browser.link(:id,"groupChannelRewardDisplay0").click
      @browser.link(:text,/Pre-fill reward fields with suggested reward/).click
      sleep 2
      @browser.link(:id,"addCostsNextButton").click
      @browser.link(:text,"Back").click
      sleep 5
      @browser.text_field(:index,0).value.should include("5")
      @browser.text_field(:index,2).value.should include("5")
      @browser.text_field(:index,4).value.should include("5")
      @browser.text_field(:index,6).value.should include("5")
      @browser.text_field(:index,8).value.should include("5")
      @browser.text_field(:index,9).value.should include("5")
      @browser.text_field(:index,11).value.should include("5")
      @browser.text_field(:index,13).value.should include("5")
      @browser.text_field(:index,15).value.should include("5")
      @browser.text_field(:index,17).value.should include("5")
      @browser.text_field(:index,1).value.should include("1.50")
      @browser.text_field(:index,3).value.should include("1.50")
      @browser.text_field(:index,5).value.should include("1.50")
      @browser.text_field(:index,7).value.should include("1.50")
      @browser.text_field(:index,10).value.should include("1.50")
      @browser.text_field(:index,12).value.should include("1.50")
      @browser.text_field(:index,14).value.should include("1.50")
      @browser.text_field(:index,16).value.should include("1.50")
    end

    it "Test to check if the user is permitted to change the incidence value" do
      body_text = @browser.text
      body_text.should include("Completes Needed: 25    Incidence: 50%")
      @browser.link(:id,"groupChannelIncidenceDisplay0").click
      @browser.link(:text,"35%").click
      sleep 5
      body_text = @browser.text
      body_text.should include("Completes Needed: 25    Incidence: 35%")
    end


    after(:all) do
	@browser.close
	puts "test 11 has completed"
    end
end
