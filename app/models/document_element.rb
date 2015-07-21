class DocumentElement < ActiveRecord::Base

  belongs_to :document, inverse_of: :document_elements
  has_many :action_fluffs, inverse_of: :document, dependent: :destroy
  has_many :action_suspicions, inverse_of: :document, dependent: :destroy
  has_many :action_importances, inverse_of: :document, dependent: :destroy

end
