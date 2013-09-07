{resp} = require './response'
{cache} = require './cache'

# POST /moods
exports.post_mood = (req, res) ->
	q = req.query
	
	# incomplete request
	if !q.id || !q.msg || !q.tags || !q.timestamp || !q.duration
		resp.error res, resp.BAD
		return

	cache.set q.id, mood(q.id, q.msg, q.tags, q.timestamp, q.duration), q.duration

	resp.success res, 'ok'

# GET /moods
exports.get_mood = (req, res) ->
	numbers = req.query.n
	cache.getMulti numbers, (val) ->
		resp.success(res, val)

# GET /dummy
# populate redis with dummy data
exports.populate_dummy = (req, res) ->
	for [k, v, d] in dummy
		cache.set k, v, d 

	resp.success res, 'ok'

mood = (_number, _message, _tags, _timestamp, _duration) ->
	return {
		_id: _number
		message: _message
		tags: _tags
		timestamp: _timestamp
		duration: _duration
	}

dummy = [
	[6969696969, mood(6969696969, 'hello', 'going out', new Date(), 30), 30],
	[1234567890, mood(1234567890, 'hello', 'going out', new Date(), 30), 30]
]