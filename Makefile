INSTALLDIR	= /usr/local/bin

default:
	@echo "ERROR: At least one target of following must be specified."
	@echo
	@echo "    list          display list of tags can be build"
	@echo "    allimages     build all images"
	@echo "    <tag name>    build a images for specified tag"
	@echo "    dockerfiles   generate Dockerfiles from template"
	@echo "    install       install a assistance tool to run container"
	@echo "    uninstall     uninstall a assistance tool to run container"
	@echo "    push          push all docker images to DockerHub"
	@echo
	@false

.PHONY: list dockerfiles allimages install uninstall

list:
	@ls -1 dockerfiles

dockerfiles:
	@templates/gendockerfiles

install:
	install tools/dlenv $(INSTALLDIR)

uninstall:
	rm -f $(INSTALLDIR)/dlenv

push:
	docker push opiopan/dlenv-core
	docker push opiopan/dlenv-utils
	docker push opiopan/dlenv

clean-dungling-image:
	@docker images -q --filter dangling=true | while read IID; do \
	    docker ps -aq --filter ancestor=$$IID | while read PID; do \
	        docker rm $$PID; \
	    done; \
	    docker rmi $$IID; \
	done

include dockerfiles/.buildrule
