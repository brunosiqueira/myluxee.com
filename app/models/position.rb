class Position < ActiveRecord::Base
  belongs_to :sales_associate
  belongs_to :store

  validates :start_date, :role , presence: true
end
# == Schema Information
#
# Table name: positions
#
#  id                 :integer(4)      not null, primary key
#  store_id           :integer(4)
#  sales_associate_id :integer(4)
#  start_date         :date
#  end_date           :date
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  role               :string(255)
#

