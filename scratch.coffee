Circle = Ember.Object.extend
  area: (->
    r = get 'r'
    Math.PI * r * r
  ).property('r')
c = Circle.create(r: 1)
c.get 'area' # => 3.141592653589793
c.set 'r', 2
c.get 'area' # => 


c = Circle.create(r: 1)
c.addObserver 'area', -> console.log "area changed to #{c.get 'area'}"
c.set 'r', 2
# area changed to 12.566370614359172
