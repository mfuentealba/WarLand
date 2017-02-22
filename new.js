var net = require('net');

var fs = require("fs");

 

console.log("Going to write into existing file");

fs.writeFile('input.txt', 'Simply Easy Learning!',  function(err) {

   if (err) {

       return console.error(err);

   }

   console.log("Data written successfully!");

   console.log("Let's read newly written data");

   fs.readFile('input.txt', function (err, data) {

      if (err) {

         return console.error(err);

      }

      console.log("Asynchronous read: " + data.toString());

   });

});

/*

var arrSocket = {};

 

function newSocket(socket) {

 

                console.log('ingresando en newSocket');

               

               

}

 

 

function onConnect()

{

    console.log("Connected to Flash");

   

    

}

*/

 

function onClose(socket)

{

                console.log("ingresando en onClose");

                //console.log(socket);

                closeSocket(socket);

}

 

 

 

function closeSocket(socket) {

                console.log('ingresando en closeSocket');//53820010

               

                              

               

               

}

 

 

 

function newSocket(socket) {

 

                console.log('ingresando en newSocket');

                socket.on("close", function(){

                               onClose(socket);

                });

               

               

                socket.on('end', function() {

                               closeSocket(socket);

                })

                socket.setTimeout(10000, function(ev){

                               console.log(socket);
								socket.write('OK|', 'utf8');
                               /*fs.writeFile('input.txt', socket,  function(err) {

                                               if (err) {

                                                  return console.error(err);

                                               }

                               });*/

                               console.log("********************************************");

                              // socket.destroy();

                               console.log(socket);

                               /*fs.writeFile('input.txt', console.log(socket),  function(err) {

                                               if (err) {

                                                  return console.error(err);

                                               }

                               });*/

               

                })

               

}

 

var server = net.createServer(newSocket);

 

server.listen(9003);