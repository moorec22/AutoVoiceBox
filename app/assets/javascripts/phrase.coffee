# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
# TODO: Make more methods that return this stuff from AJAX

$ ->
  say = (phrase) ->
    $.ajax
      url: '/speech'
      type: 'POST'
      data : {'phrase': phrase}
      success: (data, status, response) ->
      error: ->
        console.log('error')

  save = (phrase) ->
    $.ajax
      url: '/phrase'
      type: 'POST'
      data : {'phrase': phrase}
      success: (data, status, response) ->
        $('#phrase_queue').append(response.responseText)
        $('#phrase_queue').append('<br />')
        phrase_setup()
      error: ->
        console.log('error')

  save_category = (category_name) ->
    $.ajax
      url: '/category'
      type: 'POST'
      data : {'name': category_name}
      success: (data, status, response) ->
      error: ->
        console.log('error')

  destroy = (phrase_id) ->
    $.ajax
      url: '/phrase'
      type: 'DELETE'
      data: {'phrase_id': phrase_id}
      success: (data, status,response) ->
        $("[phrase_id='" + phrase_id + "']").remove()
      error: ->
        console.log('error')

  update_category = (phrase_id, category_id) ->
    $.ajax
      url: '/phrase'
      type: 'UPDATE'
      data: {'type': 'CATEGORY', 'phrase_id': phrase_id, 'category_id': category_id}
      success: (data, status,response) ->
      error: ->
        console.log('error')

  delete_category = (category_id) ->
    $.ajax
      url: '/category'
      type: 'DELETE'
      data: {category_id: category_id}
      success: (data, status, response) ->
      error: ->
        console.log('error')


  allowDrop = (event) ->
    event.preventDefault()

  drag = (event) ->
    event.dataTransfer.setData("phrase", event.target.id)

  drop = (event) ->
    event.preventDefault()
    id = event.dataTransfer.getData("phrase")
    phrase = document.getElementById(id)
    phrase_id = phrase.getAttribute("phrase_id")
    category_id = event.target.getAttribute('category_id')
    if phrase_id
      update_category(phrase_id, category_id)
    else

  phrase_setup = ->
    $('#say').click ->
      say($('#phrase_input').val())

    $('#save').click ->
      save($('#phrase_input').val())

    $(".phrase_say").click ->
      say(this.getAttribute('text'))

    $(".phrase_delete").click ->
      destroy(this.getAttribute('phrase_id'))

    $(".phrase_box").on('dragstart', ->
      drag(event)
    )

  category_setup = ->
    $(".category_box").on('dragover', ->
      allowDrop(event)
    )

    $(".category_box").on('drop', ->
      drop(event)
    )

    $("#new_category_button").click ->
      save_category($("#new_category_input").val())

    $(".category_delete").click ->
      delete_category(this.getAttribute('category_id'))

  phrase_setup()
  category_setup()
