import 'package:flutter/material.dart';
import 'package:manga_cap/data/db.dart';

class MangaForm extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    var _mangaNameController = TextEditingController(text: '');
    var _mangaNumberController = TextEditingController(text: '');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manga form',
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            fontSize: 22.0,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_mangaNameController.text.isNotEmpty &&
              _mangaNumberController.text.isNotEmpty) {
            Map<String, dynamic> row = {
              DatabaseHelper.columnName:
                  "${_mangaNameController.text[0].toUpperCase()}${_mangaNameController.text.substring(1)}",
              DatabaseHelper.columnCap: _mangaNumberController.text,
            };

            final id = await dbHelper.insert(row);
            print('Inserido a linha: $id');
            Navigator.pop(context, true);
          }
        },
        child: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _mangaNameController,
              style: TextStyle(
                color: Color(0xFFFFD748),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
              decoration: InputDecoration(
                hintText: 'Nome do Mangá',
                hintStyle: const TextStyle(
                  color: Color(0xFFFFD748),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                    color: Color(0xFFFFD748),
                  ),
                ),
              ),
              maxLines: 1,
            ),
            TextField(
              controller: _mangaNumberController,
              style: TextStyle(
                color: Color(0xFFFFD748),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
              decoration: InputDecoration(
                hintText: 'Número do cap',
                hintStyle: const TextStyle(
                  color: Color(0xFFFFD748),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                    color: Color(0xFFFFD748),
                  ),
                ),
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
