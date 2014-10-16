theApp.bindSubscriptions =  ->
  theApp.allSubscriptions = [
    Meteor.subscribe("users")
    Meteor.subscribe("items")
  ]

theApp.bindSubscriptions()