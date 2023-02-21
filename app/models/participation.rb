class Participation < ApplicationRecord
  after_create :confirmation_send

  def confirmation_send
    ParticipationMailer.confirmation_email(self.user).deliver_now
  end

  belongs_to :user
  belongs_to :event
end
