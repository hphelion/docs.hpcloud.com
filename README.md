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

## Dependencies

Before using this project you need the following dependencies.

* [Jekyll](jekyllrb.com)
* [jekyll_ext (a.k.a ejekyll)](https://github.com/rfelix/jekyll_ext)

## Usage

_Coming soon_