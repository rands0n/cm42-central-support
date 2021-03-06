module Central
  module Support
    module StoryConcern
      module Associations
        extend ActiveSupport::Concern
        included do
          belongs_to :project, counter_cache: true
          belongs_to :requested_by, class_name: 'User'
          belongs_to :owned_by, class_name: 'User'

          has_many :users, through: :project
        end

        # The list of users that should be notified when a new note is added to this
        # story.  Includes the requestor, the owner, and any other users who have
        # added notes to the story.
        def stakeholders_users
          ([requested_by, owned_by] + notes.map(&:user)).compact.uniq
        end
      end
    end
  end
end
