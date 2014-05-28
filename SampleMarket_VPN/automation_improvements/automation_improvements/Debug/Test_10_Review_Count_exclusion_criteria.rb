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

describe "Test 10: Review Counts with Demographic Criteria, Geographic Criteria and matching panel book questions" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "To create a new project on network site for obtaining counts related to the exclusion criteria" do
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
    #project_name = {}
    #project_name['project'] = prj_name
    #File.open("InputRepository/projectname.yml","w"){|file| YAML.dump(project_name,file)}
    @browser.text_field(:id, "txtPrjName").set(prj_name)
    @browser.select_list(:id,"optPrjCat").select("Business")
    @browser.select_list(:id,"optPM").select("Nitin Kumar")
    @date=Time.now.strftime("%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @browser.text_field(:id, "txtSurveyLength").set("10")
    @browser.text_field(:name ,'txtStartDate').set @date_added_1
    @browser.text_field(:name ,'txtEndDate').set @date_added_10
    sleep 3
    @browser.link(:text,'Create Project').click
    @browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")
  end

    it "Test to confirm if valid review count values are obtained for members who have not completed a survey in the last 30 days" do
    @browser.link(:text,/Group Setup/).click
    sleep 3
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.radio(:id,"ruleYes").set
    grp_name= Time.now
    grp_name = grp_name.to_s
    grp_name = grp_name.slice(0..18)
    grp_name = "Test Automation Group_"+grp_name
    @browser.text_field(:id,"txtGroupName").set(grp_name)
    @browser.text_field(:id,"txtSampleSize").set("20")
    @browser.text_field(:id,"txtIncidenceEst").set("50")
    @browser.checkbox(:id,"chkSurveyCompleteExclude").set
    @browser.select_list(:id,"optSurveyComplete").select("30")
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    body_text = @browser.html
    #puts body_text
    #body_text=ff.html
    #html_array = body_text.split(/\n/)
    html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys</)
    #if(html_array[index] =~ //)
      #puts "***"
      #puts html_array[index]
      @code = html_array[index+2]
      #puts html_array[index+2]
      break
        else
          next
        end
        }

    @code1 = @code.slice(25..30)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 45000
    end

  it "Test to confirm if valid review count values are obtained for members who have completed a survey in the last 30 days" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.radio(:id,"ruleYes").set
    @browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
    @browser.checkbox(:id,"chkSurveyCompleteInclude").set
    @browser.select_list(:id,"optSurveyComplete").select("30")
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
    #@browser.text should include
    #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
    #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
    body_text = @browser.html
    #puts body_text
    #body_text=ff.html
    #html_array = body_text.split(/\n/)
    html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys</)
    #if(html_array[index] =~ //)
      #puts "***"
      #puts html_array[index]
      @code = html_array[index+2]
      #puts html_array[index+2]
      break
        else
          next
        end
        }

    @code1 = @code.slice(25..26)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should >= 0
    @number.should < 500
    end

  it "Test to confirm if valid review count values are obtained for members who have not received an email invitation in the last in the last 30 days" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.radio(:id,"ruleYes").set
    #@browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
    @browser.checkbox(:id,"chkSurveyCompleteInclude").set(false)
    @browser.checkbox(:id,"chkEmailReceivedExclude").set
    @browser.select_list(:id,"optEmailReceived").select("30")
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
    #@browser.text should include
    #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
    #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
    body_text = @browser.html
    #puts body_text
    #body_text=ff.html
    #html_array = body_text.split(/\n/)
    html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys</)
    #if(html_array[index] =~ //)
      #puts "***"
      #puts html_array[index]
      @code = html_array[index+2]
      #puts html_array[index+2]
      break
        else
          next
        end
        }
    @code1 = @code.slice(25..30)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 45000
    end

  it "Test to confirm if valid review count values are obtained for members who have received an email invitation in the last in the last 30 days" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.radio(:id,"ruleYes").set
    #@browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
    #@browser.checkbox(:id,"chkSurveyCompleteInclude").set(false)
    @browser.checkbox(:id,"chkEmailReceivedExclude").set(false)
    @browser.checkbox(:id,"chkEmailReceivedInclude").set
    @browser.select_list(:id,"optEmailReceived").select("30")
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
    #@browser.text should include
    #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
    #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
    body_text = @browser.html
    #puts body_text
    #body_text=ff.html
    #html_array = body_text.split(/\n/)
    html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys</)
    #if(html_array[index] =~ //)
      #puts "***"
      #puts html_array[index]
      @code = html_array[index+2]
      #puts html_array[index+2]
      break
        else
          next
        end
        }

    @code1 = @code.slice(25..27)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 500
    end

  
  it "Test to confirm if valid review count values are obtained for members who have not completed a survey in the last 30 days in specific category" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.radio(:id,"ruleYes").set
    #@browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
    #@browser.checkbox(:id,"chkSurveyCompleteInclude").set(false)
    #@browser.checkbox(:id,"chkEmailReceivedExclude").set(false)
    @browser.checkbox(:id,"chkEmailReceivedInclude").set(false)
    @browser.checkbox(:id,"chkMemberCategoryExclude").set
    @browser.select_list(:id,"optMemberCategory").select("30")
    @browser.link(:id,"selCategoryhref").click
    sleep 2
    @browser.select_list(:id,"optCategoryId").select("Business")
    @browser.select_list(:id,"optCategoryId").select("Advertising")
    @browser.select_list(:id,"optCategoryId").select("Child Care")
    @browser.select_list(:id,"optCategoryId").select("Consumer")
    @browser.select_list(:id,"optCategoryId").select("Cosmetics")
    @browser.link(:text,"Add").click
    @browser.link(:text,"Done").click
    sleep 2
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
    #@browser.text should include
    #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
    #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
    body_text = @browser.html
    #puts body_text
    #body_text=ff.html
    #html_array = body_text.split(/\n/)
    html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys</)
    #if(html_array[index] =~ //)
      #puts "***"
      #puts html_array[index]
      @code = html_array[index+2]
      #puts html_array[index+2]
      break
        else
          next
        end
        }

    @code1 = @code.slice(25..30)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 45000
    end

  it "Test to confirm if valid review count values are obtained for members who have completed a survey in the last 30 days in specific category" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.radio(:id,"ruleYes").set
    #@browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
    #@browser.checkbox(:id,"chkSurveyCompleteInclude").set(false)
    #@browser.checkbox(:id,"chkEmailReceivedExclude").set(false)
    #@browser.checkbox(:id,"chkEmailReceivedInclude").set(false)
    @browser.checkbox(:id,"chkMemberCategoryExclude").set(false)
    @browser.checkbox(:id,"chkMemberCategoryInclude").set
    @browser.select_list(:id,"optMemberCategory").select("30")
    #@browser.link(:id,"selCategoryhref").click
    #sleep 2
    #@browser.select_list(:id,"optCategoryId").select("Business")
    #@browser.link(:text,"Done").click
    sleep 1
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
    #@browser.text should include
    #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
    #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
    body_text = @browser.html
    #puts body_text
    #body_text=ff.html
    #html_array = body_text.split(/\n/)
    html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys</)
    #if(html_array[index] =~ //)
      #puts "***"
      #puts html_array[index]
      @code = html_array[index+2]
      #puts html_array[index+2]
      break
        else
          next
        end
        }

    @code1 = @code.slice(25..26)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 500
    end

  it "Test to confirm if valid review count values are obtained for members who have not registered in a time period" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.radio(:id,"ruleYes").set
    #@browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
    #@browser.checkbox(:id,"chkSurveyCompleteInclude").set(false)
    #@browser.checkbox(:id,"chkEmailReceivedExclude").set(false)
    #@browser.checkbox(:id,"chkEmailReceivedInclude").set(false)
    #@browser.checkbox(:id,"chkMemberCategoryExclude").set(false)
    @browser.checkbox(:id,"chkMemberCategoryInclude").set(false)
    @browser.checkbox(:id,"exMemberRegisteredChk").set
    @browser.text_field(:id,"txtExcludeRegStartDate").set("01/01/2011")
    @browser.text_field(:id,"txtExcludeRegEndDate").set("03/01/2011")

    #@browser.select_list(:id,"optMemberCategory").select("30")
    #@browser.link(:id,"selCategoryhref").click
    #sleep 2
    #@browser.select_list(:id,"optCategoryId").select("Business")
    #@browser.link(:text,"Done").click
    sleep 2
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
    #@browser.text should include
    #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
    #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
    body_text = @browser.html
    #puts body_text
    #body_text=ff.html
    #html_array = body_text.split(/\n/)
    html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys</)
    #if(html_array[index] =~ //)
      #puts "***"
      #puts html_array[index]
      @code = html_array[index+2]
      #puts html_array[index+2]
      break
        else
          next
        end
        }
    @code1 = @code.slice(25..30)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 45000
    end

    it "Test to confirm if valid review count values are obtained for members who have registered in a time period" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.radio(:id,"ruleYes").set
    #@browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
    #@browser.checkbox(:id,"chkSurveyCompleteInclude").set(false)
    #@browser.checkbox(:id,"chkEmailReceivedExclude").set(false)
    #@browser.checkbox(:id,"chkEmailReceivedInclude").set(false)
    #@browser.checkbox(:id,"chkMemberCategoryExclude").set(false)
    @browser.checkbox(:id,"exMemberRegisteredChk").set(false)
    @browser.checkbox(:id,"incMemberRegisteredChk").set
    @browser.text_field(:id,"txtIncludeRegStartDate").set("03/01/2010")
    @browser.text_field(:id,"txtIncludeRegEndDate").set("03/01/2011")

    #@browser.select_list(:id,"optMemberCategory").select("30")
    #@browser.link(:id,"selCategoryhref").click
    #sleep 2
    #@browser.select_list(:id,"optCategoryId").select("Business")
    #@browser.link(:text,"Done").click
    sleep 2
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
    #@browser.text should include
    #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
    #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
    body_text = @browser.html
    #puts body_text
    #body_text=ff.html
    #html_array = body_text.split(/\n/)
    html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys</)
    #if(html_array[index] =~ //)
      #puts "***"
      #puts html_array[index]
      @code = html_array[index+2]
      #puts html_array[index+2]
      break
        else
          next
        end
        }

    @code1 = @code.slice(25..30)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 5000
    end

  it "Test to check if old target counts for respective criteria shown" do
    @browser.link(:text,"Target 1").should exist
    @browser.link(:text,"Target 2").should exist
    @browser.link(:text,"Target 3").should exist
    @browser.link(:text,"Target 4").should exist
  end

    it "Test to Check if old target counts for respective criteria can be deleted" do
    @browser.link(:text,"Delete").click
    sleep 1
    @browser.link(:text,"Delete").click
    sleep 1
    @browser.link(:text,"Delete").click
    sleep 1
    @browser.link(:text,"Delete").click
    sleep 1
    @browser.link(:text,"Delete").click
    sleep 1
    @browser.link(:text,"Delete").click
    sleep 1
    @browser.link(:text,"Delete").click
    sleep 1
    @browser.link(:text,"Target 4").should_not exist
    sleep 1
    @browser.link(:text,"Target 5").should_not exist
  end


    after(:all) do
	@browser.close
	puts "test 10 has completed"
    end
end