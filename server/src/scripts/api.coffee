{resp} = require './response'
{cache} = require './cache'

# POST /moods
exports.post_mood = (req, res) ->
	q = req.query
	
	# incomplete request
	if !q.id || !q.msg || !q.tag || !q.duration
		resp.error res, resp.BAD
		return

	cache.set q.id, mood(q.id, q.msg, q.tag, new Date().getTime(), q.duration), q.duration

	resp.success res, 'ok'

# GET /moods
exports.get_mood = (req, res) ->
	numbers = req.query.n
	if !numbers
		resp.error res, resp.BAD
		return

	cache.getMulti numbers, (val) ->
		resp.success(res, val)

# GET /dummy
# populate redis with dummy data
exports.populate_dummy = (req, res) ->
	for [k, v, d] in dummy
		cache.set k, v, d 

	resp.success res, 'ok'

mood = (_number, _message, _tag, _timestamp, _duration) ->
	return {
		_id: _number
		message: _message
		tag: _tag
		timestamp: _timestamp
		duration: _duration
	}

dummy = [
	[6969696969, mood(6969696969, 'hello', 1, new Date().getTime(), 300), 300],
	[1234567890, mood(1234567890, 'hello', 1, new Date().getTime(), 300), 300],
	[4085553514, mood(4085553514, 'cool', 2, new Date().getTime(), 300), 300],
	[8885555512, mood(8885555512, 'bro', 3, new Date().getTime(), 300), 300],
	[5164584981, mood(5164584981, 'bro', 3, new Date().getTime(), 300), 300],
	[9737477052, mood(9737477052, 'What\'s going on', 4, new Date().getTime(), 300), 300],
	[2288617430, mood(2288617430, 'Let\'s get lunch?', 1, new Date().getTime(), 300), 300],
	[6095067689, mood(6095067689, 'How is everyone doing?', 4, new Date().getTime(), 300), 300],
	[5166607239, mood(5166607239, 'lolololol', 2, new Date().getTime(), 300), 300],
	[2166456142, mood(2166456142, 'What\'s good?', 1, new Date().getTime(), 1000), 1000],
	[2679946356, mood(2679946356, 'What\'s good?', 3, new Date().getTime(), 1), 1],
	[7044308567, mood(7044308567, 'What\'s good?', 5, new Date().getTime(), 60*60*3), 60*60*3],
	[6467852201, mood(6467852201, 'What\'s good?', 5, new Date().getTime(), 1), 1]

]