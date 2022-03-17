import { Vector2 } from './Vector2'
import { Star } from './Star'

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

colors = [[0, 50], [240, 30], [120, 30], [60, 30], [0, 0]]
stars = (new Star(5, new Vector2(100 + i * 100, 100), hue, lightness) for [hue, lightness], i in colors)

stars.forEach (s) -> s.draw(bigCanvas.ctx)

bigCanvas.el.addEventListener 'mousedown', (e) ->
  rect = bigCanvas.el.getBoundingClientRect()
  mousePos = new Vector2(e.clientX - rect.left, e.clientY - rect.top)
  s = stars.find (s) -> s.isInside(mousePos)

  smallCanvas.ctx.fillStyle = if s then s.getFillColor() else 'white'
  smallCanvas.ctx.fillRect(0, 0, smallCanvas.el.width, smallCanvas.el.height)
