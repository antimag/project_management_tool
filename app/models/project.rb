class Project < ApplicationRecord
  has_many :todos
  has_and_belongs_to_many :users
  validates :name, presence: true

  def team_members
    users.map(&:full_name).join(',') rescue ''
  end

  def project_name
    name.titleize
  end
end
