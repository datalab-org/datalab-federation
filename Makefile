.ONESHELL:
SHELLFLAGS := -o errexit -o nounset

validate:
	  @echo "Validating entries..."
		errored=false
		@for file in $$(find src -type f); do
			file_id=$$(basename $$file .yaml)
			entry_id=$$(yq -r '.id' $$file)
			if [ "$$file_id" != "$$entry_id" ]; then
				echo "    ✗ $$file_id != $$entry_id (entry ID and file name do not match)"
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
