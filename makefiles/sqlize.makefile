
SQLIZED_SCHEMA_DIR = data/sqlized/schemas
SQLIZED_DBSCHEMA = data/sqlized/schemas/blank.sqlite
SQLIZED_DBNAME = data/sqlized/nypd_stop_and_frisk.sqlite


sqlize_clean:
	test -d data/sqlized/  && rm -r data/sqlized/ || true


sqlize_import_raw: $(SQLIZED_DBNAME)

$(SQLIZED_DBNAME): csvs
	mkdir -p $(dir $(SQLIZED_DBNAME))
	./src/sqlize/import_raw_csvs.sh $(SQLIZED_DBNAME)

sqlize_schemas: $(SQLIZED_DBSCHEMA)

$(SQLIZED_DBSCHEMA): csvs
	mkdir -p $(dir $(SQLIZED_DBSCHEMA))
	./src/sqlize/generate_schemas.sh $(SQLIZED_DBSCHEMA)
