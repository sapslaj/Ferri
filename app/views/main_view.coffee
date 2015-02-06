require 'lib/view'

class MainView extends View
  keys: ['enter']

  execute: ->
    @game.display.drawText(1, 10, "wat")

  keyPress: (key) ->
    switch key
      when 'enter' then @game.switchView('Start')
