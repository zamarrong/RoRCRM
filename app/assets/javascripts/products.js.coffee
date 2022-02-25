# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	$('.edit-image img').click ->
		$('#product_image').trigger('click')

	$("#product_image").change ->
		imageFile = this.files[0]
		url = window.URL.createObjectURL(imageFile)
		$('.edit-image img').attr('src', url)

	$('#import-link').click ->
		$('#hf-inventory').trigger('click')

	$('#hf-inventory').change ->
		$('#hf-submit').click()

	$('.nav-tabs a').click ->
		$('#current_inventory').val($(this).attr('href').substring(1))



$(document).ready(ready)
$(document).on('turbolinks:load', ready)