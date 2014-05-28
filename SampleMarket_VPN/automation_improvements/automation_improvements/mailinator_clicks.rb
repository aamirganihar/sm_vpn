equire 'rubygems'
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


it "Test to check if the email broadcast is successfully received and a member is able to complete it" do
driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	    @browser1 = Watir::Browser.new driver
	    #puts "waiting for 60 seconds for the email to be received"
	    #sleep 60
	    #@browser1.goto("http://www.mailinator.com/maildir.jsp?email=test_ul")
		@browser1.goto("http://test_u1.mailinator.com")
	
	    #@browser1.goto('http://www.mailop.com/?email=test_u1')
	    sleep 4
	    #body_text = @browser1.text
	    @browser1.text.should include("subject: test automation broadcast")	
		@browser1.link(:text,"subject: test automation broadcast").click
		
		sleep 2
		#@browser1.image(:text,"Start the Survey Now").click
		@browser1.image(:src ,"http://unitedsample1.s3.amazonaws.com/pl/emailArt/startSurvey_EN.png").click
	    #@browser1.link(:text,/http:\/\/click\.surveyhelpcenter.com\/y\.z/).click
	    sleep 5
	    @browser1.goto("http://sm1mr.com/ssred.php?S=1&ID=")
	    sleep 5
	    #@browser1.text.should include("CONGRATULATIONS")
		if (@browser1.text.include?("Congratulations") || @browser1.text.include?("CONGRATULATIONS")|| @browser1.text.include?("committed"))
				puts "mail complete success"
		else
				puts "mail complete fail"
				break
		end
		
	    #@browser1.text.should include("")
	    @browser1.close
    end