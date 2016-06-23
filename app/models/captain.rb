require 'pry'

class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    Captain.includes(boats: :classifications).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.motors
    Captain.includes(boats: :classifications).where("classifications.name = ?", "Motorboat")
  end

  def self.talented_seamen
     Captain.where("id IN (?)", self.sailors.pluck(:id) & self.motors.pluck(:id))
  end

  def self.non_sailors
    Captain.where.not("id IN (?)", self.sailors.pluck(:id))
  end


end
