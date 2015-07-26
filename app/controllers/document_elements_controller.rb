require 'json'

class DocumentElementsController < ApplicationController

  include ActionView::Helpers::TagHelper

  before_action :set_element, only: [:create_action]

  resource_description { resource_id 'document_element' }

  # GET /moments
  # GET /moments.json
  api :GET, "/document_elements", "Get all document_elements."
  def index
    doc = Document.first
    root_elem = DocumentElement.find(doc.root_element)

    elements = []
    DocumentElement.each_with_level(root_elem.self_and_descendants) do |elem, level|
      elements.append(elem.as_json.merge({level: level}))
    end

    # last_level = -1
    # obj_stack = []
    # DocumentElement.each_with_level(root_elem.self_and_descendants) do |elem, level|
    #   elem = elem.as_json

    #   print "Level: ", level, "(", obj_stack.length, ")-- " , last_level

    #   if level == 0
    #     obj_stack.append([elem])
    #   elsif level > last_level
    #     obj_stack.append([elem])
    #   elsif level == last_level
    #     obj_stack[-1].append(elem)
    #   elsif level < last_level
    #     counts = last_level - level
    #     (0..counts-1).each do |it|
    #       last_elem = obj_stack.pop()
    #       obj_stack[-1][-1][:elements].append(last_elem)
    #     end
    #     obj_stack[-1].append(elem)
    #   end

    #   last_level = level
    # end

    # while obj_stack.length > 1
    #   obj_stack[-2][-1][:elements].append(obj_stack.pop())
    # end


    render json: {
      document: doc,
      root: elements
    }
  end

  # POST /moments
  # POST /moments.json
  api :POST, "/moments/:id/addaction", "Create action on document element."
  def create_action
    if !@element
      render json: "Unable to find document element."
      return
    end

    type = params[:type]

    if type == "important"
      newaction = ActionImportance.new(:document_element => @element)
    elsif type == "fluff"
      newaction = ActionFluff.new(:document_element => @element)
    elsif type == "suspicion"
      newaction = ActionSuspicion.new(:document_element => @element)
    else
      render json: params, status: :unprocessable_entity
      return
    end

    if newaction.save
        render json: newaction
    else
      render json: newaction.errors, status: :unprocessable_entity
    end
  end

  

  private

    def set_user
      @user = User.find(current_user.id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_element
      @element = DocumentElement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def moment_params
      params.require(:moment).permit(:type, :content_type, :content)
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
