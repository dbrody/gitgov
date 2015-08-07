require 'json'

class DocumentsController < ApplicationController

  include ActionView::Helpers::TagHelper

  before_action :set_element, only: [:create_action]

  resource_description { resource_id 'document' }

  # GET /documents
  # GET /documents.json
  api :GET, "/documents", "Get all documents."
  def index
    render json: Document.all
  end
end

ActionController::Renderers.add :json do |json, options|
  unless json.kind_of?(String)
    json = json.as_json(options) if json.respond_to?(:as_json)
    json = JSON.pretty_generate(json, options)
  end

  if options[:callback].present?
    self.content_type ||= Mime::JS
    "#{options[:callback]}(#{json})"
  else
    self.content_type ||= Mime::JSON
    json
  end
end
