include $(PQ_FACTORY)/factory.mk

pq_part_name := perl-5.20.1
pq_part_file := $(pq_part_name).tar.gz

pq_perl_configuration_flags += -Dprefix='$(part_dir)'
pq_perl_configuration_flags += -Duseshrplib

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir)
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir) DESTDIR=$(stage_dir) install
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && sh Configure $(pq_perl_configuration_flags) -de
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@
