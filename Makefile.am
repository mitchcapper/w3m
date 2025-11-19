# Makefile.am for w3m
# Describes what to build; 'automake' uses this to generate Makefile.in

# 1. Global Compiler and Preprocessor Flags
# AM_CPPFLAGS is for the C Preprocessor (e.g., -I, -D defines)
# AM_CFLAGS is for the C Compiler
AUTOMAKE_OPTIONS = foreign
SUBDIRS = lib scripts w3mimg libwc .
LDADD = lib/libgnu.a

# most recursive makefiles dont have an install target
install-recursive:
	$(MAKE) $(AM_MAKEFLAGS) install-am

AM_CPPFLAGS = \
	-I. \
	-I$(top_srcdir)/lib \
	-I$(top_srcdir) \
	-DAUXBIN_DIR=\"$(libexecdir)/$(PACKAGE)\" \
	-DCGIBIN_DIR=\"$(libexecdir)/$(PACKAGE)/cgi-bin\" \
	-DETC_DIR=\"$(sysconfdir)\" \
	-DCONF_DIR=\"$(sysconfdir)/$(PACKAGE)\" \
	-DRC_DIR=\"@RC_DIR@\" \
        -DLOCALEDIR=\"$(localedir)\"

WARNINGS  = -Wall
WARNINGS += -Werror=vla
WARNINGS += -Wnull-dereference
WARNINGS += -Wimplicit-function-declaration
WARNINGS += -Wimplicit-int
WARNINGS += -Wstrict-prototypes



ACLOCAL_AMFLAGS = -I m4
# 2. Subdirectories to process
# Automake will recursively run 'make' in these directories

# 3. Definition of Programs to be Built and Installed
# bin_PROGRAMS are installed in $(bindir) (e.g., /usr/local/bin)
bin_PROGRAMS = w3m

#all-local:
#    cd lib && $(MAKE) $(AM_MAKEFLAGS) all



# libexec_PROGRAMS are installed in $(libexecdir)
# We define custom paths for better organization, as in the original file
cgibindir = $(libexecdir)/$(PACKAGE)/cgi-bin
cgibin_PROGRAMS = w3mbookmark w3mhelperpanel

auxbindir = $(libexecdir)/$(PACKAGE)
auxbin_PROGRAMS =

# Conditionally build w3mimgdisplay based on ./configure checks
if ENABLE_IMAGE
auxbin_PROGRAMS += w3mimgdisplay
endif

# 4. Libraries
# noinst_LIBRARIES are built but not installed. They are used to link with other targets.
noinst_LIBRARIES = libindep.a

# Sources for the main library
libindep_a_SOURCES = \
	Str.c \
	indep.c \
	regex.c \
	textlist.c \
	parsetag.c \
	myctype.c \
	hash.c

# 5. Sources and Linker Dependencies for Each Program

# Main w3m program
w3m_SOURCES = \
	main.c file.c buffer.c display.c etc.c search.c linein.c \
	table.c local.c form.c map.c frame.c rc.c menu.c mailcap.c \
	image.c symbol.c entity.c terms.c url.c ftp.c mimehead.c \
	regex.c news.c func.c cookie.c history.c backend.c util.c \
	keybind.c \
	anchor.c parsetagx.c tagtable.c istream.c
w3m_LDADD = libindep.a libwc/libwc.a $(W3M_LIBS) @LIBINTL@ @LIBGC@
ALLOBJS=$(OBJS) $(LOBJS) $(LLOBJS)

# Helper programs
w3mbookmark_SOURCES = w3mbookmark.c dummy.c
w3mbookmark_LDADD = libindep.a @LIBINTL@ @LIBGC@

w3mhelperpanel_SOURCES = w3mhelperpanel.c dummy.c
w3mhelperpanel_LDADD = libindep.a @LIBINTL@ @LIBGC@

