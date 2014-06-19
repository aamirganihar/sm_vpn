@REM OFF

cd /d D:\SampleMarket_Chrome\automation_improvements\automation_improvements

rspec --format h -o Report_summary.html --tag ~datacreation --tag ~temp --tag ~inprogress Test_99_report_generation.rb

