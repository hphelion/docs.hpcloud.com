add-tutorials:
	git subtree add -P content/tutorials git@git01.hpcloud.net:DevExDocs/tutorials.git master

update-tutorials:
	git subtree pull -P content/tutorials git@git01.hpcloud.net:DevExDocs/tutorials.git master

add-docs:
	git subtree add -P content/documentation git@git.hpcloud.net:DevExDocs/documentation.git master

update-docs:
	git subtree pull -P content/documentation git@git.hpcloud.net:DevExDocs/documentation.git master

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

.PHONY: add-tutorials update-tutorials add-docs update-docs server prepare optimize build clean