.PHONY: test test-all test-unit test-snapshots clean build clear-snapshots sourcery sourcery-all docc

PACKAGES = Common $(shell find . -maxdepth 1 -type d -name "*Component*" -exec basename {} \; | sort)
RESULTS_DIR = .testResults
DERIVED_DATA_PATH = .spmComponentDerivedData/
SDK = iphonesimulator
DESTINATION = platform=iOS Simulator,name=iPhone 17,OS=26.2
XCODEBUILD_FLAGS = -derivedDataPath $(DERIVED_DATA_PATH) -sdk $(SDK) -destination "$(DESTINATION)"
DOCC_DERIVED_DATA = .derivedData
DOCC_OUTPUT_PATH = .docs
HOSTING_BASE_PATH ?= poc-monorepo

###################################
#######################
###########

##
## BUILD
##

# Build all packages ($ make build)
build:
	@failed_pkgs=""; \
	for pkg in $(PACKAGES); do \
		echo "Building $$pkg..."; \
		if ! (cd $$pkg && xcodebuild -scheme $$pkg-Package $(XCODEBUILD_FLAGS) build); then \
			failed_pkgs="$$failed_pkgs $$pkg"; \
		fi; \
		echo ""; \
	done; \
	echo "Building ECommerceApp..."; \
	if ! xcodebuild -scheme ECommerceApp-Package $(XCODEBUILD_FLAGS) build; then \
		failed_pkgs="$$failed_pkgs ECommerceApp"; \
	fi; \
	if [ -n "$$failed_pkgs" ]; then \
		echo "\n✗ Failed packages:$$failed_pkgs"; \
		exit 1; \
	else \
		echo "\n✓ All packages built successfully"; \
	fi

###########
#######################
###################################

###################################
#######################
###########

##
## TESTS
##

# Run tests for all packages (ECommerceApp and all dependencies) ($ make test)
test: test-unit test-snapshots
	@echo "\n✓ All tests completed successfully"

