import 'package:flutter/material.dart';
import 'package:manga_cap/data/db.dart';

class MangaUpdate extends StatefulWidget {
  final int id;
  final String mangaName;
  final int mangaCap;

  const MangaUpdate({Key key, this.id, this.mangaName, this.mangaCap})
      : super(key: key);

  @override
  _MangaUpdateState createState() => _MangaUpdateState();
}

class _MangaUpdateState extends State<MangaUpdate> {
  var _mangaNameController;
  var _mangaId;
  var _mangaNumberController;

  @override
  void initState() {
    _mangaNameController = TextEditingController(text: widget.mangaName);

    _mangaNumberController =
        TextEditingController(text: widget.mangaCap.toString());
    _mangaId = widget.id;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar mangá'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_mangaNameController.text.isNotEmpty &&
              _mangaNumberController.text.isNotEmpty) {
            Map<String, dynamic> row = {
              DatabaseHelper.columnId: _mangaId,
              DatabaseHelper.columnName:
                  "${_mangaNameController.text[0].toUpperCase()}${_mangaNameController.text.substring(1)}",
              DatabaseHelper.columnCap: _mangaNumberController.text,
            };

            final updateManga = await DatabaseHelper.instance.update(row);
            print('Inserido a linha: $updateManga');
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
