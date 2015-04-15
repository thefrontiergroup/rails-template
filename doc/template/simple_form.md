# Form styles

Rails template gives you three different form styles by default, similar to what [Bootstrap](http://getbootstrap.com/css/#forms) or [Zurb Foundation](http://foundation.zurb.com/docs/components/forms.html) offers:

1. [Basic](#basicdefault)
2. [Inline](#inline)
3. [Horizontal](#horizontal)

## Basic (default)

The label sits on top of the input field (exception checkboxes and radios).

**Usage:** Styles will be applied automatically when using `= simple_forms_for`

## Inline

Left-aligned labels and inline-block form fields. The recommendation is to use this style only for 2-3 fields that can comfortably sit beside each other.

**Usage:** Extra form class of `.form-inline` is required.

```haml
= simple_form_for(html: { class: "form-inline", method: :post }) do |f|
```

## Horizontal

Using the [Neat Grid](http://neat.bourbon.io/) to align label and corresponding form control in a horizontal layout (side-by-side).

**Usage:**

* Extra `wrapper` definition of `horizontal` is required.
* Extra `form` class of `.form-horizontal` is required.
* Extra `div` for (submit) button is required.

```haml
= simple_form_for(wrapper: "horizontal", html: { class: "form-horizontal"}) do |f|
  = f.input :email
  .form-actions
    = f.button :submit
```
