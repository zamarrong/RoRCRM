# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



ready = ->
	$('#supplier_name').focusout ->
		$.ajax({
			type: "GET"
			url: "/suppliers/search.json"
			data: {q:$('#supplier_name').val()}
			})
			.done((data)->
				$('#supplier_id').val(data["id"])
				$("#purchase_order_contact_id").empty()
				$.each data["contacts"], (id, contact) ->
				  $("#purchase_order_contact_id").append $("<option></option>").attr("value", contact['id']).text(contact['name'])
				  return
				)
			.error((e)->
				)

$(document).ready(ready)
$(document).on('turbolinks:load', ready)