class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :attachment, as: :attachable
  accepts_nested_attributes_for :attachment

  def profile_pic_url(style = :original)
    profile_pic = self.attachment
    if profile_pic
      profile_pic.try(:image).url(style)
    else
      default_attachment = Attachment.new
      default_attachment.image.url(:medium)
   end
  end
end
