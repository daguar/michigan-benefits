# frozen_string_literal: true

class Views::Steps::DummyFinalStep < Views::Base
  def content
    p <<~TEXT
      Your application is being processed!
    TEXT
  end
end
