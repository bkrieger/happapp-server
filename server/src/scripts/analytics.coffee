schedule   = require 'node-schedule'
utils     = require './utils'
{cache}    = require './cache'

exports.init = () ->
	rule = new schedule.RecurrenceRule()
	rule.hour = 4
	rule.minute = 0
	job = schedule.scheduleJob rule, () ->
		cache.info (val) ->
    		utils.email "Daily Happ Update", val

exports.get_stats = (req, res) ->
	cache.info (val) ->
		res.render 'stats', {title: "Stats", stats: val}
