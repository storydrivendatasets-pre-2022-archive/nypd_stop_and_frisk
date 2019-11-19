SQLIZED_DIR = data/sqlized
SQLIZED_SCRIPTS_DIR = $(SQLIZED_DIR)/scripts
SQLIZED_DBNAME = data/sqlized/nypd_stop_and_frisk.sqlite
# Note that the src/sqlize/import sql script is "baked" out by *another* script
# located in src/sqlize/genscripts
# This is because the import sql could theoretically be written out by hand,
#  e.g. by someone who doesn't know how to shell script. But I am not that someone
SQL_SCRIPT_IMPORT_RAW = src/sqlize/import_raw.sql

sqlize_clean:
	test -f $(SQLIZED_DBNAME)  && rm $(SQLIZED_DBNAME) || true
	test -f $(SQL_SCRIPT_IMPORT_RAW)  && rm $(SQL_SCRIPT_IMPORT_RAW) || true


sqlize_scripts: $(SQL_SCRIPT_IMPORT_RAW)


$(SQL_SCRIPT_IMPORT_RAW): csvs
	./src/sqlize/genscripts/generate_import_raw_sql.sh \
		data/stashed/nypd/csv \
		> $@

sqlize_import_raw: $(SQL_SCRIPT_IMPORT_RAW)
	sqlite3 $(SQLIZED_DBNAME) < $(SQL_SCRIPT_IMPORT_RAW)

sqlize_quick_unify: sqlize_import_raw
	sqlite3 $(SQLIZED_DBNAME) < src/sqlize/quick_unify_beta.sql

# sqlize_schemas: $(SQLIZED_DBSCHEMA)

# $(SQLIZED_DBSCHEMA): csvs
# 	mkdir -p $(dir $(SQLIZED_DBSCHEMA))
# 	./src/sqlize/generate_schemas.sh $(SQLIZED_DBSCHEMA)
