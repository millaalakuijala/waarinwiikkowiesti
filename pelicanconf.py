#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

import datetime
def month_number_to_name(month):
	return datetime.date(1900, month, 1).strftime('%B').title()

AUTHOR = u'Fuksiwaari 2017-2018'
SITENAME = u'Waarin wiikkowiesti'
SITEURL = 'http://millaalakuijala.github.io/waarinwiikkowiesti'

PATH = 'content'

TIMEZONE = 'Europe/Helsinki'

DEFAULT_LANG = u'fi'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None
DISPLAY_PAGES_ON_MENU = True

# Blogroll
LINKS = (('Tietokilta', 'http://www.tietokilta.fi'),)

# Social widget
SOCIAL = ()

DEFAULT_PAGINATION = 5

THEME="storm"
CSS_FILE = 'screen.css'
METADATA = 'Tietokillan fuksiwaarin blogi'
SITESUBTITLE = 'Tietokilta 2017-2018'

RELATIVE_URLS = True

JINJA_FILTERS={'monthname': month_number_to_name}
DATE_FORMATS = {'fi': '%d.%m.%Y'}
LOCALE = ('fi_FI.utf8')
DIRECT_TEMPLATES = ('about', 'archives', '404', 'index')
DISPLAY_PAGES_ON_MENU  = True
ARCHIVES_URL = 'archives/'
ARCHIVES_SAVE_AS = 'archives/index.html'
ABOUT_URL = 'about/'
ABOUT_SAVE_AS = 'about/index.html'

MENUITEMS = (('Etusivu', ''),
            ('Arkisto', 'archives/'),
            ('Tietoa', 'about/'),)
STATIC_PATHS = ['img']
