# terraform playground

## what is?

Terraform is (was) an open source tool created by HashiCorp that allows you to define your infrastructure as code using a simple, declarative language.

## What Is Infrastructure as Code?

The idea behind infrastructure as code (IaC) is that you write and execute code to define, deploy, update, and destroy your infrastructure.

There are five broad categories of IaC tools:

Ad hoc scripts
Scripts thats execute some task, step by step using some scripting language (bash, python, go)

Configuration management tools
Designed to install and manage software on existing servers. (ansible, chef, puppet)

Server templating tools
the idea behind server templating tools is to create an image of a server that captures a fully self-contained “snapshot” of the operating system (OS), the software, the files, and all other relevant details. (packer, docker, vagrant)

Orchestration tools
allows you to define how to manage your Docker containers as code. (kubernetes, ecs, nomad)

Provisioning tools
are responsible forquero que detalhe as ações para o Item 7: Documentação e Procedimentos Operacionais

## How Does Terraform Work?

Terraform is an open source tool created by HashiCorp and written in the Go programming language.

Under the hood, the terraform binary makes API calls on your behalf to one or more providers, such as AWS, Azure, Google Cloud, DigitalOcean, OpenStack, and more.


## anatomy

resource"<PROVIDER>_<TYPE>" "<NAME>"{
[CONFIG...]
}

where PROVIDER is the name of a provider (e.g., aws), TYPE is the type of resource to create in that provider (e.g., instance), NAME is an identifier you can use throughout the Terraform code to refer to this resource (e.g., my_instance), and CONFIG consists of one or more arguments that are specific to that resource.

## References:

1. [terraform-up-and-running-code](https://github.com/brikis98/terraform-up-and-running-code)