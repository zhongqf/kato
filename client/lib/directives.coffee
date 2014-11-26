
angular.module('app.directives', [])
  .directive 'fsUserAvatar', ['$rootScope', ($rs)->
    return {
      restrict: 'A'
      link: (scope, element, attrs)->
        userId = attrs.fsUserAvatar
        avatar = "/images/avatar/avatar.png"
        username = "(No Name)"

        if userId
          user = Meteor.users.findOne(userId)

          if _.isObject(user) and _.has(user, "profile")
            avatar = user.profile.avatar?.thumb_url
            username = user.profile.name

        child = "<img class='img-full' src='#{avatar}' alt='#{username}'>"
        element.append(child)
    }
  ]
