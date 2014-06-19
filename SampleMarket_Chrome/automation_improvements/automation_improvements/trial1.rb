require 'rubygems'
#Load WATIR
require 'optparse'
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'

prj_number= Time.now
prj_number = prj_number.to_s
prj_number = prj_number.slice(0..18)
prj_number = prj_number.gsub(/:/, "")
prj_number = prj_number.gsub(/-/, "")
prj_number = prj_number.gsub(/ /, "")
puts prj_number

survey_url = "https://network.usamp.com/pshield/ps_project_suppliers.php?hdPsPrjId=NTg0Ng=="
project_id = survey_url.slice(69..77)
puts test