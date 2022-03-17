class Vector2
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

class Triangle
  # равнобедренный треугольник с origin в основании медианы третьей стороны
  @BASE_POINTS: [
    new Vector2(-1, 0),
    new Vector2(1, 0),
    new Vector2(0, -1),
  ]

  constructor: (@pos, @scale, @fillStyle) ->

  draw: (ctx, angle) ->
    points = Triangle.BASE_POINTS.map((v) => v.scale(@scale).rotate(angle).translate(@pos))

    ctx.fillStyle = @fillStyle
    ctx.beginPath()
    ctx.moveTo(points[0].x, points[0].y)
    ctx.lineTo(points[1].x, points[1].y)
    ctx.lineTo(points[2].x, points[2].y)
    ctx.fill()

buildCanvas = (size) ->
  el = document.createElement('canvas')
  el.width = size.x
  el.height = size.y
  el.style.border = '1px solid #ccc'
  el.style.display = 'block'
  el.style.margin = '10px'

  el: el
  ctx: el.getContext('2d')

bigCanvas = buildCanvas(new Vector2(600, 600))
smallCanvas = buildCanvas(new Vector2(600, 50))

container = document.getElementById('app')
container.appendChild(bigCanvas.el)
container.appendChild(smallCanvas.el)

t = new Triangle(new Vector2(100, 100), new Vector2(10, 50))
angle = 0

animate = () ->
  bigCanvas.ctx.clearRect(0, 0, bigCanvas.el.width, bigCanvas.el.height)
  count = 5
  step = Math.PI * 2 / count
  t.draw(bigCanvas.ctx, i * step + angle) for i in [0..count]
  angle += 0.05
  requestAnimationFrame animate

requestAnimationFrame animate
