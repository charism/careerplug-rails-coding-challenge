# == Schema Information
#
# Table name: jobs
#
#  id              :integer          not null, primary key
#  name            :string
#  status          :integer
#  description     :text
#  employment_type :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Job < ActiveRecord::Base
  belongs_to :user, inverse_of: :jobs
  
  enum status: [:active, :inactive]
  enum employment_type: [:full_time, :part_time]

  validates_presence_of :name, :description, :status, :employment_type, :user_id
end
