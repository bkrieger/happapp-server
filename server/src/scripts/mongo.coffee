mongoose = require 'mongoose'

exports.mongo = 
    
    DailyCount: null
    currentDay: null

    init: ->
        mongoose.connect 'mongodb://localhost/stats'
        db = mongoose.connection
        db.on 'error', console.log 'Mongo connection error.'
        db.once 'open', () ->
            dailyCountSchema = mongoose.Schema({
                date: { type: Date, default: Date.now }
                count: { type: Number, default: 0 }
            })
            DailyCount = mongoose.model('DailyCount', dailyCountSchema)
            currentDay = new DailyCount
            currentDay.save (err, currentDay) ->
                if err
                    console.log 'MongoDB Error: ' + err

    incrementCurrentDay: ->
        if currentDay
            currentDay.count = currentDay.count + 1
            currentDay.save (err, currentDay) ->
                if err
                    console.log 'MongoDB Error: ' + err

    makeNewCurrentDay: ->
        currentDay = new DailyCount
        currentDay.save (err, currentDay) ->
            if err
                console.log 'MongoDB Error: ' + err
