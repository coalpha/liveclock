window.w = window
w.d = document
w.ls = local-storage
w.d-id = d~get-element-by-id

w.get-cwd = (s) -> s.slice 0, s.lastIndexOf "/"

w.go-to-root = !-> w.location = getCwd w.location.href

w.CDate = class CDate
   @@from-string = (string) ->
      [year, month, day] = string.split "-"
      new CDate year, month - 1, day

   (year, month, day) ->
      year  = year  .|. 0
      month = month .|. 0
      day   = day   .|. 0
      @_val = new Date year, month, day
      if @_val.value-of!
         if \
            @year! == year \
            and @month! == month \
            and @day! == day
               @is-good = true
         else
            @error = "Nonexistent date"
      else
         @error = "Bad input"

   value-of: ->
      if @is-good
         @_val.value-of!
      else
         throw new Error @error

   to-string: ->
      if @is-good
         @_val.toJSON!.slice 0, 10
      else
         @error

   year: -> @_val.get-full-year!

   month: -> @_val.get-month!

   day: -> @_val.get-date!

w.birthday = if ls.birthday?
   CDate.from-string ls.birthday
else
   { -is-good }
