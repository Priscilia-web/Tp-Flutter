import 'package:flutter/material.dart';
import 'package:tpascaline/services/firebase.dart';
import 'package:flutter/services.dart';
// Pour ajouter une animation de chargement si nécessaire.

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();

  void openDialogCode() async {
    final code = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Ton code',
            style: TextStyle(
              fontFamily: 'PixelifySans', // Utilisation de la nouvelle police
            ),
          ),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Mon code gojo SLLAAAY ',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('Cancel');
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'PixelifySans', // Utilisation de la nouvelle police
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                FirebaseService().createCode(_controller.text);
                Navigator.of(context).pop('OK');
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'PixelifySans', // Utilisation de la nouvelle police
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Code',
          style: TextStyle(
            fontFamily: 'PixelifySans', // Application de la nouvelle police
          ),
        ),
        backgroundColor: Colors.pinkAccent, // Couleur plus féminine
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialogCode();
        },
        tooltip: 'Add Code',
        backgroundColor: Colors.pink, // Couleur plus féminine pour le bouton
        child: const Icon(Icons.add),
      ), // FloatingActionButton
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseService().getCodes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.pink[50], // Couleur plus douce et féminine
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          snapshot.data!.docs[index]['code'],
                          style: const TextStyle(
                            fontFamily: 'PixelifySans', // Utilisation de la nouvelle police
                            color: Colors.black, // Couleur du texte
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // GIF de remerciement
          Center(
            child: Image.network(
              'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZGJsZWZzNHg4a3FldTZ3cTZ6aGlvbHNsNno1ZWtqbmJ2bmNydDh4dyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/fWfowxJtHySJ0SGCgN/giphy.gif',
              height: 200,
              width: 200,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Merci pour votre soutien !',
              style: TextStyle(
                fontFamily: 'PixelifySans', // Application de la nouvelle police
                fontSize: 18,
                color: Colors.pinkAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
