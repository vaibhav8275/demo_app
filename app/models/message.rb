class Message < ActiveRecord::Base
  # belongs_to :sent_by,:class_name => 'User'
  # belongs_to :recieved_by,:class_name => 'User'

	belongs_to :sender,:class_name => 'User', :foreign_key => 'sent_by_id'
	belongs_to :reciever,:class_name => 'User', :foreign_key => 'recieved_by_id'

end
