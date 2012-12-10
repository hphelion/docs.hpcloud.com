add-tutorials:
	git subtree add -P content/tutorials git@git01.hpcloud.net:DevExDocs/tutorials.git master

update-tutorials:
	git subtree pull -P content/tutorials git@git01.hpcloud.net:DevExDocs/tutorials.git master

add-docs:
	git subtree add -P content/documentation git@git.hpcloud.net:DevExDocs/documentation.git master

update-docs:
	git subtree pull -P content/documentation git@git.hpcloud.net:DevExDocs/documentation.git master

add-api:
	git subtree add -P content/api git@git.hpcloud.net:DevExDocs/apihome.git master

update-api:
	git subtree pull -P content/api git@git.hpcloud.net:DevExDocs/apihome.git master

server:
	@ejekyll --server --auto

prepare:
	@echo "Building the site..."
	@ejekyll --no-future

optimize:
	@echo "Minifying the CSS..."
	@java -jar _build/yuicompressor.jar --verbose --type css -o _site/css/application.css _site/css/application.css
	@echo "Minifying the HTML..."
	@java -jar _build/htmlcompressor.jar -r --type html -o _site _site

build: prepare optimize

clean:
	@echo "Removing _site directory"
	@rm -rf _site

deploy-qa: build
	@echo "Deploying to stackato QA cluster"
	stackato target https://api.stackato-qa-1-az1.devex.uswest.hpcloud.net
	stackato login
	stackato --group Documentation update docs-site

deploy-prod-az2: build
	stackato target https://api.stackato-prod-1-az2.devex.uswest.hpcloud.net
	stackato login
	stackato --group Documentation update docs-site

deploy-prod-az1: build
	stackato target https://api.stackato-prod-2-az1.devex.uswest.hpcloud.net
	stackato login
	stackato --group Documentation update docs-site

deploy-prod: deploy-prod-az2 deploy-prod-az1


.PHONY: add-tutorials update-tutorials add-docs update-docs server prepare optimize build clean deploy-qa deploy-prod-az1 deploy-prod-az2 deploy-prod add-api update-api