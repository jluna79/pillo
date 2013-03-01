express = require 'express'
request = require 'request'
url = require 'url'

app = express()

#general
app.get '/', (req, response) ->
	response.send "Running..."

### basic testcases
###
app.get '/dashboard', (req, response) ->
	fieldList = [
		{id: 101, description : "Un campo", visible: true, status: 'new'}
		{id: 102, description : "Segundo campo", visible: false, status: 'new'}
		{id: 103, description : "Tercer campo", visible: true, status: 'seen'}
	]
	response.setHeader 'Access-Control-Allow-Origin', '*'
	response.setHeader 'Content-Type', 'application/json'
	response.send fieldList

# Listen!

app.listen(8080)
console.log 'The Pillo Node server: Listening on 8080...'