//host.js
var util = require("util"),
    io = require("socket.io"),
    mysql = require("mysql"),
    Db = require("./db.js").Db;

//Lets require/import the HTTP module
var http = require('http');

const PORT = 8080,
      DB_HOST = "mysql.cis.ksu.edu";
      DB_USERNAME = "wjbaldwi";
      DB_PASSWORD = "PRBYC94uBrzMKECM"
      DB_NAME = "wjbaldwi";

// //We need a function which handles requests and send response
// function handleRequest(request, response){
//     response.end('It Works!! Path Hit: ' + request.url);
// }
//
// //Create a server
// var server = http.createServer(handleRequest);
//
// //Lets start our server
// server.listen(PORT, function()
// {
//     //Callback triggered when server is successfully listening. Hurray!
//     console.log("Server listening on: http://localhost:%s", PORT);
// });

var socket;
// var dbConnection;
var db;

function init()
{
  console.log("Initializing...");

  console.log("Connecting to db...");
  db = new Db(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);
  console.log("Db connection complete.")

  console.log("Initialization complete.");
  socket = io.listen(PORT);
  console.log("Listening on port " + PORT);
  console.log("=======================");
  db.testStuff("1");
  // console.log(Db);
  console.log(db.query("select * from Person"));

  // setEventHandlers();
}

init();
