class Store < ActiveRecord::Base
  validates :address, :state, :city, :zip_code, :country, presence:true

  has_one :store_brand, dependent: :destroy
  has_one :brand, through: :store_brand

  has_many :positions, ->{where('end_date is null')}, dependent: :destroy
  has_many :sales_associates, through: :positions
end
# == Schema Information
#
# Table name: stores
#
#  id              :integer(4)      not null, primary key
#  address         :string(255)
#  state           :string(255)
#  city            :string(255)
#  zip_code        :integer(4)
#  country         :string(255)
#  monday          :boolean(1)
#  tuesday         :boolean(1)
#  wednesday       :boolean(1)
#  thursday        :boolean(1)
#  friday          :boolean(1)
#  saturday        :boolean(1)
#  sunday          :boolean(1)
#  monday_start    :time
#  monday_end      :time
#  tuesday_start   :time
#  tuesday_end     :time
#  wednesday_start :time
#  wednesday_end   :time
#  thursday_start  :time
#  thursday_end    :time
#  friday_start    :time
#  friday_end      :time
#  saturday_start  :time
#  saturday_end    :time
#  sunday_start    :time
#  sunday_end      :time
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

