global = exports ? this

class @Project
  constructor: (document)->
    _.extend(@, document)

@Projects= new Meteor.Collection "projects",
  transform: (doc)->
    return new Project(doc)
