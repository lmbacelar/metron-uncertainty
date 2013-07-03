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

describe 'show a Model' do
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

describe 'Create and Update Model' do
  describe 'POST /models' do
    context 'valid data' do
      before(:each) do
        visit '/models'
        click_on 'New Model'
        fill_in 'Name',     with: 'a new model'
        fill_in 'Equation', with: 'X$a + X$b'
        click_on 'Create'
      end
      let(:model) { Model.find_by name: 'a new model' }
      
      it 'creates a valid model' do
        expect(model).to be_valid
      end
    end
    context 'invalid data' do
      it 'throws an error' do
        visit '/models/new'
        fill_in 'Name',     with: 'another new model'
        fill_in 'Equation', with: 'X$a + ('
        click_on 'Create'
        expect(page).to have_selector 'div#error'

      end
    end
  end
end
