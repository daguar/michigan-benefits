module Integrated
  class <%= model.camelcase %>Controller < FormsController
    <%- if options.doc? -%>
    # If controller should be skipped for any reason, uncomment the following and modify logic:
    <%- end -%>
    def self.skip?(application)
      # application.stable_housing?
    end

    <%- if options.doc? -%>
    # If updating models, uncomment the following and modify required logic:
    <%- end -%>

    def update_models
      # current_application.primary_member.update(member_params)
      # current_application.update(application_params)
    end

    <%- if options.doc? -%>
    # If no database update is needed, uncomment the following `form_class` method
    # to override the form class (otherwise form class will
    # default to <%= model.underscore %>Form):
    <%- end -%>
    #   def form_class
    #     NullStep
    #   end
  end
end
