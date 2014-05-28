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

describe "Test 33: To check if we are able to perform search for profile questions in feasibility report" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "To check if we are able to search Profile in the feasibility report" do
      @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/list")
      @browser.link(:text,"Custom Feasibility Report").click
      sleep 2
      @browser.checkbox(:id,"PL[40]").set
      @browser.checkbox(:id,"PL[13]").set
      @browser.checkbox(:id,"PL[2]").set
      @browser.checkbox(:id,"PL[0]").set
      @browser.link(:text,/Profile Questions/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
      end
      @browser.text_field(:id,"keyword_search").set("rental car companies")
      @browser.link(:text,"Search").click
      sleep 2
      puts "waiting for search to complete"
      while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          #puts "waiting for element"
      end
      
      @browser.text.should include("Which rental car companies have you used?")
  end

  it "To check if the user is able to use the searched profile as a criteria" do
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
      if(html_array[index] =~ />FocuslineSurveys</)
      #if(html_array[index] =~ //)
        #puts "***"
        #puts html_array[index]
        @code = html_array[index+1]
        #puts html_array[index+2]
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
      #@browser.link(:text,"Trash").click
    end

  

    after(:all) do
    @browser.close
    end
end