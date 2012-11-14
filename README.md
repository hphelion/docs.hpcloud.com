# docs.hpcloud.com
This repository contains the generation and deployment functionality for docs.hpcloud.com.

## Content
The documentation itself is stored as [Markdown](https://en.wikipedia.org/wiki/Markdown) and [reStructuredText](https://en.wikipedia.org/wiki/ReStructuredText) in the following projects:

* [documentation](https://git.hpcloud.net/DevExDocs/documentation) - The main source of documentation for product and services overviews, getting started guides, and general documentation.
* [tutorials](https://git.hpcloud.net/DevExDocs/tutorials) - Product and service tutorials are separated into a different repo so this can be publicly contributed to.
* API Docs - The public and private API documentation. This is managed by the service teams.

## Project Structure
The branch structure for this project is:

* master - production
* QA - what is ready to be tested by QA
* develop - the current development copy

_Note: this project uses git flow with the addition of a QA branch._

## Usage

This setup has a number of commands using Make to operate.

* `make server` - Use this to launch a local version of the site at http://0.0.0.0:4000
* `make build` - Places the output site in the _site folder and optimizes the files (e.g., minifies html)
* `make clear` - Cleans up a build.
* `make update-docs` - Updates the docs to the latest.
* `make update-tutorials` - Updates the tutorials to the latest.

Additionally there are some commands that should rarely be used if at all:

* `make prepare` - Sets up the site in the `_site` folder. This is used by the `build` step.
* `make optimize` - Optimizes the contents of `_site`. This is used by the `build` step.
* `make add-docs` - Adds the docs project to the site (via subtree).
* `make add-tutorials` - Adds the tutorials project to the site (via subtree).

## Dependencies

Before using this project you need the following dependencies installed.

* [Jekyll](jekyllrb.com)
* [jekyll_ext (a.k.a ejekyll)](https://github.com/rfelix/jekyll_ext)
* Git
* Git Subtree
* Docutils - Note, with pip or with easy_install. On linux don't use the apt version.
* [RbST](http://rubygems.org/gems/RbST)
* PHP5 (just the CLI portion - already on mac and `apt-get install php5-cli` on linux)