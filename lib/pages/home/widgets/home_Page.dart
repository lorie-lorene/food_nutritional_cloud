import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_nutritional_cloud/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../../detail/widgets/chat_page.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Définir la hauteur de l'AppBar
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), // Coins arrondis à gauche
            bottomRight: Radius.circular(30), // Coins arrondis à droite
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent], // Dégradé bleu
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: AppBar(
              title: Text(
                "Messenger",
                style: TextStyle(
                  color: Colors.white, // Titre en blanc
                  fontWeight: FontWeight.bold, // Titre en gras
                ),
              ),
              centerTitle: true, // Centrer le titre
              backgroundColor: Colors.transparent, // Rendre l'AppBar transparente
              elevation: 0, // Supprimer l'ombre de l'AppBar
            ),
          ),
        ),
      ),
      body: _buildUserList(),
    );
  }
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return Container(
          color: Colors.white38, // Fond bleu
          child: ListView(
            children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Ne pas afficher l'utilisateur connecté
    if (_firebaseAuth.currentUser!.email != data['email']) {
      return Column(
        children: [
          ListTile(
            title: Text(
              data['email'],
              style: TextStyle(color: Colors.black,), // Texte en blanc
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverUserEmail: data['email'],
                    receiverUserID: data['uid'],
                  ),
                ),
              );
            },
          ),
          Divider(color: Colors.black), // Ligne noire pour séparer
        ],
      );
    } else {
      return Container();
    }
  }
}
