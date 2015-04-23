# Modernizr

> Modernizr is a JavaScript library that detects HTML5 and CSS3 features in the user’s browser.

We use a custom build of Modernizr, because we do not need the entire test suite included in our app.

To find out what tests are included, check out the URL in [vendor/assets/javascripts/modernizr.custom.js](https://github.com/thefrontiergroup/curtin_volunteers-webapp/blob/develop/vendor/assets/javascripts/modernizr.custom.js#L2) on line 2.

In case more tests are required:

1. Use the given URL to load up our custom build
2. Tick additional tests
3. Tick "Don't Minify Source"
4. Hit Generate!
5. Update modernizr.custom.js
