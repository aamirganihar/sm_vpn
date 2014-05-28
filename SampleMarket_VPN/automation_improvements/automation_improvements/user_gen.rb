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

describe "Test 26: Search functionality in Network site" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    
    
  end

  it "Users" do
	  @i=1
	  while @i<50 do
		  driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
		  @browser = Watir::Browser.new driver
		  @browser.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
		  @browser.goto("sm.p.surveyhead.com/registration_step1.php?P=3")
		  @browser.text_field(:name, "txtFname").set("AUTO FNAME")
		  @browser.text_field(:name, "txtLname").set("AUTO LNAME")
                  @browser.select_list(:name, "optCountryId").select("United States")
                  @browser.select_list(:name, "optLanguageId").select("English")
                  sleep 4
                  @browser.select_list(:name, "optStateId").select("California")
                  sleep 2
                  @browser.text_field(:name, "txtZipPostal").set("90001")
		  sleep 3
                  @browser.select_list(:name, "optDayId").select("04")
                  @browser.select_list(:name, "optMonthId").select("July")
                  @browser.select_list(:name, "optYearId").select("1945")
                  @browser.radio(:value, "Male").set
		  @extension = Time.new
                  @extension = @extension.to_s
                  @extension = @extension.slice(9..18)
                  mail_address="auto_test.des"+@extension+"@mailinator.com"
                  mail_address = mail_address.gsub(/:/, "")
                  mail_address = mail_address.gsub(/\s/, "")
                  mem_1 = mail_address
				  @browser.text_field(:name, "txtEmail").set(mail_address)
                  sleep 5
                  @browser.text_field(:name, "txtConfirmEmail").set(mail_address)
                  @browser.text_field(:name, "txtPassword").set(mail_address)
                  @browser.text_field(:name, "txtConfirmPassword").set(mail_address)
                  @browser.checkbox(:name, "chbTermsAndConditions").set
				  sleep 1
                  code= "test string"
                  #puts code
				  @browser.text_field(:name,"recaptcha_response_field").set(code)
                  @browser.button(:value, "Submit").click
				  @browser.select_list(:name, "optAnnualHouseholdIncomeId").select("Prefer not to answer")
                  @browser.select_list(:name, "optEducationLevelId").select("Advanced degree")
                  @browser.select_list(:name, "optEmploymentStatusId").select("Homemaker")
                  @browser.select_list(:name, "optMaritalStatusId").select("Never married")
                  @browser.select_list(:name, "optEthnicityId").select("Native American, Eskimo, Aleutian")
                  @browser.select_list(:name, "optNationalityId").select("United States")
                  @browser.radio(:value, "N").set
                  @browser.button(:value, "NEXT").click
                  sleep 7
#		  sleep 30
		  @browser.text.should include ("Logout")
		  puts mail_address
		  @browser.goto("sm.p.surveyhead.com/index.php?mode=logout")
		  @browser.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
                  @browser.close
		  @i=@i.to_i+1
	  end
	  
  end
  
  after(:all) do
    #puts "Test 26 has completed"
    #@browser.close
  end
  
end
