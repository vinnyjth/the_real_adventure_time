require 'spec_helper'

describe Page do
	it 'is valid with a name and email and password' do
		expect(build(:user)).to be_valid
	end
	it 'is not valid without name' do
		expect(build(:user, :name => nil)).to have(1).errors_on(:name)
	end
	it 'is not valid without email' do 
		expect(build(:user, :email => nil)).to have(1).errors_on(:email)
	end
	it 'is invalid with duplicate email' do 
		create(:user, :email => "high@gmail.com")
		john = build(:user, :email => "high@gmail.com")
		# no idea why there should be two errors
		expect(john).to have(2).errors_on(:email)
	end

	it 'has at least one group on creation' do
		john = create(:user)
		expect(john.groups).to_not be_empty
	end

	it 'is invalid with profanity in name' do
		expect(build(:user, :name => "ass")).to_not be_valid
	end

	it 'is returning valid search results' do
		john = create(:user, :name => "John")

		expect(User.search("joh")).to include(john)
	end
end