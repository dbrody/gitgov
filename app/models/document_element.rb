class DocumentElement < ActiveRecord::Base

  acts_as_nested_set

  belongs_to :document, inverse_of: :document_elements
  has_many :action_fluffs, inverse_of: :document_element, dependent: :destroy
  has_many :action_suspicions, inverse_of: :document_element, dependent: :destroy
  has_many :action_importances, inverse_of: :document_element, dependent: :destroy

  def as_json(options = nil)
  	{
  		id: id,
  		position: position,
  		numeral: numeral,
  		body: body,
  		elements: [],
      fluffs: fluff_count || 0,
      suspicions: suspicious_count,
      importances: important_count
  	}
  end

end
