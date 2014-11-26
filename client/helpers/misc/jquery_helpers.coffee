$ = jQuery

$.fn.extend
  isDescendantOf: (p)->
    return @closest(p).length > 0


  selectRange: (start,end)->
    end = start unless end
    @each ->
      if @setSelectionRange
        @focus()
        @setSelectionRange(start,end)
      else if @createTextRange
        range = @createTextRange()
        range.collapse(true)
        range.moveEnd('character', end)
        range.moveStart('character', start)
        range.select()