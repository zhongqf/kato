global = exports ? this

class @Workinfo
  constructor: (document)->
    _.extend(@, document)

@Workinfos = new Meteor.Collection "workinfos",
  transform: (doc)->
    return new Workinfo(doc)
