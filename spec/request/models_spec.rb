require 'spec_helper'

describe 'Models Page' do
  describe 'GET /models' do
    context 'empty database' do
      it 'renders success' do
        visit '/models'
        expect(page.status_code).to be 200
      end
    end

    context 'populated database' do
      it 'show a list of models' do
        model = FactoryGirl.create :model
        visit '/models'
        expect(page).to have_selector 'dt a', text: model.name
        expect(page).to have_selector 'dd',   text: model.description
      end
    end
  end
end

describe 'Models detail' do
  let(:model) { FactoryGirl.create :model }

  describe 'GET /models/:id' do
    before(:each) { visit "/models/#{model.to_param}" }

    it 'renders success' do
      expect(page.status_code).to be 200
    end

    it 'displays name' do
      expect(page).to have_selector 'h2', text: model.name
    end

    it 'displays description' do
      expect(page).to have_selector 'div.model dl dt', text: 'Description'
      expect(page).to have_selector 'div.model dl dd', text: model.description
    end

    it 'has a variables section' do
      expect(page).to have_selector 'h3', text: 'Variables'
    end

    it 'displays equation variables' do
      expect(page).to have_selector 'div.variables dl dt a', text: 'a'
      expect(page).to have_selector 'div.variables dl dt a', text: 'b'
      expect(page).to have_selector 'div.variables dl dd',   text: ''
    end
  end
end
