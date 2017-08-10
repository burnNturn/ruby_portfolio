class Portfolio < ActiveRecord::Base
    belongs_to :user
    has_many :holdings
    has_many :transactions
    validates :user_id, presence: true
end
