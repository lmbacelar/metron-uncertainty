require 'spec_helper'

describe 'Model Page' do
  describe 'GET /model' do
    context 'empty database' do
      before(:each) { visit '/model' }
      it 'renders success' do
        expect(page.status_code).to be 200
      end
    end
    context 'populated database' do
      it 'show a list of models' do
        pending 'Need to write model and its specs'
        expect(page).to have_selector 'li a', text: 'name'
      end
    end
  end
end
