class Tag < ApplicationRecord
    has_and_belongs_to_many :songs

    def tag_type_name
        return "#{self.tag_type}_#{self.name}"
    end
end
