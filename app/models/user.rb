class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :attachment, as: :attachable
  accepts_nested_attributes_for :attachment

  def profile_pic_url(style = :original)
    self.attachment.image.url(style)
  end
end
