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

describe "Test 34: Test to check the functionality of Exclude PL Site Members from SampleMarket" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    #@browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
end

    it "To check if a member is able to disable the checkbox for Exclude PL Site Members from SampleMarket" do
        driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
        @browser1 = Watir::Browser.new driver
        
        @browser1.goto('http://p.usampadmin.com')
        if @browser1.text.include?('Logout')
            @browser1.goto("http://p.usampadmin.com/login.php?hdMode=logout")
        end
        # Setting login credentials (email/password)
        @browser1.text_field(:name,"txtEmail").set("nitin_kumar@persistent.co.in")
        @browser1.text_field(:name,"txtPassword").set("test")
        #Click login button
        @browser1.button(:value, "Login").click
        @browser1.goto('http://p.usampadmin.com/add_site.php?site_id=Mg==')
        @browser1.checkbox(:id,"cbExcludeMembersFromUsampChannel").set(false)
        @browser1.button(:id,"Refine").click
        @browser1.close
    end
    

    it "To obtain Review Counts with Demographic Criteria for the feasibility report with the Exclude PL Site Members from SampleMarket checkbox not set" do
        #@browser1.goto("http://p.usampadmin.com/add_client.php?client_id=Njky")
        #@browser1.link(:text,"Logon to "
        driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
        @browser2 = Watir::Browser.new driver
        @browser2.goto("https://p.network.u-samp.com/autologin.php?empid=257&email=nitin_kumar@persistent.co.in&client_id=692")
        @browser2.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/list")
        @browser2.link(:text,"Custom Feasibility Report").click
        sleep 2
        @browser2.checkbox(:id,"PL[40]").set
        @browser2.checkbox(:id,"PL[13]").set
        @browser2.checkbox(:id,"PL[2]").set
        @browser2.checkbox(:id,"PL[0]").set
        @browser2.link(:text,/Demographic Targeting/).click
        while @browser2.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
      end
      sleep 3
        @browser2.link(:text,/Age/).click
        while @browser2.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
        end
        @browser2.text_field(:id,"txtAgeRangeLower_1").set("10")
        @browser2.text_field(:id,"txtAgeRangeUpper_1").set("99")
        @browser2.link(:text,/Done/).click
        @browser2.link(:text,/10-99/).should exist
        @browser2.link(:text,"Get Sample Counts").click
        while @browser2.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
          sleep 1
        end
        #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
        #@browser.text should include
        #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
        #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
        body_text = @browser2.html
        #puts @browser2.html
        #puts "******************"
        #puts "******************"
        #puts "******************"
        #puts "******************"
        #puts @browser2.text
        #puts body_text
        #body_text=ff.html
        html_array = body_text.split(/\n/)
        #html_array = body_text.split(/td><td/)
        #puts html_array
        0.upto(html_array.size - 1) { |index|
        if(html_array[index] =~ />uSamp </)
        #if(html_array[index] =~ //)
          #puts html_array[index]
          #puts html_array[index+1]
          #puts html_array[index+2]
          #puts html_array[index+3]
          #puts html_array[index+4]
          @code = html_array[index+2]
          puts html_array[index+2]
          break
            else
              next
            end
            }
        puts "****"
        puts @code
        @code1 = @code.slice(39..47)
        puts "********"
        puts @code1
        @code1 = @code1.gsub(/,/, "")
        @number = @code1.to_i
        puts @number
        @number.should > 0
        
        count = {}
        count['number'] = @number
        File.open("InputRepository/count.yml","w"){|file| YAML.dump(count,file)}
        #@number.should < 15000
        sleep 2
        #(@number > 5000 && @number < 15000)

        #val = @browser.get_text("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
    #    puts val
        #@browser.link(:id,"next").click
        @browser2.close

        end
        
        
        
      it "To check if a member is able to enable the checkbox for Exclude PL Site Members from SampleMarket" do
        driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
        @browser1 = Watir::Browser.new driver
        
        @browser1.goto('http://p.usampadmin.com')
        if @browser1.text.include?('Logout')
            @browser1.goto("http://p.usampadmin.com/login.php?hdMode=logout")
        end
        # Setting login credentials (email/password)
        @browser1.text_field(:name,"txtEmail").set("nitin_kumar@persistent.co.in")
        @browser1.text_field(:name,"txtPassword").set("test")
        #Click login button
        @browser1.button(:value, "Login").click
        @browser1.goto('http://p.usampadmin.com/add_site.php?site_id=Mg==')
        @browser1.checkbox(:id,"cbExcludeMembersFromUsampChannel").set
        @browser1.button(:id,"Refine").click
        @browser1.close
    end  


    it "To obtain Review Counts with Demographic Criteria for the feasibility report with the Exclude PL Site Members from SampleMarket checkbox set and ensuring that the counts are updated" do
        #@browser1.goto("http://p.usampadmin.com/add_client.php?client_id=Njky")
        #@browser1.link(:text,"Logon to "
        count = File.open("InputRepository/count.yml"){|file| YAML::load(file)}
        @num= count['number']
                
        driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
        @browser2 = Watir::Browser.new driver
        @browser2.goto("https://p.network.u-samp.com/autologin.php?empid=257&email=nitin_kumar@persistent.co.in&client_id=692")
        @browser2.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/list")
        @browser2.link(:text,"Custom Feasibility Report").click
        sleep 2
        @browser2.checkbox(:id,"PL[40]").set
        @browser2.checkbox(:id,"PL[13]").set
        @browser2.checkbox(:id,"PL[2]").set
        @browser2.checkbox(:id,"PL[0]").set
        @browser2.link(:text,/Demographic Targeting/).click
        while @browser2.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
      end
      sleep 3
        @browser2.link(:text,/Age/).click
        while @browser2.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
        end
        @browser2.text_field(:id,"txtAgeRangeLower_1").set("10")
        @browser2.text_field(:id,"txtAgeRangeUpper_1").set("99")
        @browser2.link(:text,/Done/).click
        @browser2.link(:text,/10-99/).should exist
        @browser2.link(:text,"Get Sample Counts").click
        while @browser2.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
          sleep 1
        end
        #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
        #@browser.text should include
        #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
        #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
        body_text = @browser2.html
        #puts @browser2.html
        #puts "******************"
        #puts "******************"
        #puts "******************"
        #puts "******************"
        #puts @browser2.text
        #puts body_text
        #body_text=ff.html
        html_array = body_text.split(/\n/)
        #html_array = body_text.split(/td><td/)
        #puts html_array
        0.upto(html_array.size - 1) { |index|
        if(html_array[index] =~ />uSamp </)
        #if(html_array[index] =~ //)
          puts html_array[index]
          puts html_array[index+1]
          puts html_array[index+2]
          puts html_array[index+3]
          puts html_array[index+4]
          @code = html_array[index+2]
          puts html_array[index+2]
          break
            else
              next
            end
            }
        puts "****"
        puts @code
        @code1 = @code.slice(39..47)
        puts "********"
        puts @code1
        @code1 = @code1.gsub(/,/, "")
        @number1 = @code1.to_i
        puts @number1
        @number1.should > 0
        @number1.should < @num.to_i
        
        #@number.should < 15000
        sleep 2
        #(@number > 5000 && @number < 15000)

        #val = @browser.get_text("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
    #    puts val
        #@browser.link(:id,"next").click
        @browser2.close

        end
        
        it "To revert all changes made for the Exclude PL Site Members from SampleMarket checkbox" do
        driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
        @browser1 = Watir::Browser.new driver
        
        @browser1.goto('http://p.usampadmin.com')
        if @browser1.text.include?('Logout')
            @browser1.goto("http://p.usampadmin.com/login.php?hdMode=logout")
        end
        # Setting login credentials (email/password)
        @browser1.text_field(:name,"txtEmail").set("nitin_kumar@persistent.co.in")
        @browser1.text_field(:name,"txtPassword").set("test")
        #Click login button
        @browser1.button(:value, "Login").click
        @browser1.goto('http://p.usampadmin.com/add_site.php?site_id=Mg==')
        @browser1.checkbox(:id,"cbExcludeMembersFromUsampChannel").set(false)
        @browser1.button(:id,"Refine").click
        @browser1.close
    end
    
