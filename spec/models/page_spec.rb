require 'spec_helper'

describe Page do
	it 'is valid with a title and content' do
		expect(build(:page)).to be_valid
	end
	it 'is not valid without title' do
		expect(build(:page, :title => nil)).to have(1).errors_on(:title)
	end
	it 'is not valid without content' do 
		expect(build(:page, :content => nil)).to have(1).errors_on(:content)
	end

	it 'has at least one group on creation' do
		page1 = create(:page)
		expect(page1.group).to be_valid
	end

	it 'is valid with profanity in content' do
		expect(build(:page, :content => "ass")).to be_valid
	end

	it 'is returning valid search results' do
		page1 = create(:page, :title => "Taco Time")

		expect(Page.search("co")).to include(page1)
	end
	describe 'linking pages to pages' do 

		before :each do 
			@page1 = create(:page)
			@page2 = create(:page)
		end
		it 'is invalid wihout question' do

			expect(@page1.paths.build(page_to_id: @page2.id)).to_not be_valid
		end

		it 'is valid with question' do 
			expect(@page1.paths.build(page_to_id: @page2.id, question: "How are you today")).to be_valid
		end
	end

end