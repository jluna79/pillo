$ ->
	$.pillo = {}

	# Models //////////////////////////////////////////////////
	$.pillo.Pill = Backbone.RelationalModel.extend
		idAttribute: '_id'
		defaults:
			_id: ''
			content: 'Some text describing'
			references: [4,5]


	$.pillo.Track = Backbone.RelationalModel.extend
		idAttribute: '_id'
		defaults:
			_id: ''
			title: 'New track'
			description: 'Some text'
		relations: [
			type: Backbone.HasMany
			key: 'pills'
			relatedModel: '$.pillo.Pill'
			reverseRelation:
				key: 'track'
				includeInJSON: '_id'
		]


	$.pillo.TrackCollection = Backbone.Collection.extend
		model: $.pillo.Track

	# Views //////////////////////////////////////////////////

	# TrackList
	$.pillo.TrackListView = Backbone.View.extend
		tagName: 'div'
		className: 'trak_list_view'

		template: Handlebars.compile $('#tmpl_track_list').html()

		initialize: ->
			_.bindAll @, 'render', 'addTrack', 'addOne'
			@.collection.bind 'add', @.addOne
			@.collection.bind 'reset', @.render
			@.collection.bind 'change', @.render

		render: ->
			@.$el.html(@.template())
			@.collection.forEach @.addOne

		addOne: (track) ->
			trackView = new $.pillo.TrackView {model: track}
			@.$('#addOne').parent().prepend trackView.render()

		events:
			'click #addOne': 'addTrack'

		addTrack: (e) ->
			console.log 'New track!'

	# Track
	$.pillo.TrackView = Backbone.View.extend
		tagName: 'section'
		className: 'kunit span3'
		
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
	$.pillo.PillView = Backbone.View.extend
		tagName: 'div'
		className: 'pill_view'
		template: Handlebars.compile $('#tmpl_pill')

		initialize: ->
			_.bindAll @, 'render'
			@.model.bind 'change', @.render

		render: ->
			@.$el.html( @.template(@.model.toJSON() ))



	# Router //////////////////////////////////////////////////
	tracks = [
		{ _id: 101, title : "Un campo", description: 'Una descripcion', pills: [{ "_id": "123", "content": "The message"}, {"_id": "124","content": "The reply to the previous message"}]}
		{ _id: 201, title : "Otro campo", description: 'Otra descripcion', pills: [{"_id": "223","content": "The messagessss"},{"_id": "224","content": "The reply to the previous messagesss"}]}
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
			trackListView.render()

			console.log 'Pill-o initialized...'

		show_track_list: ->

		show_details: ->


	# Initialize app //////////////////////////////////////////////////
	$.pillo.start = ->
		$.pillo.app = new $.pillo.App()
		Backbone.history.start
			pushState: true
