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
	    @browser1 = Watir::Browser.new driver
	    puts "waiting for 60 seconds for the email to be received"
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
		#@browser1.image(:text,"Start the Survey Now!").click
		#@browser1.link(:text,"Start the Survey Now!").click
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



    




