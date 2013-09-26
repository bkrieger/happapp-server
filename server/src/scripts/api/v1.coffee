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

# GET /dummy
# populate redis with dummy data
exports.populate_dummy = (req, res) ->

	contacts = {
		"5164584981": 1
		"2679946356": 1
		"6467852201": 1
	}
	
	dummy = [
		["6969696969", mood("6969696969", 'hello!', 1, contacts, new Date().getTime(), 300), 300],
		["1234567890", mood("1234567890", 'come over to my place', 1, contacts, new Date().getTime(), 600), 600]
		["4085553514", mood("4085553514", 'food?', 2, contacts, new Date().getTime(), 1000), 1000],
		["8885555512", mood("8885555512", 'Lets see a movie', 3, contacts, new Date().getTime(), 1400), 1400],
		["5164584981", mood("5164584981", 'Hey guys, movie?', 3, contacts, new Date().getTime(), 1800), 1800],
		["9737477052", mood("9737477052", 'Whats going on', 4, contacts, new Date().getTime(), 2100), 2100],
		["7044308567", mood("7044308567", 'Anyone down for Chipotle?', 2, contacts, new Date().getTime(), 2500), 2500],
		["2288617430", mood("2288617430", 'in the mood for Bobbys', 2, contacts, new Date().getTime(), 3500), 3500],
		["6095067689", mood("6095067689", 'Anyone want to go out tonite?', 4, contacts, new Date().getTime(), 3700), 3700],
		["5166607239", mood("5166607239", 'Gym time?', 5, contacts, new Date().getTime(), 4000), 4000],
		["2678477385", mood("2678477385", 'Im feeling a movie, not sure which one.', 3, contacts, new Date().getTime(), 2700), 2700],
		["6154794880", mood("6154794880", 'Soccer anyone?', 5, contacts, new Date().getTime(), 3100), 3100]
	]

	for [k, v, d] in dummy
		cache.set k, v, d 

	resp.success res, 'ok'


mood = (_number, _message, _tag, _contacts, _timestamp, _duration) ->
	return {
		_id: _number
		message: _message
		tag: _tag
		contacts: _contacts
		timestamp: _timestamp
		duration: _duration
	}

