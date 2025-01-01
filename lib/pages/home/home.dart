import 'package:flutter/material.dart';
import 'package:food_nutritional_cloud/pages/home/widgets/category.dart';
import 'package:food_nutritional_cloud/pages/home/widgets/header.dart';
import 'package:food_nutritional_cloud/pages/home/widgets/home_Page.dart';
import 'package:food_nutritional_cloud/pages/home/widgets/imc_screen.dart';
import 'package:food_nutritional_cloud/pages/home/widgets/search.dart';
import 'package:provider/provider.dart';

import '../../services/auth/auth_service.dart';
import '../detail/widgets/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Indice pour déterminer quelle page afficher

  // // Liste des pages avec la page chat correctement assignée à l'index approprié
  // final List<Widget> _pages = [
  //   HomePage(),      // Page d'accueil
  //   const ImcScreen(),      // Page IMC
  //   HomePage(),      // Page FoodCloud
  //   const HomePage2(), // Page Chat (correspond à la page HomePage2)
  //   // Autres pages ici
  // ];

  // Méthode de changement de page en fonction de l'index sélectionné
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Change l'index de la page à afficher
    });

    // Si l'utilisateur appuie sur le bouton "logout"
    if (index == 4) {  // Supposons que l'index 4 est celui du bouton logout
      signOut();
    }
  }

  // Méthode de déconnexion
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
    print("Déconnexion effectuée");
  }

  // Fonction pour retourner la page en fonction de l'index
  Widget _page(int index) {
    switch (index) {
      case 0:
        return SingleChildScrollView(
          child: Stack(
            children: [
              Transform(
                transform: Matrix4.identity()..rotateZ(20),
                origin: const Offset(150, 50),
                child: Image.asset(
                  'assets/images/bg_liquid.png',
                  width: 200,
                ),
              ),
              Positioned(
                right: 0,
                top: 200,
                child: Transform(
                  transform: Matrix4.identity()..rotateZ(20),
                  origin: const Offset(180, 100),
                  child: Image.asset(
                    'assets/images/bg_liquid.png',
                    width: 200,
                  ),
                ),
              ),
              Column(
                children: [
                  const HeaderSection(),
                  const SearchSection(),
                  CategorySection(),
                ],
              ),
            ],
          ),
        );
      case 1:
        return const ImcScreen(); // Page IMC
      case 2:
        return const HomePage(); // Page FoodCloud
      case 3:
        return const HomePage2(); // Page Chat
      default:
        return const HomePage(); // Par défaut, la page d'accueil
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5F67EA),
      body: _page(_currentIndex), // Utiliser la fonction _page pour afficher la page active
      bottomNavigationBar: NavigationBar(onItemTapped: _onItemTapped), // Passer la méthode de callback
    );
  }

  // La barre de navigation en bas
  Widget NavigationBar({required Function(int) onItemTapped}) {
    return Container(
      color: const Color(0xfff6f8ff),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: const Color(0xFF5F67EA),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            unselectedItemColor: Colors.grey.withOpacity(0.7),
            type: BottomNavigationBarType.fixed,
            onTap: onItemTapped,  // Assigner la fonction de changement de page
            items: [
              const BottomNavigationBarItem(
                label: 'home',
                icon: Icon(
                  Icons.home_rounded,
                  size: 50,
                ),
              ),
              BottomNavigationBarItem(
                label: "IMC",
                icon: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.balance_rounded,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "FoodCloud",
                icon: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.fastfood_rounded,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "Chat",
                icon: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.mark_chat_unread_sharp,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "logout",
                icon: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
