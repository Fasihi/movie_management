class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :attachment, as: :attachable
  accepts_nested_attributes_for :attachment

  def profile_pic_url(style = :original)
    profile_pic = self.attachment
    profile_pic.try(:image).url(style) if profile_pic
  end
end
