require "spec_helper"

RSpec.describe ClippingsPluck::Clipping do
  context '#normalized_location' do
    let(:clipping) { ClippingsPluck::Clipping.new }
    subject do
      clipping.location = location
      clipping
    end

    describe 'there is no location' do
      let(:location) { "" }

      it "returns empty string" do
        expect(subject.normalized_location).to eq("")
      end
    end

    describe 'there is a location' do
      let(:location) { "23" }

      it "returns a single location" do
        expect(subject.normalized_location).to eq("23")
      end
    end

    describe 'location is a range' do
      let(:location) { "23-36" }

      it "returns a single location" do
        expect(subject.normalized_location).to eq("36")
      end
    end
  end
end
