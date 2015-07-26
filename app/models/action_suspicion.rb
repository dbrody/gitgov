class ActionSuspicion < ActiveRecord::Base

  belongs_to :document_element, inverse_of: :action_suspicions
  belongs_to :user, inverse_of: :action_suspicions

end
