class Task < ApplicationRecord

    before_save :set_defaults, only: [:edit, :update, :show, :destory, :create]


    def set_defaults
        self.is_deleted = false if self.is_deleted.nil?
        self.status = false if self.status.nil?
    end
end