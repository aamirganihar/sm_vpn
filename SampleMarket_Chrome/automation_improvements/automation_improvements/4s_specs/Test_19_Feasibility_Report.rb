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

describe "Test 19: Review Counts with Demographic Criteria, Geographic Criteria and matching panel bok questions for the feasibility report" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "To obtain Review Counts with Demographic Criteria for the feasibility report" do
    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/list")
    @browser.link(:text,"Custom Feasibility Report").click
    sleep 2
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.link(:text,/Demographic Targeting/).click
    #while @browser.div(:id=>"fancybox-loading").visible? do
      #sleep 0.5
      #puts "waiting for element"
    #end
    
   # sleep 5
Watir::Wait.until { @browser.text.include? 'Age' }#explicit wait:default timeout :30sec:HRISHI
      @browser.link(:text,/Age/).click
      Watir::Wait.until { @browser.text.include? 'Age Range' }#explicit wait:default timeout :30sec:HRISHI
    
    #@browser.link(:text,/Age/).click
    #while @browser.div(:id=>"fancybox-loading").visible? do
# sleep 0.5
#puts "waiting for element"
  #  end
    #sleep 5
    @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
    @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
    @browser.link(:text,/Done/).click
    @browser.link(:text,/50-75/).should exist
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
    #puts html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys </)
    #if(html_array[index] =~ //)
      puts html_array[index]
      puts html_array[index+1]
      @code = html_array[index+2]
      puts html_array[index+2]
      break
        else
          next
        end
        }
    puts "****"
    puts @code
    @code1 = @code.slice(40..42)
    puts @code1
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 15000
    sleep 2
    #(@number > 5000 && @number < 15000)

    #val = @browser.get_text("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
#    puts val
    #@browser.link(:id,"next").click

    end

  
    it "To obtain Review Counts with Geo graphic Criteria for the feasibility report" do
      @browser.link(:text,"Trash").click
      @browser.link(:text,/Geographic Targeting/).click
      #while @browser.div(:id=>"fancybox-loading").visible? do
        #sleep 0.5
        #puts "waiting for element"
	#end
	#sleep 3
      @browser.link(:text,'Zip Code').click
      #while @browser.div(:id=>"fancybox-loading").visible? do
        #sleep 0.5
        #puts "waiting for element"
	#end
#	sleep 3
      @browser.text_field(:id,"txtZipList").set("90001,90002,90003,90004,90005,90006,90007,90008,90009,90010")
      sleep 3
      @browser.link(:text,/Done/).click
      sleep 3
      #@browser.link(:text,/90001/).should exist
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
        puts "***"
        puts html_array[index]
        @code = html_array[index+1]
        puts html_array[index+2]
        break
          else
            next
          end
          }


      @code1 = @code.slice(41..42)
      @code1 = @code1.gsub(/,/, "")
      @number = @code1.to_i

      @number.should > 0
      @number.should < 500
      sleep 2
    
    end
    it "To obtain Review Counts with Profile Criteria for the feasibility report" do
      sleep 2
      @browser.link(:text,"Trash").click
      @browser.link(:text,'Profile Questions').click
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
      end
      @browser.select_list(:id,"profileSelOption").select("Travel")
      sleep 2
      @browser.link(:text,/Which rental car companies have you used?/).click
      sleep 2
      @browser.checkbox(:title,"ACE Rent A Car").set
      @browser.checkbox(:title,"Advantage Rent A Car").set
      @browser.checkbox(:title,"Alamo Rent A Car").set
      @browser.checkbox(:title,"Avis Rent A Car").set
      @browser.checkbox(:title,"Budget Rent A Car").set
      @browser.checkbox(:title,"Dollar Rent A Car").set
      @browser.checkbox(:title,"E-Z Rent A Car").set
      @browser.checkbox(:title,"Enterprise Rent A Car").set
      @browser.checkbox(:title,"Europcar Rent A Car").set
      @browser.checkbox(:title,"Hertz Rent A Car").set

      @browser.link(:text,/Done/).click
      #@browser.link(:text,/Which rental car companies have you used?/).should exist

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
        puts "***"
        puts html_array[index]
        @code = html_array[index+1]
        puts html_array[index+2]
        break
          else
            next
          end
          }



      @code1 = @code.slice(41..42)
      @code1 = @code1.gsub(/,/, "")
      @number = @code1.to_i

      @number.should > 0
      @number.should < 10000
      sleep 2
      @browser.link(:text,"Trash").click
    end

  

    after(:all) do
    @browser.close
    end
end