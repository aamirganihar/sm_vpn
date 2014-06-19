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
      @browser = Watir::Browser.new driver
      @browser.goto('https://network.usamp.com/login.php')
      @browser.radio(:value, "Client").set
      @browser.text_field(:id, "txtEmail").set("sangeeta_pai@persistent.co.in")
      @browser.text_field(:id, "txtPassword").set("spai")
      #Click login button
      @browser.link(:id,"btnLogin").click
      @browser1 = Watir::Browser.new :chrome
      sleep 3
  end

    it "To successfully create a Panelshield project" do
        @browser.goto("https://network.usamp.com/pshield/ps_welcome.php")
	@browser.link(:text,"Create New Project").click
	@browser.text_field(:id,"projectName").set "Test Project"
	prj_number= Time.now
	prj_number = prj_number.to_s
	prj_number = prj_number.slice(0..18)
	prj_number = prj_number.gsub(/:/, "")
	prj_number = prj_number.gsub(/-/, "")
	prj_number = prj_number.gsub(/ /, "")
	@browser.text_field(:id,"projectNumber").set prj_number
	@browser.select_list(:id,"projectStatus").select "OPEN"
	@browser.select_list(:id,"allGeoIPCountries").select "INDIA"
	@browser.button(:value,/>>/).click
	@browser.button(:name,"Submit").click
	sleep 3
	@browser.html.should include "Project saved"
