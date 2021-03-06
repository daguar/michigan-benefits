require "rails_helper"

RSpec.feature "Submit application with minimal information" do
  scenario "completes successfully", :js, :single_app_flow do
    visit root_path
    within(".slab--hero") { proceed_with "Apply for SNAP" }

    on_page "Introduction" do
      expect(page).to have_content("Food Assistance Application")
      fill_in_name_and_birthday
      proceed_with "Continue"
    end

    on_page "Office" do
      select_radio(
        question: "Which office are you in?",
        answer: "I'm not in an office",
      )
      proceed_with "Continue"
    end

    on_page "Contact Information" do
      fill_in "What is the best phone number to reach you?", with: "2024561111"
      proceed_with "Continue"
    end

    on_page "Your Location" do
      fill_in "Street address", with: "123 Main St"
      fill_in "City", with: "Flint"
      fill_in "ZIP code", with: "12345"
      select_address_same_as_home_address
      proceed_with "Continue"
    end

    on_page "Introduction Complete" do
      proceed_with "Continue"
    end

    on_page "Introduction" do
      proceed_with "Continue"
    end

    on_page "Personal Details" do
      select_radio(question: "What is your sex?", answer: "Female")
      select "Divorced", from: "What is your marital status?"
      proceed_with "Continue"
    end

    on_page "Case Details" do
      expect(page).to have_content(
        "Have you applied for benefits in Michigan before?",
      )
      proceed_with "Yes"
    end

    on_page("Your Household") do
      proceed_with "Continue"
    end

    on_page("Your Household") do
      answer_household_more_info_questions(js: false)
      proceed_with "Continue"
    end

    on_page "Money & Income" do
      proceed_with "Continue"
    end

    on_page "Money & Income" do
      choose "No"
      proceed_with "Continue"
    end

    on_page "Money & Income" do
      select_employment(
        display_name: "Jessie Tester",
        employment_status: "Not Employed",
      )

      proceed_with "Continue"
    end

    on_page "Money & Income" do
      proceed_with "Continue"
    end

    on_page "Money & Income" do
      choose_no("Does your household have any money or accounts?")
      choose_no("Does your household own any property or real estate?")
      choose_no("Does your household own any vehicles?")

      proceed_with "Continue"
    end

    on_page "Expenses" do
      proceed_with "Continue"
    end

    on_page "Expenses" do
      proceed_with "Continue"
    end

    submit_expense_sources(answer: "no")

    on_page "Contact Preferences" do
      choose_no(
        "Would you like text message reminders about key steps and documents" +
        " required to help you through the enrollment process?",
      )
      proceed_with "Continue"
    end

    on_page "Other Details" do
      choose "No"
      proceed_with "Continue"
    end

    on_page "Other Details" do
      proceed_with "Continue"
    end

    on_page "Paperwork" do
      expect(page).to have_content("Do you have any paperwork with you? You can upload it now.")
      proceed_with "I'll do this later"
    end

    on_page "Rights and Responsibilities" do
      consent_to_terms
    end

    on_page "Sign and Submit" do
      fill_in "Sign by typing your full legal name", with: "Jessie Tester"
      proceed_with "Sign and submit"
    end

    on_page "Application Submitted" do
      proceed_with "Skip this step"
    end

    expect(page).to have_text(
      "Your application has been submitted.", wait: 2
    )
  end
end
