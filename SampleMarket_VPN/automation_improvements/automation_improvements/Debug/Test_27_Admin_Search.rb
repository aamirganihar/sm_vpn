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

describe "Test 27: Search functionality in Admin" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    @browser = @obj.Usampadmin_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD)
  end

  it "To Check if the search feature functions correctly for invalid search" do
    @browser.goto("http://p.usampadmin.com/selfserve.php")
    @browser.text_field(:id,"searchField").set("*&^%")
    @browser.button(:id,"search_1").click
    sleep 2
    @browser.text.should include("No records found.")
  end

  it "To Check if the search feature functions correctly for a valid search" do
    @browser.text_field(:id,"searchField").set("TESTAUTOMATIONPROJECTSEARCH")
    @browser.button(:id,"search_1").click
    sleep 2
    puts @browser.html
    @browser.text.should include("Displaying 1 - 1 of 1 projects")
    @browser.text.should include("TESTAUTOMATIONPROJECTSEARCH / PR36547")
    @browser.link(:text,/TESTAUTOMATIONPROJECTSEARCH/).should exist
    #@browser.text.should include("")
  end
  
  
  after(:all) do
    puts "Test 27 has completed"
    @browser.close
  end
end

