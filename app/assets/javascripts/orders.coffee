# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#btnCheckout').click ->
    $('#divAddress').attr('style','')

  $('#cb_shipping_same_as_billing').on 'change', =>
    if $('#cb_shipping_same_as_billing')[0].checked
      console.log('setting_values')
      set_shipping_values()
      add_ef_change_handlers()
      toggle_ef_shipping_disabled(true)
    else
      console.log('removing handlers')
      remove_ef_change_handlers()
      toggle_ef_shipping_disabled(false)

set_shipping_values = ->
  set_shipping_name()
  set_shipping_address1()
  set_shipping_address2()
  set_shipping_city()
  set_shipping_state()
  set_shipping_zip()

set_shipping_name = ->
  $('#ef_shipping_name')[0].value = $('#ef_billing_first_name')[0].value + " " + $('#ef_billing_last_name')[0].value

set_shipping_address1 = ->
  $('#ef_shipping_address1')[0].value = $('#ef_billing_address1')[0].value

set_shipping_address2 = ->
  $('#ef_shipping_address2')[0].value = $('#ef_billing_address2')[0].value

set_shipping_city = ->
  $('#ef_shipping_city')[0].value = $('#ef_billing_city')[0].value

set_shipping_state = ->
  $('#ef_shipping_state')[0].value = $('#ef_billing_state')[0].value

set_shipping_zip = ->
  $('#ef_shipping_zip')[0].value = $('#ef_billing_zip')[0].value


add_ef_change_handlers = () ->
  console.log('setting handlers')
  $('#ef_billing_first_name').on 'keyup', =>
    set_shipping_name()
  $('#ef_billing_last_name').on 'keyup', =>
    set_shipping_name()
  $('#ef_billing_address1').on 'keyup', =>
    set_shipping_address1()
  $('#ef_billing_address2').on 'keyup', =>
    set_shipping_address2()
  $('#ef_billing_city').on 'keyup', =>
    set_shipping_city()
  $('#ef_billing_state').on 'keyup', =>
    set_shipping_state()
  $('#ef_billing_zip').on 'keyup', =>
    set_shipping_zip()

remove_ef_change_handlers = ->
  $('#ef_billing_first_name').off 'keyup'
  $('#ef_billing_last_name').off 'keyup'
  $('#ef_billing_address1').off 'keyup'
  $('#ef_billing_address2').off 'keyup'
  $('#ef_billing_city').off 'keyup'
  $('#ef_billing_state').off 'keyup'
  $('#ef_billing_zip').off 'keyup'


toggle_ef_shipping_disabled = (value) ->
  $('#ef_shipping_name').prop('readonly',value)
  $('#ef_shipping_address1').prop('readonly',value)
  $('#ef_shipping_address2').prop('readonly',value)
  $('#ef_shipping_city').prop('readonly',value)
  $('#ef_shipping_state').prop('readonly',value)
  $('#ef_shipping_zip').prop('readonly',value)
