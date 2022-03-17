export class Vector2
  constructor: (@x, @y) ->

  # https://en.wikipedia.org/wiki/Rotation_matrix
  rotate: (angle) ->
    c = Math.cos(angle)
    s = Math.sin(angle)

    new Vector2(
      @x * c - @y * s,
      @x * s + @y * c
    )

  translate: (v) -> new Vector2(@x + v.x, @y + v.y)
  scale: (v) -> new Vector2(@x * v.x, @y * v.y)
