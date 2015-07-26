class ActionFluff < ActiveRecord::Base

  belongs_to :document_element, inverse_of: :action_fluffs
  belongs_to :user, inverse_of: :action_fluffs

end
