require 'spec_helper'

describe 'Home Page' do
  describe 'GET /' do
    before(:each) { visit '/' }
    it ' sets title' do
      expect(page).to have_title 'Metron'
    end

    describe 'page header' do
      it 'displays title' do
        expect(page).to have_selector 'h1', text: 'Metron'
      end
    end
  end
end
