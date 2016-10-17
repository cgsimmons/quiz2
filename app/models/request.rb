class Request < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :department, presence: true
  validates :message, presence: true

  def self.search(search)
    where("name LIKE ? OR email LIKE ? OR department LIKE ? OR message LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def self.dstats()
    find_by_sql("SELECT DISTINCT requests.department, COUNT(requests.department) FROM requests GROUP BY requests.department ORDER BY requests.department")
  end
end
