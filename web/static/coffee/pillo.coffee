$ ->
	$.pillo = {}

	# Models //////////////////////////////////////////////////
	$.pillo.Track = Backbone.Model.extend
		defaults:
			_id: ''
			title: 'New track'
			description: 'Some text'


	$.pillo.TrackCollection = Backbone.Collection.extend
		model: $.pillo.Track

	# Views //////////////////////////////////////////////////

	# TrackList
	$.pillo.TrackListView = Backbone.View.extend
		tagName: 'div'
		className: 'trak_list_view'

		template: Handlebars.compile $('#tmpl_track_list').html()

		initialize: ->
			_.bindAll @, 'render', 'addTrack', 'addOne', 'addAll'
			#@.model.bind 'reset', @.render
			#@.model.bind 'change', @.render

			@.collection.bind 'add', @.addOne
			@.collection.bind 'reset', @.addAll
			@.collection.bind 'change', @.addAll

		render: ->
			@.addAll

		addAll: ->
			@.collection.forEach @.addOne

		addOne: (track) ->
			trackView = new $.pillo.TrackView {model: track}
			@.$el.append trackView.render()

		events:
			'click #addOne': 'addTrack'

		addTrack: (e) ->
			console.log 'New track!'

	# Track
	$.pillo.TrackView = Backbone.View.extend
		tagName: 'div'
		className: 'track_view'
		
		template: Handlebars.compile $('#tmpl_track').html()

		initialize: ->
			_.bindAll @, 'render', 'addPill'
			@.model.bind 'change', @.render

		render: ->
			@.$el.html( @.template(@.model.toJSON() ))

		events:
			'click footer > a': 'addPill'

		addPill: (e) ->
			console.log 'New pill!'


	# Pill

	# Router //////////////////////////////////////////////////
	tracks = [
		{_id: 101, title : "Un campo", description: 'Una descripcion'}
		{_id: 102, title : "Otro campo", description: 'Otra descripcion'}
	]

	$.pillo.App = Backbone.Router.extend
		routes:
			"": "show_track_list"
			"pill/:_id": "show_details"

		initialize: ->
			trackCollection = new $.pillo.TrackCollection()
			trackListView = new $.pillo.TrackListView
				el: $('#workspace')
				collection: trackCollection

			trackCollection.reset(tracks)
			console.log 'Pill-o initialized...'

		show_track_list: ->

		show_details: ->


	# Initialize app //////////////////////////////////////////////////
	$.pillo.start = ->
		$.pillo.app = new $.pillo.App()
		Backbone.history.start
			pushState: true
