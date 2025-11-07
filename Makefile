TF_STACK ?= stacks/airport-ingestion/aws
TF_ENV   ?= dev
TERRAFORM ?= terraform

STACK_DIR   := $(patsubst %/,%,$(dir $(TF_STACK)))
STACK_NAME  := $(notdir $(STACK_DIR))
CLOUD       := $(notdir $(TF_STACK))
TFVARS      ?= envs/$(CLOUD)/$(TF_ENV)/$(STACK_NAME).tfvars
BACKEND_CONFIG ?= envs/$(CLOUD)/$(TF_ENV)/backend.hcl

BACKEND_STACK_KEY :=
ifeq ($(CLOUD),aws)
BACKEND_STACK_KEY := key=$(TF_ENV)/$(STACK_NAME).tfstate
else ifeq ($(CLOUD),gcp)
BACKEND_STACK_KEY := prefix=$(TF_ENV)/$(STACK_NAME)
endif

INIT_ARGS :=
ifneq ($(wildcard $(BACKEND_CONFIG)),)
INIT_ARGS += -backend-config=$(BACKEND_CONFIG)
endif
ifneq ($(strip $(BACKEND_STACK_KEY)),)
INIT_ARGS += -backend-config=$(BACKEND_STACK_KEY)
endif

.PHONY: fmt lint init validate plan apply destroy clean

fmt:
	$(TERRAFORM) -chdir=$(TF_STACK) fmt -recursive

lint: fmt
	tflint --chdir=$(TF_STACK)
	tfsec $(TF_STACK)
	checkov -d $(TF_STACK)
	conftest test $(TF_STACK)

init:
	$(TERRAFORM) -chdir=$(TF_STACK) init $(INIT_ARGS)

validate:
	$(TERRAFORM) -chdir=$(TF_STACK) validate

plan: init
	@if [ -f $(TFVARS) ]; then \
		$(TERRAFORM) -chdir=$(TF_STACK) plan -var-file=$(TFVARS); \
	else \
		$(TERRAFORM) -chdir=$(TF_STACK) plan; \
	fi

apply: init
	@if [ -f $(TFVARS) ]; then \
		$(TERRAFORM) -chdir=$(TF_STACK) apply -var-file=$(TFVARS); \
	else \
		$(TERRAFORM) -chdir=$(TF_STACK) apply; \
	fi

destroy: init
	@if [ -f $(TFVARS) ]; then \
		$(TERRAFORM) -chdir=$(TF_STACK) destroy -var-file=$(TFVARS); \
	else \
		$(TERRAFORM) -chdir=$(TF_STACK) destroy; \
	fi

clean:
	find . -name ".terraform" -type d -prune -exec rm -rf {} +
	find . -name ".terraform.lock.hcl" -prune -exec rm -f {} +
