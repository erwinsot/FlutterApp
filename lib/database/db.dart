import 'dart:async';
import "../models/models.dart";

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class procesDb {
  static Future<Database> database() async {
    return openDatabase(
      // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
      // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
      // construida para cada plataforma.
      join(await getDatabasesPath(), 'Database_Words.db'),
      // Cuando la base de datos se crea por primera vez, crea una tabla para almacenar dogs
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE words(id   INTEGER        PRIMARY KEY AUTOINCREMENT, word TEXT, respuesta TEXT)",
        );
      },
      // Establece la versión. Esto ejecuta la función onCreate y proporciona una
      // ruta para realizar actualizacones y defradaciones en la base de datos.
      version: 1,
    );
  }

  static Future<void> insertWord(Word word) async {
    // Obtiene una referencia de la base de datos
    final Database db = await database();

    // Inserta el Dog en la tabla correcta. También puede especificar el
    // `conflictAlgorithm` para usar en caso de que el mismo Dog se inserte dos veces.
    // En este caso, reemplaza cualquier dato anterior.
    await db.insert(
      'words',
      word.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Answer>> answers() async {
    // Obtiene una referencia de la base de datos
    final Database db = await database();

    // Consulta la tabla por todos los Dogs.
    final List<Map<String, dynamic>> maps = await db.query('words');

    // Convierte List<Map<String, dynamic> en List<Dog>.
    return List.generate(maps.length, (i) {
      return Answer(
        word: maps[i]['word'],
        answer: maps[i]['answer'],
      );
    });

  }

  static Future<void> updateWord(Answer answer) async {
    // Obtiene una referencia de la base de datos
    final db = await database();

    // Actualiza el Dog dado
    await db.update(
      'words',
      answer.toMap(),
      // Aseguúrate de que solo actualizarás el Dog con el id coincidente
      where: "id = ?",
      // Pasa el id Dog a través de whereArg para prevenir SQL injection
      whereArgs: [answer.answer],
    );
  }

  static Future<void> deleteDog(int id, Answer answer) async {
    // Obtiene una referencia de la base de datos
    final db = await database();

    // Elimina el Dog de la base de datos
    await db.delete(
      'words',
      // Utiliza la cláusula `where` para eliminar un dog específico
      where: "id = ?",
      // Pasa el id Dog a través de whereArg para prevenir SQL injection
      whereArgs: [answer.word],
    );
  }
}
