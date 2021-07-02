import 'package:flutter/material.dart';
import 'package:pts/Constant.dart';
import 'package:pts/Model/components/back_appbar.dart';
import 'package:pts/Model/services/firestore_service.dart';
import 'package:pts/Model/soiree.dart';
import 'package:pts/View/Pages/creation/components/headertext_one.dart';
import 'package:pts/View/Pages/creation/end_page.dart';

class DescriptionPage extends StatefulWidget {
  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  String _description = "";
  final db = FireStoreServices("party");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FORMBACKGROUNDCOLOR,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: BackAppBar(),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Soiree.setDataDescriptionPage(_description);

            await db.add(
              data: {
                'Name': Soiree.nom,
                'Theme': Soiree.theme,
                'Date': Soiree.date,
                'Hour': Soiree.heure.format(context),
                'Number': Soiree.nombre,
                'Price': Soiree.prix,
                'Description': Soiree.description,
                'adress': Soiree.adresse,
                'city': Soiree.ville,
                'postal code': Soiree.codepostal
              },
            );
            Navigator.push(context, 
              MaterialPageRoute(builder: (context) => EndPage())
            );
          },
          backgroundColor: SECONDARY_COLOR,
          elevation: 0,
          label: Text(
            'Publier la soirée',
            style: TextStyle(
              fontSize: 15
            ),
          )
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderText1(
              text: "Un mot à ajouter pour décrire votre soirée ?",
            ),
            Center(
              child: Container(
                height: 226,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR, 
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    onChanged: (value) {
                      _description = value;
                    },
                    style: TextStyle(
                      fontSize: TEXTFIELDFONTSIZE,
                    ),
                    maxLength: 500,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'ex: Ambiance boîte de nuit !!',
                      border: InputBorder.none,
                      counterStyle: TextStyle(  
                        height: 1
                      )
                    )
                  ),
                ),
              ),
            ),
          ]
        )
      ),
    );
  }
}
