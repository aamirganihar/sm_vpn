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
require 'fastercsv'
require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 21: Report generation" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "To Check if user is able to to run the Feasibility report and save it" do
    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/list")
    @browser.link(:text,"Custom Feasibility Report").click
    sleep 3
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.link(:text,/Demographic Targeting/).click
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    @browser.link(:text,/Age/).click
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
    @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
    @browser.link(:text,/Done/).click
    @browser.link(:text,/50-75/).should exist
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    sleep 4
    report_name= Time.now
    report_name = report_name.to_s
    report_name = report_name.slice(0..18)
    sleep 8
    @browser.link(:href,/mode=report\/saveReportOverlay/).click
    sleep 3
    
    @browser.text_field(:id,"feasilbilityRepNameId1").set(report_name)
    sleep 2
    @browser.link(:text,"Save").click
    sleep 5
    @browser.link(:text,"Saved Reports").click
    sleep 2
    @browser.text.should include("#{report_name}")
    @browser.link(:text,"#{report_name}").click
    @browser.link(:text,/50-75/).should exist
    #sleep 1
    #@browser.link(:text,"Saved Reports").click
    #sleep 1
    #@browser.link(:text,"Delete").click
    #sleep 1
    #@browser.driver.switch_to.alert.accept
    #sleep 1
    #@browser.text.should_not include("#{report_name}")
    end

    it "To Check if user is able to to run the Panel SignUp report and download it (All Time)" do
      @browser.link(:text,"Panel Sign Up").click
      sleep 1
      @browser.link(:text,"Download these results").click
      sleep 5
      basedir = "D:\\SampleMarket_Downloads\\"
      contains = Dir.new(basedir).entries
      #p contains
      #puts contains[2].to_s
      @file = contains[2].to_s
      puts @file
      @file_name=basedir+"#{@file}"
      data = FasterCSV.read("#{@file_name}")
      registered_members = data[1][1]
      registered_members = registered_members.gsub(/,/, "")
#
#      excel= WIN32OLE::new('excel.Application')
#      workbook=excel.Workbooks.Open("#{@file_name}")
#      worksheet=workbook.Worksheets(1)
#      #worksheet.Range('a2') ['Value']
#      registered_members=worksheet.Range('b2') ['Value']
      puts registered_members
      registered_members.to_i.should > 14000
      #excel.ActiveWorkbook.Save
      #excel.Workbooks.Close
      #excel.quit
    end
    
    it "To Check if user is able to to run the Panel SignUp report and download it (Last 30 days)" do
      @browser.link(:text,"Last 30 Days").click
      sleep 1
      @browser.link(:text,"Download these results").click
      sleep 5
      basedir = "D:\\SampleMarket_Downloads\\"
      contains = Dir.new(basedir).entries
      #p contains
      #puts contains[2].to_s
      @file = contains[3].to_s
      puts @file
      @file_name=basedir+"#{@file}"
      data = FasterCSV.read("#{@file_name}")
      registered_members = data[1][1]
      registered_members = registered_members.gsub(/,/, "")
#      excel= WIN32OLE::new('excel.Application')
#      workbook=excel.Workbooks.Open("#{@file_name}")
#      worksheet=workbook.Worksheets(1)
#      #worksheet.Range('a2') ['Value']
#      registered_members=worksheet.Range('b2') ['Value']
      puts registered_members
      registered_members.to_i.should >= 2
      #excel.ActiveWorkbook.Save
#      excel.Workbooks.Close
#      excel.quit
    end

    it "To Check if user is able to to run the Project Report and download it (All time)" do
      @browser.link(:text,"Project Report").click
      #@browser.link(:text,"Last 30 Days").click
      sleep 7
      @browser.link(:text,"Download this report").click
      sleep 15
      basedir = "D:\\SampleMarket_Downloads\\"
      contains = Dir.new(basedir).entries
      #p contains
      #puts contains[2].to_s
      @file = contains[2].to_s
      puts @file
      @file_name=basedir+"#{@file}"
      data = FasterCSV.read("#{@file_name}")
      total_cost = data[1][8]
      total_completes_needed = data[1][2]
      total_cost = total_cost.gsub(/,/, "")
      total_cost = total_cost.gsub(/\$/, "")
      total_completes_needed = total_completes_needed.gsub(/,/, "")
