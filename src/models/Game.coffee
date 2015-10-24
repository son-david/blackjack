class window.Game extends Backbone.Model
  
  initialize: (@playerHand, @dealerHand) ->
    @playerHand.on 'add', => @bustCheck(@playerHand)
    @dealerHand.on 'add', => @bustCheck(@dealerHand)

  comparison: ->
    playerScore = @playerHand.scores()
    dealerScore = @dealerHand.scores()
   
    playerScore = @highScore(playerScore)

    dealerScore = @highScore(dealerScore)

    if dealerScore >= playerScore
      console.log('dealer wins!')
      @dealerHand.endGame()
    else
      console.log('player wins!')
      @playerHand.endGame()
    #for i in playerScore

  bustCheck: (hand) ->
    # if @playerHand or @dealerHand adds, bustCheck
      score = hand.scores()
      if score[0] > 21
        busted = true
      if score[1] > 21
        busted = true
      console.log('busted') if busted == true
      hand.endGame() if busted == true
    #@collection.on 'add remove change', => @render()
    # if score > 21 that player busted.
    # send alert, end the game

  gameLogic: ->
    # hit if score < 16 and return call to gameLogic
    if @highScore(@dealerHand.scores()) < 17
      @dealerHand.hit()
      @gameLogic()
    # stand and end turn if >= 17
    # run comparison
    else
      @comparison()

  highScore: (array) ->
    if array[0] < array[1]
      result = array[1]
    else
      result = array[0]
    return result
