class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Association
  has_many :exercises, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User'

  # Validation
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def follows_or_same?(new_friend)
    friendships.map(&:friend).include?(new_friend) || self == new_friend
  end

  def current_friendship(friend)
    friendships.where(friend: friend).first
  end

  # Class method
  def self.search_by_name(name)
    names_away = name.to_s.split(' ')
    if names_away.size == 1
      where('first_name LIKE ? or last_name LIKE ?', "%#{names_away[0]}%", "%#{names_away[0]}%")
          .order(:first_name)
    else
      where('first_name LIKE ? or first_name LIKE ? or last_name LIKE ? or last_name LIKE ?',
            "%#{names_away[0]}%", "%#{names_away[1]}%", "%#{names_away[0]}%", "%#{names_away[1]}%")
          .order(:first_name)
    end
  end
end
