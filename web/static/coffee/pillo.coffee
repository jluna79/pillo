$ ->
	$.pillo = {}

	$.pillo.Track = Backbone.Model.extend
		defaults:
			__id: ''
			title: 'New track'
			description: 'Some text'


	# Initialize app
	$.pillo.start = ->
		console.log new $.pillo.Track();
