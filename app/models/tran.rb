class Tran < ApplicationRecord
  # This is option #1 which would need triggers (ActiveRecord speak hooks, like :after_commit)
  # to creat `Tran` objects. :(
  belongs_to :transable, polymorphic: true
end
