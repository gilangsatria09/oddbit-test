import 'package:drift/drift.dart';
import 'database.dart';

class NoteRepository {
  final AppDatabase db;
  NoteRepository(this.db);

  Future<List<Note>> getAllByUser(int userId) => (db.select(db.notes)
        ..where((n) => n.userId.equals(userId))
        ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)]))
      .get();

  Future<Note?> getByIdAndUser(int id, int userId) => (db.select(db.notes)
        ..where((n) => n.id.equals(id) & n.userId.equals(userId)))
      .getSingleOrNull();

  Future<Note> create(int userId, String title, String content) async {
    final id = await db.into(db.notes).insert(
          NotesCompanion.insert(
            userId: userId,
            title: title,
            content: content,
          ),
        );
    return getByIdAndUser(id, userId).then((n) => n!);
  }

  Future<bool> update(
    int id,
    int userId, {
    required String title,
    required String content,
  }) async {
    final rows = await (db.update(db.notes)
          ..where((n) => n.id.equals(id) & n.userId.equals(userId)))
        .write(NotesCompanion(
      title: Value(title),
      content: Value(content),
      updatedAt: Value(DateTime.now()),
    ));
    return rows > 0;
  }

  Future<bool> delete(int id, int userId) async {
    final rows = await (db.delete(db.notes)
          ..where((n) => n.id.equals(id) & n.userId.equals(userId)))
        .go();
    return rows > 0;
  }
}
