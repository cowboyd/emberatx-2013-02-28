$.fn.bindTo = ()->
$('.block').each ->
  interaction = Drag.Interaction.create element: this
  drag = interaction.get 'drag'
  $.bindTo drag,
    'start.x', '.start-x',
    'start.y', '.start-y',
  $('.offset').bindTo drag, 'delta'