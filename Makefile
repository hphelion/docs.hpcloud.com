add-tutorials:
	git subtree add -P content/tutorials git@git01.hpcloud.net:DevExDocs/tutorials.git master

update-tutorials:
	git subtree pull -P content/tutorials git@git01.hpcloud.net:DevExDocs/tutorials.git master

.PHONY: add-tutorials update-tutorials