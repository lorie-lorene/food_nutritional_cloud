import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_nutritional_cloud/components/chat_buble.dart';
import 'package:food_nutritional_cloud/components/my_text_field.dart';
import 'package:food_nutritional_cloud/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController= TextEditingController();
  final ChatService _chatService= ChatService();
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(
          widget.receiverUserID,
          _messageController.text);
      _messageController.clear();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail,
          style: TextStyle(
            fontWeight: FontWeight.bold, // Met le texte en gras
          ),
        ),
        backgroundColor: Colors.blue, // Fond de l'AppBar bleu
        centerTitle: true, // Centrer le titre
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
  Widget _buildMessageList(){
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text('Error${snapshot.error}');
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Text('Loading');
          }
          return ListView(
            children:snapshot.data!.docs
                  .map((document)=>_buildMessageItem(document))
              .toList(),
          );
        },
    );
  }



  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data=document.data() as Map<String,dynamic>;
    var alignment= (data['senderId']== _firebaseAuth.currentUser!.uid)?Alignment.centerRight:Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:  (data['senderId']== _firebaseAuth.currentUser!.uid)? CrossAxisAlignment.end: CrossAxisAlignment.start,
          mainAxisAlignment:  (data['senderId']== _firebaseAuth.currentUser!.uid)?MainAxisAlignment.end:MainAxisAlignment.start,
          children: [
            // Text(
            //     data['senderEmail']),
           const SizedBox(height: 5),
           ChatBuble( mesaage: data['message']),
          ],
        ),
      ),
    );
  }
  Widget _buildMessageInput(){
    return Row(
      children: [
        Expanded(child: MyTextField(controller: _messageController, obscureText: false, hintText: 'enter your message'
        ),
        ),
        IconButton(onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_circle_right_sharp,
              size: 40,
              color: Colors.blue,
            )),
        IconButton(onPressed: sendMessage,
            icon: const Icon(
              Icons.image,
              size: 40,
              color: Colors.blue,
            ))
      ],
    );
  }


}

//test pour upload l'image
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_nutritional_cloud/components/chat_buble.dart';
// import 'package:food_nutritional_cloud/components/my_text_field.dart';
// import 'package:food_nutritional_cloud/services/chat/chat_service.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // Importation du package image_picker
// import 'dart:io'; // Pour gérer les fichiers d'images
//
// class ChatPage extends StatefulWidget {
//   final String receiverUserEmail;
//   final String receiverUserID;
//   const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserID});
//
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final ImagePicker _picker = ImagePicker(); // Initialisation du ImagePicker
//   File? _imageFile,image; // Stocke l'image sélectionnée
//
//   // Fonction pour envoyer le message ou l'image
//   void sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       await _chatService.sendMessage(
//         widget.receiverUserID,
//         _messageController.text,
//         image: null, // Si aucun fichier image, passez null
//       );
//       _messageController.clear();
//     } else if (_imageFile != null) {
//       // Si une image est sélectionnée, l'envoyer
//       await _chatService.sendMessage(
//         widget.receiverUserID,
//         '', // Aucun texte, juste l'image
//         image: _imageFile, // Passer l'image ici
//       );
//       setState(() {
//         _imageFile = null; // Réinitialiser l'image après l'envoi
//       });
//     }
//   }
//
//   // Fonction pour sélectionner une image
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Choisir une image depuis la galerie
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path); // Stocker l'image sélectionnée
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.receiverUserEmail,
//           style: TextStyle(
//             fontWeight: FontWeight.bold, // Mettre le titre en gras
//           ),
//         ),
//         backgroundColor: Colors.blue, // Fond bleu de l'AppBar
//         centerTitle: true, // Centrer le titre
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _buildMessageList(),
//           ),
//           _buildMessageInput(),
//           const SizedBox(height: 25),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageList() {
//     return StreamBuilder(
//       stream: _chatService.getMessages(widget.receiverUserID, _firebaseAuth.currentUser!.uid),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text('Loading...');
//         }
//         return ListView(
//           children: snapshot.data!.docs
//               .map((document) => _buildMessageItem(document))
//               .toList(),
//         );
//       },
//     );
//   }
//
//   Widget _buildMessageItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//     var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;
//
//     return Container(
//       alignment: alignment,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
//               ? CrossAxisAlignment.end
//               : CrossAxisAlignment.start,
//           mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
//               ? MainAxisAlignment.end
//               : MainAxisAlignment.start,
//           children: [
//             const SizedBox(height: 5),
//             // Affichage du message
//             ChatBuble(mesaage: data['message']),
//             // Si un fichier image est envoyé, afficher l'image
//             if (data['imageUrl'] != null && data['imageUrl'].isNotEmpty)
//               Image.network(
//                 data['imageUrl'], // Vous devez envoyer l'URL de l'image
//                 width: 200,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMessageInput() {
//     return Row(
//       children: [
//         Expanded(
//           child: MyTextField(
//             controller: _messageController,
//             obscureText: false,
//             hintText: 'Enter your message',
//           ),
//         ),
//         IconButton(
//           onPressed: sendMessage,
//           icon: const Icon(
//             Icons.arrow_circle_right_sharp,
//             size: 40,
//             color: Colors.blue,
//           ),
//         ),
//         IconButton(
//           onPressed: _pickImage, // Appeler la fonction pour sélectionner une image
//           icon: const Icon(
//             Icons.image,
//             size: 40,
//             color: Colors.blue,
//           ),
//         ),
//       ],
//     );
//   }
// }
















