Meteor.publish "users", ->
  return Meteor.users.find {},
    fields:
      username: 1
      emails: 1
      profile: 1

Meteor.publish "people", -> People.find()
Meteor.publish "groups", -> Groups.find()
Meteor.publish "projects", -> Projects.find()
Meteor.publish "workinfos", -> Workinfos.find()

