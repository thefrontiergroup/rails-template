# Stylesheets

The `stylesheets` directory is organized following the [architecture from Sass Guidelines](http://sass-guidelin.es/#architecture).

- [`abstracts`](abstracts/README.md)
- [`base`](base/README.md)
- [`layouts`](layouts/README.md)
- [`components`](components/README.md)
- [`pages`](pages/README.md)
- [`vendor-extensions`](vendor-extensions/README.md)

In summary, it follows a certain pattern:

By default, we have 3 main files at the root level:

1. public.sass
2. member.sass
3. admin.sass

Each file imports the relevant and necessary files from the 6 folders above to be compiled into one CSS stylesheet.

In some cases - best example, `easy-sign-in.sass` - we have extra files at the root level that will get imported/used in very specific cases.

For example: `easy-sign-in` styles are only required during development and sometimes in the staging environment. It should never appear in any shipped production code.

## TL;DR

The files at the root level import their relevant and necessary resources from a pool of files stored away in the 6 main folders.
