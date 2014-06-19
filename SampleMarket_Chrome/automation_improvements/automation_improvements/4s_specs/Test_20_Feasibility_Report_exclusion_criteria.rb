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

describe "Test 20: Review Counts with Demographic Criteria, Geographic Criteria and matching panel bok questions for the feasibility report" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "To enable exclusion criteria for feasibility reports" do
      @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/list")
      @browser.link(:text,"Custom Feasibility Report").click
      sleep 1
      @browser.checkbox(:id,"PL[40]").set
      @browser.checkbox(:id,"PL[13]").set
      @browser.checkbox(:id,"PL[2]").set
      @browser.checkbox(:id,"PL[0]").set
      @browser.radio(:id,"exIncYes").set
    end
    
  it "To obtain Review Counts with members who have completed a survey in the last 30 days" do
    sleep 1
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    #@browser.radio(:id,"ruleYes").set
    @browser.checkbox(:id,"chkSurveyCompleteExclude").set
    @browser.select_list(:id,"optSurveyComplete").select("30")
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    body_text = @browser.html
    #puts body_text
    #body_text=ff.html
    html_array = body_text.split(/\n/)
    #html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys </)
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

    @code1 = @code.slice(40..43)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 4500
    end

  it "To obtain Review Counts with members who have not completed a survey in the last 30 days" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    #@browser.radio(:id,"ruleYes").set
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
    html_array = body_text.split(/\n/)
    #html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys </)
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

    @code1 = @code.slice(40..43)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 500
    end

  it "To obtain Review Counts with members who have received an email invitation in the last in the last 30 days" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    #@browser.radio(:id,"ruleYes").set
    #@browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
    @browser.checkbox(:id,"chkSurveyCompleteInclude").set(false)
    @browser.checkbox(:id,"chkEmailReceivedExclude").set
    @browser.select_list(:id,"optEmailReceived").select("30 Days")
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
    html_array = body_text.split(/\n/)
    #html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys </)
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
    @code1 = @code.slice(40..43)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should >= 0
    @number.should < 45000
    end

  it "To obtain Review Counts with members who have not received an email invitation in the last in the last 30 days" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    #@browser.radio(:id,"ruleYes").set
    #@browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
    #@browser.checkbox(:id,"chkSurveyCompleteInclude").set(false)
    @browser.checkbox(:id,"chkEmailReceivedExclude").set(false)
    @browser.checkbox(:id,"chkEmailReceivedInclude").set
    @browser.select_list(:id,"optEmailReceived").select("30 Days")
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
    html_array = body_text.split(/\n/)
    #html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys </)
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

    @number.should >= 0
    @number.should < 500
    end


  it "To obtain Review Counts with members who have completed a survey in the last 30 days in Business category" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    #@browser.radio(:id,"ruleYes").set
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
    @browser.link(:text,"Add").click
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
    html_array = body_text.split(/\n/)
    #html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys </)
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

    @code1 = @code.slice(40..43)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should >= 2
    @number.should < 45000
    end

it "To obtain Review Counts with members who have not completed a survey in the last 30 days in Business category" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    #@browser.radio(:id,"ruleYes").set
    #@browser.checkbox(:id,"chkSurveyCompleteExclude").set(false)
    #@browser.checkbox(:id,"chkSurveyCompleteInclude").set(false)
    #@browser.checkbox(:id,"chkEmailReceivedExclude").set(false)
    #@browser.checkbox(:id,"chkEmailReceivedInclude").set(false)
    @browser.checkbox(:id,"chkMemberCategoryExclude").set(false)
    sleep 0.5
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
    html_array = body_text.split(/\n/)
    #html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys </)
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

    @code1 = @code.slice(40..43)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should >= 0
    @number.should < 500
    end

  it "To obtain Review Counts with members who have not registered in a time period" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    #@browser.radio(:id,"ruleYes").set
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
    html_array = body_text.split(/\n/)
    #html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys </)
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
    @code1 = @code.slice(40..43)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should >= 3
    @number.should < 45000
    end

    it "To obtain Review Counts with members who have registered in a time period" do
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    #@browser.radio(:id,"ruleYes").set
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
    html_array = body_text.split(/\n/)
    #html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys </)
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

    @code1 = @code.slice(40..43)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 5000
    end

    after(:all) do
      @browser.link(:text,"Log Out").click
      @browser.close
    end


end

    
    
    


