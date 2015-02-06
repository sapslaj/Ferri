class MapCell
  constructor: (@x, @y, @type) ->
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

  contentMapping:
    wall: ' '
    free: '.'
    player: '@'
    default: '#'
    conservative: 'C'

  colorMapping:
    player: '#0f0'
    conservative: '#f00'
    default: '#fff'
    free: '#ddd'

  bgMapping:
    default: '#000'

  _coerceCellContent: ->
    @content = if @contentMapping.hasOwnProperty(@type)
      @contentMapping[@type]
    else
      @contentMapping.default

  _coerceCellColor: ->
    @color = if @colorMapping.hasOwnProperty(@type)
      @colorMapping[@type]
    else
      @colorMapping.default

  _coerceCellBg: ->
    @bgcolor = if @bgMapping.hasOwnProperty(@type)
      @bgMapping[@type]
    else
      @bgMapping.default
