@REM OFF

cd /d D:\API_AUTOMATION
del D:\API_AUTOMATION\Results_Stage.csv

cd /d D:\jakarta-jmeter-2.3.4\bin\
java -jar ApacheJMeter.jar -n -t D:\API_AUTOMATION\4S_API_AUTOMATION_STAGE.jmx

cd /d D:\API_AUTOMATION
ruby api_email_stage.rb

echo today is %DATE% %TIME% 

cd /d D:\SampleMarket\automation_improvements\automation_improvements

ruby Mail.rb