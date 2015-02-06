class MapCell
  constructor: (@x, @y, @type, @styling) ->
    @styling = stylingDefaults if @styling == undefined
    @updateAttributes()

  setType: (type, noUpdate) ->
    @type = type
    @updateAttributes() unless noUpdate

  updateAttributes: () ->
    @_coerceCellContent()
    @_coerceCellColor()
    @_coerceCellBg()

  isFree: ->
    return if @type == 'free'
      true
    else
      false

  _coerceCellContent: ->
    @content = if @styling.contentMapping.hasOwnProperty(@type)
      @styling.contentMapping[@type]
    else
      @styling.contentMapping.default

  _coerceCellColor: ->
    @color = if @styling.colorMapping.hasOwnProperty(@type)
      @styling.colorMapping[@type]
    else
      @styling.colorMapping.default

  _coerceCellBg: ->
    @bgcolor = if @styling.bgMapping.hasOwnProperty(@type)
      @styling.bgMapping[@type]
    else
      @styling.bgMapping.default