=begin  
    it "To obtain Review Counts with Geo graphic Criteria for the feasibility report" do
          @browser.link(:text,"Trash").click
          @browser.link(:text,/Geographic Targeting/).click
          while @browser.div(:id=>"fancybox-loading").visible? do
            sleep 0.5
            puts "waiting for element"
          end
          @browser.link(:text,/Zip Code/).click
          while @browser.div(:id=>"fancybox-loading").visible? do
            sleep 0.5
            puts "waiting for element"
          end
          @browser.text_field(:id,"txtZipList").set("90001,90002,90003,90004,90005,90006,90007,90008,90009,90010")
          @browser.link(:text,/Done/).click
          #@browser.link(:text,/90001/).should exist
          @browser.link(:text,"Get Sample Counts").click
          while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
            sleep 1
          end
          #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
          #@browser.text should include
          #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
          #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
          body_text = @browser.html
          #puts body_text
          #body_text=ff.html
          html_array = body_text.split(/\n/)
          #html_array = body_text.split(/td><td/)
          #puts     $html_array
          0.upto(html_array.size - 1) { |index|
          if(html_array[index] =~ />FocuslineSurveys</)
          #if(html_array[index] =~ //)
            puts "***"
            puts html_array[index]
            @code = html_array[index+1]
            puts html_array[index+2]
            break
              else
                next
              end
              }


          @code1 = @code.slice(41..42)
          @code1 = @code1.gsub(/,/, "")
          @number = @code1.to_i

          @number.should = 0
          #@number.should < 500
          sleep 2
    
    end
    it "To obtain Review Counts with Profile Criteria for the feasibility report" do
          sleep 2
          @browser.link(:text,"Trash").click
          @browser.link(:text,/Profile Questions/).click
          while @browser.div(:id=>"fancybox-loading").visible? do
            sleep 0.5
            puts "waiting for element"
          end
          @browser.select_list(:id,"profileSelOption").select("Travel")
          sleep 2
          @browser.link(:text,/Which rental car companies have you used?/).click
          sleep 2
          @browser.checkbox(:title,"ACE Rent A Car").set
          @browser.checkbox(:title,"Advantage Rent A Car").set
          @browser.checkbox(:title,"Alamo Rent A Car").set
          @browser.checkbox(:title,"Avis Rent A Car").set
          @browser.checkbox(:title,"Budget Rent A Car").set
          @browser.checkbox(:title,"Dollar Rent A Car").set
          @browser.checkbox(:title,"E-Z Rent A Car").set
          @browser.checkbox(:title,"Enterprise Rent A Car").set
          @browser.checkbox(:title,"Europcar Rent A Car").set
          @browser.checkbox(:title,"Hertz Rent A Car").set

          @browser.link(:text,/Done/).click
          #@browser.link(:text,/Which rental car companies have you used?/).should exist

          @browser.link(:text,"Get Sample Counts").click
          while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
            sleep 1
          end
          #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
          #@browser.text should include
          #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
          #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
          body_text = @browser.html
          #puts body_text
          #body_text=ff.html
          html_array = body_text.split(/\n/)
          #html_array = body_text.split(/td><td/)
          #puts     $html_array
          0.upto(html_array.size - 1) { |index|
          if(html_array[index] =~ />FocuslineSurveys</)
          #if(html_array[index] =~ //)
            puts "***"
            puts html_array[index]
            @code = html_array[index+1]
            puts html_array[index+2]
            break
              else
                next
              end
              }



          @code1 = @code.slice(41..42)
          @code1 = @code1.gsub(/,/, "")
          @number = @code1.to_i

          @number.should = 0
          #@number.should < 10000
          sleep 2
          @browser.link(:text,"Trash").click
    end

=end  

    after(:all) do
    @browser.close
    end
end