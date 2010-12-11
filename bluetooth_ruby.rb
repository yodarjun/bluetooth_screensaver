#! /usr/bin/ruby
#

RADIUS = 18 # change this value according to your radius of interest
SLEEP_TIME = 7 # change this value to reduce/increase time intervals for checks
deviceid = ''
range = ''
buffer = 0
count = 0
while count < 1
  range = `hcitool rssi #{deviceid}`.chomp
   index = range =~ /\d/
   numeric_range = range[index..-1]
   if numeric_range.to_i > RADIUS
     buffer += 1
     puts range[/\w+$/]
     # for linux gnome:
     # system("gnome-screensaver-command --lock") if buffer > 2
     #
     # for mac:
     system("/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine")
   else
     buffer = 0
     puts "bluetooth device is in range...#{numeric_range}"
     Thread.new{`rfcomm connect 0 #{deviceid}`}
   end

   sleep SLEEP_TIME
end
