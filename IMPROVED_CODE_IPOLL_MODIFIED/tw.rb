# PROJECT/QG CREATION

require 'rubygems'
require 'watir'
require './Usamp_lib.rb'
require 'test/unit'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole' 
require 'Win32API'
#Load the win32 library
require 'win32/clipboard'
include Win32
#include 'Suite'
require 'base64'
#require 'watir-webdriver'
require './Input Repository\surveyurl.rb'
require './Input Repository\Test_01_Project_QG_Create_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"


class Test_01_Project_QG_Create < Test::Unit::TestCase
  
  def test_01_report_head
    #ff = FireWatir::Firefox.new
	driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
    ff = Watir::Browser.new driver
    ff.goto('https://twitter.com/')
    #ff.text_field(:id,"signin-email").set("Bikezzz@mailinator.com")
    #ff.text_field(:id,"signin-password").set("test123")
    #ff.button(:text,"Sign in").click
    #ff.button(:id,"global-new-tweet-button").click
      sleep 2
      
      #ff.frame(:title => 'Rich text editor, tweet-box-global, press ALT 0 for help.').send_keys 'hello world again'
      #ff.text_field(:text,/Tweet text/).set("#PersistentInnovates #bonobos #MyFavourite Bonobos Rock!!")
      #ff.div(:id,"tweet-box-mini-home-profile").set("#PersistentInnovates #bonobos #MyFavourite Bonobos Rock!!")
      #frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
      #ff.div(:id=>"tweet-box-mini-home-profile").set("#PersistentInnovates #bonobos #MyFavourite Bonobos Rock!!")
      ff.text_filed(:class=>"tweet-content").set("#PersistentInnovates #bonobos #MyFavourite Bonobos Rock!!")
      #ff.button(:name,"Tweet").click
      sleep 10
  
    end
    
  end