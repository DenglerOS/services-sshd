ARG     BASE_IMAGE=$BASE_IMAGE
FROM    $BASE_IMAGE AS tinyssh

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
FROM	$BASE_IMAGE

COPY	--from=tinyssh /rootfs/ /

CMD	[ "/usr/sbin/dropbear", "-R", "-F", "-E" ]