#      excel= WIN32OLE::new('excel.Application')
#      workbook=excel.Workbooks.Open("#{@file_name}")
#      worksheet=workbook.Worksheets(1)
#      #worksheet.Range('a2') ['Value']
#      total_cost=worksheet.Range('i2') ['Value']
#      total_completes_needed=worksheet.Range('c2') ['Value']

      puts total_cost
      puts total_completes_needed
      total_cost.to_i.should > 10
      total_completes_needed.to_i.should >100
      #excel.ActiveWorkbook.Save
#      excel.Workbooks.Close
#      excel.quit
    end

    it "To Check if user is able to to run the Project Report and download it (Last 30 days)" do
      #@browser.link(:text,"Project Report").click
      @browser.link(:text,"Last 30 Days").click
      sleep 8
      @browser.link(:text,"Download this report").click
      sleep 15
      basedir = "D:\\SampleMarket_Downloads\\"
      contains = Dir.new(basedir).entries
      #p contains
      #puts contains[2].to_s
      @file = contains[3].to_s
      puts @file
      @file_name=basedir+"#{@file}"
      data = FasterCSV.read("#{@file_name}")
      total_cost = data[1][8]
      total_completes_needed = data[1][2]
      total_cost = total_cost.gsub(/,/, "")
      total_cost = total_cost.gsub(/\$/, "")
      total_completes_needed = total_completes_needed.gsub(/,/, "")
      #total_completes_needed = total_completes_needed.gsub(/$/, "")

#      excel= WIN32OLE::new('excel.Application')
#      workbook=excel.Workbooks.Open("#{@file_name}")
#      worksheet=workbook.Worksheets(1)
#      #worksheet.Range('a2') ['Value']
#      total_cost=worksheet.Range('i2') ['Value']
#      total_completes_needed=worksheet.Range('c2') ['Value']

      puts total_cost
      puts total_completes_needed
      total_cost.to_i.should > 10
      total_completes_needed.to_i.should >100
      #excel.ActiveWorkbook.Save
#      excel.Workbooks.Close
#      excel.quit
    end

  
    it "To Check if user is able to to run the Cost Report and download it (All time)" do
      @browser.link(:text,"Cost Report").click
      #@browser.link(:text,"Last 30 Days").click
      sleep 1
      @browser.link(:text,"Download this report").click
      sleep 15
      basedir = "D:\\SampleMarket_Downloads\\"
      contains = Dir.new(basedir).entries
      #p contains
      #puts contains[2].to_s
      @file = contains[2].to_s
      puts @file
      @file_name=basedir+"#{@file}"
      data = FasterCSV.read("#{@file_name}")
      total_cost = data[1][5]
      total_completes_needed = data[1][1]
      total_cost = total_cost.gsub(/,/, "")
      total_cost = total_cost.gsub(/\$/, "")
      total_completes_needed = total_completes_needed.gsub(/,/, "")
      total_completes_needed = total_completes_needed.gsub(/\$/, "")

#      excel= WIN32OLE::new('excel.Application')
#      workbook=excel.Workbooks.Open("#{@file_name}")
#      worksheet=workbook.Worksheets(1)
#      #worksheet.Range('a2') ['Value']
#      total_cost=worksheet.Range('f2') ['Value']
#      total_completes_needed=worksheet.Range('b2') ['Value']

      puts total_cost
      puts total_completes_needed
      total_cost.to_i.should > 10
      total_completes_needed.to_i.should >20
      #excel.ActiveWorkbook.Save
