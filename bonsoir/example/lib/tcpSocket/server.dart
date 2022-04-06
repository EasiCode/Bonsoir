import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
//import 'package:bonsoir_example/models/app_service.dart';

Future<void> serverSide () async {
    // bind the socket server to an address and port
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 8000);

  // listen for connections from client(s)
  server.listen((client) {
    handleConnection(client);
  });
}

void handleConnection(Socket client) {
  print('Connection from'
      ' ${client.remoteAddress.address}:${client.remotePort}');

  // listen for events from the client
  client.listen(

    // handle data from the client
    (Uint8List data) async {
      await Future.delayed(Duration(seconds: 1));
      final message = String.fromCharCodes(data);
      if (message == 'Knock, knock.') {
        client.write('Who is there?');
      } else if (message.length < 10) {
        client.write('$message who?!');
      } else {
        client.write('Very funny.');
        client.close();
      }
    },

    // handle errors
    onError: (error) {
      print(error);
      client.close();
    },

    // handle the client closing the connection
    onDone: () {
      print('Client left');
      client.close();
    },
  );
}