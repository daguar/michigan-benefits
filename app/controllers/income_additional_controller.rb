class IncomeAdditionalController < SnapStepsController
  def edit
    @additional_income = current_application.additional_income.map do |key|
      "income_#{key}"
    end

    @income_fields = income_fields(@additional_income)

    @step = step_class.new(
      @additional_income.map { |k| [k, current_application[k]] }.to_h,
    )
  end

  private

  def skip?
    no_additional_income_sources?
  end

  def no_additional_income_sources?
    current_application.additional_income.empty?
  end

  def income_fields(additional_income)
    {
      income_unemployment_insurance: "Unemployment Insurance",
      income_ssi_or_disability: "SSI or Disability",
      income_workers_compensation: "Worker's Compensation",
      income_pension: "Pension",
      income_social_security: "Social Security",
      income_child_support: "Child Support",
      income_other: "Other Income",
    }.stringify_keys.slice(*additional_income)
  end
end
