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

  save = (phrase, category_id) ->
    $.ajax
      url: '/phrase'
      type: 'POST'
      data : {'phrase': phrase, 'category_id': category_id}
      success: (data, status, response) ->
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
      error: ->
        console.log('error')

  update_category = (phrase_id, category_id, on_success) ->
    $.ajax
      url: '/phrase'
      type: 'UPDATE'
      data: {'type': 'CATEGORY', 'phrase_id': phrase_id, 'category_id': category_id}
      success: (data, status,response) ->
        on_success()
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
    on_success = ->
      event.target.appendChild(phrase)
    if phrase_id
      update_category(phrase_id, category_id, on_success)
    else



  $('#say').click ->
    phrase = $('#phrase_input').val()
    say(phrase)
    phraseQueue = document.getElementById('phrase_queue')
    newPhrase = document.createElement('div')
    newPhrase.classList.add('phrase_new')
    newPhrase.classList.add('box')
    newPhrase.classList.add('phrase_box')
    newPhrase.draggable = 'true'
    newPhrase.innerHTML = phrase

    sayButton = document.createElement('input')
    sayButton.classList.add('phrase_say')
    sayButton.text = phrase
    sayButton.type = 'submit'
    sayButton.value = "Say"
    sayButton.onclick = -> say(phrase)
    newPhrase.append(sayButton)

    phraseQueue.append(newPhrase)

  $('#save').click ->
    save($('#phrase_input').val())

  $(".phrase_say").click ->
    say(this.getAttribute('text'))

  $(".phrase_delete").click ->
    destroy(this.getAttribute('phrase_id'))

  $(".phrase_box").on('dragstart', ->
    drag(event)
  )

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
