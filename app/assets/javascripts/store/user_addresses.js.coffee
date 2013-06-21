@disableSaveOnClick = ->
  ($ 'form.edit_order').submit ->
    ($ this).find(':submit, :image').attr('disabled', true).removeClass('primary').addClass 'disabled'

$ ->
  if ($ '.profile-address form').is('*')
    ($ '.profile-address form').validate()

    $("#add-user-address").on "click", (event)->
      $.ajax
        dataType: 'html'
        url: $(this).prop("href")+".js"
        data:
          address_count: $('.profile-address form').length
        success: (data)->
          html = $(data)
          html.find("input[name='commit']").after("<a class='button remove-new-address' herf='#' style='background-color:red;'>Delete</a>")
          $(".profile-address").append(html)
          if $(".profile-address form").length >= 6
            $("#add-user-address").hide();

      return false

    $('.profile-address').on "click", 'a.remove-new-address', (event) ->
      $(this).parents(".wrapper-form-address:first").remove()
      if $(".profile-address form").length < 6
        $("#add-user-address").show();

      return false

    _country_from_region = (form) ->
      $('select[name="address[country_id]"]', form).val()

    _get_states = (form) ->
      state_mapper[_country_from_region(form)]

    _get_states_required = (form) ->
      states_required_mapper[_country_from_region(form)]

    _update_state = (form) ->
      states = _get_states(form)
      states_required  = _get_states_required(form)

      state_para = $(".address-state", form)
      state_select = state_para.find('select')
      state_input = state_para.find('input')
      state_span_required = state_para.find('state-required')
      if states
        selected = parseInt state_select.val()
        state_select.html ''
        states_with_blank = [ [ '', '' ] ].concat(states)
        $.each states_with_blank, (pos, id_nm) ->
          opt = ($ document.createElement('option')).attr('value', id_nm[0]).html(id_nm[1])
          opt.prop 'selected', true if selected is id_nm[0]
          state_select.append opt

        state_select.prop('disabled', false).show()
        state_input.hide().prop 'disabled', true
        state_span_required.show()
      else
        state_select.hide().prop 'disabled', true
        state_input.show()
        if states_required
          state_span_required.show()
        else
          state_input.val ''
          state_span_required.hide()
        state_para.toggle(!!states_required)
        state_input.prop('disabled', !states_required)

    $('.profile-address').on "change", 'select[name="address[country_id]"]', (event) ->
      _update_state $(this).parents("form:first")

    $.each $('.profile-address form'), (index, form) ->
      _update_state form
