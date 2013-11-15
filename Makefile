NAME=clogger
MANPAGES="${NAME}.1"
VERSION=$(shell sed -n -e 's/VERSION = "\([0-9.]*\)"/\1/p' src/${NAME} )
BUILDHOST=""

help:
	@echo "The following targets are available:"
	@echo "build      build the RPM of ${NAME}-${VERSION} on ${BUILDHOST}"
	@echo "clean      remove any interim files"
	@echo "help       print this help"
	@echo "install    install nvd2sqlite3"
	@echo "rpm        build an RPM"
	@echo "uninstall  uninstall nvd2sqlite3"

build:
	@ssh ${BUILDHOST} "mkdir -p ${NAME}"
	@rsync -e ssh -avz . ${BUILDHOST}:${NAME}/.
	@ssh ${BUILDHOST} "cd ${NAME} && make rpm"
	@scp ${BUILDHOST}:redhat/RPMS/x86_64/${NAME}-${VERSION}*rpm /tmp/
	@ls /tmp/${NAME}-${VERSION}*

rpm: spec wrapper man-compress
	cd rpm && sh mkrpm.sh ${NAME}.spec

spec: rpm/${NAME}.spec

rpm/${NAME}.spec: rpm/${NAME}.spec.in
	cat $< CHANGES >$@

wrapper: src/wrapper.c
	cc -Wall -DSCRIPT=\"/usr/libexec/clogger\" $< -o $@

man-compress:
	@for f in ${MANPAGES}; do			\
		gzip -9 doc/$${f} -c > doc/$${f}.gz;	\
	done;

clean:
	rm -fr doc/*.gz wrapper rpm/${NAME}.spec.in
