clock = document.getElementById "clock"

deathday = dayjs localStorage.birthday .add 90 + ~~localStorage.sex, "years" .valueOf!

u-second = 1000
u-minute = 60 * u-second
u-hour   = 60 * u-minute
u-day    = 24 * u-hour
u-week   = 7  * u-day
u-month  = 4.34524 * u-week # you ruined the nice chain
u-year   = 12 * u-month

set-time-remaining = !->
   ms = deathday - Date.parse new Date
   seconds = (ms / u-second) % 60 .|. 0
   minutes = (ms / u-minute) % 60 .|. 0
   hours   = (ms / u-hour)   % 24 .|. 0
   days    = (ms / u-day)    % 7  .|. 0
   weeks   = (ms / u-week)   % 4.34524  .|. 0
   months  = (ms / u-month)  % 12 .|. 0
   years   = (ms / u-year)       .|. 0
   clock.innerText = "#{years} years #{months} months #{weeks} weeks #{days} days #{hours} hours #{minutes} minutes #{seconds} seconds"
set-time-remaining!
setInterval set-time-remaining, 1000
# function ti(endtime){
#   var t = Date.parse(endtime) - Date.parse(new Date());
#   var seconds = Math.floor( (t/1000) % 60 );
#   var minutes = Math.floor( (t/1000/60) % 60 );
#   var hours = Math.floor( (t/(1000*60*60)) % 24 );
#   var days = Math.floor( t/(1000*60*60*24) );
#   return {
#     'total': t,
#     'days': days,
#     'hours': hours,
#     'minutes': minutes,
#     'seconds': seconds
#   };
# }
