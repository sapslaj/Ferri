class View
  constructor: (@game) ->
    @_bindKeys(@keys)
    @execute()

  deconstruct: ->
    @_unbindKeys(@keys)

  _bindKeys: (keys) ->
    self = @
    for k in keys
      key k, ->
        self.keyPress(k)

  _unbindKeys: (keys) ->
    for k in keys
      key.unbind k
