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
#require 'watir'
#require 'watir-webdriver'
require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 16: Live/Close settings",:inprogress => true do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
    @grp_name= Time.now
    @grp_name = @grp_name.to_s
    @grp_name = @grp_name.slice(0..18)
  end

    it "should create a project on network site",:inprogress => true do
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
    #@browser.link(:text,'Create Project').click
    @browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")
  end

    it "To create a survey with a specific Demographic criteria",:inprogress => true do
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
    #while @browser.div(:id=>"fancybox-loading").visible? do
      #  sleep 0.5
        #puts "waiting for element"
    #end
    Watir::Wait.until { @browser.text.include? 'Age' }#explicit wait:default timeout :30sec:HRISHI
    @browser.link(:text,/Age/).click
     Watir::Wait.until { @browser.text.include? 'Age Range' }#explicit wait:default timeout :30sec:HRISHI
    #while @browser.div(:id=>"fancybox-loading").visible? do
      #  sleep 0.5
        #puts "waiting for element"
    #end
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
    sleep 5
    body_text = @browser.text
    body_text.should include("Your groups have been defined")
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
    #@browser.checkbox(:id,"multiple_clicks_allowed").set
    @browser.text_field(:id,"survey_name").set(@grp_name)
    @browser.link(:id,"btnNext").click
    end

    it "To check if a Group goes live at the specified time",:inprogress => true do
      @date=Time.now.strftime("%m/%d/%Y")
=begin
      @stamp = Time.new
      @stamp = @stamp.to_s
      @hour = @stamp.slice(11..12)
      @min = @stamp.slice(14..15)
      @second = @stamp.slice(17..18)
      #@stamp = @stamp.gsub(/\s/, "_")
      puts @hour
      puts @min
      puts @second
      
      if (@min.to_i < 58 && @min.to_i > 8)
        @min = @min.to_i+2
        else 
          if (@min.to_i < 8)
            @min1 = @min.to_i+2
            @min = "0"+@min1.to_s
          else
          
            if (@min.to_i == 58 && @hour.to_i >= 9 && @hour.to_i <23)
              @min = @min.to_i+2
              @min = 60 - @min.to_i
              @hour = @hour.to_i+1
              @min = @min.to_i+1
              else
                if (@min.to_i == 58 && @hour.to_i < 9)
                  @min = @min.to_i+2
                  @min = 60 - @min.to_i
                  @hour = @hour.to_i+1
                  @hour = @hour.to_s
                  @min = "0"+@min.to_s
              else
                if (@min.to_i > 58 && @hour.to_i >= 9 && @hour.to_i <23)
                  @min = @min.to_i+2
                  @min = @min.to_i - 60
                  @hour = @hour.to_i+1
                  else
                    if (@min.to_i > 58 && @hour.to_i < 9 )
                      @min = @min.to_i+2
                      @min = @min.to_i - 60
                      @hour = @hour.to_i+1
                      @hour = @hour.to_i
                      else
                        if (@min.to_i == 58 && @hour.to_i == 23)
                          @min = @min.to_i+2
                          @min = 60 - @min.to_i
                          @hour = "00"
                          else
                            if (@min.to_i > 58 && @hour.to_i == 23)
                              @min = @min.to_i+2
                              @min = @min.to_i - 60
                              @hour = "00"
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
              @browser.radio(:name,"autoOpenOption").set
              @browser.text_field(:name,"txtAutoOpenDate").value = @date
              if (@hour.to_i > 12)
                @hour = @hour.to_i - 12
                @time = "pm"
              else
                @time = "am"
              end
              if (@hour.to_i < 9 && @hour.to_i > 0)
                @hour = @hour.to_s
              end

              puts @hour
              @browser.select_list(:id,"optAutoOpenTimehr").select(@hour)
              @browser.select_list(:id,"optAutoOpenTimemin").select(@min)
              @browser.select_list(:id,"optAutoOpenTimehrFormat").select(@time)

              @browser.checkbox(:name,"chkAutoCloseByDate").set
              @browser.checkbox(:name,"chkAutoCloseCompletes").set(false)
              @date=Time.now.strftime("%m/%d/%Y")

              @stamp = Time.new
              @stamp = @stamp.to_s
              @hour = @stamp.slice(11..12)
              @min = @stamp.slice(14..15)
              @second = @stamp.slice(17..18)
              #@stamp = @stamp.gsub(/\s/, "_")
              puts @hour
              puts @min
              puts @second

              if (@min.to_i < 58 && @min.to_i > 8)
                @min = @min.to_i+4
                else
                  if (@min.to_i < 8)
                    @min1 = @min.to_i+4
                    @min = "0"+@min1.to_s
                  else

                    if (@min.to_i == 58 && @hour.to_i >= 9 && @hour.to_i <23)
                      @min = @min.to_i+4
                      @min = 60 - @min.to_i
                      @hour = @hour.to_i+1
                      @min = @min.to_i+1
                      else
                        if (@min.to_i == 58 && @hour.to_i < 9)
                          @min = @min.to_i+4
                          @min = 60 - @min.to_i
                          @hour = @hour.to_i+1
                          @hour = "0"+@hour.to_s
                          @min = "0"+@min.to_s
                      else
                        if (@min.to_i > 58 && @hour.to_i >= 9 && @hour.to_i <23)
                          @min = @min.to_i+4
                          @min = @min.to_i - 60
                          @hour = @hour.to_i+1
                          else
                            if (@min.to_i > 58 && @hour.to_i < 9 )
                              @min = @min.to_i+4
                              @min = @min.to_i - 60
                              @hour = @hour.to_i+1
                              @hour = @hour.to_i
                              else
                                if (@min.to_i == 58 && @hour.to_i == 23)
                                  @min = @min.to_i+4
                                  @min = 60 - @min.to_i
                                  @hour = "00"
                                  else
                                    if (@min.to_i > 58 && @hour.to_i == 23)
                                      @min = @min.to_i+4
                                      @min = @min.to_i - 60
                                      @hour = "00"
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                      @browser.radio(:name,"autoOpenOption").set
                      @browser.text_field(:name,"txtAutoOpenDate").value = @date
                      if (@hour.to_i > 12)
                        @hour = @hour.to_i - 12
                        @time = "pm"
                      else
                        @time = "am"
                      end
                      if (@hour.to_i < 9 && @hour.to_i > 0)
                        @hour = @hour.to_s
                      end

                      puts @hour

                      @browser.text_field(:id,"txtAutoCloseDate").set(@date)

                      @browser.select_list(:id,"optAutoCloseTimehr").select(@hour)
                      @browser.select_list(:id,"optAutoCloseTimemin").select(@min)
                      @browser.select_list(:id,"optAutoCloseTimehrFormat").select(@time)
