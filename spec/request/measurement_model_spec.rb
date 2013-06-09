require 'spec_helper'

describe 'Measurement Model Page' do
  describe 'GET /measurement_model' do
    context 'empty database' do
      before(:each) { visit '/measurement_model' }
      it 'renders success' do
        expect(page.status_code).to be 200
      end
    end
    context 'populated database' do
      it 'show a list of measurement models' do
        pending 'Need to write model and its specs'
        expect(page).to have_selector 'li a', text: 'PC.40601'
      end
    end
  end
end
