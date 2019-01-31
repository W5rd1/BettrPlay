class Challenge < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :host, class_name: 'User'
  belongs_to :guest, class_name: 'User', optional: true
end
