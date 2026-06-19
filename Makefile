.PHONY: test test-all test-unit test-snapshots clean build clear-snapshots sourcery sourcery-all

PACKAGES = UserManagementComponent ProductCatalogComponent OrderManagementComponent
RESULTS_DIR = TestResults

###################################
#######################
###########

##
## TESTS
##

# Run tests for the main ECommerceApp package only ($ make test)
test:
	swift test

# Run tests for all packages (ECommerceApp and all dependencies) ($ make test-all)
test-all: test-snapshots
	@echo "\n✓ All tests completed successfully"

# Run unit tests with JUnit XML output ($ make test-unit)
test-unit: sourcery-all
	@mkdir -p $(RESULTS_DIR)/junit
	@rm -f $(RESULTS_DIR)/junit/*.xml
	@failed_pkgs=""; \
	for pkg in $(PACKAGES); do \
		echo "Running unit tests for $$pkg..."; \
		xml_path="$(RESULTS_DIR)/junit/$$pkg.xml"; \
		if ! (cd $$pkg && swift test --xunit-output ../$$xml_path); then \
			failed_pkgs="$$failed_pkgs $$pkg"; \
		fi; \
		echo ""; \
	done; \
	echo "Running unit tests for ECommerceApp..."; \
	if ! swift test --xunit-output $(RESULTS_DIR)/junit/ECommerceApp.xml; then \
		failed_pkgs="$$failed_pkgs ECommerceApp"; \
	fi; \
	echo ""; \
	echo "JUnit XML results saved to $(RESULTS_DIR)/junit/"; \
	ls -la $(RESULTS_DIR)/junit/*.xml 2>/dev/null || true; \
	if [ -n "$$failed_pkgs" ]; then \
		echo "\n✗ Failed packages:$$failed_pkgs"; \
		exit 1; \
	else \
		echo "\n✓ All unit tests completed successfully"; \
	fi

# Run snapshot tests with .xcresult bundles ($ make test-snapshots)
test-snapshots: sourcery-all
	@mkdir -p $(RESULTS_DIR)/xcresult
	@rm -rf $(RESULTS_DIR)/xcresult/*.xcresult
	@failed_pkgs=""; \
	for pkg in $(PACKAGES); do \
		echo "Running snapshot tests for $$pkg..."; \
		result_path="$(RESULTS_DIR)/xcresult/$$pkg.xcresult"; \
		if ! (cd $$pkg && xcodebuild test -scheme $$pkg -resultBundlePath ../$$result_path); then \
			failed_pkgs="$$failed_pkgs $$pkg"; \
		fi; \
		echo ""; \
	done; \
	echo "Running snapshot tests for ECommerceApp..."; \
	if ! xcodebuild test -scheme ECommerceApp -resultBundlePath $(RESULTS_DIR)/xcresult/ECommerceApp.xcresult; then \
		failed_pkgs="$$failed_pkgs ECommerceApp"; \
	fi; \
	echo ""; \
	echo "XCResult bundles saved to $(RESULTS_DIR)/xcresult/"; \
	ls -la $(RESULTS_DIR)/xcresult/*.xcresult 2>/dev/null || true; \
	if [ -n "$$failed_pkgs" ]; then \
		echo "\n✗ Failed packages:$$failed_pkgs"; \
		exit 1; \
	else \
		echo "\n✓ All snapshot tests completed successfully"; \
	fi

###########
#######################
###################################

##
## BUILD
##

# Build all packages ($ make build)
build:
	swift build

###########
#######################
###################################

###################################
#######################
###########

##
## CLEAR & CLEAN
##

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

###########
#######################
###################################

###################################
#######################
###########

##
## SOURCERY
##

# Run Sourcery for all packages ($ make sourcery-all)
sourcery-all:
	@echo "Running Sourcery for root package..."
	@sourcery --config .sourcery.yml
	@echo ""
	@for pkg in $(PACKAGES); do \
		echo "Running Sourcery for $$pkg..."; \
		cd $$pkg && sourcery --config .sourcery.yml && cd ..; \
		echo ""; \
	done
	@echo "✓ Sourcery completed for all packages"

###########
#######################
###################################
