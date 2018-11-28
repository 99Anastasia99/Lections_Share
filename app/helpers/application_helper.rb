require 'redcarpet'

module ApplicationHelper
  def markdown(text)
  options = {
    filter_html:     true,
    hard_wrap:       true,
    link_attributes: { rel: 'nofollow', target: "_blank" },
    quote:              true,
    space_after_headers: true,
    fenced_code_blocks: true
  }

  extensions = {
    autolink:           true,
    superscript:        true,
    disable_indented_code_blocks: true
  }

  renderer = Redcarpet::Render::HTML.new(options)
  markdown = Redcarpet::Markdown.new(renderer, extensions)

  markdown.render(text).html_safe
end
def sortable(column, title=nil)
title ||= column.titleize
direction = column == params[:sort] && params[:direction]=="asc" ? "desc":"asc"
link_to title, :sort => column, :direction => direction, :remote => true
end
end
