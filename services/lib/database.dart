import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'env/env.dart';

part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  TextColumn get hashedPassword => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get title => text()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Users, Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await into(users).insert(UsersCompanion.insert(
            username: 'dummy_account1',
            // SHA-256 of "DuMmMyAccount1#"
            hashedPassword:
                '6341d395356ea23c7ce6e07ba4fe201671fee26979f61d37bdf0598babc322b2',
          ));
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = File(Env.dbPath);
    return NativeDatabase.createInBackground(file);
  });
}
