import 'package:socket_io_client/socket_io_client.dart' as IO;

class chatSocket {
  late IO.Socket socket;

  initSocket() {
    socket = IO.io('http://192.168.0.105:3000', <String, dynamic> {
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    //socket.onConnect((data) => print('Connected'));
    //socket.onDisconnect((data) => print('Disconnected'));
    //socket.onConnectError((data) => print('Connect Error: $data'));
    //socket.onError((data) => print('Error: $data'));
  }
}