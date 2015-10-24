class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': ->
      @model.get('dealerHand').flip()
      @model.get('playerHand').stand()

    # event listener for end game,  render

  initialize: ->
    @render()
    @model.get 'dealerHand'
      .on 'endGame', =>
        console.log('endgame render')
        @render()
    # @get 'game'
    #   .on 'endGame', =>
    #     console.log 'gameover'
    #     @newGame()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  # renderonend ->
  #   append a button also append message bottom