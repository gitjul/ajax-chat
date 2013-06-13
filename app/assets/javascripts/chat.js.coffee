$ ->
  lastId = 0

  $('[type=submit]').click (e) ->
    nick = $('[name=nick]').val()
    message = $('[name=message]').val()
    e.preventDefault()

    $.ajax
      url: 'http://localhost:3000/incoming'
      method: 'POST'
      data:
        nick: nick
        message: message
      dataType: 'json'

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
          timestamp.text(messageObject.created_at)

          nick = $("<span class='nick'></span>")
          nick.text(messageObject.nick)

          message = $("<span class='timestamp'></span>")
          message.text(messageObject.message)

          messageRow.append(timestamp)
          messageRow.append(nick)
          messageRow.append(message)

          $(".chat-window").append(messageRow)

          lastId = messageObject.id if messageObject.id > lastId 
  , 1000