import { Vector2 } from './Vector2'
import { Triangle } from './Triangle'

export class Star
  constructor: (@pointCount, @pos, @hue, @lightness) ->
    step = Math.PI * 2 / @pointCount
    scale = new Vector2(10, 50)
    @triangles = (new Triangle(@pos, scale, i * step) for i in [0..@pointCount])

  isInside: (mousePos) ->
    @triangles.some (t) -> t.isInside(mousePos)

  getFillColor: ->
    "hsl(#{@hue}, 70%, #{@lightness}%)"

  draw: (ctx, fillStyle) ->
    ctx.fillStyle = @getFillColor()
    @triangles.forEach (t) -> t.draw(ctx)
