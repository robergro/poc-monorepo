.PHONY: test test-all clean build clear-snapshots

PACKAGES = UserManagement ProductCatalog OrderManagement

# Run tests for the main ECommerceApp package only ($ make test)
test:
	swift test

# Run tests for all packages (ECommerceApp and all dependencies) ($ make test-all)
test-all:
	@for pkg in $(PACKAGES); do \
		echo "Testing $$pkg..."; \
		cd $$pkg && swift test && cd ..; \
		echo ""; \
	done
	@echo "Testing ECommerceApp..."
	@swift test
	@echo "\n✓ All tests completed successfully"

# Build all packages ($ make build)
build:
	swift build

# Clean build artifacts ($ make clean)
clean:
	swift package clean
	@for pkg in $(PACKAGES); do \
		cd $$pkg && swift package clean && cd ..; \
	done

# Remove all snapshot files from Tests folders ($ make clear-snapshots)
clear-snapshots:
	@for pkg in $(PACKAGES); do \
		if [ -d "$$pkg/Tests" ]; then \
			echo "Checking $$pkg for snapshots..."; \
			find $$pkg/Tests -type d -name "*.__snapshots__" -exec sh -c 'echo "Clearing snapshots in {}"; rm -rf {}/*' \; ; \
		fi \
	done
	@echo "\n✓ All snapshots cleared successfully"
