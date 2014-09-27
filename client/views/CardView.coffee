class window.CardView extends Backbone.View

  className: 'card'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.addClass 'covered' unless @model.get 'revealed'
    @$el.css('background-image', "url(img/cards/#{@model.get('rankName')}-#{@model.get('suitName')}.png)") if @model.get 'revealed'
