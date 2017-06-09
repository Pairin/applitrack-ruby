require 'applitrack/application'

module Applitrack
  describe Application do
    it_behaves_like "a list object"
    it_behaves_like "a retrievable object"

    describe ".endpoint" do
      it "should be correct" do
        expect(Application.endpoint).to eq("Applications()")
      end
    end

    describe "#vacancies_selected" do
      let(:application) { Application.new({app_no: 1}) }

      context "with no options" do
        it "should pass app_no into VacanciesSelected.list" do
          expect(VacanciesSelected).to receive(:list).with({app_no: application.app_no})
          application.vacancies_selected
        end
      end

      context "with options" do
        let(:options) { {selection_active: true} }

        it "should pass app_no and options into VacanciesSelected.list" do
          options.merge!({app_no: application.app_no})

          expect(VacanciesSelected).to receive(:list).with(options)
          application.vacancies_selected(options)
        end
      end
    end


  end
end
