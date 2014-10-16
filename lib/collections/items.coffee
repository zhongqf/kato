global = exports ? this

class @Item
  constructor: (document)->
    _.extend(@, document)

@Items= new Meteor.Collection "items",
  transform: (doc)->
    return new Item(doc)
