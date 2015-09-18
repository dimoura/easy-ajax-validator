$(document).ready ->

  TestForms = (container) ->
    # Container which will receive errors messages
    _append_container = 'html,body'

    # Var that counts erros for validation
    validation = 0

    # Reset errors message
    $(container+' .error').removeClass('error')

    # Decides where we are going to put the messages, for mobile is better that the container still static not fixed
    if $(window).width() <= 480
      _append_container = container

    console.log $(window).width()
    # Append the messages container
    $(_append_container).append '<div class="form_messages"></div>'

    # Search for required inputs
    $(container).find('.required').each ->
      # Instance the field for tests
      _field = $(this)

      # If the guy is a machine, we are going to check... just for fun =)
      _field_value = _field.attr('title')

      # Check if the input is empty or if the content if like the title
      if _field.val() == '' || _field.val() == _field_value || (_field.is(':checkbox') && !_field.is(':checked')) || _field.val() == 'nda'
        _field.focus()
        _field.parent().addClass('error')
        validation++
        console.log _field.val()

    # Now, if is all set, we are going to send the infos
    if validation == 0
      # Include the success class for our message container
      $('.form_messages').addClass 'success'
      
      # And put the beauty message
      $('.form_messages').html 'Thank for the contact! We will contact you soon!'
      
      # This is the ajax. We will pass the variables trought a data object by the field class
      $.ajax
        type: 'POST'
        url: "your-url.php"
        data:
          n: $(container+ '.name').val()

      setTimeout (->
        $('.form_messages').remove()
        $('input, textarea').val ''
      ), 2000

    else
      $('.form_messages').html 'Please, fill all fields'

      setTimeout (->
        $('.form_messages').remove()
      ), 2000

  $('.form-submit').click ->
    _form_check = $(this).data('form')
    TestForms(_form_check)
    return false
