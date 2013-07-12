require 'spec_helper'

describe NotesController do
	helper_objects

	describe "GET index" do
		before :each do
			Note.delete_all
			Employee.delete_all
			sign_in sameer
		end

		it "assigns employee" do
			get :index, employee_id: peter.nickname, format: :js
			assigns[:employee].nickname.should eq 'peter'
		end

		it "assigns all the notes to this employee" do
			create(:note, title: 'first note', employee: peter, content: 'test', creator: sameer)
			create(:note, title: 'second note', employee: peter, content: 'test_2', creator: sameer)
			get :index, employee_id: peter.nickname, format: :js
			assigns[:notes].count.should eq peter.describing_notes.count
		end
	end
end
