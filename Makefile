add-tutorials:
	git subtree add -P content/tutorials git@git01.hpcloud.net:DevExDocs/tutorials.git master

update-tutorials:
	git subtree pull -P content/tutorials git@git01.hpcloud.net:DevExDocs/tutorials.git master

add-docs:
	git subtree add -P content/documentation git@git.hpcloud.net:DevExDocs/documentation.git master

update-docs:
	git subtree pull -P content/documentation git@git.hpcloud.net:DevExDocs/documentation.git master

qa-add-docs:
	git subtree add -P content/documentation git@git.hpcloud.net:DevExDocs/documentation.git develop

qa-update-docs:
	git subtree pull -P content/documentation git@git.hpcloud.net:DevExDocs/documentation.git develop

add-api:
	git subtree add -P content/api git@git.hpcloud.net:DevExDocs/apihome.git master

update-api:
	git subtree pull -P content/api git@git.hpcloud.net:DevExDocs/apihome.git master

qa-add-api:
	git subtree add -P content/api git@git.hpcloud.net:DevExDocs/apihome.git develop

qa-update-api:
	git subtree pull -P content/api git@git.hpcloud.net:DevExDocs/apihome.git develop

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
	stackato target https://api.qa1-stackato.cx.hpcloud.net
	stackato login
	stackato group Documentation
	-stackato map docs-two docs.qa.devex.uswest.hpcloud.net
	-stackato unmap docs-one docs.qa.devex.uswest.hpcloud.net
	cp stackato-one.yml stackato.yml
	stackato update -n --nostart docs-one
	stackato start docs-one
	stackato map docs-one docs.qa.devex.uswest.hpcloud.net
	-stackato unmap docs-two docs.qa.devex.uswest.hpcloud.net
	cp stackato-two.yml stackato.yml
	stackato update -n --nostart docs-two
	stackato start docs-two
	stackato map docs-two docs.qa.devex.uswest.hpcloud.net
	rm -f stackato.yml

deploy-prod-az2: build
	stackato target https://api.stackato-prod-1-az2.devex.uswest.hpcloud.net
	stackato login
	stackato group Documentation
	stackato map OffLineApp docs.hpcloud.com
	-stackato unmap docs-site docs.hpcloud.com
	stackato update -n --nostart docs-site
	stackato start docs-site
	stackato map docs-site docs.hpcloud.com
	stackato unmap OffLineApp docs.hpcloud.com

deploy-prod-az1: build
	stackato target https://api.stackato-prod-2-az1.devex.uswest.hpcloud.net
	stackato login
	stackato group Documentation
	stackato map OffLineApp docs.hpcloud.com
	-stackato unmap docs-site docs.hpcloud.com
	stackato update -n --nostart docs-site
	stackato start docs-site
	stackato map docs-site docs.hpcloud.com
	stackato unmap OffLineApp docs.hpcloud.com

deploy-prod: deploy-prod-az2 deploy-prod-az1


.PHONY: add-tutorials update-tutorials add-docs update-docs server prepare optimize build clean deploy-qa deploy-prod-az1 deploy-prod-az2 deploy-prod add-api update-api
