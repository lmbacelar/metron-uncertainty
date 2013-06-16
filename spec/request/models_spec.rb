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
