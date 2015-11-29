// db.js
var mysql = require("mysql");

var Db = function(host, username, password, database)
{
    var connection =  mysql.createConnection(
    {
    	host: host,
    	user: username,
    	password: password,
      database: database
    });


    this.query = function(query)
    {
      var result;
      connection.query(query, function(err, rows)
      {
        if(err)
        {
          console.log(err);
          result = "NULL";
        }
        else
        {
          result = rows;
        }
      });

      return result;
    }

  this.testStuff = function(personId) {
     var query = "SELECT * FROM Person";
     connection.query(query, function(err, rows) {
       if(err) {
         console.log(err);
         return NULL;
       }
       console.log("HELLO");
       for(i = 0; i < rows.length; i++) {
         console.log(rows[i]);
       }
     });
   }

   this.testStuff(1);

   return
   {
       connection: connection
   }
};

exports.Db = Db;
