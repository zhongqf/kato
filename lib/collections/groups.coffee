global = exports ? this

class @Group
  constructor: (document)->
    _.extend(@, document)

@Groups= new Meteor.Collection "groups",
  transform: (doc)->
    return new Group(doc)
