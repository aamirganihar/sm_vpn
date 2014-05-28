@REM OFF

cd /d D:\SampleMarket\automation_improvements\automation_improvements

rspec --format h -o Report_summaryalltest.html --tag ~datacreation --tag ~temp --tag ~inprogress productionreport_generationalltest.rb

