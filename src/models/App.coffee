# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'game', game = @makeGame()
    @get 'playerHand'
      .on 'endTurn', ->
        console.log 'ending'
        @get game.gameLogic()
    @get 'playerHand'
      .on 'endGame', =>
        console.log 'gameover'
        @newGame()
    @get 'dealerHand'
      .on 'endGame', =>
        console.log 'gameover'
        @newGame()
    
  makeGame: -> new Game (@get 'playerHand'), @get 'dealerHand'

  newGame: ->
    console.log 'new game!'
    deck = @get 'deck'
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
