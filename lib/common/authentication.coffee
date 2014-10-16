global = exports ? this

global.authenticatedUser = ->
  user = Meteor.user()
  if (!user)
    throw new Meteor.Error(401, "You need to login.")

  return user