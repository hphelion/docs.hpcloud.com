# docs.hpcloud.com
This repository contains the generation and deployment functionality for docs.hpcloud.com.

## Content
The documentation itself is stored as [Markdown](https://en.wikipedia.org/wiki/Markdown) (specifically [Markdown Extra](https://en.wikipedia.org/wiki/Markdown_Extra)) and [reStructuredText](https://en.wikipedia.org/wiki/ReStructuredText) in the following projects:

* [documentation](https://git.hpcloud.net/DevExDocs/documentation) - The main source of documentation for product and services overviews, getting started guides, and general documentation.
* [tutorials](https://git.hpcloud.net/DevExDocs/tutorials) - Product and service tutorials are separated into a different repo so this can be publicly contributed to.
* [API Docs](https://git.hpcloud.net:DevExDocs/apihome) - The public and private API documentation. This is managed by the service teams.

### YAML Front Matter
Jekyll content needs to have [YAML front matter](https://github.com/mojombo/jekyll/wiki/YAML-Front-Matter). We have some specifics around what should be used in here. This includes:

* `layout` is either _default_ for standard pages or _page_ for api pages.
* `title` contains the title for the page shared in places like the title tag for the page.
* `permalink` should always be specificed and have the path including an ending /.
* `description` is the meta description optionally injected into the page.
* `keywords` is the meta keywords optionally injected into a page.
* `product` is the product the content is associated with (e.g., object-storage). This is used for menus.
* `private` should be set to _false_ if this is an api document that can be displayed internally but not on the public site.
* `published` can be set to _false_ for a page to not be published in the html form.

### Menus
Menus are simply YAML in the _congif.yml file. See that file for details.

## Project Structure
The branch structure for this project is:

* master - production
* QA - what is ready to be tested by QA
* develop - the current development copy

_Note: this project uses git flow with the addition of a QA branch._

## Deployment Process
When working on updates they should all happen on the _develop_ or _feature_ branches. When the site is ready for QA the _develop_ branch should be merged into the _QA_ branch. This should be built and deployed to QA. When what is on QA is ready for production the _QA_ branch should be merged into _master_ and _master_ should be deployed to production.

At any time someone can check the contents of _master_ and see what is running on production or _QA_ and see what is in QA.

## Usage

This setup has a number of commands using Make to operate.

* `make server` - Use this to launch a local version of the site at http://0.0.0.0:4000
* `make build` - Places the output site in the _site folder and optimizes the files (e.g., minifies html)
* `make clear` - Cleans up a build.
* `make update-docs` - Updates the docs to the latest.
* `make update-tutorials` - Updates the tutorials to the latest.
* `make update-api` - Updates the API documentation to the latest.
* `make deploy-qa` - Deploy to [QA](http://docs.qa.devex.uswest.hpcloud.net/). Note, you need credentials that will be asked for when deploying.
* `make deploy-prod` -  Deploy to [production](http://docs.hpcloud.com/). Note, you need credentials that will be asked for when deploying.

Additionally there are some commands that should rarely be used if at all:

* `make prepare` - Sets up the site in the `_site` folder. This is used by the `build` step.
* `make optimize` - Optimizes the contents of `_site`. This is used by the `build` step.
* `make add-docs` - Adds the docs project to the site (via subtree).
* `make add-tutorials` - Adds the tutorials project to the site (via subtree).
* `make add-api` - Adds the tutorials project to the site (via subtree).
* `make deploy-prod-az2` - Deploys an update to the cluster in AZ2 (the primary cluster).
* `make deploy-prod-az1` - Deploy to the backup cluster in AZ1.

## Dependencies

Before using this project you need the following dependencies installed. Some of these are for deployments while others are used for the build package or managing sub-projects.

* Make (If you are on a Mac, install XCode via the App Store, then follow [these instructions on installing the XCode command line tools](http://slashusr.wordpress.com/2012/07/27/os-x-mountain-lion-need-to-reinstall-xcode-command-line-tools/)}.
* Java runtime
* [Jekyll](jekyllrb.com) (Easist is to install using the gem package: `gem install jekyll`.)
* [jekyll_ext (a.k.a ejekyll)](https://github.com/rfelix/jekyll_ext)  (Easiest to install using the gem package: `gem install jekyll_ext`.)
* Git  (Easiest is to install using [Homebrew](http://mxcl.github.com/homebrew/): `brew install git`.)
* Git Subtree  (From the command line just `cd /usr/local/share/git-core/contrib/' and then run `make`.)
* Docutils - **Note**:  If you have installed Pyton, install using `easy_install` or [pip](http://www.pip-installer.org/en/latest/index.html): `sudo pip install docutils`.  On Linux don't use the apt version.
* [RbST](http://rubygems.org/gems/RbST)  (Easiest is to install using the gem package:  `gem install RbST'.)
* PHP5 (just the CLI portion - already on Mac and `apt-get install php5-cli` on linux)
* For deployments you need the [stackato client](https://api.stackato-prod-1-az2.devex.uswest.hpcloud.net/console/client/).

## Notes

### Layouts

There are two main layouts that can be used for pages:

1. default: used for general documentation pages.
2. page: used for api pages (meant for /api/*)

### Menus

There are two menu structures in the _config.yml file:

1. navigation: This menu is broken down by main or product name. When no product is present main is used.
2. apinavigation: This is used on all page layouts and is meant for the api navigation.
