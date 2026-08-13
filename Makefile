BUILD_DIR    ?= build
SERVICES     := mongodb-reader mongodb-writer
CGO_ENABLED  ?= 0
GOARCH       ?= amd64
GOOS         ?= linux
MF_BROKER_TYPE ?= nats

VERSION ?= $(shell git describe --abbrev=0 --tags 2>/dev/null || echo "0.0.0")
COMMIT  ?= $(shell git rev-parse HEAD)
TIME    ?= $(shell date +%F_%T)

MF_DOCKER_IMAGE_NAME_PREFIX ?= mainfluxlabs

define compile_service
	CGO_ENABLED=$(CGO_ENABLED) GOOS=$(GOOS) GOARCH=$(GOARCH) \
	go build -mod=mod -tags $(MF_BROKER_TYPE) \
	-o $(BUILD_DIR)/mainfluxlabs-$(1) cmd/$(1)/main.go
endef

define make_docker
	docker build \
		--build-arg SVC=$(1) \
		--build-arg VERSION=$(VERSION) \
		--build-arg COMMIT=$(COMMIT) \
		--build-arg TIME=$(TIME) \
		--tag=$(MF_DOCKER_IMAGE_NAME_PREFIX)/$(1):$(VERSION) \
		-f docker/Dockerfile .
endef

all: $(SERVICES)

$(SERVICES):
	$(call compile_service,$@)

dockers:
	$(foreach svc,$(SERVICES),$(call make_docker,$(svc));)

.PHONY: all $(SERVICES) dockers
