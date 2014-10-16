Meteor.publish "users", ->
  return Meteor.users.find {},
    fields:
      username: 1
      emails: 1
      profile: 1

Meteor.publish "items", ->
  #todo: publish items with condition
  return Items.find()
