class Vector2
  constructor: (@x, @y) ->

class Triangle
  constructor: (@pos, @size, @fillStyle) ->

  draw: (ctx, matrix) ->
    ctx.fillStyle = @fillStyle
    ctx.beginPath()
    # равнобедренный треугольник с origin в основании медианы третьей стороны
    ctx.moveTo(@pos.x - @size.x / 2, @pos.y + @size.y)
    ctx.lineTo(@pos.x + @size.x / 2, @pos.y + @size.y)
    ctx.lineTo(@pos.x, @pos.y - @size.y)
    ctx.fill()

buildCanvas = (size) ->
  el = document.createElement('canvas')
  el.width = size.x
  el.height = size.y
  el.style.border = '1px solid #ccc'

  el: el
  ctx: el.getContext('2d')

bigCanvas = buildCanvas(new Vector2(600, 600))
smallCanvas = buildCanvas(new Vector2(600, 50))

container = document.getElementById('app')
container.appendChild(bigCanvas.el)
container.appendChild(smallCanvas.el)

t = new Triangle(new Vector2(100, 100), new Vector2(20, 50))
t.draw(bigCanvas.ctx)
