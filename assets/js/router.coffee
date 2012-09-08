define (require)->

  Backbone = require('backbone')

  class Router extends Backbone.Router
    routes:
      "": "index"


    index: ->
      HelloView = require 'views/hello'
      view = new HelloView
      $('body').html view.render().el
