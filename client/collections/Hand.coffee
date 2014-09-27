class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    if @scores()[0] > 21 then @trigger 'bust'
    if @scores()[0] is 21 then @stand()
    @last()

  play: ->
    if @scores()[0] > 21 then return
    if @scores()[0] >= 17 then return @stand()

    @hit()
    @play()

  stand: ->
    @trigger 'stand'

  scores: (countHidden=true) ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get('revealed') or countHidden then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
