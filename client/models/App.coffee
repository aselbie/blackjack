#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', @lose, @
    @get('playerHand').on 'stand', @get('dealerHand').play, @get('dealerHand')

    @get('dealerHand').on 'bust', @win, @
    @get('dealerHand').on 'stand', @compare, @
    @

  compare: ->
    playerScores = @get('playerHand').scores()
    if playerScores[1]?
      if playerScores[1] > 21 then playerScore = playerScores[0]
      else playerScore = playerScores[0]
    else playerScore = playerScores[0]
    console.log playerScore

    dealerScores = @get('dealerHand').scores()
    if dealerScores[1]?
      if dealerScores[1] > 21 then dealerScore = dealerScores[0]
      else dealerScore = dealerScores[0]
    else dealerScore = dealerScores[0]
    console.log dealerScore

    if dealerScore > playerScore then @lose()
    if dealerScore < playerScore then @win()
    if dealerScore is playerScore then @tie()

  tie: ->
    console.log 'It\'s a tie!'

  lose: ->
    console.log 'You lose!'

  win: ->
    console.log 'You win!'

  playerHit: ->
    @get('playerHand').hit();
