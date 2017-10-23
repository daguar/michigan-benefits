# frozen_string_literal: true

module Medicaid
  class InsuranceCurrentType < Step
    step_attributes(
      :insurance_type,
      :members,
    )

    def valid?
      if members.select(&:insurance_type).any?
        true
      else
        errors.add(
          :insurance_type,
          "Please select a plan",
        )
        false
      end
    end
  end
end
