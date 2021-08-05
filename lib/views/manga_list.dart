import 'package:flutter/material.dart';
import 'package:manga_cap/data/db.dart';
import 'package:manga_cap/views/manga_update.dart';

import 'manga_form.dart';

class MangaList extends StatefulWidget {
  @override
  _MangaListState createState() => _MangaListState();
}

class _MangaListState extends State<MangaList> {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var adicionar = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MangaForm();
              },
            ),
          );
          if (adicionar) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Lista de Mangás',
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            fontSize: 22.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<List<dynamic>>(
          future: dbHelper.queryAllRowsAlphabetically(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          tileColor: Color(0xFF5265E4),
                          onTap: () async {
                            var update = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MangaUpdate(
                                    id: snapshot.data[index]['_id'],
                                    mangaName: snapshot.data[index]['name'],
                                    mangaCap: snapshot.data[index]['cap'],
                                  );
                                },
                              ),
                            );
                            if (update) {
                              setState(() {});
                            }
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '${snapshot.data[index]['name']} - ${snapshot.data[index]['cap']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextButton(
                                child: Icon(Icons.delete, color: Colors.white),
                                onPressed: () async {
                                  final mangaDeletado = await dbHelper
                                      .delete(snapshot.data[index]['_id']);
                                  print('Deletado $mangaDeletado');
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text('Não há mangás...'),
                  );
          },
        ),
      ),
    );
  }
}
