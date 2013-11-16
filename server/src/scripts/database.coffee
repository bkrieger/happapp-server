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
        connection.query "INSERT INTO users (phone_number, os, pn_token) VALUES ('#{phone_number}', #{os}, '#{pn_token}')", (err, result) ->
            connection.end()
            if err
                console.log("SQL INSERT Error")
                console.log(err)
                callback(err)
            else
                console.log("SQL INSERT success")
                callback()

    get_device: (phone_number, callback) ->
        connection = @create()
        connection.query "SELECT * FROM users WHERE phone_number = #{phone_number}", (err, result) ->
            if err
                console.log("SQL SELECT error")
            else
                console.log("SQL SELECT success")
                callback result