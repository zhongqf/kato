$ = jQuery

$.fn.extend
 isDescendantOf: (p)->
  return @closest(p).length > 0