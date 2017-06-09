require 'applitrack/vacancies_selected'

module Applitrack
  describe VacanciesSelected do
    it_behaves_like "a list object"
    it_behaves_like "a retrievable object"

    describe ".endpoint" do
      it "should be correct" do
        expect(VacanciesSelected.endpoint).to eq("VacanciesSelected()")
      end
    end

    describe "#job_posting" do
      let(:vs) { VacanciesSelected.new({job_code: 1}) }

      it "should retrieve JobPosting with job_code" do
        expect(JobPosting).to receive(:retrieve).with(vs.job_code)
        vs.job_posting
      end
    end

  end
end
