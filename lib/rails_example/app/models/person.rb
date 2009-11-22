class Person < ActiveRecord::Base
  unloadable
  has_many :addresses
end
