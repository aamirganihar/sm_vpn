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

describe "Test 05: Group creation with Geo graphic Criteria" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Surveyhead_login("test22.des03@mailop.com","test22.des03@mailop.com")
  end

    
    it "Test to check if a member can click on the ccs tasks" do
	    @browser.link(:id,"link_dashboard_ccs_tasks").click
	    #puts @browser.text
	    #puts "*********"
	    #puts "*********"
	    #puts "*********"
	    #puts @browser.html
	    @browser.html.should include("Tasks Home")
    end
    
    
    it "Test to check if a member can click on the ccs tasks" do
	    @browser.link(:index,1).flash
	    @browser.link(:index,1).flash
	    @browser.link(:index,1).flash
	    @browser.link(:index,1).flash
	    
    end
    
    
=begin    

      #@browser.link(:text,"Logout").click
      #@browser.close

      it "Test to check if a member who does not satisfy the Geo graphic criteria is unable to see the survey" do
      @browser = @obj.Surveyhead_sm_login("test22.des02@mailop.com","test22.des02@mailop.com")
      sleep 3
      group_name = File.open("InputRepository/groupname_Geo.yml"){|file| YAML::load(file)}
      grp_name = group_name['group']
      body_text = @browser.text
      body_text.should_not include("#{grp_name}")
      @browser.link(:text,"Logout").click
      @browser.close

      #Userrname['demographic']

    end
=end
    after(:all) do
    #@browser.close
    puts "test 41 has completed"
    end

end