end	

	it "To successfully add a supplier to a Panelshield project" do
		@browser.link(:text,"Suppliers").click
		@browser.select_list(:id,"supplierList").select "new sup"
		@browser.text_field(:id,"surveyUrl").set "http://www.google.com?ID=%%ID%%"
		@browser.text_field(:id,"rejectionUrl").set "http://www.rediff.com?ID=%%ID%%"
		survey_url = @browser.url
		project_id = survey_url.slice(69..77)
		@browser.button(:id,"addSupplier").click
		@supplier_url="http://mr1mr.com/?pr=#{project_id}&su=38&id=&id2=&id3=&id4=&id5=&id6=&id7=&id8="
		@success_url = "http://mr1mr.com/redirect.php?S=1&PRID=#{project_id}&ID="
		@fail_url = "http://mr1mr.com/redirect.php?S=2&PRID=#{project_id}&ID="
		@overquota_url = "http://mr1mr.com/redirect.php?S=3&PRID=#{project_id}&ID="
		links = {}
		links['supplier_url'] = @supplier_url
		links['success_url'] = @success_url
		links['fail_url'] = @fail_url
		links['overquota_url'] = @overquota_url
		File.open("InputRepository/panelshieldurl.yml","w"){|file| YAML.dump(links,file)}
		@browser.html.should include "Supplier added"
	end
	
	it "To Simulate Maximum clicks" do
		links = File.open("InputRepository/panelshieldurl.yml"){|file| YAML::load(file)}
		@supplier_url = links['supplier_url']
		@success_url = links['success_url']
		@fail_url = links['fail_url']
		@overquota_url = links['overquota_url']
		@browser.link(:text,"Control Panel").click
		@browser.checkbox(:id,"chbMaximumClicksOption").set
		@browser.checkbox(:id,"chbRejectDuplicatePanelAccountOption").set(false)
		@browser.checkbox(:name,"chbRejectionStatusForDuplicateSurveyAttempts").set(false)
		@browser.checkbox(:id,"chbRejectionPastParticipation").set(false)
		@browser.checkbox(:name,"chbGeoIPStatus").set(false)
		@browser.checkbox(:name,"chbRejectSuspiciousProxies").set(false)
		@browser.checkbox(:name,"chbRejectAllProxies").set(false)
		@browser.checkbox(:id,"chbRejectProfessional").set(false)
		@browser.select_list(:id,"percentageLOI").select "90%"
		@browser.button(:id,"Submit").click
		#@browser1 = Watir::Browser.new :chrome
		@browser1.goto("#{@supplier_url}")
		sleep 3
		@browser1.goto("#{@supplier_url}")
		sleep 10
		@browser1.text.should include ("Rediff")
		@browser1.cookies.clear
		#@browser1.close
	end
	
	it "To Simulate Duplicate Survey Complete Attempts" do
		links = File.open("InputRepository/panelshieldurl.yml"){|file| YAML::load(file)}
		@supplier_url = links['supplier_url']
		@success_url = links['success_url']
		@fail_url = links['fail_url']
		@overquota_url = links['overquota_url']
		@browser.checkbox(:id,"chbMaximumClicksOption").set(false)
		@browser.checkbox(:id,"chbRejectDuplicatePanelAccountOption").set(false)
		@browser.checkbox(:name,"chbRejectionStatusForDuplicateSurveyAttempts").set
		@browser.checkbox(:id,"chbRejectionPastParticipation").set(false)
		@browser.checkbox(:name,"chbGeoIPStatus").set(false)
		@browser.checkbox(:name,"chbRejectSuspiciousProxies").set(false)
		@browser.checkbox(:name,"chbRejectAllProxies").set(false)
		@browser.checkbox(:id,"chbRejectProfessional").set(false)
		@browser.button(:id,"Submit").click
		#@browser1 = Watir::Browser.new :chrome
		@browser1.goto("#{@supplier_url}")
		sleep 10
		@browser1.goto("#{@success_url}")
		sleep 3
		@browser1.goto("#{@supplier_url}")
		#@browser1.goto("#{@success_url}")
		sleep 10
		@browser1.text.should include ("Rediff")
		@browser1.cookies.clear
		#@browser1.close
	end
	
	it "To Simulate Geo-IP Detection Attempts" do
		links = File.open("InputRepository/panelshieldurl.yml"){|file| YAML::load(file)}
		@supplier_url = links['supplier_url']
		@success_url = links['success_url']
		@fail_url = links['fail_url']
		@overquota_url = links['overquota_url']
		@browser.checkbox(:id,"chbMaximumClicksOption").set(false)
		@browser.checkbox(:id,"chbRejectDuplicatePanelAccountOption").set(false)
		@browser.checkbox(:name,"chbRejectionStatusForDuplicateSurveyAttempts").set(false)
		@browser.checkbox(:id,"chbRejectionPastParticipation").set(false)
		@browser.checkbox(:name,"chbGeoIPStatus").set
		@browser.checkbox(:name,"chbRejectSuspiciousProxies").set(false)
		@browser.checkbox(:name,"chbRejectAllProxies").set(false)
		@browser.checkbox(:id,"chbRejectProfessional").set(false)
		@browser.button(:id,"Submit").click
		@browser2 = Watir::Browser.new :chrome
		@browser2.goto("#{@supplier_url}")
		sleep 10
		@browser2.text.should include ("Rediff")
		@browser2.cookies.clear
		@browser2.close
	end
	
	it "To Simulate Professionals Attempts" do
		links = File.open("InputRepository/panelshieldurl.yml"){|file| YAML::load(file)}
		@supplier_url = links['supplier_url']
		@success_url = links['success_url']
		@fail_url = links['fail_url']
		@overquota_url = links['overquota_url']
		@browser.checkbox(:id,"chbMaximumClicksOption").set(false)
		@browser.checkbox(:id,"chbRejectDuplicatePanelAccountOption").set(false)
		@browser.checkbox(:name,"chbRejectionStatusForDuplicateSurveyAttempts").set(false)
		@browser.checkbox(:id,"chbRejectionPastParticipation").set(false)
		@browser.checkbox(:name,"chbGeoIPStatus").set(false)
		@browser.checkbox(:name,"chbRejectSuspiciousProxies").set(false)
		@browser.checkbox(:name,"chbRejectAllProxies").set(false)
		@browser.checkbox(:id,"chbRejectProfessional").set
		@browser.button(:id,"Submit").click
		#@browser1 = Watir::Browser.new :chrome
		@browser1.goto("#{@supplier_url}")
		#@browser1.goto("#{@success_url}")
		sleep 3
		#@browser1.goto("#{@supplier_url}")
		#@browser1.goto("#{@success_url}")
		sleep 10
		@browser1.text.should include ("Rediff")
		@browser1.cookies.clear
		@browser1.close
	end
	
	it "To check the counts for Maximum clicks, Duplicate Survey Complete Attempts, Geo-IP Detection Attempts and  Professionals Attempts" do
		@browser.link(:text,"Stats").click
		sleep 3
		@browser.text.should include ("# of Clicks # Rejected # Allowed # Completes # Fails # Over Quota Mean Survey Length")
		@browser.text.should include ("6 4 2 1 0 0")
		@browser.text.should include ("1 0 1 1 0 1 1 0")
		
	end
	
    after(:all) do
        @browser.link(:text,"Project Details").click
	@browser.select_list(:id,"projectStatus").select "CLOSED"
	@browser.button(:name,"Submit").click
        @browser.close
        puts "Test case for Panelshield has completed"
    end
end

