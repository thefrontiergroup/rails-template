SimpleForm.setup do |config|
  config.wrappers :semantic_ui, tag: 'div', class: "field", error_class: 'error', hint_class: 'with_hint' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.use :label
    b.use :input
    b.use :hint,  wrap_with: { tag: 'div', class: 'ui label left aligned hint' }
    b.use :error, wrap_with: { tag: 'div', class: 'ui red pointing above label error' }
  end

  config.wrappers :checkbox, tag: :div, class: "field", error_class: "has-error", boolean_style: :inline do |b|
    # b.use :html5
    b.wrapper tag: "div", class: "ui checkbox" do |ba|
      ba.use :input
      ba.use :label
    end
    b.use :hint,  wrap_with: { tag: :p, class: "help-block" }
    b.use :error, wrap_with: { tag: :span, class: "help-block text-danger" }
  end

  config.button_class = 'ui button'

  # You can wrap each item in a collection of radio/check boxes with a tag,
  # defaulting to :span. Please note that when using :boolean_style = :nested,
  # SimpleForm will force this option to be a label.
  config.item_wrapper_tag = :div

  # You can define a class to use in all item wrappers. Defaulting to none.
  config.item_wrapper_class = 'ui checkbox'

  # How the label text should be generated altogether with the required text.
  # config.label_text = lambda { |label, required| "#{required} #{label}" }
  # Semantic UI has its own asterix
  config.label_text = lambda { |label, required, explicit_label| "#{label}" }
end
