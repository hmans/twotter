$(document).on 'turbolinks:load', ->
  $form = $('form#new_post')
  $button = $form.find('input[type="submit"]')
  $textarea = $('textarea#post_body')

  # Disable the submit button first thing after loading the page.
  $button.prop('disabled', true)

  # When the textarea changes, enable/disable the submit button,
  # depending on whether we have any text available.
  $textarea.on 'keyup', (e) ->
    value = $(this).val().trim()
    $button.prop('disabled', value == "")

  # Submit the form when user hits Enter. Yes, we need to do this in
  # a different event (keypress, not keyup.)
  $textarea.on 'keypress', (e) ->
    if e.which == 13
      $form.submit() if !$button.prop('disabled')
      e.preventDefault()
