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

describe "Test 17: Email invites" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "To create a new project for sending Email Broadcasts on network site" do
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

    it "Test to create a new Email broadcast" do
#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
#    @browser.link(:text,/#{project_name['project'][1]}/).click
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
    sleep 4
    @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
    @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
    @browser.link(:text,/Done/).click
    @browser.link(:text,/50-75/).should exist
    grp_name= Time.now
    grp_name = grp_name.to_s
    grp_name = grp_name.slice(0..18)
    grp_name = "Test Automation Group_"+grp_name
    @browser.text_field(:id,"txtGroupName").set(grp_name)
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
    #@browser.checkbox(:index,0).set(false)
    #@browser.checkbox(:index,1).set(false)
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
    @browser.text_field(:id,"survey_name").set(@grp_name)
#    group_name = {}
#    group_name['group'] = @grp_name
#    File.open("InputRepository/groupname_Demo.yml","w"){|file| YAML.dump(group_name,file)}
    @browser.link(:id,"btnNext").click
    sleep 1
    @browser.checkbox(:id,"multiple_clicks_allowed").set
    sleep 1
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
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
    sleep 1
    @browser.link(:id,"finishBtn").click
    sleep 1
    @browser.link(:text,/Go to Project Page/).click
    
    sleep 5
    @browser.link(:text,/compose invites/).click
    sleep 5
    body_text = @browser.text

    body_text.should include("COMPOSE YOUR EMAIL MESSAGE")
    body_text.should include("When you have finished composing your message it is suggested that you send a test email to ensure your broadcast is accurate.")

    end

    it "Test to check if all the mandatory fields for sending a email broadcast are compulsarily filled" do
    @browser.link(:text,"Next").click
    sleep 5
    body_text = @browser.text
    body_text.should include("The following fields must be corrected before you can continue:")
    body_text.should include("Subject is required")
    body_text.should include("Headline is required")
    end

    it "Test to check if user is able to enter details on Compose Email page" do
      @browser.text_field(:id,"txtSubject").set("Subject: Test automation broadcast")
      @browser.text_field(:id,"texHeadline").set("Headline: Test automation headline")
      @browser.text_field(:id,"texSubHead").set("Subhead: Test automation headline")
      @browser.text_field(:id,"txtMsg").set("Message: This is a test automation broadcast mail")
 
      @browser.link(:text,"Next").click
      sleep 4
      body_text = @browser.text
      body_text.should include("SPECIFY THE NUMBER OF EMAILS TO SEND")
      body_text.should include("You can also adjust your sample criteria for this broadcast to broaden or narrow your target. In addition, you can also define your recipient list based on member activity.")
    end
    
    it "Test to check if user is able to save settings on clicking next" do
      sleep 3
      @browser.link(:text,"Back").click
      sleep 4
      body_text = @browser.text
      body_text.should include("Subject*")
      body_text.should include("166 Characters Remaining")
      body_text.should include("Headline*")
      body_text.should include("166 Characters Remaining")
      body_text.should include("Subhead")
      body_text.should include("167 Characters Remaining")
      body_text.should include("Message")
      body_text.should include("Message: This is a test automation broadcast mail 451 Characters Remaining")
      
      @browser.link(:text,"Send test email").click
      while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
      end
      sleep 3
      @browser.text_field(:id,"txtEmail1").set("test22.des00@mailinator.com")
      #@browser.text_field(:id,"txtEmail2").set("nitin_kumar@persistent.co.in")
      @browser.link(:text,"Send").click
      while @browser.div(:id=>"fancybox-inner").visible? do
      sleep 0.5
      puts "waiting for element"
      end
    end


    it "Test to check if correct count is seen on specify # of emails" do
      @browser.link(:text,"Next").click
      sleep 4
      body_text = @browser.html
      #body_text=ff.html
      html_array = body_text.split(/\n/)
      #html_array = body_text.split(/td><td/)
      0.upto(html_array.size - 1) { |index|
      if(html_array[index] =~ />FocuslineSurveys</)
      #if(html_array[index] =~ //)
        @code = html_array[index+1]
	break
          else
            next
          end
          }

      @code1 = @code.slice(112..113)
      #@code1 = @code1.gsub(/,/, "")
      @number = @code1.to_i

      @number.should > 0
      @number.should < 15000

    end

    it "Test to check if user is able to adjust sample criteria" do
      @browser.link(:text,/adjust sample criteria/).click
      sleep 4
      body_text = @browser.text
      body_text.should include("Adjust Sample Criteria")
      body_text.should include("Modifying the group criteria on this page is for the purpose of this broadcast only and will not change your actual group criteria.")
    end

    it "Test to check if user is able to set demographic criteria and check counts" do
      sleep 3
      @browser.link(:text,"Trash").click
      sleep 2
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
      @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
      @browser.text_field(:id,"txtAgeRangeUpper_1").set("70")
      @browser.link(:text,/Done/).click
      sleep 2
      @browser.link(:text,/50-70/).should exist
      @browser.link(:text,"Get New Count").click
      sleep 4
      body_text = @browser.html
      #body_text=ff.html
      html_array = body_text.split(/\n/)
      #html_array = body_text.split(/td><td/)
      0.upto(html_array.size - 1) { |index|
      if(html_array[index] =~ />FocuslineSurveys</)
      #if(html_array[index] =~ //)
        @code = html_array[index+1]
        break
          else
            next
          end
          }

        @code1 = @code.slice(112..113)
        #@code1 = @code1.gsub(/,/, "")
        @number = @code1.to_i

        @number.should > 0
        @number.should < 15000
    end



    it "Test to check if user is able to set Geographic criteria and check counts" do
      @browser.link(:text,/adjust sample criteria/).click
      sleep 5
      @browser.link(:text,"Trash").click
      
      @browser.link(:text,/Geographic Targeting/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
	end
	sleep 5
      @browser.link(:text,/Zip Code/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
      end
      @browser.text_field(:id,"txtZipList").set("90001,90002,90003,90004,90005,90006,90007,90008,90009,90010")
      @browser.link(:text,/Done/).click
      sleep 2
      @browser.link(:text,"Get New Count").click
      sleep 4
      body_text = @browser.html
      #body_text=ff.html
      html_array = body_text.split(/\n/)
      #html_array = body_text.split(/td><td/)
      0.upto(html_array.size - 1) { |index|
      if(html_array[index] =~ />FocuslineSurveys</)
      #if(html_array[index] =~ //)
        @code = html_array[index+1]
        break
          else
            next
          end
          }

        @code1 = @code.slice(112..113)
        #@code1 = @code1.gsub(/,/, "")
        @number = @code1.to_i

        @number.should > 0
        @number.should < 15000
    end



    it "Test to check if user is able to set profile criteria and check counts" do
      @browser.link(:text,/adjust sample criteria/).click
      sleep 3
      @browser.link(:text,"Trash").click
      @browser.link(:text,/Profile Questions/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
      end
      @browser.select_list(:id,"profileSelOption").select("Sel_Automation")
    #sleep 4
    #@browser.select_list(:id,"profileSelOption").select("Travel")
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 4
    #@browser.link(:text,/Which rental car companies have you used?/).click
    @browser.link(:text,/Select a number/).click
    sleep 2
    @browser.checkbox(:title,"1").set
    sleep 2
    @browser.link(:text,/Select an alphabet/).click
    sleep 3
    @browser.checkbox(:title,"a").set
    
	
#    @browser.checkbox(:title,"Advantage Rent A Car").set
    @browser.link(:text,/Done/).click
      sleep 2
      @browser.link(:text,"Get New Count").click
      sleep 4
      body_text = @browser.html
      #body_text=ff.html
      html_array = body_text.split(/\n/)
      #html_array = body_text.split(/td><td/)
      0.upto(html_array.size - 1) { |index|
      if(html_array[index] =~ />FocuslineSurveys</)
      #if(html_array[index] =~ //)
        @code = html_array[index+1]
        break
          else
            next
          end
          }

        @code1 = @code.slice(112..113)
        #@code1 = @code1.gsub(/,/, "")
        @number = @code1.to_i

        @number.should >= 0
        @number.should < 15000
        
	
	@browser.link(:text,/adjust sample criteria/).click
	sleep 3
	@browser.link(:text,"Trash").click
	sleep 2
	@browser.link(:text,"Trash").click

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
      @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
      @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
      @browser.link(:text,/Done/).click
      sleep 2
      @browser.link(:text,/50-75/).should exist
      @browser.link(:text,"Get New Count").click
    end

     it "Test to check user is able to set number of emails and include send me in email broadcast" do
     sleep 3
       @browser.text_field(:id,"totEmailToSend0").set("5")
       @browser.text_field(:id,"totEmailToSend2").set("4")
       @browser.checkbox(:name,"chkSendMe").set
       @browser.link(:text,"Next").click
       sleep 2
       @browser.link(:text,"Back").click
       sleep 2
       @email1 = @browser.text_field(:id,"totEmailToSend0").value
       @email2 = @browser.text_field(:id,"totEmailToSend2").value
       @email1.to_i.should == 5
       @email2.to_i.should == 4
    end

      it "Test to check if Email invites can be scheduled based on time and timezone" do
	 sleep 5
        @browser.link(:text,"Next").click
        @browser.radio(:id,"rdSchedule").set
        @date=Time.now.strftime("%m/%d/%Y")
        @SECONDS_PER_DAY = 60 * 60 * 24
        @date=Time.now.strftime("%d")
	  #puts @date
	  @date1=@date.to_i+1
	  #puts @date1
    
	@browser.link(:id,"show").click
	if (@date.to_i == 31)
	    @browser.link(:text,"1").click
	    else
		    @browser.link(:text,@date1.to_s).click
    	    end
	#sleep 3
        #@browser.text_field(:id,"txtScheduleDate").set @date_added_1
	@browser.select_list(:id,"optHour").select("11")
	@browser.select_list(:id,"optMin").select("59")
	@browser.select_list(:id,"rdTime").select("pm")
	@browser.select_list(:id,"optScheduleTimezone").select(/Bombay/)
        @browser.link(:text,"Next").click
        sleep 2
	#@browser.text_field(:index,0).value.should include("5")
        @browser.link(:text,"Back").click
	@browser.select_list(:id,"optHour").value.should include("11")
	@browser.select_list(:id,"optMin").value.should include("59")
	@browser.select_list(:id,"rdTime").value.should include("PM")
        #@date_schedule = @browser.text_field(:id,"txtScheduleDate").value
        @timezone = @browser.select_list(:id,"optScheduleTimezone").value
        #@date_schedule.should == @date_added_1
        @timezone.to_i.should == 22
        @browser.select_list(:id,"optScheduleTimezone").select(/Pacific/)
        @browser.link(:text,"Next").click
        sleep 2
        @browser.link(:text,"Back").click
        @timezone = @browser.select_list(:id,"optScheduleTimezone").value
        @timezone.to_i.should == 5

      end
  
      it "Test to check Review broadcast-check details" do
        sleep 2
        @browser.radio(:id,"rdSendNow").set
        @browser.link(:text,"Next").click
        sleep 4
        body_text = @browser.text
        body_text.should include("REVIEW YOUR BROADCAST")
        body_text.should include("Please verify that the information below is correct. You can make changes by clicking the 'Edit' links on the right.")
        body_text.should include("Subject: Subject: Test automation broadcast")
        body_text.should include("Headline: Headline: Test automation headline")
        body_text.should include("Sub-Head: Subhead: Test automation headline")
        body_text.should include("Message: Message: This is a test automation broadcast mail")
        body_text.should include("Surveyhead -- 5 emails")
        body_text.should include("FocuslineSurveys -- 4 emails")
        #body_text.should include("Your group has to be live on that date/time for the schedule to take effect.")
      end
      
  
  
      it "Test to check if user can edit details from review broadcast" do
        #@browser.link(:href,/specifySample/).click
        @browser.link(:href,/composeEmail/).click
        sleep 3
        @browser.text_field(:id,"txtSubject").value.should == "Subject: Test automation broadcast"
        @browser.text_field(:id,"texHeadline").value.should == "Headline: Test automation headline"
        @browser.text_field(:id,"texSubHead").value.should == "Subhead: Test automation headline"
        @browser.text_field(:id,"txtMsg").value.should == "Message: This is a test automation broadcast mail"
        @browser.text_field(:id,"txtMsg").set("Message: This is a test automation broadcast mail changed")
        @browser.link(:text,"Save").click
        sleep 4
        body_text = @browser.text
        body_text.should include("Subject: Subject: Test automation broadcast")
        body_text.should include("Headline: Headline: Test automation headline")
        body_text.should include("Sub-Head: Subhead: Test automation headline")
        body_text.should include("Message: Message: This is a test automation broadcast mail changed")
        @browser.link(:href,/composeEmail/).click
        @browser.text_field(:id,"txtSubject").value.should == "Subject: Test automation broadcast"
        @browser.text_field(:id,"texHeadline").value.should == "Headline: Test automation headline"
        @browser.text_field(:id,"texSubHead").value.should == "Subhead: Test automation headline"
        @browser.text_field(:id,"txtMsg").value.should == "Message: This is a test automation broadcast mail changed"
        @browser.text_field(:id,"txtMsg").set("Message: This is a test automation broadcast mail")
        @browser.link(:text,"Save").click
        sleep 4
        body_text = @browser.text
        body_text.should include("Subject: Subject: Test automation broadcast")
        body_text.should include("Headline: Headline: Test automation headline")
        body_text.should include("Sub-Head: Subhead: Test automation headline")
        body_text.should include("Message: Message: This is a test automation broadcast mail")
        @browser.link(:href,/specifySample/).click
        @browser.text_field(:id,"totEmailToSend0").value.should == "5"
        @browser.text_field(:id,"totEmailToSend2").value.should == "4"
        @browser.text_field(:id,"totEmailToSend0").set("4")
        @browser.text_field(:id,"totEmailToSend2").set("4")
        @browser.link(:text,"Save").click
        sleep 4
        body_text = @browser.text
        body_text.should include("iPoll -- 4 emails")
        body_text.should include("FocuslineSurveys -- 4 emails")
        @browser.link(:href,/specifySample/).click
        @browser.text_field(:id,"totEmailToSend0").value.should == "4"
        @browser.text_field(:id,"totEmailToSend2").value.should == "4"
        @browser.text_field(:id,"totEmailToSend0").set("5")
        @browser.text_field(:id,"totEmailToSend2").set("4")
        @browser.link(:text,"Save").click
      end

    it "Test to check if user is able to complete sending the email broadcast" do
      @browser.checkbox(:name,"chkAcceptCost").set
      @browser.link(:text,"Finish").click
      sleep 4
      #body_text = @browser.text
      #puts body_text
      #body_text.should include("Your email campaign for")
      #body_text.should include("has been finalized")
      #body_text.should include("You can view details for this broadcast under the email invites tab on the group page. It may take a few minutes for this broadcast to be listed here.")
      #sleep 2
      @browser.link(:text,"Go Live").click
      sleep 5
      @browser.link(:text,"golive").click
      sleep 10
      @browser.link(:text,"Pause").should exist
      sleep 2
      @browser.link(:text,"Close").should exist
    end

    it "Test to check if user is able to complete the email broadcast" do
      @browser.link(:text,/Test Automation Group/).click
      sleep 2
      @browser.link(:text,/Email Invites/).click

    end
=begin  
    it "Test to check if user is able to Draft Reminders" do
        sleep 3
        @browser.link(:text,/Send Reminders/).click
        sleep 5
        @browser.radio(:id,"rdSelectCampaign").set
        sleep 5
        @browser.text_field(:id,"txtSubject").set("Subject: Test automation broadcast")
        @browser.text_field(:id,"texHeadline").set("Headline: Test automation headline")
        @browser.text_field(:id,"texSubHead").set("Subhead: Test automation headline")
        @browser.text_field(:id,"txtMsg").set("Message: This is a test automation broadcast mail")
 
        @browser.link(:text,"Next").click
        @browser.text_field(:id,"totEmailToSend0").set("2")
        @browser.text_field(:id,"totEmailToSend2").set("2")
        @browser.checkbox(:name,"chkSendMe").set
        @browser.link(:text,"Next").click
        sleep 2
        #@browser.link(:text,"Next").click
        @browser.radio(:id,"rdSendNow").set
        @browser.link(:text,"Next").click
        @browser.checkbox(:name,"chkAcceptCost").set
        @browser.link(:text,"Finish").click
        sleep 10
        @browser.text.should include("Reminder")
        @browser.text.should include("(pre-processing)")
        #puts @browser.text
    end
=end    
    it "Test to check if the email broadcast is successfully received" do
      driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
      @browser1 = Watir::Browser.new driver
      puts "waiting for 60 seconds for the email to be received"
      sleep 60
      #@browser1.goto("http://www.mailinator.com/maildir.jsp?email=test_automation")
      @browser1.goto('http://test22.des00@mailinator.com')
      #@browser1.text_field(:name,"email").set("test22.des00")
      #@browser1.button(:value,"Check!").click
      sleep 4
      body_text = @browser1.text
      body_text.should include("Subject: Test automation broadcast")
      @browser1.close
    end



    after(:all) do
        @browser.close
        puts "test 17 has completed" 
    end
    

end