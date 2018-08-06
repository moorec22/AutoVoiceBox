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
        $('#phrase_input').val("")
        phrase_setup()
      error: ->
        console.log('error')

  save_category = (category_name) ->
    $.ajax
      url: '/category'
      type: 'POST'
      data : {'name': category_name}
      success: (data, status, response) ->
        left = $("#category_column_left")
        right = $("#category_column_right")
        if (left.children().size() <= right.children().size())
          left.append(response.responseText)
        else
          right.append(response.responseText)
        category_setup()
        $("#new_category_input").val("")
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

  update_category = (phrase_id, category_id, on_success) ->
    $.ajax
      url: '/phrase'
      type: 'UPDATE'
      data: {'type': 'CATEGORY', 'phrase_id': phrase_id, 'category_id': category_id}
      success: (data, status, response) ->
        on_success()
      error: ->
        console.log('error')

  delete_category = (category_id) ->
    $.ajax
      url: '/category'
      type: 'DELETE'
      data: {category_id: category_id}
      success: (data, status, response) ->
        $("[category_id='" + category_id + "']").remove()
      error: ->
        console.log('error')


  allowDrop = (event) ->
    event.preventDefault()

  drag = (event) ->
    event.dataTransfer.setData("phrase", event.target.id)

  getParentCategoryBox = (element) ->
    while (element && !element.classList.contains('category_box'))
      element = element.parentNode
    return element

  drop = (event) ->
    event.preventDefault()
    id = event.dataTransfer.getData("phrase")
    phrase = document.getElementById(id)
    phrase_id = phrase.getAttribute("phrase_id")
    box = getParentCategoryBox(event.target)
    category_id = box.getAttribute('category_id')
    on_success = ->
      box.appendChild(phrase)
    if phrase_id
      update_category(phrase_id, category_id, on_success)
    else

  $('#say').click ->
    say($('#phrase_input').val())

  $('#save').click ->
    input = $('#phrase_input').val()
    if input
      save(input)

  phrase_setup = ->
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
  
    $(".category_delete").click ->
      delete_category(this.getAttribute('category_id'))

  $("#new_category_button").click ->
    input = $("#new_category_input").val()
    if input
      save_category(input)


  phrase_setup()
  category_setup()

