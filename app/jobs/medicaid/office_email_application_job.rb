module Medicaid
  class OfficeEmailApplicationJob < ApplicationJob
    def perform(export:)
      export.execute do |medicaid_application, logger|
        ApplicationMailer.office_medicaid_application_notification(
          application_pdf: medicaid_application.pdf,
          recipient_email: medicaid_application.receiving_office_email,
          applicant_name: medicaid_application.primary_member.display_name,
        ).deliver

        logger.info(
          "Emailed to #{medicaid_application.receiving_office_email} "\
          "for Medicaid Client #{medicaid_application.id}",
        )
      end
    end
  end
end
