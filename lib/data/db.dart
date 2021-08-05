import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // Informações do banco
  static final _databaseName = "MangaDB.db";
  static final _databaseVersion = 1;

  //Tabela
  static final table = 'mangaCap';

  //Colunas
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnCap = 'cap';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //Iniciando o banco de dados
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //Abertura da base de dados
  _initDatabase() async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String path = join(diretorio.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //SQL para criação de tabelas
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnCap INTEGER NOT NULL
          )
          ''');
  }

  // CRUD

  // Inserir
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // Listar todos do banco
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Listar todos do banco
  Future<List<Map<String, dynamic>>> queryAllRowsAlphabetically() async {
    Database db = await instance.database;
    return await db.query(
      table,
      orderBy: '$columnName ASC',
    );
  }

  // Contador de linhas da tabela
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // Editar
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletar
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
