require 'rubygems'
#require './automation'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
require 'win32/clipboard'
include Win32 
require 'YAML'
#require 'fastercsv'
require 'csv'
require "fastercsv"

i=1
j=1
pass=0
fail=0

csvData = CSV.read("./Results_Production.csv")

while (i <= 151)
	myString = csvData[i]
	#puts csvData[j][5]
	if (csvData[j][5] =~ /false/)
		fail+=1
		else
			pass+=1
		end
		#puts myString
		i+=1
		j+=1
	end
#puts csvData[125]
=begin
j=1

while (i <= 150)
if csvData[j][5] =~ /false/
	fail+=1
		else
			pass+=1
		end
	j+=1
end
=end
#puts myString
	puts pass
	puts fail
	total = pass.to_i+fail.to_i
	puts total
=begin
0.upto(149) { |index|
if(csvData[index][5] =~ /false/)
	puts "pass"
	else
		puts "fail"
	end
	}
=end	