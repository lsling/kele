require 'httparty'
require 'json'
require './lib/roadmap.rb'

class Kele
  include HTTParty
	include Roadmap

	base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    post_response = self.class.post('/sessions', body: {
        email: email,
        password: password
      })
    @user_auth_token = post_response['auth_token']
    raise "Invalid Email or Password. Try Again." if @user_auth_token.nil?
  end

	def get_me
		response = self.class.get('/users/me', headers: { "authorization" => @user_auth_token })
		JSON.parse(response.body)
	end

	def get_mentor_availability(mentor_id)
    @mentor_id = 2299843
    response = self.class.get('/mentors/2299843/student_availability', headers: { "authorization" => @user_auth_token })
    JSON.parse(response.body)
  end

	def get_messages(page = 0)
		if page > 0
				message_url = "/message_threads?page=#{page}"
		else
				message_url = "/message_threads"
		end
		response = self.class.get(message_url, headers: { "authorization" => @user_auth_token })
		JSON.parse(response.body)
	end

	def create_message(sender_email, recipient_id, subject, message)
		response = self.class.post("/messages", headers: { "authorization" => @user_auth_token },
		body: {
			"sender": sender_email,
			"recipient_id": recipient_id,
			"subject": subject,
			"stripped-text": message
		})
	end

end
# user_id = 2376019
# mentor_id = 2299843
