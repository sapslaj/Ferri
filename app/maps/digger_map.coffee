require 'lib/map'

class DiggerMap extends Map
  _generate: ->
    @_create new ROT.Map.Digger()
