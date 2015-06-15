## automake.am
##
## Top level automake.am for rfbconnect
##
## Use automake to process this into a Makefile.in
##
##   (C) Copyright 2015 Fred Gleason <fredg@paravelsystems.com>
##
##   This program is free software; you can redistribute it and/or modify
##   it under the terms of the GNU General Public License version 2 as
##   published by the Free Software Foundation.
##
##   This program is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
##
##   You should have received a copy of the GNU General Public
##   License along with this program; if not, write to the Free Software
##   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
##

ACLOCAL_AMFLAGS = -I m4

maintainer-clean-local:	
	rm -rf m4

install-exec-local:	
	mkdir -p $(DESTDIR)$(prefix)/bin
	cp rfbconnect.pl $(DESTDIR)$(prefix)/bin/
	mkdir -p $(DESTDIR)/usr/share/applications
	cp rfbconnect.desktop $(DESTDIR)/usr/share/applications/

uninstall-exec:
	rm -f $(DESTDIR)$(prefix)/bin/rfbconnect.pl
	rm -f $(DESTDIR)/usr/share/applications/rfbconnect.desktop

rpm:	dist
	mkdir -p $(HOME)/rpmbuild/SOURCES
	cp rfbconnect-$(VERSION).tar.gz $(HOME)/rpmbuild/SOURCES/
	$(RPMBUILD) -ba --target noarch-$(VENDOR)-linux rfbconnect.spec
	mv $(HOME)/rpmbuild/RPMS/noarch/rfbconnect-*.rpm $(top_srcdir)/
	mv $(HOME)/rpmbuild/SRPMS/rfbconnect-*.src.rpm $(top_srcdir)/
	rm $(HOME)/rpmbuild/SOURCES/rfbconnect-$(VERSION).tar.gz

bin_SCRIPTS = rfbconnect.pl

EXTRA_DIST = autogen.sh\
             get_distro.sh\
             get_target.sh\
             PACKAGE_VERSION\
             rfbconnect.desktop\
             rfbconnect.pl\
             rfbconnect.spec.in

CLEANFILES = *~\
             *.mo\
             *.rpm\
             *.tar.gz\
             *.tgz\
             *.zip

DISTCLEANFILES = *.spec\
                 config.guess\
                 config.sub\
                 ltmain.sh

MAINTAINERCLEANFILES = *~\
                       *.tar.gz\
                       aclocal.m4\
                       Makefile.in\
                       config.guess\
                       config.status\
                       config.sub\
                       configure\
                       depcomp\
                       install-sh\
                       libtool\
                       ltmain.sh\
                       missing\
                       mkinstalldirs
