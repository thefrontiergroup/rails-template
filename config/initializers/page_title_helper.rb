# change the default format used (if no format is specified):
PageTitleHelper.formats[:default] = ":title – :app"

# add custom format aliases (which can be used with page_title(format: :page))
PageTitleHelper.formats[:page] = ":title"
PageTitleHelper.formats[:public_home] = ":app - :title"
PageTitleHelper.formats[:admin] = ":title | :app Admin"
