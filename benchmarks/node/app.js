var express = require('express');
var app = express();
app.get('/benchmark', function(req, res){
  res.send('Hello ' + req);
});
var server = app.listen(8081, function() {
  console.log('Listening on port %d', server.address().port);
});
