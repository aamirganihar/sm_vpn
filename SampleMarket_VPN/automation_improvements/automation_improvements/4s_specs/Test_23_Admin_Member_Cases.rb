require 'rubygems'
require './automation'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
# require 'win32/clipboard'
# include Win32 
require 'YAML'

require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 23: Group creation for PanelShield test" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Usampadmin_login(BasicData::USAMP_ADMIN_LOGIN, BasicData::USAMP_ADMIN_PASSWORD)
  end


 it "To check if a member can see the reward earned" do

   @browser.link(:text,/Members/).click
   @browser.text_field(:name,"txtEmail").set 'test22.des03@mailop.com'
   @browser.text_field(:name,"txtPassword").set 'test22.des03@mailop.com'
   @browser.select_list(:id,'optPLSites').select('iPoll')
   sleep 1
   @browser.button(:name,'btnSearch').click
   sleep 3
   @browser.link(:text,'M23236004').click
   sleep 3
   #@browser.link(:text=>/SampleMarket/,:index=>2).click
   #@browser.link(:href,/member_activity_log.php/).click
    group_id = File.open("InputRepository/Group_Ids_Dashboard.yml"){|file| YAML::load(file)}
    @dec_group_id =  group_id['group_id']
    puts @dec_group_id
    @browser.goto("http://p.usampadmin.com/member_activity_log.php?ptype=ss&member_id=MTA1OTY0MzY=")
   #@html_contents=@browser.html
   @html_contents=@browser.text
   #puts @html_contents
            @html_array = @html_contents.split(/\n/)
              0.upto(@html_array.size - 1) { |index|

                if(@html_array[index] =~ /#{@dec_group_id}/)
                    @html_array[index+1].should include("1.25")

                      next
                else
              end
            }

 end
     after(:all) do
      @browser.close
      puts "Test 23 has completed"
    end
end
