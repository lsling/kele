require 'httparty'

class Kele
	include HTTParty

	base_uri 'https://www.bloc.io/api/v1'

	def initialize (email, password)
		@auth_token = get_auth_token(email, password)
	end

	private
	def get_auth_token(email, password)
		response = self.class.post("/sessions", body: {email: email, password: password})
		raise StandardError if response.code != 200
		response["auth_token"]
	end
end
