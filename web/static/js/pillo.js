// Generated by CoffeeScript 1.4.0
(function() {

  $(function() {
    var tracks;
    $.pillo = {};
    $.pillo.Pill = Backbone.RelationalModel.extend({
      idAttribute: '_id',
      defaults: {
        _id: '',
        content: 'Some text describing',
        references: [4, 5]
      }
    });
    $.pillo.Track = Backbone.RelationalModel.extend({
      idAttribute: '_id',
      defaults: {
        _id: '',
        title: 'New track',
        description: 'Some text'
      },
      relations: [
        {
          type: Backbone.HasMany,
          key: 'pills',
          relatedModel: '$.pillo.Pill',
          reverseRelation: {
            key: 'track',
            includeInJSON: '_id'
          }
        }
      ]
    });
    $.pillo.TrackCollection = Backbone.Collection.extend({
      model: $.pillo.Track
    });
    $.pillo.TrackListView = Backbone.View.extend({
      tagName: 'div',
      className: 'trak_list_view',
      template: Handlebars.compile($('#tmpl_track_list').html()),
      initialize: function() {
        _.bindAll(this, 'render', 'addTrack', 'addOne');
        this.collection.bind('add', this.addOne);
        this.collection.bind('reset', this.render);
        return this.collection.bind('change', this.render);
      },
      render: function() {
        this.$el.html(this.template());
        return this.collection.forEach(this.addOne);
      },
      addOne: function(track) {
        var trackView;
        trackView = new $.pillo.TrackView({
          model: track
        });
        return this.$('#addOne').parent().prepend(trackView.render());
      },
      events: {
        'click #addOne': 'addTrack'
      },
      addTrack: function(e) {
        return console.log('New track!');
      }
    });
    $.pillo.TrackView = Backbone.View.extend({
      tagName: 'section',
      className: 'kunit span3',
      template: Handlebars.compile($('#tmpl_track').html()),
      initialize: function() {
        _.bindAll(this, 'render', 'addPill');
        return this.model.bind('change', this.render);
      },
      render: function() {
        return this.$el.html(this.template(this.model.toJSON()));
      },
      events: {
        'click footer > a': 'addPill'
      },
      addPill: function(e) {
        return console.log('New pill!');
      }
    });
    $.pillo.PillView = Backbone.View.extend({
      tagName: 'div',
      className: 'pill_view',
      template: Handlebars.compile($('#tmpl_pill')),
      initialize: function() {
        _.bindAll(this, 'render');
        return this.model.bind('change', this.render);
      },
      render: function() {
        return this.$el.html(this.template(this.model.toJSON()));
      }
    });
    tracks = [
      {
        _id: 101,
        title: "Un campo",
        description: 'Una descripcion',
        pills: [
          {
            "_id": "123",
            "content": "The message"
          }, {
            "_id": "124",
            "content": "The reply to the previous message"
          }
        ]
      }, {
        _id: 201,
        title: "Otro campo",
        description: 'Otra descripcion',
        pills: [
          {
            "_id": "223",
            "content": "The messagessss"
          }, {
            "_id": "224",
            "content": "The reply to the previous messagesss"
          }
        ]
      }
    ];
    $.pillo.App = Backbone.Router.extend({
      routes: {
        "": "show_track_list",
        "pill/:_id": "show_details"
      },
      initialize: function() {
        var trackCollection, trackListView;
        trackCollection = new $.pillo.TrackCollection();
        trackListView = new $.pillo.TrackListView({
          el: $('#workspace'),
          collection: trackCollection
        });
        trackCollection.reset(tracks);
        trackListView.render();
        return console.log('Pill-o initialized...');
      },
      show_track_list: function() {},
      show_details: function() {}
    });
    return $.pillo.start = function() {
      $.pillo.app = new $.pillo.App();
      return Backbone.history.start({
        pushState: true
      });
    };
  });

}).call(this);
