INSTALLDIR=/usr/local/bin

default:
	@echo "ERROR: At least one target of following must be specified."
	@echo
	@echo "    list          display list of tags can be build"
	@echo "    allimages     build all images"
	@echo "    <tag name>    build a images for specified tag"
	@echo "    dockerfiles   generate Dockerfiles from template"
	@echo "    install       install a assistance tool to run container"
	@echo "    uninstall     uninstall a assistance tool to run container"
	@echo
	@false

.PHONY: list dockerfiles allimages install uninstall

list:
	@ls -1 dockerfiles

dockerfiles:
	@templates/gendockerfiles

include dockerfiles/.buildrule
