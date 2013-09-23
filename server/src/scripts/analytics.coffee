schedule   = require 'node-schedule'
hidden     = require './hidden'
{cache}    = require './cache'

exports.init = () ->
	rule = new schedule.RecurrenceRule()
	rule.hour = 5
	rule.minute = 0
	job = schedule.scheduleJob rule, () ->
		cache.info (val) ->
    		hidden.email val

exports.get_stats = (req, res) ->
	cache.info (val) ->
		res.send "<html><body><pre><code>#{val}</code></pre></body></html>"