if ENABLE_IMAGE
w3mimgdisplay_SOURCES = w3mimgdisplay.c
w3mimgdisplay_CFLAGS = $(AM_CFLAGS) $(IMGCFLAGS)

w3mimgdisplay_LDADD = libindep.a w3mimg/w3mimg.a @IMGLDFLAGS@ @LIBGC@
endif

# 6. Generated Sources
# These files are created during the build process before compilation starts.

# A build-time utility program, not installed
noinst_PROGRAMS = mktable
mktable_SOURCES = mktable.c dummy.c hash.c str.c myctype.c funcname1.h
mktable_LDADD = @LIBGC@

# List of sources that are built by custom rules
BUILT_SOURCES = \
	tagtable.c \
	entity.h \
	funcname.c \
	funcname1.h \
	funcname2.h \
	functable.c

# Custom rules to generate the above files
tagtable.c: lib tagtable.tab mktable$(EXEEXT) html.h
	./mktable 100 $(top_srcdir)/tagtable.tab > $@

entity.h: entity.tab mktable$(EXEEXT)
	echo '/* $$I''d$$ */' > $@
	./mktable 100 $(top_srcdir)/entity.tab >> $@

# Rules for generating function tables from source code
func.h: funcname1.h
funcname.tab: $(top_srcdir)/main.c $(top_srcdir)/menu.c
	CPP="$(CPP)" ./generate_funcname.sh $^ > $@.tmp
	if cmp -s $@.tmp $@; then \
		rm -f $@.tmp; \
	else \
		mv $@.tmp $@; \
	fi

funcname.c: funcname.tab funcname0.awk
	sort funcname.tab | $(AWK) -f $(top_srcdir)/funcname0.awk > $@

funcname1.h: funcname.tab funcname1.awk
	sort funcname.tab | $(AWK) -f $(top_srcdir)/funcname1.awk > $@

funcname2.h: funcname.tab funcname2.awk
	sort funcname.tab | $(AWK) -f $(top_srcdir)/funcname2.awk > $@

functable.c: funcname.tab mktable$(EXEEXT)
	sort funcname.tab | $(AWK) -f $(top_srcdir)/functable.awk > functable.tab
	./mktable 100 functable.tab > $@
	rm -f functable.tab

# Create a dummy source file needed by multiple programs from a template file.
# This avoids needing a special rule for dummy.o
dummy.c: entity.c
	echo '#define DUMMY 1' > $@
	cd $(top_srcdir)/lib && make
	cat $(top_srcdir)/entity.c >> $@

# 7. Data Files and Man Pages
helpdir = @HELP_DIR@
help_DATA = @HELP_FILE@

man1_MANS = doc/w3m.1

# Use custom install hooks for translated man pages
install-data-local:
	$(MKDIR_P) $(DESTDIR)$(mandir)/ja/man1
	$(MKDIR_P) $(DESTDIR)$(mandir)/de/man1
	$(INSTALL_DATA) $(top_srcdir)/doc-jp/w3m.1 $(DESTDIR)$(mandir)/ja/man1/w3m.1
	$(INSTALL_DATA) $(top_srcdir)/doc-de/w3m.1 $(DESTDIR)$(mandir)/de/man1/w3m.1

uninstall-local:
	rm -f $(DESTDIR)$(mandir)/ja/man1/w3m.1
	rm -f $(DESTDIR)$(mandir)/de/man1/w3m.1

# 8. Files to be included in the distribution tarball that are not sources
EXTRA_DIST = \
	tagtable.tab \
	entity.tab \
	funcname0.awk \
	funcname1.awk \
	funcname2.awk \
	functable.awk \
	doc-jp/w3m.1 \
	doc-de/w3m.1 \
	lib/Makefile

# 9. Custom Clean Rules
# Add generated files that automake doesn't know about to the clean target
clean-local:
	-rm -f funcname.tab functable.tab dummy.c $(BUILT_SOURCES)
