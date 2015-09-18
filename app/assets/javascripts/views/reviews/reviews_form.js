YelpClone.Views.ReviewsForm = Backbone.View.extend({
  tagName: 'form',
  template: JST['reviews/new'],

  events: {
    'click button.post-review': 'createReview'
  },

  initialize: function(options) {
    this.restaurant = options.restaurant;
    this.listenTo(this.restaurant, "sync", this.render);
  },

  render: function() {
    this.$el.html(this.template({ restaurant: this.restaurant }));

    this.$el.find('#star-rate').raty('destroy');
    this.$el.find('#star-rate').raty({
      path: '/assets/',
      half: false,
      targetType: 'score',
      targetKeep: true,
      scoreName: 'review[rating]'
    });
    return this;
  },

  createReview: function(event) {
    event.preventDefault();
    var formData = $(event.currentTarget).parent().serializeJSON();
    formData.review.rating = parseInt(formData.review.rating);

    this.model.save(formData.review, {
      success: function(model) {
        this.restaurant.reviews().add(model);
        Backbone.history.navigate(
          "#/restaurants/" + this.restaurant.id,
          { trigger: true }
        )
      }.bind(this)
    });
  }
});
