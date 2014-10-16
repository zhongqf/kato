theApp.bindSubscriptions =  ->
  theApp.allSubscriptions = [
    Meteor.subscribe("users")
    Meteor.subscribe("groups")
    Meteor.subscribe("people")
    Meteor.subscribe("projects")
    Meteor.subscribe("workinfos")
  ]

theApp.bindSubscriptions()