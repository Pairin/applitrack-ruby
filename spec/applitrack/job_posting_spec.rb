require 'applitrack/job_posting'

module Applitrack
  describe JobPosting do
    it_behaves_like "a list object"
    it_behaves_like "a retrievable object"

    describe ".endpoint" do
      it "should be correct" do
        expect(JobPosting.endpoint).to eq("JobPostings()")
      end
    end

    describe "#position" do
      let(:posting) { JobPosting.new(title: "1") }

      it "should pass title into Position.list" do
        expect(Position).to receive(:list).with({specialty: posting.title}).and_return([])
        posting.position
      end
    end

  end
end
