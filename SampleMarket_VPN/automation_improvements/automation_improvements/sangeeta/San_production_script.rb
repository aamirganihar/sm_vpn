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
      #driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
      #@browser = Watir::Browser.new driver
	  
      #@browser.goto('https://network.usamp.com/login.php')
      #@browser.radio(:value, "Client").set
      #@browser.text_field(:id, "txtEmail").set("sangeeta_pai@persistent.co.in")
      #@browser.text_field(:id, "txtPassword").set("spai")
      #Click login button
      #@browser.link(:id,"btnLogin").click
  end
  
=begin
   it "To check if a member is able to see the survey, click on it, complete it and check for the rewards" do
        group_id = File.open("InputRepository/Group_Ids_Stats_prod.yml"){|file| YAML::load(file)}
        @dec_group_id =  group_id['group_id']
        #group_id = File.open("InputRepository/Group_Ids_Stats_prod.yml"){|file| YAML::load(file)}
        @dec_group_link = group_id['group_link']


        driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
        @browser1 = Watir::Browser.new driver
        @browser1.goto('http://surveyhead.com')
	
	# SangeetaPai- 12 March 2013 - start changes - commented the previous fix and refixed
		#if(@browser1.link(:text,"Remind Me Later").exists?)
		#	@browser1.link(:text,"Remind Me Later").click
		#end
			
		if(@browser1.div(:id=>"desktopCover").exists?)			
			@browser1.div(:id=>"desktopCover").click
		end
		sleep 2
	
	# End changes - SangeetaPai
	
	
	@browser1.text_field(:name, "txtEmail").set("sangeeta_pai@mailop.com")
	
        @browser1.text_field(:name, "txtPassword").set("sangeeta_pai@mailop.com")
        @browser1.button(:value,"login").click
        sleep 3
=begin	
	if(@browser1.link(:id,"sb-nav-close").exists?)
	      @browser1.link(:id,"sb-nav-close").click
      end
  
      
      
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

        #body_text.should include("CONGRATULATIONS")
=end
=begin		
		
		body_text = @browser1.text
		
		@santest=["Surveys111" ,"Welcome"]
		
		
		puts "aa"
		#puts body_text.text
		
		puts "bb"
	

		if (@browser1.text.include?("Surveys1111") || @browser1.text.include?("Welcome"))
			puts "success"
		else
			puts "fail"
			break		
		end
		
		
		
		#body_text.any include["Surveys" || "Welcome"]
		puts "qq"
=begin
		@browser1.link(:text,"Rewards").click
        @text_contents=@browser1.html
        @text_array =@text_contents.split(/\n/)
        0.upto(@text_array.size - 1) { |index|
        if(@text_array[index] =~ /#{@dec_group_id}/)
            @text_array[index+5].should include("0.50") 
            next
            else
            end
            }
        end
=end
=begin

        @browser1.link(:text,"Logout").click
        system("cookies.bat")
        @browser1.close
        sleep 2
	end
=end
	
	it "Test to check if the email broadcast is successfully received and a member is able to complete it" do
	    driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new driver
	    #puts "waiting for 60 seconds for the email to be received"
	    #sleep 60
	    #@browser1.goto("http://www.mailinator.com/maildir.jsp?email=test_automation")
	    
		@browser1.goto("http://test_u1.mailinator.com")
			    
	    body_text = @browser1.text
	    body_text.should include("Subject: Test automation broadcast")
		sleep 3
		puts "1"
		@browser1.link(:text,"Subject: Test automation broadcast").click
	    sleep 3
		puts "2"
		@browser1.link(:text,"Start the Survey Now!").click
	    #$@browser1.link(:text,/http:\/\/click\.surveyhelpcenter.com\/y\.z/).click
		puts "3"
		sleep 5
		puts "3"
	    @browser1.goto("http://sm1mr.com/ssred.php?S=1&ID=")
		puts "4"
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
	
	
end



    




