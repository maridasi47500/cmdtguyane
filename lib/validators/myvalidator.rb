class Myvalidator < ActiveModel::Validator
    def validate(record)
    unless record.your_email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      #record.errors.add attribute, (options[:message] || "is not an email")
      record.errors.add :your_email, "L'e-mail n'est pas valide"
    end

  end

end
