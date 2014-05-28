require 'rubygems'
require './automation'
#Load WATIR
require 'optparse'
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
require 'win32/clipboard'
include Win32
#require 'md5'
require 'base64'
require 'YAML'

#require 'InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 00: Production basic tests" do

  before(:all) do
      driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
      @browser = Watir::Browser.new driver
      @browser.goto('https://network.usamp.com/login.php')
      @browser.radio(:value, "Client").set
      @browser.text_field(:id, "txtEmail").set("sangeeta_pai@persistent.co.in")
      @browser.text_field(:id, "txtPassword").set("spai")
      #Click login button
      @browser.link(:id,"btnLogin").click
	  sleep 3
  end

    it "To successfully create a SM project" do
        @browser.goto("https://network.usamp.com/SelfServe/index.php?mode=report/projectslanding")
        @browser.link(:text,"Add a new project").click
        prj_name= Time.now
        prj_name = prj_name.to_s
        prj_name = prj_name.slice(0..18)

        @date=Time.now.strftime("%m/%d/%Y")
        @SECONDS_PER_DAY = 60 * 60 * 24
        @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
        @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
      

        prj_name = "Production Automation"+prj_name
        project_name = {}
        project_name['project'] = prj_name
        File.open("InputRepository/projectname.yml","w"){|file| YAML.dump(project_name,file)}
        @browser.text_field(:id, "txtPrjName").set(prj_name)
        @browser.select_list(:id,"optPrjCat").select("Business")
        @browser.select_list(:id,"optPM").select("mayuri rivankar")
        @browser.select_list(:id,"optSalesRep").select("san pai-test1")    
        @date=Time.now.strftime("%m/%d/%Y")
        @SECONDS_PER_DAY = 60 * 60 * 24
        @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
        @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
        @browser.text_field(:id, "txtSurveyLength").set("2")
        @browser.text_field(:name ,'txtStartDate').set @date_added_1
        @browser.text_field(:name ,'txtEndDate').set @date_added_10
        @browser.checkbox(:name,"chkRelvantId").set(false)
        @browser.checkbox(:name,"chkRelvantId").set(false)
        @browser.link(:text,'Create Project').click
        sleep 2
        body_text = @browser.text
        body_text.should include("Your project has been created")
    end
    


    it "To successfully set Demographic criteria for a group" do
        @browser.link(:text,/Group Setup/).click
        #@browser.link(:text,/GROUP SETUP/).click
        sleep 2
       
        @browser.checkbox(:id,"PL[0]").set
        @browser.link(:text,/Demographic Targeting/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
            sleep 0.5
            puts "waiting for element"
        end
        @browser.link(:text,/Age /).click
        while @browser.div(:id=>"fancybox-loading").visible? do
            sleep 0.5
            puts "waiting for element"
    end
    sleep 4
        
        @browser.text_field(:id,"txtAgeGenderRangeLower_1").set("90")
        @browser.text_field(:id,"txtAgeGenderRangeUpper_1").set("99")
        sleep 2
        @browser.checkbox(:id,"rdFemaleAgeGender1").set
        #@browser.link(:text,/SAVE and add another category/).click
        @browser.link(:text,/Done/).click
        @browser.link(:text,/90-99/).should exist
    end
    

    it "To successfully set Geographic criteria for a group" do
        @browser.link(:text,/Geographic Targeting/).click
		sleep 0.5
        @browser.link(:text,/Zip Code/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
            sleep 0.5
            puts "waiting for element"
    end
    sleep 4
        @browser.text_field(:id,"txtZipList").set("98765")
        @browser.link(:text,/Done/).click
        @browser.link(:text,/98765/).should exist
    end
    

    it "To check if the get sample counts displays proper count" do
        grp_name= Time.now
        grp_name = grp_name.to_s
        grp_name = grp_name.slice(0..18)
        grp_name = "Production_Automation_Group"+grp_name
        @browser.text_field(:id,"txtGroupName").set(grp_name)
        @browser.text_field(:id,"txtSampleSize").set("15")
        @browser.text_field(:id,"txtIncidenceEst").set("100")
        @browser.checkbox(:id,"PL[0]").set
        @browser.link(:text,"Get Sample Counts").click
        while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
            sleep 1
    end
    sleep 2
            
        body_text = @browser.html
        html_array = body_text.split(/\n/)
        0.upto(html_array.size - 1) { |index|
        if(html_array[index] =~ />iPoll</)
            @code = html_array[index]
            break
            else
                next
            end
            }
	    puts @code
            @code1 = @code.slice(467..470)
	    puts @code1
            @code1 = @code1.gsub(/,/, "")
	    puts @code1
            @number = @code1.to_i
	    puts @number

            @number.should > 5
            @number.should < 35
        end
        
    it "To complete successful setup of group" do
        @browser.link(:id,"next").click
        sleep 3
        @browser.text_field(:index,0).set("5")   
        @browser.text_field(:index,1).set("0.01")   
        @browser.text_field(:index,2).set("5")   
        @browser.link(:id,"addCostsNextButton").click
        @browser.checkbox(:id,"tc").set
        @browser.text_field(:id,"textfield").set("sangeeta pai")
        sleep 3
        @browser.link(:text,"Finish").click
        sleep 8
        #body_text = @browser.text
	#sleep 3
        #body_text.should include("Your groups have been defined")
	@browser.text.should include("Your groups have been defined")
        @browser.link(:text,"Prepare to go live").click
        sleep 15
        @browser.link(:id,"btnApply").click
        @browser.checkbox(:id,"chkClicksAllowed").set(false)
        @browser.checkbox(:id,"chkGeoIP").set(false)
        @browser.checkbox(:id,"chkRejProxy").set(false)
        @browser.checkbox(:id,"chkRejSpeeder").set(false)
        #@browser.checkbox(:id,"chkRelevantId").set(false)
        @browser.link(:text,"Next").click
        @browser.checkbox(:index,0).set
        
        @grp_name= Time.now
        @grp_name = @grp_name.to_s
        @grp_name = @grp_name.slice(0..18)
        @grp_name = "Production please ignore"+@grp_name
        @browser.text_field(:id,"survey_name").set(@grp_name)
        group_name = {}
        group_name['group'] = @grp_name
        File.open("InputRepository/groupname_Demo.yml","w"){|file| YAML.dump(group_name,file)}
        sleep 3
	@browser.link(:id,"btnNext").click
	@browser.checkbox(:id,"multiple_clicks_allowed").set
        @browser.link(:text,"Next").click
        @browser.text_field(:id,"txtSurveyUrl").set("http://www.google.com?id=%%Token%%")
        sleep 2
        @browser.link(:id,"btnSaveURL").click
        sleep 5
        @browser.link(:id,"succes_status").should exist
        @browser.link(:id,"succes_status").click
        @browser.window(:title => /Google/).use do
            @browser.goto("http://sm1mr.com/ssred.php?S=1&ID=")
            sleep 2
            @browser.button(:id,"btnClose").click
        end
        sleep 2
        @browser.link(:id,"fail_status").click
        @browser.window(:title => /Google/).use do
            @browser.goto("http://sm1mr.com/ssred.php?S=2&ID=")
            body_text = @browser.text
            body_text.should include("The fail redirect has passed for this URL!")
            sleep 2
            @browser.button(:id,"btnClose").click
        end
        sleep 2
        @browser.link(:id,"finishBtn").click
	
        sleep 2
end

    it "To successfully create a email broadcast" do
	@browser.link(:text,/Go to Project Page/).click
        sleep 5
	@browser.link(:text,/compose invites/).click
	#sleep 5
	#body_text = @browser.text
	#body_text.should include("COMPOSE YOUR EMAIL MESSAGE")
	#body_text.should include("When you have finished composing your message it is suggested that you send a test email to ensure your broadcast is accurate.")
	#@browser.link(:text,"Next").click
	#sleep 5
	#body_text = @browser.text
	#body_text.should include("The following fields must be corrected before you can continue:")
	#body_text.should include("Subject is required")
	#body_text.should include("Headline is required")
	@browser.text_field(:id,"txtSubject").set("Subject: Test automation broadcast")
	@browser.text_field(:id,"texHeadline").set("Headline: Test automation headline")
	@browser.text_field(:id,"texSubHead").set("Subhead: Test automation headline")
	@browser.text_field(:id,"txtMsg").set("Message: This is a test automation broadcast mail")
	@browser.link(:text,"Next").click
	sleep 2
=begin	
	#body_text = @browser.text
	#body_text.should include("SPECIFY THE NUMBER OF EMAILS TO SEND")
	#body_text.should include("You can also adjust your sample criteria for this broadcast to broaden or narrow your target. In addition, you can also define your recipient list based on member activity.")
	#sleep 3
      #@browser.link(:text,"Back").click
      #sleep 4
      #body_text = @browser.text
      #body_text.should include("Subject*")
      #body_text.should include("166 Characters Remaining")
      #body_text.should include("Headline*")
      #body_text.should include("166 Characters Remaining")
      #body_text.should include("Subhead")
      #body_text.should include("167 Characters Remaining")
      #body_text.should include("Message")
      #body_text.should include("Message: This is a test automation broadcast mail 451 Characters Remaining")
      
      #@browser.link(:text,"Send test email").click
      #while @browser.div(:id=>"fancybox-loading").visible? do
      #sleep 0.5
      #puts "waiting for element"
      #end
      #sleep 3
      #@browser.text_field(:id,"txtEmail1").set("test22.des00@mailop.com")
      #@browser.text_field(:id,"txtEmail2").set("nitin_kumar@persistent.co.in")
      #@browser.link(:text,"Send").click
      #while @browser.div(:id=>"fancybox-inner").visible? do
      #sleep 0.5
      #puts "waiting for element"
      #end

      #@browser.link(:text,"Next").click
      #sleep 4
      body_text = @browser.html
      #body_text=ff.html
      html_array = body_text.split(/\n/)
      #html_array = body_text.split(/td><td/)
      0.upto(html_array.size - 1) { |index|
      if(html_array[index] =~ />iPOll</)
      #if(html_array[index] =~ //)
        @code = html_array[index+1]
	break
          else
            next
          end
          }
	  #puts @code

      @code1 = @code.slice(112..113)
      #@code1 = @code1.gsub(/,/, "")
      @number = @code1.to_i

      @number.should > 0
      @number.should < 15000
=end

      @browser.link(:text,/adjust sample criteria/).click
      #sleep 4
      #body_text = @browser.text
      #body_text.should include("Adjust Sample Criteria")
      #body_text.should include("Modifying the group criteria on this page is for the purpose of this broadcast only and will not change your actual group criteria.")
      #sleep 3
      #@browser.link(:text,"Trash").click
      sleep 2
      @browser.link(:text,/Demographic Targeting/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
	end
	sleep 4
      @browser.link(:text,/Income/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
	end
	sleep 4   
	@browser.select_list(:id,"optIncomeId").select("Prefer not to answer")
	sleep 2
	@browser.link(:text,"Add").click
	sleep 3
	@browser.link(:text,/Done/).click
	@browser.link(:text,"Get New Count").click
      sleep 4
      body_text = @browser.html
      #body_text=ff.html
      html_array = body_text.split(/\n/)
      #html_array = body_text.split(/td><td/)
      0.upto(html_array.size - 1) { |index|
      if(html_array[index] =~ />iPoll</)
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

#*****************************************************
     it "Test to check user is able to set number of emails and include send me in email broadcast" do
	sleep 3
       @browser.text_field(:id,"totEmailToSend0").set("1")
       #@browser.text_field(:id,"totEmailToSend2").set("4")
       @browser.checkbox(:name,"chkSendMe").set
       @browser.link(:text,"Next").click
=begin
sleep 2
       @browser.link(:text,"Back").click
       sleep 2
       @email1 = @browser.text_field(:id,"totEmailToSend0").value
       #@email2 = @browser.text_field(:id,"totEmailToSend2").value
       @email1.to_i.should == 1
       #@email2.to_i.should == 4
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
=end	
        #@browser.select_list(:id,"optScheduleTimezone").select(/Pacific/)
        #@browser.link(:text,"Next").click
        #sleep 2
        #@browser.link(:text,"Back").click
        #@timezone = @browser.select_list(:id,"optScheduleTimezone").value
        #@timezone.to_i.should == 5

        #sleep 2
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
        body_text.should include("iPoll -- 1 email")
        #body_text.should include("FocuslineSurveys -- 4 emails")
        #body_text.should include("Your group has to be live on that date/time for the schedule to take effect.")
=begin
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
        @browser.text_field(:id,"totEmailToSend0").value.should == "1"
        #@browser.text_field(:id,"totEmailToSend2").value.should == "4"
        #@browser.text_field(:id,"totEmailToSend0").set("4")
        #@browser.text_field(:id,"totEmailToSend2").set("4")
        @browser.link(:text,"Save").click
        sleep 4
        body_text = @browser.text
        body_text.should include("iPoll -- 1 email")
        #body_text.should include("FocuslineSurveys -- 4 emails")
        @browser.link(:href,/specifySample/).click
        @browser.text_field(:id,"totEmailToSend0").value.should == "1"
        #@browser.text_field(:id,"totEmailToSend2").value.should == "4"
        @browser.text_field(:id,"totEmailToSend0").set("1")
        #@browser.text_field(:id,"totEmailToSend2").set("4")
        @browser.link(:text,"Save").click
      end

    it "Test to check if user is able to complete sending the email broadcast" do
=end    
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
    
    
	
=begin  
    it "Test to successfully create a group" do
        @browser.link(:text,/Go Live/).click
        sleep 2
        body_text = @browser.text
        body_text.should include("You are about to go live with these groups/channels.")
        @browser.link(:text,/golive/).click
        sleep 15
        @browser.link(:text,"Pause").should exist
	sleep 2
        @browser.link(:text,"Close").should exist
    end
=end    
    it "To Get Project and group details for survey Taking and Get IDs" do
	    sleep 3
        @browser.link(:text,/Production_Automation_Group/).click
	sleep 8
        @group_url=@browser.url
        #puts @group_url
        @enc_group_name=/groupid=(\w+)=/.match(@group_url)
        # @enc_group_name=/groupid=([A-Za-z])+==/
		
		#Begin changes- SangeetaPai- 03 Jan 2012
				
		if @enc_group_name.nil?
			@enc_group_name=/groupid=(\w+)#/.match(@group_url)			
		end
		#end of changes- SangeetaPai
		
		sleep 5
		
		
        @enc_group_name=@enc_group_name.to_s()
        # puts @enc_group_name
        @enc_group_name=@enc_group_name[8..15]
        @dec_group_id=Base64.decode64(@enc_group_name)
        #puts @dec_group_id
        @dec_group_link="link"+@enc_group_name
        #@browser.link(:text,/SampleMarket/).click
        #p "#{@prj_name}"
        p "one:#{@dec_group_link}"
        #body_text = @browser.text
        #body_text.should include("#{@prj_name}")
        group_id = {}
        group_id['group_id'] = @dec_group_id
        group_id['group_link'] = @dec_group_link

        File.open("InputRepository/Group_Ids_Stats_prod.yml","w"){|file| YAML.dump(group_id,file)}
    end
   
    it "To check if a member is able to see the survey, click on it, complete it and check for the rewards" do
        group_id = File.open("InputRepository/Group_Ids_Stats_prod.yml"){|file| YAML::load(file)}
        @dec_group_id =  group_id['group_id']
        #group_id = File.open("InputRepository/Group_Ids_Stats_prod.yml"){|file| YAML::load(file)}
        @dec_group_link = group_id['group_link']


        driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
        @browser1 = Watir::Browser.new driver
        @browser1.goto('http://www.ipoll.com')
		
		# SangeetaPai- 12 March 2013 - start changes - commented the previous fix and refixed
		
			sleep 2
		
		if(@browser1.div(:id=>"desktopCover").exists?)			
			@browser1.div(:id=>"desktopCover").click			
		end
		sleep 2
	
	# End changes - SangeetaPai	
		
	@browser1.link(:id,"memLogin").click
		
        @browser1.text_field(:name, "txtEmail").set("sangeeta_pai@mailop.com")
        @browser1.text_field(:name, "txtPassword").set("sangeeta_pai@mailop.com")
        @browser1.button(:value,"Login").click
        sleep 3
=begin	
	if(@browser1.link(:id,"sb-nav-close").exists?)
	      @browser1.link(:id,"sb-nav-close").click
      end
=end      
      sleep 5
      
      if(@browser1.div(:id=>"loadingSurveys").exists?)
	      while @browser1.div(:id=>"loadingSurveys").visible? do
		      sleep 0.5
		      puts "waiting for surveys to load"
	      end
      end
      sleep 2
        body_text = @browser1.text
        body_text.should include("#{@dec_group_id}")
            @browser1.link(:id,"#{@dec_group_link}").click
        @browser1.button(:name,'Submit').click
        sleep(2)
        @browser1.window(:title => /Google/).use do
        @browser1.goto("http://sm1mr.com/ssred.php?S=1&ID=")
        body_text = @browser1.text
		
		
		
		# SangeetaPai- 15 March 2013 - start changes - commented the below line and fixed
		#body_text.should include("Congratulations") 
		
		
		if (@browser1.text.include?("Congratulations") || @browser1.text.include?("CONGRATULATIONS"))
			puts "complete success"
		else
			puts "complete fail"			
			break
		end	
				
		# SangeetaPai- 15 March 2013 - end changes 
			
		
		#body_text.should include("CONGRATULATIONS")
        @browser1.link(:text,"Rewards").click
        @text_contents=@browser1.html
        @text_array =@text_contents.split(/\n/)
        0.upto(@text_array.size - 1) { |index|
        if(@text_array[index] =~ /#{@dec_group_id}/)
            @text_array[index+5].should include("0.50") or ("1.00")
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
    
        
           


    it "To check if a member is able to fail the survey" do
        group_id = File.open("InputRepository/Group_Ids_Stats_prod.yml"){|file| YAML::load(file)}
        @dec_group_id =  group_id['group_id']
        group_id = File.open("InputRepository/Group_Ids_Stats_prod.yml"){|file| YAML::load(file)}
        @dec_group_link = group_id['group_link']
        driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
        @browser1 = Watir::Browser.new driver
        @browser1.goto('http://www.ipoll.com')
		
		# SangeetaPai- 12 March 2013 - start changes - commented the previous fix and refixed
		#if(@browser1.link(:text,"Remind Me Later").exists?)
		#	@browser1.link(:text,"Remind Me Later").click
		#end
			sleep 2
			
		if(@browser1.div(:id=>"desktopCover").exists?)			
			@browser1.div(:id=>"desktopCover").click			
		end
		sleep 2
	
	# End changes - SangeetaPai	
		
	@browser1.link(:id,"memLogin").click			
        @browser1.text_field(:name, "txtEmail").set("sangeeta@mailop.com")
        @browser1.text_field(:name, "txtPassword").set("sangeeta@mailop.com")
        @browser1.button(:value,"Login").click
        #sleep 3
	sleep 3
=begin	
	if(@browser1.link(:id,"sb-nav-close").exists?)
	      @browser1.link(:id,"sb-nav-close").click
      end
=end      
      sleep 5
      
      if(@browser1.div(:id=>"loadingSurveys").exists?)
	      while @browser1.div(:id=>"loadingSurveys").visible? do
		      sleep 0.5
		      puts "waiting for surveys to load"
	      end
      end
      sleep 2
        body_text = @browser1.text
        body_text.should include("#{@dec_group_id}")
        @browser1.link(:id,"#{@dec_group_link}").click
        @browser1.button(:name,'Submit').click
        sleep(2)
        @browser1.window(:title => /Google/).use do
            @browser1.goto("http://sm1mr.com/ssred.php?S=2&ID=")
            body_text = @browser1.text
            #body_text.should include ("Congratulations") or ("SORRY")
			if (@browser1.text.include?("Congratulations") || @browser1.text.include?("SORRY"))
				puts "Fail success"
			else
				puts "Fail  fail"
				break
			end
						
        end
		 sleep 2
        @browser1.link(:text,"Logout").click
        system("cookies.bat")
        @browser1.close
    end
    
  
    it "To check if a member is able to generate over quota for a survey" do
        group_id = File.open("InputRepository/Group_Ids_Stats_prod.yml"){|file| YAML::load(file)}
        @dec_group_id =  group_id['group_id']
        group_id = File.open("InputRepository/Group_Ids_Stats_prod.yml"){|file| YAML::load(file)}
        @dec_group_link = group_id['group_link']
        driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
        @browser1 = Watir::Browser.new driver
        @browser1.goto('http://www.ipoll.com')
		
		# SangeetaPai- 12 March 2013 - start changes - commented the previous fix and refixed
		#if(@browser1.link(:text,"Remind Me Later").exists?)
		#	@browser1.link(:text,"Remind Me Later").click
		#end
			sleep 3
			
		if(@browser1.div(:id=>"desktopCover").exists?)			
			@browser1.div(:id=>"desktopCover").click			
		end
		sleep 5
	
	# End changes - SangeetaPai	
		
	@browser1.link(:id,"memLogin").click		
        @browser1.text_field(:name, "txtEmail").set("sangeeta1@mailinator.com")
        @browser1.text_field(:name, "txtPassword").set("sangeeta1@mailinator.com")
        @browser1.button(:value,"Login").click
        sleep 3
	#sleep 3
=begin	
	if(@browser1.link(:id,"sb-nav-close").exists?)
	      @browser1.link(:id,"sb-nav-close").click
      end
=end      
      sleep 5
      
      if(@browser1.div(:id=>"loadingSurveys").exists?)
	      while @browser1.div(:id=>"loadingSurveys").visible? do
		      sleep 0.5
		      puts "waiting for surveys to load"
	      end
      end
      sleep 2
        body_text = @browser1.text
        body_text.should include("#{@dec_group_id}")
        @browser1.link(:id,"#{@dec_group_link}").click
        @browser1.button(:name,'Submit').click
        sleep(2)
        @browser1.window(:title => /Google/).use do
            @browser1.goto("http://sm1mr.com/ssred.php?S=3&ID=")
            body_text = @browser1.text
            #body_text.should include("SORRY")
			
			if (@browser1.text.include?("Congratulations") || @browser1.text.include?("SORRY"))
				puts "OverQuota success"
			else
				puts "OverQuota fail"
				break
			end
					
        end
        @browser1.link(:text,"Logout").click
        system("cookies.bat")
        @browser1.close
    end

    it "Test to check if the email broadcast is successfully received and a member is able to complete it" do
	    driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new driver
	    #puts "waiting for 60 seconds for the email to be received"
	    #sleep 60
	    #@browser1.goto("http://www.mailinator.com/maildir.jsp?email=test_ul")
		@browser1.goto("http://test_u1.mailinator.com")
	
	    #@browser1.goto('http://www.mailop.com/?email=test_u1')
	    sleep 4
	    body_text = @browser1.text
	    body_text.should include("Subject: Test automation broadcast")	
		@browser1.link(:text,"Subject: Test automation broadcast").click
		
		sleep 2
		@browser1.link(:text,"Start the Survey Now").click		
	    #@browser1.link(:text,/http:\/\/click\.surveyhelpcenter.com\/y\.z/).click
	    sleep 5
	    @browser1.goto("http://sm1mr.com/ssred.php?S=1&ID=")
	    sleep 5
	    #@browser1.text.should include("CONGRATULATIONS")
		if (@browser1.text.include?("Congratulations") || @browser1.text.include?("CONGRATULATIONS"))
				puts "mail complete success"
		else
				puts "mail complete fail"
				break
		end
		
	    #@browser1.text.should include("")
	    @browser1.close
    end
    
        it "To check if the stats(including the complete with email invite) are correctly shown correctly" do
        sleep 5
        @browser.refresh
        #puts @browser.text
        @browser.text.should include("uSamp")
        @browser.text.should include("5 3 1 1 1 33.3%")
        @browser.text.should include("Total   10 4 2 1 1 Avg. 66.7%")
    end
    
    it "To successfully close a project" do
        @browser.link(:text,"Close").click
        sleep 3
        @browser.driver.switch_to.alert.accept
    end


    it "To check the feasibility report and the count" do
        @browser.goto("https://network.usamp.com/SelfServe/index.php?mode=report/feasibilityRep")
        @browser.checkbox(:id,"PL[0]").set
        
        @browser.link(:text,/Demographic Targeting/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
		sleep 0.5
		puts "waiting for element"
	end
	sleep 4
        @browser.link(:text,/Age /).click
        while @browser.div(:id=>"fancybox-loading").visible? do
		sleep 0.5
		puts "waiting for element"
	end
	sleep 4
        @browser.text_field(:id,"txtAgeGenderRangeLower_1").set("90")
        @browser.text_field(:id,"txtAgeGenderRangeUpper_1").set("99")
        sleep 2
        @browser.checkbox(:id,"rdFemaleAgeGender1").set
        #@browser.link(:text,/SAVE and add another category/).click
        @browser.link(:text,/Done/).click
	sleep 3
        @browser.link(:text,/90-99/).should exist
        
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
        @browser.text_field(:id,"txtZipList").set("98765")
        @browser.link(:text,/Done/).click
	sleep 4
        @browser.link(:text,/98765/).should exist
        
        @browser.link(:text,"Get Sample Counts").click
        while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
            sleep 1
        end
            
        body_text = @browser.html
        html_array = body_text.split(/\n/)
        0.upto(html_array.size - 1) { |index|
        if(html_array[index] =~ />iPoll </)
            @code = html_array[index+2]
            #puts html_array[index]
            #puts html_array[index+1]
            #puts html_array[index+2]
            
            puts @code
            break
            else
                next
            end
            }
            @code1 = @code.slice(40..41)
            #puts @code1
            @code1 = @code1.gsub(/,/, "")
            @number = @code1.to_i

            @number.should > 5
            @number.should < 30
    end
    


    after(:all) do
        @browser.link(:text,"Log Out").click
        @browser.close
        puts "Test case for production has completed"
    end
end

