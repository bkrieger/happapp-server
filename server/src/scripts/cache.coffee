redis  = require 'redis' 

exports.cache = 
    
    client: null

    init: ->
        @client = redis.createClient()
        @client.on 'error', (err) ->
            console.log 'Error: ' + err

    get: (key, callback) ->
        @client.get key, (err, reply) ->
            callback JSON.parse(reply)

    getMulti: (keys, callback) ->
        multi = @client.multi()
        for k in keys
            multi.get k
        multi.exec (err, reply) ->
            callback reply

    set: (key, value, duration) ->
        @client.setex key, duration, JSON.stringify(value)
