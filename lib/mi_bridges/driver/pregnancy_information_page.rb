# frozen_string_literal: true

module MiBridges
  class Driver
    class PregnancyInformationPage < BasePage
      TITLE = "Pregnancy Information"

      delegate :members, to: :snap_application

      def setup; end

      def fill_in_required_fields
        if no_one_pregnant?
          click_no_one
        else
          members.each do |member|
            check_in_section(
              "starPregnancyAllPrograms",
              member.new_mom?,
              first_name_section(member),
            )
          end
        end
      end

      def continue
        click_on "Next"
      end

      private

      def click_no_one
        check_in_section "starPregnancyAllPrograms"
      end

      def no_one_pregnant?
        members.none?(&:new_mom?)
      end
    end
  end
end
