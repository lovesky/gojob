GO_CMD=go
GOJOB_BIN=gojob
GOJOB_BIN_PATH=./output
GOJOB_CONF_PATH=./output/conf
GOJOB_STATIC_PATH=./output/static
GOJOB_VIEWS_PATH=./output/views

.PHONY: all
all: clean build install

.PHONY: build
build:
	@echo "build start >>>"
	go env -w GOPROXY=https://goproxy.io
	go env -w GOSUMDB=off
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GO_CMD) build -o $(GOJOB_BIN) ./main.go
	@echo ">>> build complete"

.PHONY: install
install:
	@echo "install start >>>"
	mkdir -p $(GOJOB_BIN_PATH)
	mv $(GOJOB_BIN) $(GOJOB_BIN_PATH)/gojob
	mkdir -p $(GOJOB_CONF_PATH)
	cp ./conf/app.conf $(GOJOB_CONF_PATH)
	cp -r ./static $(GOJOB_STATIC_PATH)
	cp -r ./views $(GOJOB_VIEWS_PATH)
	@echo ">>> install complete"

.PHONY: clean
clean:
	@echo "clean start >>>"
	rm -fr ./output
	rm -f $(GOJOB_BIN)
	@echo ">>> clean complete"