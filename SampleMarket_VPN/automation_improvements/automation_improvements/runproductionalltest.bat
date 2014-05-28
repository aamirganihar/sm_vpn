@REM OFF

cd /d D:\SampleMarket\automation_improvements\automation_improvements

rspec --format h -o AllTest.html --tag ~datacreation --tag ~temp --tag ~inprogress Production_test\*

