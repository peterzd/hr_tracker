class NotesController < ApplicationController
	load_resource :employee, find_by: :nickname
	load_and_authorize_resource

	def index
		@notes = @employee.describing_notes
	end
end
