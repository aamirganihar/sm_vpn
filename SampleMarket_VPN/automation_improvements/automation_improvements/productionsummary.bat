@REM OFF

cd /d D:\SampleMarket\automation_improvements\automation_improvements

rspec --format h -o Report_summary.html --tag ~datacreation --tag ~temp --tag ~inprogress productionreport_generation.rb

