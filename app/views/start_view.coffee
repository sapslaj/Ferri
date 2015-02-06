require 'lib/view'

class StartView extends View
  keys: ['enter']

  execute: ->
    @game.display.drawText(1, 10, "so this is lcs:ny")
    @game.display.drawText(1, 11, "press enter to continue")

  keyPress: (key) ->
    switch key
      when 'enter' then @game.switchView('Main')
