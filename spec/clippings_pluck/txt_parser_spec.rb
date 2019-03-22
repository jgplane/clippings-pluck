require "spec_helper"

RSpec.describe ClippingsPluck::TxtParser do
  subject(:txt_parser) { described_class.new }

  describe 'Run' do
    let(:data) {
      "Test Book 2 (Mr Author)\n- Your Highlight on page 4 | Location 51-52 |"\
      "Added on Tuesday, November 22, 2017 6:42:51 PM\n\nThis is a quote from"\
      "Test Book 2\n=========="
    }

    let(:clipping_data) {
      "Test Book 2 (Author, Ms)\n- Your Highlight on page 4 | Location 51-52 |"\
      "Added on Tuesday, November 22, 2017 6:42:51 PM\n\nThis is a quote from"\
      "Test Book 2\n=========="\
      "Test Book 2 (Author, Ms)\n- Your Note on page 4 | Location 51-52 |"\
      "Added on Tuesday, November 22, 2017 6:42:51 PM\n\nThis is a note"\
      "\n=========="
    }

    it 'parses one candidate from test data' do
      candidates = txt_parser.run(data)

      expect(candidates.length).to eq(1)
    end

    it 'parses author names separated by a comma' do
      candidates = txt_parser.run(clipping_data)

      expect(candidates.first[:author]).to eq('Ms Author')
    end

    it 'parses assigns notes to candidates' do
      candidates = txt_parser.run(clipping_data)
      expect(candidates.first[:note]).to eq('This is a note')
    end
  end
end
