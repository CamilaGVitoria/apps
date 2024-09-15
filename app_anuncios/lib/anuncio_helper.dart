import 'package:app_anuncios/data_base_helper.dart';
import 'package:app_anuncios/model/anuncio.dart';
import 'package:sqflite/sqflite.dart';

class AnuncioHelper {
  static const String tableName = 'anuncios';
  static const String idColumn = 'id';
  static const String nomeColumn = 'nome';
  static const String informacoesColumn = 'informacoes';
  static const String precoColumn = 'preco';
  static const String imageColumn = 'imagePath';

  static String get createScript {
    return 'CREATE TABLE $tableName($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nomeColumn TEXT NOT NULL, $informacoesColumn NOT NULL, $precoColumn TEXT NOT NULL, $imageColumn STRING);';
  }

  Future<Anuncio?> saveAnuncio(Anuncio anuncio) async {
    Database? db = await DataBaseHelper().db;
    if (db != null) {
      anuncio.id = await db.insert(tableName, anuncio.toMap());
      return anuncio;
    }
    return null;
  }

  Future<List<Anuncio>?> getAll() async {
    Database? db = await DataBaseHelper().db;
    if (db == null) return null;

    List<Map> returnedAnuncios = await db.query(tableName, columns: [
      idColumn,
      nomeColumn,
      informacoesColumn,
      precoColumn,
      imageColumn
    ]);

    List<Anuncio> anuncios = List.empty(growable: true);

    for (Map anuncio in returnedAnuncios) {
      anuncios.add(Anuncio.fromMap(anuncio));
    }
    return anuncios;
  }

  Future<Anuncio?> getById(int id) async {
    Database? db = await DataBaseHelper().db;

    List<Map> returnedAnuncio = await db!.query(tableName,
        columns: [
          idColumn,
          nomeColumn,
          informacoesColumn,
          precoColumn,
          imageColumn
        ],
        where: '$idColumn = ?',
        whereArgs: [id]);

    return Anuncio.fromMap(returnedAnuncio.first);
  }

  Future<int?> editAnuncio(Anuncio anuncio) async {
    Database? db = await DataBaseHelper().db;
    if (db == null) return null;

    return await db.update(tableName, anuncio.toMap(),
        where: '$idColumn = ?', whereArgs: [anuncio.id]);
  }

  Future<int?> deleteAnuncio(Anuncio anuncio) async {
    Database? db = await DataBaseHelper().db;
    if (db == null) return null;

    return await db
        .delete(tableName, where: '$idColumn = ?', whereArgs: [anuncio.id]);
  }
}
