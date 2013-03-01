# Generic js

$ ->
	$('#dashboard section').sortable
		items: 'article'
		cancel: 'footer, .placeholder'
		connectWith : '.kunit'

	$( "#dashboard section" ).disableSelection()
