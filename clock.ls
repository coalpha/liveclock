clock = d-id "clock"

# seconds-per
const s-minute = 60
const s-hour   = 3600
const s-day    = 86400
const s-week   = 604800
const s-month  = 2592000
const s-year   = 31556952

unless birthday.is-good
   go-to-root!

s-deathday = birthday.value-of! / 1000 # put it in seconds

if ls.sex == "XX"
   s-deathday += s-year * 91
else
   s-deathday += s-year * 90

get-now = -> Date.now! / 1000 .|. 0 # get the time in seconds

quantify = (num, what, postfix = " ") ->
   "#{num} #{what}#{if num == 1 then "" else "s"}#{postfix}"

set-time-remaining = !->
   sr = s-deathday - get-now! # seconds remaining
   seconds = sr % s-minute .|. 0
   minutes = sr % s-hour / s-minute .|. 0
   hours   = sr % s-day / s-hour .|. 0
   days    = sr % s-week / s-day .|. 0
   weeks   = sr % s-month / s-week .|. 0
   months  = sr % s-year / s-month .|. 0
   out = quantify sr / s-year .|. 0, "year"
   out += quantify months, "month"
   out += quantify weeks, "week"
   out += quantify days, "day"
   out += quantify hours, "hour"
   out += quantify minutes, "minute"
   out += quantify seconds, "second", ""
   clock.innerText = out

set-time-remaining!
setInterval set-time-remaining, 1000
