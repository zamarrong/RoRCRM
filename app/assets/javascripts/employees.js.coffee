# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	$('.edit-avatar img').click ->
		$('#user_avatar').trigger('click')

	$("#user_avatar").change ->
		imageFile = this.files[0]
		url = window.URL.createObjectURL(imageFile)
		$('.edit-avatar img').attr('src', url)



$(document).ready(ready)
$(document).on('turbolinks:load', ready)