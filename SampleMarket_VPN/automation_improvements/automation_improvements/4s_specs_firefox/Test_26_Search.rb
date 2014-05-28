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
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

  it "To Check if the search feature functions correctly for invalid search" do
    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
    @browser.text_field(:id,"sidebarSearchField").set("*&^%$")
#    @browser.button(:id,"searchGoSB").click
    @browser.link(:id,"searchGoSB").click
    sleep 3
    @browser.text.should include("Search results for *&^%$")
    @browser.text.should include("NO RESULTS FOUND")
  end

  it "To Check if the search feature functions correctly for valid search of projects" do
    @browser.text_field(:id,"searchField").set("TESTAUTOMATIONPROJECTSEARCH")
    @browser.link(:id,"searchGo").click
    while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
    end
    #@browser.link(:id,"prjCount").click
    sleep 1
    @browser.text.should include("Displaying 1-1 of 1 projects")
    @browser.text.should include("Search results for TESTAUTOMATIONPROJECTSEARCH")
    @browser.link(:text,/TESTAUTOMATIONPROJECTSEARCH - PR63801/).should exist
    @browser.text.should include("TESTAUTOMATIONPROJECTSEARCH - PR63801")
  end

  it "To Check if the search feature functions correctly for valid search of groups" do
    @browser.link(:text,/Groups/).click
    while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
    end
    sleep 1
    @browser.text.should include("Displaying 1-1 of 1 groups")
    @browser.text.should include("TESTAUTOMATIONPROJECTSEARCH")
    @browser.link(:text,/TESTAUTOMATIONPROJECTSEARCH/).should exist

  end
  it "To Check if the advanced search feature functions correctly for invalid country in the advanced search" do
    @browser.link(:id,"searchMode").click
    @browser.select_list(:id,"optSearchCountryId").select("Uganda")
    #@browser.select_list(:id,"optSearchCountryId").select("United States")
    @browser.link(:id,"searchGo").click
    while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
    end
    sleep 1
    @browser.text.should include("Search results for TESTAUTOMATIONPROJECTSEARCH")
    @browser.text.should include("NO RESULTS FOUND")    
  end
  
  it "To Check if the advanced search feature functions correctly for invalid language in the advanced search" do
    @browser.select_list(:id,"optSearchCountryId").select("--Select Country--")
    @browser.select_list(:id,"optSearchLanguageId").select("Arabic")
    @browser.link(:id,"searchGo").click
    while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
    end
    sleep 1
    @browser.text.should include("Search results for TESTAUTOMATIONPROJECTSEARCH")
    @browser.text.should include("NO RESULTS FOUND")

  end

  it "To Check if the advanced search feature functions correctly for invalid country and valid language in the advanced search" do
    @browser.select_list(:id,"optSearchCountryId").select("Uganda")
    @browser.select_list(:id,"optSearchLanguageId").select("Arabic")
    #@browser.select_list(:id,"optSearchCountryId").select("United States")
    @browser.link(:id,"searchGo").click
    while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
    end
    sleep 1
    @browser.text.should include("Search results for TESTAUTOMATIONPROJECTSEARCH")
    @browser.text.should include("NO RESULTS FOUND.")
  end

  it "To Check if the advanced search feature functions correctly for valid country and invalid language in the advanced search" do
    @browser.select_list(:id,"optSearchCountryId").select("United States")
    @browser.select_list(:id,"optSearchLanguageId").select("Arabic")
    @browser.link(:id,"searchGo").click
    while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
    end
    sleep 1
    @browser.text.should include("Search results for TESTAUTOMATIONPROJECTSEARCH")
    @browser.text.should include("NO RESULTS FOUND.")

  end
  
  
  it "To Check if the advanced search feature functions correctly for valid country and language in advanced search for projects" do
    @browser.select_list(:id,"optSearchCountryId").select("United States")
    @browser.select_list(:id,"optSearchLanguageId").select("English")
    sleep 1
    @browser.link(:id,"searchGo").click
    while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
    end
    #@browser.link(:id,"prjCount").click
    sleep 1
    @browser.text.should include("Displaying 1-1 of 1 projects")
    @browser.text.should include("Search results for TESTAUTOMATIONPROJECTSEARCH")
    @browser.link(:text,/TESTAUTOMATIONPROJECTSEARCH - PR63801/).should exist
    @browser.text.should include("TESTAUTOMATIONPROJECTSEARCH - PR63801")
  end
  
  after(:all) do
    puts "Test 26 has completed"
    @browser.close
  end
  
end
