{conf}   = require './stealth/conf'
mysql    = require 'mysql'

exports.database =

    create: ->
        return mysql.createConnection({
            host : conf.sql.host,
            user : conf.sql.user,
            password : conf.sql.password,
            database : conf.sql.db_name
        })

    put_device: (phone_number, os, pn_token, callback) ->
        connection = @create()
        connection.query "INSERT INTO users (phone_number, os, pn_token) VALUES (?,?,?)", phone_number, os, pn_token, (err, result) ->
            connection.end()
            if err
                console.log("SQL INSERT Error")
                console.log(err)
                callback(err)
            else
                callback()

    #phone_numbers is an array of strings representing phone numbers
    get_devices: (phone_numbers, callback) ->
        connection = @create()
        connection.query "SELECT * FROM users WHERE phone_number in(#{connection.escape(phone_numbers)})", (err, result) ->
            if err
                console.log("SQL SELECT error")
                console.log(err)
            else
                # result is an array of js objects, one for each row returned
                callback result