
CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "cars" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "parts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "car_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_parts_on_car_id" ON "parts" ("car_id");
INSERT INTO schema_migrations (version) VALUES ('20150226190137');

INSERT INTO schema_migrations (version) VALUES ('20150226190156');

