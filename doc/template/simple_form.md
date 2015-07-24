# Simple Form

## Table of Contents

1. [Form Styles](#formstyles)
2. [Custom input field: datepicker](#custominputfielddatepicker)

# Form styles

Rails template gives you three different form styles by default, similar to what [Bootstrap](http://getbootstrap.com/css/#forms) or [Zurb Foundation](http://foundation.zurb.com/docs/components/forms.html) offers:

1. [Basic](#basic-default)
2. [Inline](#inline)
3. [Horizontal](#horizontal)
  1. [Field Sizing](#field-sizing)

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

### Field Sizing

As some fields do not require an entire line to themselves (e.g. Postcode), there are 3 different row styles to choose from:

* 2-1
* 1-2
* 2-2

Each number refers to the column size input fields can assume in a grid of 7 available columns. The remainder is used for labels. When choosing the sizing, label & input value length should be considered.

**Usage:**

* Extra `.row` and `.sized-[x]-[y]` class for the wrapper of the 2 fields

```haml
.row.sized-2-1
  = form.input :suburb
  = form.input :postcode
.row.sized-2-2
  = form.input :phone
  = form.input :fax
```

# Custom input field: datepicker

Input fields with date pickers have become very common in our Rails apps, so we wanted to have a default implementation. Our implementation uses the Pikaday JavaScript library for all desktop and the native UI datepicker on mobile devices.

**Usage:**

```haml
= simple_form_for(...) do |f|
  = f.input :deadline, as: :date_picker
  .form-actions
    = f.button :submit
```

# Custom input field: timepicker
