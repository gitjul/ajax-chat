$ ->
  lastId = 0
  chat_window = $('.chat-window')

  scrollDown = ->
    chat_height = chat_window[0].scrollHeight
    chat_window.scrollTop(chat_height)

  scrollDown()

  $('[type=submit]').click (e) ->
    nick = $('[name=nick]')
    message = $('[name=message]')
    e.preventDefault()

    $.ajax
      url: 'http://localhost:3000/incoming'
      method: 'POST'
      data:
        nick: nick.val()
        message: message.val()
      dataType: 'json'

    message.val('')

  setInterval ->
    $.ajax
      url: 'http://localhost:3000/outgoing'
      method: 'GET'
      dataType: 'json'
      data:
        last_id: lastId
      success: (data, status, xhr) ->
        for messageObject in data
          messageRow = $("<div class='message'></div>")
          timestamp = $("<span class='timestamp'></span>")
          timestamp.text(messageObject.time)

          nick = $("<span class='nick'></span>")
          nick.text(messageObject.nick)

          message = $("<span class='message-text'></span>")
          message.text(messageObject.message)

          messageRow.append(nick)
          messageRow.append(timestamp)
          messageRow.append(message)

          $(".chat-window").append(messageRow)
          scrollDown()

          lastId = messageObject.id if messageObject.id > lastId 
  , 1000
