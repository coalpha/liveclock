d = document
d-id = d~getElementById

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

year-inp.max = "" + dayjs!.year!
year-inp.min = ("" + dayjs!.year! - 122)

html-option = (value, innerText) ->
   d.createElement "option"
      ..value = value
      ..innerText = innerText

select-option = (html-element, idx) !->
   html-element.children[idx].selected = "selected"

for month, i in month-names
   html-option i, month |> month-inp.appendChild

for i from 1 to 31
   html-option i, i |> day-inp.appendChild

ls = local-storage

birthday = ls.birthday
console.log birthday
if birthday
   if (birthday = dayjs birthday).isValid!
      select-option month-inp, birthday.month!
      select-option day-inp, birthday.day! - 1
      year-inp.value = birthday.year!
      select-option sex-inp, ls.sex
   else
      console.log "Invalid Date"
      delete ls.birthday
else
   console.log "No Date"

input-is-valid = (v = year-inp.value) -> /\d{4}/~test v and v >= year-inp.min

button.addEventListener "click" !->
   if input-is-valid!
      ls.birthday = new Date year-inp.value, month-inp.value, day-inp.value .toJSON!
      console.log ls.birthday
      ls.sex = + sex-inp.value
      window.location = (get-cwd location.href) + "/clock"
   else
      year-inp.value = do
         if /\d{4}.*/.test year-inp.value
            year-inp.value.slice 0, 4
         else
            year-inp.min

