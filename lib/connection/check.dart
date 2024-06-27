import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sante_en_poche/connection/serviceConn.dart';
import 'package:sante_en_poche/main.dart';

class ConnectivityCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connectivity Check'),
      ),
      body: Center(
        child: GetBuilder<NetworkManager>(
          init: NetworkManager(),
          builder: (controller) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              bool connected = await controller.isConnected();
              if (connected) {
                Get.off(() => MainScreen());
              } else {
                Get.off(() => NoConnectionScreen());
              }
            });

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

