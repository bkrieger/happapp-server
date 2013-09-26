{resp} = require '../response'
{cache} = require '../cache'

# POST /moods
exports.post_mood = (req, res) ->
	q = req.query
	
	# incomplete request
	if !q.id || !q.msg || !q.tag || !q.n || !q.duration
		resp.error res, resp.BAD
		return

	contacts = {};
	for number in q.n
	    contacts[number] = 1;

	cache.set q.id, mood(q.id, q.msg, q.tag, contacts, new Date().getTime(), q.duration), q.duration

	resp.success res, 'ok'

# GET /moods
exports.get_mood = (req, res) ->
	me = req.query.me
	numbers = req.query.n

	if !numbers || !me
		resp.error res, resp.BAD
		return

	numbers.push(me)

	cache.getMulti numbers, (val) ->
		# apply sorting here
		out =
			me: {}
			contacts: val

		i = 0
		while i < val.length
			v = val[i]
			if v._id == me
				val.splice(i, 1)
				delete v.contacts
				out.me = v
			else if !v.contacts.hasOwnProperty me
				val.splice(i, 1)
			else
				delete v.contacts
				i += 1

		out.contacts.sort (a, b) ->
			b.timestamp - a.timestamp

		resp.success(res, out)

mood = (_number, _message, _tag, _contacts, _timestamp, _duration) ->
	return {
		_id: _number
		message: _message
		tag: _tag
		contacts: _contacts
		timestamp: _timestamp
		duration: _duration
	}

