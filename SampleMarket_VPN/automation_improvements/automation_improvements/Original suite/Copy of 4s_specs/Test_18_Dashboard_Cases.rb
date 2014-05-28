require 'rubygems'
require './automation'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
require 'win32/clipboard'
require 'digest/md5'
#require 'base64'
require "base64"
include Win32 
require 'YAML'


require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 18: Dashboard, Email invite survey cases and reward checking" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    @browser = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    #@browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
     
  end

  it "To create a project to test the dashboard functionalities" do

    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
    @browser.link(:text,"Add a new project").click

    prj_name= Time.now
    prj_name = prj_name.to_s
    prj_name = prj_name.slice(0..18)

    #@date=Time.now.strftime(#"%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")

    prj_name = "Test Automation Project_"+prj_name
    project_name = {}
    project_name['project'] = prj_name
    File.open("InputRepository/Projectname_Dashboard.yml","w"){|file| YAML.dump(project_name,file)}
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
    @browser.checkbox(:name,"chkRelvantId").set(false)
    @browser.checkbox(:name,"chkRelvantId").set(false)
    #@browser.link(:text,'Create Project').click
    @browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")
   end

   it "To Create a group for Dashboard feature testing" do
       @browser.link(:text,/Group Setup/).click
       sleep  4
       Country_value = @browser.select_list(:id,"optCountryId").text
       Language_value = @browser.select_list(:id,"optLanguageId").text
       Country_value.should include("United States")
       Language_value.should include("English")
	
      @browser.checkbox(:id,"PL[40]").set
      @browser.checkbox(:id,"PL[13]").set
      @browser.checkbox(:id,"PL[2]").set
      @browser.checkbox(:id,"PL[0]").set
      sleep 1
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
    sleep 4
      @browser.text_field(:id,"txtAgeRangeLower_1").set("44")
      @browser.text_field(:id,"txtAgeRangeUpper_1").set("54")
      @browser.link(:text,/Done/).click
      sleep 2
      @browser.link(:text,/Geographic Targeting/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
      sleep 4
      @browser.link(:text,/Zip Code/).click
       while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
      end
    sleep 4
      @browser.text_field(:id,"txtZipList").set("90001")
      @browser.link(:text,/Done/).click
      @browser.link(:text,/90001/).should exist

      #Creating and Entering the group name into yaml files
      grp_name= Time.now
      grp_name = grp_name.to_s
      grp_name = grp_name.slice(0..18)
      @grp_name = "Test Automation Group_"+grp_name
      group_name = {}
      group_name['group'] = @grp_name
      File.open("InputRepository/Groupname_Dashboard.yml","w"){|file| YAML.dump(group_name,file)}

      @browser.text_field(:id,"txtGroupName").set("#{@grp_name}")
      @browser.text_field(:id,"txtSampleSize").set("20")
      @browser.text_field(:id,"txtIncidenceEst").set("50")
      @browser.link(:text,"Get Sample Counts").click
      sleep 10
      @browser.link(:id,"next").click
      sleep 2
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
      @browser.link(:text,/Prepare to go live/).click
      sleep 3
      #@browser.link(:id,"btnApply").click
      sleep 2
    @browser.link(:id,"btnApply").click
    end

  it "Test to check if a client can enter PanelShield data successfully" do
      @browser.checkbox(:id,"chkClicksAllowed").set(false)
      @browser.checkbox(:id,"chkGeoIP").set(false)
      @browser.checkbox(:id,"chkRejProxy").set(false)
      @browser.checkbox(:id,"chkRejSpeeder").set(false)
      @browser.link(:text,"Next").click
    end

   it "Test to confirm if a client can  enter the survey name and set the live close settings" do
    #@browser.checkbox(:id,"multiple_clicks_allowed").set
    sleep 1
    group_name = File.open("InputRepository/Groupname_Dashboard.yml"){|file| YAML::load(file)}
    @grp_name = group_name['group']
    @browser.text_field(:id,"survey_name").set("#{@grp_name}")
    @browser.link(:id,"btnNext").click
    sleep 1
    @browser.checkbox(:id,"multiple_clicks_allowed").set
    sleep(1)
    @browser.link(:text,"Next").click
    @browser.text_field(:id,"txtSurveyUrl").set("http://203.199.26.75/usamp/TEST_SURVEY.php?id=%%Token%%")
    sleep 2
    @browser.link(:id,"btnSaveURL").click
    sleep 5
    @browser.link(:id,"succes_status").should exist
   end

  it "Test to check if the success links works" do
    @browser.link(:id,"succes_status").click
    @browser.window(:title => /TEST_AUTOMATION_SURVEY/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
    sleep 3
    body_text = @browser.text
    body_text.should include("The success redirect has passed for this URL!")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
  end

  it "Test to check if the failure link works" do
    @browser.link(:id,"fail_status").click
    @browser.window(:title => /TEST_AUTOMATION_SURVEY/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
    sleep 3
    body_text = @browser.text
    body_text.should include("The fail redirect has passed for this URL!")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
  end

  it "Test to check if once all the data is entered, the project is allowed to go live" do
    @browser.link(:id,"finishBtn").click
    sleep 7
    body_text = @browser.text
    body_text.should include("Congratulations")
    body_text.should include("You have successfully prepared your groups to go live.")
  end

  it "Test to check if a client can make a group go live with" do
    @browser.link(:text,/Go to Project Page/).click
    sleep 5
    @browser.link(:text,/Go Live/).click
    sleep 5
    body_text = @browser.text
    body_text.should include("You are about to go live with these groups/channels.")
    @browser.link(:text,/golive/).click
    sleep 10
    @browser.link(:text,"Pause").should exist
    @browser.link(:text,"Close").should exist
 end
   
  it "To Get Project and group details for survey Taking and Get IDs" do

     project_name = File.open("InputRepository/Projectname_Dashboard.yml"){|file| YAML::load(file)}
     @prj_name =  project_name['project']
     group_name = File.open("InputRepository/Groupname_Dashboard.yml"){|file| YAML::load(file)}
     @grp_name = group_name['group']
#     @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=project/list&prid=NDEwMw==#groups")
#     @browser.link(:text,/SampleMarket/).click
#
#      until(@browser.link(:text,/#{@prj_name}/).exists?)
#       @browser.link(:text,'Next').click
#        sleep(2)
#      end

#     @browser.link(:text,/#{@prj_name}/).click
	sleep 2
     @browser.link(:text,/Test Automation Group/).click
     sleep 5

     @group_url=@browser.url
     puts @group_url
     @enc_group_name=/groupid=(\w+)=/.match(@group_url.to_s)
     # @enc_group_name=/groupid=([A-Za-z])+==/
     @enc_group_name=@enc_group_name.to_s()
     puts @enc_group_name
     @enc_group_name=@enc_group_name[8..15]
     puts @enc_group_name
     #@dec_group_id=Base64.decode64(@enc_group_name)
     @dec_group_id=Base64.decode64(@enc_group_name.to_s)
     puts @dec_group_id
     @dec_group_link="link"+@enc_group_name
     #@browser.link(:text,/SampleMarket/).click
     #p "#{@prj_name}"
     p "one:#{@dec_group_link}"
     #body_text = @browser.text
     #body_text.should include("#{@prj_name}")
    group_id = {}
    group_id['group_id'] = @dec_group_id
    group_id['group_link'] = @dec_group_link

    File.open("InputRepository/Group_Ids_Dashboard.yml","w"){|file| YAML.dump(group_id,file)}

    #@browser.close
    end

  it "Test to check if a member is able to See a survey on dashboard for a live project" do

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']

      #p @dec_group_link

      @browser1 = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
      sleep 3
      body_text = @browser1.text
      body_text.should include("#{@dec_group_id}")
      @browser1.close
   end

    it "Test to check if the survey is not shown to a member on the dashboard if the project is paused" do
      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']

      @browser.link(:text,"Pause").click

      sleep(2)
      @browser.driver.switch_to.alert.accept
      #@browser.link(:text,"Close").should exist

      @browser1 = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
      sleep 3
      body_text = @browser1.text
      body_text.should_not include("#{@dec_group_id}")
      @browser1.close
   end

  it "Test to check if a member is not able to Not See a survey on dashboard for a Closed project" do

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']

      @browser.link(:text,"Close").click
      sleep(2)
      @browser.driver.switch_to.alert.accept

      @browser1 = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
      sleep 3
       body_text = @browser1.text
       body_text.should_not include("#{@dec_group_id}")
      @browser1.close
   end

   it "Test to check if a member is able to Complete a survey and check for reward" do

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']


      @browser.link(:text,"Go Live").click
      @browser.link(:text,"golive").click
      sleep(2)

      @browser1 = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
      sleep 3
      body_text = @browser1.text
      body_text.should include("#{@dec_group_id}")
      @browser1.link(:id,"#{@dec_group_link}").click
      @browser1.button(:name,'Submit').click
      sleep 10
      @browser1.window(:title => /TEST_AUTOMATION_SURVEY/).use do
      @browser1.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
      body_text = @browser1.text
      body_text.should include("CONGRATULATIONS")
      @browser1.link(:text,"Rewards").click
      sleep 7

        #Check for reward updation on surveyhead site
        @html_contents=@browser1.html
              @html_array = @html_contents.split(/\n/)
                0.upto(@html_array.size - 1) { |index|

                  if(@html_array[index] =~ /#{@dec_group_id}/)

                      @html_array[index+5].should include("1.50")

                        next
                  else
                end
                }
        end

      @browser1.link(:text,"Logout").click
      system("cookies.bat")
      @browser1.close
      sleep 2

   end


   it "Test to check if a member is able to Fail a survey" do

      sleep(95)
      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']

      @browser.link(:text,"Pause").click
      sleep(2)
      @browser.driver.switch_to.alert.accept
      @browser.link(:text,"Pause").click

      @browser.link(:text,"Go Live").click
      @browser.link(:text,"golive").click

      @browser1 = @obj.Surveyhead_login("test22.des04@mailop.com","test22.des04@mailop.com")
      sleep 15
      if(@browser1.button(:name,"btnDashboard").exists?)
	      @browser1.button(:name,"btnDashboard").click
      end
    
      body_text = @browser1.text
      body_text.should include("#{@dec_group_id}")
      sleep 10
      @browser1.link(:id,"#{@dec_group_link}").click
      sleep 10
      @browser1.button(:name,'Submit').click
      sleep 10
      @browser1.window(:title => /TEST_AUTOMATION_SURVEY/).use do
      @browser1.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
      body_text = @browser1.text
      body_text.should_not include("CONGRATULATIONS")

      @browser1.link(:text,"Rewards").click

      #Check for the group not seen on rewards page
      
      body_text.should_not include("#{@dec_group_id}")
      end
      sleep 10
      @browser1.link(:text,"Logout").click
      
      system("cookies.bat")
      @browser1.close

    end

    it "Test to check if a member is able to fire the Over quota redirect" do

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']

      group_name = File.open("InputRepository/Groupname_Dashboard.yml"){|file| YAML::load(file)}
      @grp_name = group_name['group']

      @browser1 = @obj.Surveyhead_sm_login("test22.des01@mailop.com","test22.des01@mailop.com")
      sleep 15
      body_text = @browser1.text
      body_text.should include("#{@grp_name}")
      @browser1.link(:id,"#{@dec_group_link}").click
      @browser1.button(:name,'Submit').click
      sleep 5
      @browser1.window(:title => /TEST_AUTOMATION_SURVEY/).use do
      @browser1.goto("http://p.sm1mr.com/ssred.php?S=3&ID=")
      body_text = @browser1.text
      body_text.should_not include("Congratulations")

      @browser1.link(:text,"My Rewards").click
      #Check for the group not seen on rewards page
      body_text.should_not include("#{@dec_group_id}")
      
      end
      @browser1.link(:text,"Logout").click
      system("cookies.bat")
      @browser1.close

      sleep 2
      
    end

  it "Test to check if a member is not able to see a survey on dashboard for a Completed project and Check member data review" do

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']
#      @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=group/run&prid=Mzc2OQ==&groupid=NTgxMg==#dashboard")

      @browser.link(:text,"Close").click
      sleep(2)
      @browser.driver.switch_to.alert.accept
      @browser.link(:text,/Test Automation Project/).click
      sleep(1)
      #@browser.link(:text,/Member Data/).click
      sleep(5)
      #@browser.link(:text,/Select All/).click
    
      @browser.link(:text,/Submit Valid Completes/).click
=begin      
      sleep 5
      @url = @browser.url
      @browser.close
      sleep 3
      @browser = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
      @browser.goto(@url)
      #@browser.refresh
=end      
      sleep 120
      @browser.refresh
      sleep 5
      @browser.checkbox(:id,"chkChaPrjStatus").set(true)
      @browser.link(:text,/Complete Project/).click
      sleep 8
      @browser.link(:text,/Done/).click
      sleep 5

      body_text = @browser.text
      body_text.should include("COMPLETED")
      body_text.should include("Project is COMPLETED and members have been rewarded.")

      sleep(2)

      @browser1 = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
      sleep 3
       body_text = @browser1.text
       body_text.should_not include("#{@dec_group_id}")

      if (@browser1.link(:text,"Rewards").exists?)
        @browser1.link(:text,"Rewards").click
      end
      
      #Check for reward updation on surveyhead site
      @html_contents=@browser1.html
            @html_array = @html_contents.split(/\n/)
              0.upto(@html_array.size - 1) { |index|

                if(@html_array[index] =~ /#{@dec_group_id}/)

                    @html_array[index+5].should include("1.50")
                    @html_array[index+7].should include("earned")

                else
                      next
              end
              }

      @browser1.link(:text,"Logout").click
      @browser1.close
      sleep 2
#

   end

   after(:all) do
     @browser.close

    @browser1.window(:title => /Paid Surveys/).use do
        @browser1.link(:text,"Logout").click
        @browser1.close
    end

   puts "test 18 has completed" 
   end

end

