class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :attachment, as: :attachable
  has_many :ratings
  accepts_nested_attributes_for :attachment

  def profile_pic_url(style = :original)
    profile_pic = self.attachment
    profile_pic ? profile_pic.try(:image).url(style) : "#{style.to_s}/missing.png"
  end
end
