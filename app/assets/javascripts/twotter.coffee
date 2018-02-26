$(document).on 'keypress', '#post_body', (e) ->
  if e.which == 13
    $(this).closest('form').submit()
    e.preventDefault()