# Run unit tests with JUnit XML output ($ make test-unit)
test-unit: sourcery-all
	@mkdir -p $(RESULTS_DIR)/xcresult
	@rm -rf $(RESULTS_DIR)/xcresult/*.xcresult
	@failed_pkgs=""; \
	for pkg in $(PACKAGES); do \
		echo "Running unit tests for $$pkg..."; \
		result_path="$(RESULTS_DIR)/xcresult/$$pkg.xcresult"; \
		if ! (cd $$pkg && xcodebuild -scheme $$pkg-Package $(XCODEBUILD_FLAGS) -resultBundlePath ../$$result_path test); then \
			failed_pkgs="$$failed_pkgs $$pkg"; \
		fi; \
		echo ""; \
	done; \
	echo "Running unit tests for ECommerceApp..."; \
	if ! xcodebuild -scheme ECommerceApp-Package $(XCODEBUILD_FLAGS) -resultBundlePath $(RESULTS_DIR)/xcresult/ECommerceApp.xcresult test; then \
		failed_pkgs="$$failed_pkgs ECommerceApp"; \
	fi; \
	echo ""; \
	echo "XCResult bundles saved to $(RESULTS_DIR)/xcresult/"; \
	ls -la $(RESULTS_DIR)/xcresult/*.xcresult 2>/dev/null || true; \
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
		result_path="$(RESULTS_DIR)/xcresult/$$pkg-snapshots.xcresult"; \
		if ! (cd $$pkg && xcodebuild -scheme $$pkg-Package $(XCODEBUILD_FLAGS) -resultBundlePath ../$$result_path test); then \
			failed_pkgs="$$failed_pkgs $$pkg"; \
		fi; \
		echo ""; \
	done; \
	echo "Running snapshot tests for ECommerceApp..."; \
	if ! xcodebuild -scheme ECommerceApp-Package $(XCODEBUILD_FLAGS) -resultBundlePath $(RESULTS_DIR)/xcresult/ECommerceApp-snapshots.xcresult test; then \
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

###################################
#######################
###########

##
## DOCUMENTATION
##

# Generate DocC documentation for all packages ($ make docc or $ make docc DOCC_OUTPUT_PATH=mu-output-path HOSTING_BASE_PATH=my-custom-path)
# To test locally, use :
# $ cd .docs && python3 -m http.server 8000
# Then open http://localhost:8000
docc:
	@echo "Generating DocC documentation..."
	@mkdir -p $(DOCC_OUTPUT_PATH)
	@failed_pkgs=""; \
	for pkg in $(PACKAGES); do \
		echo "Building DocC for $$pkg..."; \
		pkg_lower=$$(echo $$pkg | tr '[:upper:]' '[:lower:]' | sed 's/component//g'); \
		if ! (cd $$pkg && xcodebuild docbuild -scheme $$pkg-Package -derivedDataPath ../$(DOCC_DERIVED_DATA) -destination 'generic/platform=iOS'); then \
			failed_pkgs="$$failed_pkgs $$pkg"; \
		else \
			echo "Processing DocC archive for $$pkg..."; \
			$$(xcrun --find docc) process-archive \
				transform-for-static-hosting $(DOCC_DERIVED_DATA)/Build/Products/Debug-iphoneos/$$pkg.doccarchive \
				--output-path $(DOCC_OUTPUT_PATH)/$$pkg_lower \
				--hosting-base-path $(HOSTING_BASE_PATH)/$$pkg_lower; \
			if [ -f "$$pkg/documentation.json" ]; then \
				cp $$pkg/documentation.json $(DOCC_OUTPUT_PATH)/$$pkg_lower/documentation.json; \
				echo "Copied documentation.json to $(DOCC_OUTPUT_PATH)/$$pkg_lower/"; \
			fi; \
		fi; \
		echo ""; \
	done; \
	echo "Building DocC for ECommerceApp..."; \
	if ! xcodebuild docbuild -scheme ECommerceApp-Package -derivedDataPath $(DOCC_DERIVED_DATA) -destination 'generic/platform=iOS'; then \
		failed_pkgs="$$failed_pkgs ECommerceApp"; \
	else \
		echo "Processing DocC archive for ECommerceApp..."; \
		$$(xcrun --find docc) process-archive \
			transform-for-static-hosting $(DOCC_DERIVED_DATA)/Build/Products/Debug-iphoneos/ECommerceApp.doccarchive \
			--output-path $(DOCC_OUTPUT_PATH)/ecommerceapp \
			--hosting-base-path $(HOSTING_BASE_PATH)/ecommerceapp; \
		if [ -f "documentation.json" ]; then \
			cp documentation.json $(DOCC_OUTPUT_PATH)/ecommerceapp/documentation.json; \
			echo "Copied documentation.json to $(DOCC_OUTPUT_PATH)/ecommerceapp/"; \
		fi; \
	fi; \
	if [ -f ".github/workflows/index.html" ]; then \
		cp .github/workflows/index.html $(DOCC_OUTPUT_PATH)/index.html; \
		echo "Copied index.html to $(DOCC_OUTPUT_PATH)/"; \
	fi; \
	echo ""; \
	echo "Generating packages.json with metadata..."; \
	echo "[" > $(DOCC_OUTPUT_PATH)/packages.json; \
	first=true; \
	for dir in $$(find $(DOCC_OUTPUT_PATH) -mindepth 1 -maxdepth 1 -type d | sort); do \
		if [ -f "$$dir/documentation.json" ]; then \
			folder=$$(basename "$$dir"); \
			if [ "$$first" = true ]; then \
				first=false; \
			else \
				printf ",\n" >> $(DOCC_OUTPUT_PATH)/packages.json; \
			fi; \
			title=$$(grep '"title"' "$$dir/documentation.json" | head -1 | sed 's/.*"title"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/'); \
			description=$$(grep '"description"' "$$dir/documentation.json" | head -1 | sed 's/.*"description"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/'); \
			image=$$(grep '"image"' "$$dir/documentation.json" | head -1 | sed 's/.*"image"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/'); \
			printf "  {\n    \"title\": \"$$title\",\n    \"description\": \"$$description\",\n    \"image\": \"$$image\",\n    \"path\": \"$$folder/documentation/$$folder\"\n  }" >> $(DOCC_OUTPUT_PATH)/packages.json; \
		fi; \
	done; \
	printf "\n]\n" >> $(DOCC_OUTPUT_PATH)/packages.json; \
	echo "Generated packages.json with $$(grep -c '"title"' $(DOCC_OUTPUT_PATH)/packages.json) packages"; \
	if [ -n "$$failed_pkgs" ]; then \
		echo "\n✗ Failed packages:$$failed_pkgs"; \
		exit 1; \
	else \
		echo "\n✓ DocC documentation generated successfully in $(DOCC_OUTPUT_PATH)/"; \
	fi
# TODO: Put the populate Package.json in a script in .script ??

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
sourcery:
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
