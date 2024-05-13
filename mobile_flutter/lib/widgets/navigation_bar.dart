/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_flutter/screens/Auth/login_screen.dart';
import 'package:mobile_flutter/screens/Auth/signup_screen.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
        height: 80,
        elevation: 0,
        //backgroundColor: Colors.white,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: (index) => controller.selectedIndex.value = index,
        
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.map_outlined), label: "MAps"),
          NavigationDestination(icon: Icon(Icons.route), label: "Routes"),
          NavigationDestination(icon: Icon(Icons.event), label: "Events"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const LoginScreen(), const SignupScreen(), const LoginScreen(), const LoginScreen(), const LoginScreen()];
}*/