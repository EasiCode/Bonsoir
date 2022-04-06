import 'package:flutter/material.dart';
//import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:typed_data';
import 'dart:io';

 Future<void> clientSide () async {

   // connect to the socket server
      final socket = await Socket.connect('192.168.0.105', 8000);
      print(
          'Connected to Server: ${socket.remoteAddress.address}:${socket.remotePort}');

      // listen for responses from the server
      socket.listen(
        // handle data from the server
        (Uint8List data) {
          final serverResponse = String.fromCharCodes(data);
          print('Samsung Note 10: $serverResponse');
        },

        // handle errors
        onError: (_) {
          print('Connection Error: $_');
          socket.destroy();
        },

        // handle server ending connection
        onDone: () {
          print('Server left.');
          socket.destroy();
        },
      );
      // send some messages to the server
  await sendMessage(socket, 'Knock, knock.');
  await sendMessage(socket, 'client');
  await sendMessage(socket, 'client');
  await sendMessage(socket, 'Banana');
  await sendMessage(socket, 'Banana');
  await sendMessage(socket, 'Banana');
  /* await sendMessage(socket, 'Orange');
  await sendMessage(socket, "Orange you glad I didn't say banana again?"); */
}

Future<void> sendMessage(Socket socket, String message) async {
  print('Client: $message');
  socket.write(message);
  await Future.delayed(Duration(seconds: 2));
}

