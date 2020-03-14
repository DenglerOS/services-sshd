ARG     BASE_IMG=$BASE_IMG
FROM    $BASE_IMG AS base

RUN     apk --update --no-cache upgrade



FROM    base as build

WORKDIR	/rootfs

RUN	mkdir -p \
	etc/dropbear \
	var/tmp \
	var/run \
	var/lib \
	etc

RUN     ln -s ../tmp var/tmp
RUN     ln -s ../run var/run

RUN     ln -s /var/lib/apk var/lib/apk
RUN     ln -s /etc/apk etc/apk

RUN     apk --update --no-cache --root /rootfs --initdb add \
        dropbear



#FROM	scratch
FROM	$BASE_IMG 

COPY	--from=build /rootfs/ /

CMD	[ "/usr/sbin/dropbear", "-R", "-F", "-E" ]
