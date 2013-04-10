require 'spec_helper'

describe User do
	it 'is valid with a name and email and password' do
		John = User.new(name: "John", 
						email: 'john@gmail.com',
						password: 'thispasswordsucks',
						password_confirmation: 'thispasswordsucks')
		expect(John).to be_valid
	end
	it 'is not valid without name' do
	expect(User.new(name: nil, 
						email: 'john@gmail.com',
						password: 'thispasswordsucks',
						password_confirmation: 'thispasswordsucks')).to have(1).errors_on(:name)
	end
	it 'is not valid without email' do 
	expect(User.new(name: "John", 
						email: nil,
						password: 'thispasswordsucks',
						password_confirmation: 'thispasswordsucks')).to have(1).errors_on(:email)
	end
	it 'is invalid with duplicate email' do 
	User.create(name: "John", 
						email: 'john@gmail.com',
						password: 'anotherpassword',
						password_confirmation: 'anotherpassword')
	John2 = User.new(name: "John Nelson", 
						email: 'john@gmail.com',
						password: 'thispasswordsucks',
						password_confirmation: 'thispasswordsucks')
	# no idea why there should be two errors
	expect(John2).to have(2).errors_on(:email)
	end

	it 'has at least one group on creation' do
	John = User.create(name: "John", 
						email: 'john@gmail.com',
						password: 'thispasswordsucks',
						password_confirmation: 'thispasswordsucks')	
	expect(John.groups).to_not be_empty
	end

end