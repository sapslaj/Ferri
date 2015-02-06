class MapLayer
  constructor: () ->
    @cells = []

  indexOf: (x, y) ->
    @cells.indexOf(@at(x, y))

  at: (x, y) ->
    for cell in @cells
      if cell.x == x and cell.y == y
        return cell

  addCell: (x, y, type) ->
    if y == undefined
      @cells.push x
    else
      @cells.push(new MapCell(x, y, type))

  updateCells: ->
    for cell in @cells
      cell.updateAttributes()
