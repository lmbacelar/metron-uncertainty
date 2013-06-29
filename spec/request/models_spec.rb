require 'spec_helper'

describe 'Models Page' do
  describe 'GET /models' do
    before(:each) { visit '/models' }

    context 'empty database' do
      it 'renders success' do
        expect(page.status_code).to be 200
      end
    end

    context 'populated database' do
      fixtures :models

      it 'show a list of models' do
        expect(page).to have_selector 'dt a', text: 'PC.40602'
        expect(page).to have_selector 'dd',   text: 'piston gauge'
      end
    end
  end
end

describe 'Models detail' do
  describe 'GET /models/:id' do
    fixtures :models
    before(:each) { visit '/models/pc-dot-40602' }

    it 'renders success' do
      expect(page.status_code).to be 200
    end

    describe 'individual model' do
      it 'displays name' do
        expect(page).to have_selector 'h2', text: 'PC.40602'
      end

      it 'displays description' do
        expect(page).to have_selector 'div.model dl dt', text: 'Description'
        expect(page).to have_selector 'div.model dl dd', text: 'piston gauge'
      end

      it 'has a variables section' do
        expect(page).to have_selector 'h3', text: 'Variables'
      end

      it 'displays and links to equation variables' do
        pending 'should change fixtures to facory first'
        # expect(page).to have_selector 'div.variables dl dt a', text: 'm'
        # expect(page).to have_selector 'div.variables dl dt a', text: 'h'
        # expect(page).to have_selector 'div.variables dl dd',   text: ''
      end
    end

  end
end
