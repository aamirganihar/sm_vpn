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
require 'digest/md5'
require 'base64'

require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 25: Dashboard, Email invite survey cases and reward checking" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    @browser = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    #@browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")

  end

  it "should create a project on network site" do

    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
	@browser.driver.manage.timeouts.implicit_wait = 5
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
    File.open("InputRepository/Projectname_Stats.yml","w"){|file| YAML.dump(project_name,file)}
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
    #@browser.link(:text,'Create Project').click
    @browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")
   end

   it "To Create a group for Dashboard test" do
	@browser.link(:text,/Group Setup/).click
	@browser.driver.manage.timeouts.implicit_wait = 8
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
    sleep 3
      @browser.link(:text,/Age/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 3
      @browser.text_field(:id,"txtAgeRangeLower_1").set("44")
      @browser.text_field(:id,"txtAgeRangeUpper_1").set("54")
      @browser.link(:text,/Done/).click
      sleep 2
      @browser.link(:text,/Geographic Targeting/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 3
      @browser.link(:text,/Zip Code/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 3
      @browser.text_field(:id,"txtZipList").set("90001")
      @browser.link(:text,/Done/).click
      sleep 2
      @browser.link(:text,/90001/).should exist

      #Creating and Entering the group name into yaml files
      grp_name= Time.now
      grp_name = grp_name.to_s
      grp_name = grp_name.slice(0..18)
      @grp_name = "Test Automation Group_"+grp_name
      group_name = {}
      group_name['group'] = @grp_name
      File.open("InputRepository/Group_Ids_Stats.yml","w"){|file| YAML.dump(group_name,file)}

      @browser.text_field(:id,"txtGroupName").set("#{@grp_name}")
      @browser.text_field(:id,"txtSampleSize").set("20")
      @browser.text_field(:id,"txtIncidenceEst").set("50")
      @browser.link(:text,"Get Sample Counts").click
      sleep 10
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
      sleep 4
      body_text = @browser.text
      body_text.should include("Your groups have been defined")
      @browser.link(:text,/Prepare to go live/).click
      sleep 3
      @browser.link(:id,"btnApply").click
    
    end

  it "To Enter PanelShield data" do
      @browser.checkbox(:id,"chkClicksAllowed").set(false)
      @browser.checkbox(:id,"chkGeoIP").set(false)
      @browser.checkbox(:id,"chkRejProxy").set(false)
      @browser.checkbox(:id,"chkRejSpeeder").set(false)
      @browser.link(:text,"Next").click
    end

   it "To enter survey name and live close settings" do
    sleep 1
    group_name = File.open("InputRepository/Group_Ids_Stats.yml"){|file| YAML::load(file)}
    @grp_name = group_name['group']
    @browser.text_field(:id,"survey_name").set("#{@grp_name}")
    @browser.link(:id,"btnNext").click
    @browser.checkbox(:id,"multiple_clicks_allowed").set
    @browser.link(:text,"Next").click
    @browser.text_field(:id,"txtSurveyUrl").set(BasicData::SURVEY_URL)
    sleep 2
    @browser.link(:id,"btnSaveURL").click
    sleep 5
    @browser.link(:id,"succes_status").should exist
   end

  it "Check if the success links works" do
    @browser.link(:id,"succes_status").click
    @browser.window(:title => /Survey/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
	@browser.driver.manage.timeouts.implicit_wait = 5
    body_text = @browser.text
    body_text.should include("The success redirect has passed for this URL!")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
  end

  it "Check if the failure link works" do
    @browser.link(:id,"fail_status").click
    @browser.window(:title => /Survey/).use do
    @browser.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
	@browser.driver.manage.timeouts.implicit_wait = 5
    body_text = @browser.text
    body_text.should include("The fail redirect has passed for this URL!")
    sleep 2
    @browser.button(:id,"btnClose").click
    end
    sleep 2
  end

  it "Check if once all the data is entered, the project is allowed to go live" do
    @browser.link(:id,"finishBtn").click
    sleep 5
    body_text = @browser.text
    body_text.should include("Congratulations")
    body_text.should include("You have successfully prepared your groups to go live.")
  end

  it "Check if client is able to create and save a group" do
    sleep 3
    @browser.link(:text,/Go to Project Page/).click
    sleep 5
    @browser.link(:text,/Go Live/).click
    sleep 2
    body_text = @browser.text
    body_text.should include("You are about to go live with these groups/channels.")
    @browser.link(:text,/golive/).click
    sleep 7
    @browser.link(:text,"Pause").should exist
    @browser.link(:text,"Close").should exist
 end

  it "To Get Project and group details for survey Taking and Get IDs" do
#
#     project_name = File.open("InputRepository/Projectname_Stats.yml"){|file| YAML::load(file)}
#     @prj_name =  project_name['project']
#     group_name = File.open("InputRepository/Group_Ids_Stats.yml"){|file| YAML::load(file)}
#     @grp_name = group_name['group']
#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=group/run&prid=NDQ3NA==&groupid=NjY4OQ==#dashboard")
##     @browser.link(:text,/SampleMarket/).click
##
##      until(@browser.link(:text,/#{@prj_name}/).exists?)
##       @browser.link(:text,'Next').click
##        sleep(2)
##      end
#
#     @browser.link(:text,/#{@prj_name}/).click
     @browser.link(:text,/Test Automation Group/).click
     sleep 5
     @group_url=@browser.url
     puts @group_url
     @enc_group_name=/groupid=(\w+)/.match(@group_url)
     # @enc_group_name=/groupid=([A-Za-z])+==/
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

    File.open("InputRepository/Group_Ids_Stats.yml","w"){|file| YAML.dump(group_id,file)}

    #@browser.close
    end

   it "To check if a member is able to Complete a survey and check for reward" do

      group_id = File.open("InputRepository/Group_Ids_Stats.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Stats.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']


      @browser1 = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
      sleep 12
      body_text = @browser1.text
      body_text.should include("#{@dec_group_id}")
      @browser1.link(:id,"#{@dec_group_link}").click
      @browser1.button(:name,'Submit').click
      sleep 10
      @browser1.window(:title => /Survey/).use do
      @browser1.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
      @browser.driver.manage.timeouts.implicit_wait = 5
      body_text = @browser1.text
      #body_text.should include("CONGRATULATIONS")
      #sleep 7
      @browser1.link(:text,"Rewards").click
	sleep 10
        #Check for reward updation on surveyhead site
       @text_contents=@browser1.html
              @text_array =@text_contents.split(/\n/)
                0.upto(@text_array.size - 1) { |index|

                  if(@text_array[index] =~ /#{@dec_group_id}/)

                      @text_array[index+6].should include("1.25")

                        next
                  else
                end
                }
        end

      @browser1.link(:text,"Logout").click
      @browser1.close
      sleep 2

   end

  it "To check for the group cost calculation" do  
        group_id = File.open("InputRepository/Group_Ids_Stats.yml"){|file| YAML::load(file)}
      @dec_group_id =  group_id['group_id']

      group_id = File.open("InputRepository/Group_Ids_Stats.yml"){|file| YAML::load(file)}
      @dec_group_link = group_id['group_link']

      #project_id = File.open("InputRepository/Projectname_Stats.yml"){|file| YAML::load(file)}
      project_name = File.open("InputRepository/Projectname_Stats.yml"){|file| YAML::load(file)}
      @browser.link(:text,/#{project_name['project']}/).click
      #@browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=project/list&prid=NDQ3NA==#groups")
      

      @browser.link(:text,/Test Automation Group/).click
      sleep 5
      @c=0
        
       @text_contents=@browser.text
              @text_array =@text_contents.split(/\n/)
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /uSamp/)
                  
                     @c+=1
                     if(@c==3)
                                 
                           @text_array[index].should include("4.55")
                           @text_array[index].should include("1")
                           @text_array[index].should include("1")
                     end
                     #if(@c==4)
                        
                           #@text_array[index].should include("1")
                           #@text_array[index].should include("7.90")
                           #@text_array[index].should include("7.90")
                      #end

                        next
                      
                  else
                   
                end
                }

      sleep(1)
  end

  it "To Check for Demographic Group Stats: Gender" do
     @browser.link(:text,/Group Stats/).click
     
     while @browser.div(:id=>"ActivityStatsLoad").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 5
    #puts @browser.html
    @browser.link(:href,"#Demographic-Stats").click
    #puts @browser.div(:id=>"Demographic-Stats").options
    #link(:text=>/Demographic Stats/).click

     sleep 10
     
     sleep 8

    #Checking Gender Stats
     @c=0
     @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
      #puts @text_array
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /Male/)
                    @c+=1
                    
                       if(@c==6)
                        @text_array[index].should include("1")
                        @text_array[index].should include("100")
                       end
                      next
                  else
                end
               }
   end

   it "To Check for Demographic Group Stats: Age" do
     #Checking Age Stats
      @c=0
     @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
      #puts @text_array
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /45-54/)
                    @c+=1
                    
                       if(@c==6)
                        @text_array[index].should include("1")
                        @text_array[index].should include("100")
                       end
                      next
                  else
                end
               }
   end

   it "To Check for Demographic Group Stats: Children" do
     #Checking Children Stats
      @c=0
     @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
      #puts @text_array
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /Children/)
                    @c+=1
                    
                   
                       if(@c==6)
                        @text_array[index+2].should include("1")
                        @text_array[index+2].should include("100")
                       end
                      next
                  else
                end
               }
   end
    
  it "To Check for Demographic Group Stats: Ethnicity" do

    #Checking Ethnicity Stats
      @c=0
     @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
      #puts @text_array
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /African American/)
                    @c+=1
                       if(@c==6)
                        @text_array[index].should include("1")
                        @text_array[index].should include("100")
                       end
                      next
                  else
                end
               }

  end

   it "To Check for Demographic Group Stats: Income" do
     #Checking Income Stats
      @c=0
     @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
      #puts @text_array
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /$60,000-$69,000/)
                    @c+=1
                       if(@c==6)
                        @text_array[index].should include("1")
                        @text_array[index].should include("100")
                       end
                      next
                  else
                end
               }

  end

   it "To Check for Group Activity Stats" do
      sleep 3
      @browser.link(:text,/Group Stats/).click
      sleep 10
      @browser.link(:href,"#Activity-Graph").click
      sleep 5
      #Checking Income Stats
      @c=0
      @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /Estimated Incidence/)
                    @c+=1
                       if(@c==1||@c==6)
                        @text_array[index].should include("50")
                        @text_array[index].should include("100")
                        @text_array[index].should include("4")
                        @text_array[index].should include("1")
                        @text_array[index].should include("1")

                       end
                      next
                  else
                end
               }

   end

  it "To Check for Demographic Project Stats" do
      sleep 5
     @browser.link(:text,/Test Automation Project/).click
     sleep 10
     @browser.link(:text,/Project Stats/).click
     sleep 10
     @browser.link(:href,"#Demographic-Stats").click
     sleep 5

     #Checking Gender Stats
     @c=0
      @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
      #puts @text_array
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /Male/)
                    @c+=1
                       if(@c==6)
                        @text_array[index].should include("1")
                        @text_array[index].should include("100")
                       end
                      next
                  else
                end
               }

     #Checking Age Stats
      @c=0
     @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
      #puts @text_array
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /45-54/)
                    @c+=1
                       if(@c==6)
                        @text_array[index].should include("1")
                        @text_array[index].should include("100")
                       end
                      next
                  else
                end
               }

     #Checking Children Stats
      @c=0
     @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
      #puts @text_array
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /Children/)
                    @c+=1
                       if(@c==6)
                        @text_array[index].should include("1")
                        @text_array[index].should include("100")
                       end
                      next
                  else
                end
               }

    #Checking Ethnicity Stats
      @c=0
     @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
      #puts @text_array
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /African American/)
                    @c+=1
                       if(@c==6)
                        @text_array[index].should include("1")
                        @text_array[index].should include("100")
                       end
                      next
                  else
                end
               }
     #Checking Income Stats
      @c=0
     @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
      #puts @text_array
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /$60,000-$69,000/)
                    @c+=1
                       if(@c==6)
                        @text_array[index].should include("1")
                        @text_array[index].should include("100")
                       end
                      next
                  else
                end
               }

  end

   it "To Check for Project Activity Stats" do
       sleep 8
      @browser.link(:href,"#Activity-Graph").click
      sleep 5
      #Checking Income Stats
      @c=0
      @text_contents=@browser.text
      @text_array =@text_contents.split(/\n/)
                0.upto(@text_array.size - 1) { |index|
                  if(@text_array[index] =~ /Estimated Incidence/)
                    @c+=1
                   
                       if(@c==6)
                        @text_array[index].should include("50")
                        @text_array[index].should include("100")
                        @text_array[index].should include("24")
                        @text_array[index].should include("1")
                        @text_array[index].should include("1")


                       end
                      next
                  else
                end
               }
   end


   after(:all) do
    @browser.close
    puts "Test case 25 has completed"
    end
end