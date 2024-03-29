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

## What Is Terraform State?

Every time you run Terraform, it records information about what infrastructure it created in a Terraform state file.

## Backends

A Terraform backend determines how Terraform loads and stores state. The default backend, which you’ve been using this entire time, is the local backend, which stores the state file on your local disk. Remote backends allow you to store the state file in a remote, shared store. A number of remote backends are supported, including Amazon S3, Azure Storage, Google Cloud Storage, and HashiCorp’s Terraform Cloud and Terraform Enterprise.

## workspaces

Terraform workspaces allow you to store your Terraform state in multiple, separate, named workspaces. Terraform starts with a single workspace called “default,” and if you never explicitly specify a workspace, the default workspace is the one you’ll use the entire time.

## The terraform_remote_state Data Source

You can use this data source to fetch the Terraform state file stored by another set of Terraform configurations.

Example:

data.terraform_remote_state.<NAME>.outputs.<ATTRIBUTE>

## Modules

Modules are the key ingredient to writing reusable, maintainable, and testable Terraform code.

## Loops

Terraform offers several different looping constructs, each intended to be used in a slightly different scenario:

* count parameter, to loop over resources and modules
* for_each expressions, to loop over resources, inline blocks within a resource, and modules
* for expressions, to loop over lists and maps
* for string directive, to loop over lists and maps within a string

## count

count is Terraform’s oldest, simplest, and most limited iteration construct: all it does is define how many copies of the resource to create.

## for_each

The for_each expression allows you to loop over lists, sets, and maps to create (a) multiple copies of an entire resource, (b) multiple copies of an inline block within a resource, or (c) multiple copies of a module.

## String directives

String directives allow you to use control statements (e.g., for-loops and if-statements) within strings using a syntax similar to string interpolations, but instead of a dollar sign and curly braces (${…}), you use a percent sign and curly braces (%{…}).
Terraform supports two types of string directives: for-loops and conditionals.

## Conditionals

Just as Terraform offers several different ways to do loops, there are also several different ways to do conditionals, each intended to be used in a slightly different scenario:

* count parameter
    * Used for conditional resources

* for_each and for expressions
    * Used for conditional resources and inline blocks within a resource

* if string directive
    * Used for conditionals within a string

## Providers

What Is a Provider?

Under the hood, Terraform consists of two parts:

Core

This is the terraform binary, and it provides all the basic functionality in Terraform that is used by all platforms, such as a command-line interface (i.e., plan, apply, etc.)

Providers
Terraform providers are plugins for the Terraform core. Each plugin is written in Go to implement a specific interface, and the Terraform core knows how to install and execute the plugin.

The Terraform core communicates with plugins via remote procedure calls (RPCs), and those plugins, in turn, communicate with their corresponding platforms via the network (e.g., via HTTP calls):

![Terraform workflow](./resources/img/terraform-core-provider-clouds.png)

## validation, precondition, and postcondition

validation, precondition, and postcondition blocks are all useful tools, but they can only do basic checks. This is because you can only use data sources, resources, and language constructs built into Terraform to do these checks, and those are often not enough for more advanced behavior.

## null_resource

The null_resource even has a handy argument called triggers, which takes in a map of keys and values. Whenever the values change, the null_resource will be re-created, therefore forcing any provisioners within it to be reexecuted.

## References:

1. [terraform-up-and-running-code](https://github.com/brikis98/terraform-up-and-running-code)