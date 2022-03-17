import { Vector2 } from './Vector2'

export class Triangle
  # равнобедренный треугольник с origin в основании медианы третьей стороны
  @BASE_POINTS: [
    new Vector2(-1, 0),
    new Vector2(1, 0),
    new Vector2(0, -1),
  ]

  constructor: (@pos, @scale, @angle) ->
    @points = Triangle.BASE_POINTS.map((v) => v.scale(@scale).rotate(@angle).translate(@pos))

  draw: (ctx) ->
    ctx.beginPath()
    ctx.moveTo(@points[0].x, @points[0].y)
    ctx.lineTo(@points[1].x, @points[1].y)
    ctx.lineTo(@points[2].x, @points[2].y)
    ctx.fill()

  sign: (p1, p2, p3) ->
    (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y)

  isInside: (p) ->
    d1 = @sign(p, @points[0], @points[1])
    d2 = @sign(p, @points[1], @points[2])
    d3 = @sign(p, @points[2], @points[0])

    hasNeg = (d1 < 0) || (d2 < 0) || (d3 < 0)
    hasPos = (d1 > 0) || (d2 > 0) || (d3 > 0)

    !(hasNeg && hasPos)
