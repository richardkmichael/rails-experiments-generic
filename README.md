## Foreign key support

Rails 4.2 does not yet support SQLite foreign keys (which must be
enabled per-connection with `PRAGMA foreign_keys = ON;`), so to actually
generate the constraints in your schema, the database adapter must be
changed to `postgresql` and `db/schema.rb` regenerated from migrations.

When ActiveRecord is aware the underlying database supports foreign
keys, it will preserve the `#add_foreign_key()` method call in the
`db/schema.rb` file.

In general, `db/schema.rb` is not portable [between databases].

ActiveRecord will add constraints using `ALTER TABLE ...` statements ;
not, for example, PostgreSQL's `CREATE TABLE ... REFERENCES ...` column
definition syntax.  Review `db/structure.sql` (`rake db:structure:dump`)
to see the generated SQL.

Rails does not provide a `validates_existence_of` validator, however
this is simple to effect with `validates_presence_of` and
`validates_associated` ; see [`app/models/part.rb`](app/models/part.rb).

It may be helpful to give meaningful names to the constraint, Rails will
autogenerate a name using the pattern `fk_rails_*`.  Both SQLite and
PostgreSQL allow naming via `CONSTRAINT <name> ... `.

*Note:* Both SQLite and PostgreSQL allow the foreign key constrained
column to be NULL, so you may want to set a `..., null: false` (`NOT
NULL`) constraint as well.


## References

### SQLite

 * [Enable foreign keys](https://www.sqlite.org/foreignkeys.html#fk_enable)
 * [Named table constraints (see sub-section)](https://www.sqlite.org/lang_createtable.html)

### PostgreSQL

 * [PostgreSQL ALTER TABLE / table constraints](http://www.postgresql.org/docs/9.4/static/sql-altertable.html)
 * [PostgresSQL datetime functions](http://www.postgresql.org/docs/9.4/static/functions-datetime.html)

### Rails

 * [`#add_foreign_key()`](http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_foreign_key)

## Helpful SQL commands

 * PostgreSQL "INSERT INTO ... SELECT ...", e.g. INSERT INTO with a query.
   (`created_at` and `updated_at` must be timestamps without timezone.)

```sql
INSERT INTO parts (name, car_id, created_at, updated_at) SELECT ('wheel', null, localtimestamp, localtimestamp);
```
