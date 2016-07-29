$(document).on 'ready turbolinks:load', ->
  $('.dropdown').hover (->
    $('.dropdown-menu', this).stop(true, true).fadeIn 'fast'
    $(this).toggleClass 'open'
    $('b', this).toggleClass 'caret caret-up'
    return
  ), ->
    $('.dropdown-menu', this).stop(true, true).fadeOut 'fast'
    $(this).toggleClass 'open'
    $('b', this).toggleClass 'caret caret-up'
