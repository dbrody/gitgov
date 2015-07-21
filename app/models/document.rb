class Document < ActiveRecord::Base

  has_many :document_elements, inverse_of: :document, dependent: :destroy

end
