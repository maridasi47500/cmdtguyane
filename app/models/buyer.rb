class Buyer < ApplicationRecord
  validates_format_of :email, multiline: true, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
 validates_presence_of :firstname
  validates_length_of :firstname,  minimum: 2 
 validates_presence_of :lastname

  validates_length_of :lastname,  minimum: 2 
   validates_presence_of :mobile

  validates_length_of :mobile,  minimum: 4
def fullname
firstname.titleize+" "+lastname.upcase
end
end
