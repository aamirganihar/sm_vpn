@REM OFF

cd /d D:\SampleMarket\automation_improvements\automation_improvements

rspec --format h -o test.html  --tag ~datacreation --tag ~temp --tag ~inprogress Test_18_non-US_Dashboard_Cases.rb

