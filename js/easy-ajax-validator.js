(function() {
  $(document).ready(function() {
    var TestForms;
    TestForms = function(container) {
      var _append_container, validation;
      _append_container = 'html,body';
      validation = 0;
      $(container + ' .error').removeClass('error');
      if ($(window).width() <= 480) {
        _append_container = container;
      }
      console.log($(window).width());
      $(_append_container).append('<div class="form_messages"></div>');
      $(container).find('.required').each(function() {
        var _field, _field_value;
        _field = $(this);
        _field_value = _field.attr('title');
        if (_field.val() === '' || _field.val() === _field_value || (_field.is(':checkbox') && !_field.is(':checked')) || _field.val() === 'nda') {
          _field.focus();
          _field.parent().addClass('error');
          validation++;
          return console.log(_field.val());
        }
      });
      if (validation === 0) {
        $('.form_messages').addClass('success');
        $('.form_messages').html('Thank for the contact! We will contact you soon!');
        $.ajax({
          type: 'POST',
          url: "your-url.php",
          data: {
            n: $(container + '.name').val()
          }
        });
        return setTimeout((function() {
          $('.form_messages').remove();
          return $('input, textarea').val('');
        }), 2000);
      } else {
        $('.form_messages').html('Please, fill all fields');
        return setTimeout((function() {
          return $('.form_messages').remove();
        }), 2000);
      }
    };
    return $('.form-submit').click(function() {
      var _form_check;
      _form_check = $(this).data('form');
      TestForms(_form_check);
      return false;
    });
  });

}).call(this);

