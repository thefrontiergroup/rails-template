module InlineSvgHelper

  # Inline SVG from @tomeara https://gist.github.com/tomeara/6515860
  # Used to render SVG on a page
  # = inline_svg('icons/svgdefs.svg')
  def inline_svg(filename)
    if Rails.application.config.assets.precompile
      raw Rails.application.assets_manifest.find_sources(filename).try(:first)
    else
      raw Rails.application.assets.find_asset(filename)
    end
  end

  # Use SVG internal link
  # = svg_use('icon-user')
  def svg_use(href, options = {})
    content_tag(:svg, content_tag(:use, "", { "xlink:href": "##{href}" }), options)
  end

end
