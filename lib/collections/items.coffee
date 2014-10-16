global = exports ? this

###
  workspaceId: id
  listId: id (can be null)

  userId: created user id

  todos: [
    title: string
    completed: bool
    weight: integer
  ]

  completed: boolean
  position: integer

  title: string
  note: string

  dueAt: date
  flagBy: [userid]
  assigneeId: id
  followBy: [userid]
  tags: ["string"]

  createdAt: date

###
class @Item
  constructor: (document)->
    _.extend(@, document)

@Items= new Meteor.Collection "items",
  transform: (doc)->
    return new Item(doc)
