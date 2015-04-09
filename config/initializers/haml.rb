# To get more control over HTML doctypes, the default HAML format needs to be set to :xhtml.
# This allows us to use the XHTML 1.0 Transitional doctype for email layouts
# and HTML5 for everything else.

# Email templates doctype:  !!!
# Any other layout:         !!! 5

# Related links:
# http://haml.info/docs/yardoc/file.REFERENCE.html#doctype_
# https://www.campaignmonitor.com/blog/post/3317/correct-doctype-to-use-in-html-email/

Haml::Template.options[:format] = :xhtml
