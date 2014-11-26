moment.fn.timeFromNow= ->
  timeNow = moment(Session.get("time") or new Date())
  diffSecs =  timeNow.diff(@, 'seconds')
  diffDays = timeNow.diff(@, 'days')

  if diffDays > 1
    return @format("D MMM")

  if diffSecs < 45
    return "Just Now"

  if diffSecs < 45*60
    return @fromNow()

  return @format("HH:mm")

