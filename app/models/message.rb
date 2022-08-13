class Message < ApplicationRecord
  validates :your_email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "L'e-mail n'est pas valide" }
  validates :your_name, presence: {message: "Le nom n'est pas valide"}
  validates :your_message, presence: {message: "Il n'y a pas de message"}
  validates :your_subject, presence: {message: "L'objet n'est pas valide"}
  def self.newone(e)
    self.new do |t|
      t.your_email = e[0]
        t.your_subject = e[1]
        t.your_name = e[2]
        t.your_message = e[3]
    end
  end
  
end