=end


		      @browser.link(:text,"Next").click
                      @browser.text_field(:id,"txtSurveyUrl").set(BasicData::SURVEY_URL)
                      sleep 2
                      @browser.link(:id,"btnSaveURL").click
                      sleep 5
                      @browser.link(:id,"succes_status").should exist
                      @browser.link(:id,"succes_status").click
                      @browser.window(:title => /Survey/).use do
                      @browser.goto("http://p.sm1mr.com/ssred.php?S=1&ID=")
					  @browser.driver.manage.timeouts.implicit_wait = 5
                      #sleep 2
                      @browser.button(:id,"btnClose").click
                      end
                      sleep 2
                      @browser.link(:id,"fail_status").click
                      @browser.window(:title => /Survey/).use do
                      @browser.goto("http://p.sm1mr.com/ssred.php?S=2&ID=")
				      @browser.driver.manage.timeouts.implicit_wait = 5
		             # sleep 3
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
                      sleep 5
                      body_text = @browser.text
                      body_text.should include("You are about to go live with these groups/channels.")
                      @browser.link(:text,/golive/).click
                      sleep 15
                      @browser.link(:text,"Pause").should exist
		      @browser.link(:text,"Close").should exist
                      #@browser.link(:text,"Log Out").click
                      #@browser.close
end
    
    

=begin
   it "To check if a member is able to see a survey only if he satisfies the demographic criteria",:inprogress => true do
      #Username = File.open("InputRepository/migrationdata.yml"){|file| YAML::load(file)}
      group_name = File.open("InputRepository/groupname_Demo.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']

      @browser1 = @obj.Surveyhead_sm_login("test22.des00@mailinator.com","test22.des00@mailinator.com")
      sleep 5
      body_text = @browser.text
      body_text.should include("#{@grp_name}")
      @browser1.link(:text,"Logout").click
      @browser1.close
    end
=end
  #  it "To check if ",:inprogress => true do
      
   # end


    after(:all) do
    @browser.close
    end

end
