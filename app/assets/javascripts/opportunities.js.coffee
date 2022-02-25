# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	update_total = ->
		total = 0
		$('.quote-fields').each ->
			total += $(this).find('.quote-price').val() * $(this).find('.quote-quantity').val()

		$('#opportunity_price').val(total)
		iva = $('#opportunity_price').val()*($('#opportunity_tax').val()/100)
		$('#iva').val(iva) 


	$('.date').datetimepicker({
		language: 'es',
		pickTime: false,
		autoclose: true
		})
	$('.date').datetimepicker().on('changeDate', (ev) ->
		$(this).datetimepicker('hide')
	)
	$('.date-time').datetimepicker({
		language: 'es',
		autoclose: true
		})
	$('.date-time').datetimepicker().on('changeDate', (ev) ->
		$(this).datetimepicker('hide')
	)
	$('#opportunity_price').change ->
		iva = $('#opportunity_price').val()*($('#opportunity_tax').val()/100)
		$('#iva').val(iva)

	$('.quote-price, .quote-quantity').change ->
		update_total()

	$('#client_name').focusout ->
		$.ajax({
			type: "GET"
			url: "/clients/search.json"
			data: {q:$('#client_name').val()}
			})
			.done((data)->
				$('#client_id').val(data["id"])
				$("#opportunity_contact_id").empty()
				$.each data["contacts"], (id, contact) ->
				  $("#opportunity_contact_id").append $("<option></option>").attr("value", contact['id']).text(contact['name'])
				  return
				)
			.error((e)->
				)

	$('.product-code').change ->
		id = $(this).val()
		fields = $(this).parents('.fields')
		$.ajax({
			type: "GET"
			url: "/products.json"
			data: {code:id}
			})
			.done((data)->
				fields.find('.quote-product-id').val(data["id"])
				fields.find('.quote-description').val(data["description"])
				fields.find('.quote-quantity').val(1)
				fields.find('.quote-price').val(data["price"])
				update_total()
				)
			.error((e)->
				)
		
$(document).ready(ready)
$(document).on('turbolinks:load', ready)