# Note: this Makefile took way longer to write than just manually
# downloading files but that's OK because I'm trying to learn
# how to write Makefiles!

include makefiles/vars.makefile
include makefiles/sqlize.makefile

.DEFAULT_GOAL := sqlize
.PHONY : clean sqlize_clean

sqlize: sqlize_clean sqlize_import_raw sqlize_collate
reboot: clean sqlize

csvs: $(ALL_CSVS)

clean: sqlize_clean
	rm -r ./data/stashed/nypd/*



# do a refresh no matter what
extract:
	./src/stash/extract_csvs.py

# do a refresh no matter what
fetch:
	./src/stash/fetch_files.py




