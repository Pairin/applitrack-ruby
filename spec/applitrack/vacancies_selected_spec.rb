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

  end
end
