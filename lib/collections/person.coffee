global = exports ? this

class @Person
  constructor: (document)->
    _.extend(@, document)

@People = new Meteor.Collection "people",
  transform: (doc)->
    return new Person(doc)