#      excel.Workbooks.Close
#      excel.quit
    end

    it "To Check if user is able to to run the Cost Report and download it (Last 30 days)" do
      #@browser.link(:text,"Project Report").click
      @browser.link(:text,"Last 30 Days").click
      sleep 1
      @browser.link(:text,"Download this report").click
      sleep 15
      basedir = "D:\\SampleMarket_Downloads\\"
      contains = Dir.new(basedir).entries
      #p contains
      #puts contains[2].to_s
      @file = contains[3].to_s
      puts @file
      @file_name=basedir+"#{@file}"
      data = FasterCSV.read("#{@file_name}")
      total_cost = data[1][5]
      total_completes_needed = data[1][1]
      total_cost = total_cost.gsub(/,/, "")
      total_cost = total_cost.gsub(/\$/, "")
      total_completes_needed = total_completes_needed.gsub(/,/, "")
      total_completes_needed = total_completes_needed.gsub(/\$/, "")
#
#
#      excel= WIN32OLE::new('excel.Application')
#      workbook=excel.Workbooks.Open("#{@file_name}")
#      worksheet=workbook.Worksheets(1)
#      #worksheet.Range('a2') ['Value']
#      total_cost=worksheet.Range('f2') ['Value']
#      total_completes_needed=worksheet.Range('b2') ['Value']

      puts total_cost
      puts total_completes_needed
      total_cost.to_i.should > 10
      total_completes_needed.to_i.should >20
      #excel.ActiveWorkbook.Save
#      excel.Workbooks.Close
#      excel.quit
    end

  
    it "To Check if user is able to to run the PanelShield Activity report and download it (All Time)" do
      @browser.link(:text,"PanelShield Activity").click
      sleep 1
      @browser.link(:text,"Download these results").click
      sleep 5
      basedir = "D:\\SampleMarket_Downloads\\"
      contains = Dir.new(basedir).entries
      #p contains
      #puts contains[2].to_s
      @file = contains[4].to_s
      puts @file
      @file_name=basedir+"#{@file}"
      data = FasterCSV.read("#{@file_name}")
      registered_members = data[1][1]
      #total_completes_needed = data[1][1]
      registered_members = registered_members.gsub(/,/, "")
      #total_completes_needed = total_completes_needed.gsub(/,/, "")

#      excel= WIN32OLE::new('excel.Application')
#      workbook=excel.Workbooks.Open("#{@file_name}")
#      worksheet=workbook.Worksheets(1)
#      #worksheet.Range('a2') ['Value']
#      registered_members=worksheet.Range('b2') ['Value']
      puts registered_members
      registered_members.to_i.should > 20
      #excel.ActiveWorkbook.Save
#      excel.Workbooks.Close
#      excel.quit
    end

    it "To Check if user is able to to run the PanelShield Activity report and download it (Last 30 days)" do
      @browser.link(:text,"Last 30 Days").click
      sleep 1
      @browser.link(:text,"Download these results").click
      sleep 5
      basedir = "D:\\SampleMarket_Downloads\\"
      contains = Dir.new(basedir).entries
      #p contains
      #puts contains[2].to_s
      @file = contains[5].to_s
      puts @file
      @file_name=basedir+"#{@file}"
      data = FasterCSV.read("#{@file_name}")
      registered_members = data[1][1]
      #total_completes_needed = data[1][1]
      registered_members = registered_members.gsub(/,/, "")

#      excel= WIN32OLE::new('excel.Application')
#      workbook=excel.Workbooks.Open("#{@file_name}")
#      worksheet=workbook.Worksheets(1)
#      #worksheet.Range('a2') ['Value']
#      registered_members=worksheet.Range('b2') ['Value']
      puts registered_members
      registered_members.to_i.should > 5
      #excel.ActiveWorkbook.Save
#      excel.Workbooks.Close
#      excel.quit
    end




    after(:all) do
      system("delete.bat")
      @browser.link(:text,"Log Out").click
      @browser.close
    end

end

