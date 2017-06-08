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

  end
end
