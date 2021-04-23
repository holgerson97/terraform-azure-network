VERSION		?= $(shell git describe --tags --always --dirty --match=v* 2> /dev/null || cat $(PWD)/.version 2> /dev/null || echo v0)
PACKAGES	?= $(shell go list ./...)
GOFILES		?= $(shell find . -type f -name '*.go' -not -path "./vendor/*")

.PHONY: help clean env
.ONESHELL: #

default: help

help: 
	@echo 'usage: make [target] ...'

env:  ## Print env vars
	echo $(VERSION)
	echo $(PACKAGES)
	echo $(VERSION)

gofmt:  ## format the go source files
	go fmt ./...
	goimports -w $(GOFILES)

golint: ## run go lint on the source files
	golint $(PACKAGES)

govet:  ## run go vet on the source files
	go vet ./...

gotest: ## test units files
	cd unit-tests/
	go test -v

go-all: gofmt golint govet gotest 

terrafmt:  ## format terrafrom source files
	terraform fmt -recursive

terralint: ## lint terraform source files
	tflint module/
	tflint examples/

terravalidate: ## valdiate terraform configuration
	terraform validate module/

terraApplyAndDestroy: ## Init, Apply and Destroy Terraform configuration
	cd examples
	terraform init
	terraform apply --auto-approve
	terraform destroy --auto-approve

terra-all: terrafmt terralint terravalidate terraApplyAndDestroy

clean:
	go clean
	rm -rf *.hcl
	rm -rf .terraform
	rm -rf terraform.tfstate
	rm -rf terraform.tfstate.backup
