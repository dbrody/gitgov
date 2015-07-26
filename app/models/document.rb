class Document < ActiveRecord::Base

  has_many :document_elements, inverse_of: :document, dependent: :destroy
  has_one :document_element, primary_key: "root_element"
end
