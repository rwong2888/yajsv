VERSION := $(shell git describe --always --dirty)
LDFLAGS := -ldflags "-X main.version=${VERSION}"
BUILD_DIR := build

.PHONY: build
build: *.go
	go build ${LDFLAGS}

.PHONY: release-local
release-local: *.go
	goreleaser release --snapshot --clean && goreleaser check

.PHONY: release
release: *.go
	@if [ -z "$$GITHUB_TOKEN" ]; then \
		echo "Error: GITHUB_TOKEN environment variable is required for release"; \
		echo "Set it with: export GITHUB_TOKEN=your_token_here"; \
		exit 1; \
	fi
	goreleaser release --clean

.PHONY: clean
clean:
	rm -rf ${BUILD_DIR} yajsv yajsv.exe coverage.out

.PHONY: fmt
fmt:
	go fmt 	./...

.PHONY: tidy
tidy:
	go mod tidy -v

.PHONY: test
test:
	go test -coverprofile=coverage.out ./...

.PHONY: ci
ci: clean test build
