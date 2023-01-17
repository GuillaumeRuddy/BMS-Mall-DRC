import 'package:flutter/material.dart';
import 'package:mall_drc/app/endPoint.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketController with ChangeNotifier {
  Socket? socket;
  Map status_data = {};

  connection() {
    socket = io("${ApiUrl().urlUniPesa}",
        OptionBuilder().setTransports(['websocket']).build());

    socket?.onConnect((data) {
      print('Connexion au serveur etablie');
    });

    socket?.on('updateVenteNotif', (data) {
      print(data.runtimeType);
      print("data socket reçu $data");
      status_data = data;
      notifyListeners();
    });
  }

  envoyer(qrcode_data, token_user) {
    Map data = {"session": qrcode_data, "token": token_user};
    socket?.emit("checkSession", data);
  }

  deconnecter() {
    socket?.disconnect();
  }
}
