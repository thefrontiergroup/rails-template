# Vendor Extensions

Rails applications have a `vendor/assets/stylesheets` folder containing all the CSS files from external libraries and frameworks – Normalize, jQueryPluginXYZ and so on.
Putting those aside in the `vendor` folder makes it clear they are not our code, our responsibility.

If you have to override a section of any vendor, put the overrides in `app/assets/stylesheets/vendor-extensions`, in which you may have files named exactly after the vendors they overwrite.
For instance, `vendor-extensions/_pikaday.sass` is a file containing all CSS rules intended to re-declare some of Pikaday’s default CSS. This is to avoid editing the vendor files themselves, which is generally not a good idea.

Reference: [Sass Guidelines](http://sass-guidelin.es/) > [Architecture](http://sass-guidelin.es/#architecture) > [Vendors folder](http://sass-guidelin.es/#vendors-folder)
