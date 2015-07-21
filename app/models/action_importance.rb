class ActionImportance < ActiveRecord::Base

  belongs_to :document, inverse_of: :action_importances
  belongs_to :user, inverse_of: :action_importances

end
