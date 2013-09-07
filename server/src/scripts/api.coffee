{resp} = require './response'
{cache} = require './cache'

# POST /moods
exports.post_mood = (req, res) ->
    res.send null

# GET /moods
exports.get_mood = (req, res) ->
    cache.get 123, (val) ->
        resp.success(res, val)

# GET /test
exports.test = (req, res) ->
    obj = 
        name: 'Alex'
        mood: 'happy'
    cache.set 123, obj, 10
    cache.set 234, 'ok', 10
    resp.success res, 'ok'

exports.multi = (req, res) ->
    cache.getMulti [123, 234], (val) ->
        resp.success(res, val)