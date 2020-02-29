subtitle = d-id "enter"
month-inp = d-id "month"
day-inp = d-id "day"
year-inp = d-id "year"
sex-inp = d-id "sex"
button = d-id "submit"

month-names = [
   "January"
   "February"
   "March"
   "April"
   "May"
   "June"
   "July"
   "August"
   "September"
   "October"
   "November"
   "December"
]

sex-inp.children[Math.random! * 2 .|. 0].selected = true

oldest-person = 123
year-inp.max = new Date!.get-full-year!
year-inp.min = year-inp.max - oldest-person

make-option = (value, text) ->
   d.create-element "option"
      ..value = value
      ..inner-text = text

select-option = (html-element, idx) !->
   html-element.children[idx].selected = "selected"

for month, i in month-names
   make-option i, month |> month-inp.append-child

for i from 1 to 31
   make-option i, i |> day-inp.append-child

if birthday.is-good
   select-option month-inp, birthday.month!
   select-option day-inp, birthday.day! - 1
   year-inp.value = birthday.year!
else
   delete ls.birthday

select-option sex-inp, switch ls.sex
   case "XX" then 0
   case "XY" then 1
   default
      delete ls.sex
      Math.random! * 2 .|. 0

year-is-valid = (v = year-inp.value) -> /\d{4}/~test v and v >= year-inp.min

submit = !->
   if year-is-valid!
      birthday = new CDate year-inp.value, month-inp.value, day-inp.value
      if birthday.is-good
         ls.birthday = birthday.to-string!
         ls.sex = sex-inp.value
         w.location = (get-cwd location.href) + "/clock"
      else
         subtitle.innerText = "#{birthday.error} at #{new Date!.toJSON!}"
   else
      year-inp.value = do
         if /\d{4}.*/.test year-inp.value
            year-inp.value.slice 0, 4
         else
            year-inp.min

button.add-event-listener "click", submit

d.add-event-listener "keyup", (e) !-> if e.keyCode == 13 then submit!
