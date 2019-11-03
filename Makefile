# Note: this Makefile took way longer to write than just manually
# downloading files but that's OK because I'm trying to learn
# how to write Makefiles!

include Makefile_vars

.DEFAULT_GOAL := csvs
.PHONY : clean

csvs: $(ALL_CSVS)

extract:
	# do a refresh no matter what
	./src/stash/extract_csvs.py

fetch:
	# do a refresh no matter what
	./src/stash/fetch_files.py

clean:
	rm -r ./data/stashed/nypd/*



