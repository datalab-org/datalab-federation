.ONESHELL:
SHELLFLAGS := -o errexit -o nounset

ENTRIES := $(shell find src/instances -type f)
COMBINED_FILE := "./combined.yaml"

.PHONY: validate combined all

all: validate combine # Run all tasks

validate: $(ENTRIES) # Validate each entry in `./src/instances` against the schema
	  @echo "Validating entries..."
		errored=false

    # Error if there are no entries
		if [ -z "$(ENTRIES)" ]; then
			echo "    ✗ No entries found."
			exit 1
		fi

		@for file in $(ENTRIES); do
			file_id=$$(basename $$file .yaml)
			entry_id=$$(yq -r '.id' $$file)
			if [ "$$file_id" != "$$entry_id" ]; then
				echo "    ✗ $$file_id != $$entry_id (entry ID and file name do not match)"
				errored=true
			fi;
			output=$$(linkml-validate -s schema.yaml $$file 2>&1); status=$$?
			if [ $$status -ne 0 ]; then
				echo "    ✗ $$entry_id (schema validation failed)"
				echo "        linkml-validate exit code: $$status."
				echo "        Error: $$output"
				errored=true
			else
				echo "    ✓ $$entry_id (schema validation passed)"
			fi
		done
		if [ "$$errored" = true ]; then
			exit 1
		fi

combine: validate $(ENTRIES) # Combine all entries into a single file for downstream use
		@echo "Combining entries into $(COMBINED_FILE)..."
		@echo $(ENTRIES)

		@echo "---" > $(COMBINED_FILE)
		@for file in $(ENTRIES); do
		  echo "-" >> $(COMBINED_FILE)
			# Strip preceeding "---" then indent the rest of the file
			sed '/^---/d; s/^/    /;' $$file >> $(COMBINED_FILE); \
		done
		@echo "Combined entries into combined.yaml"
