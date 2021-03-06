require "prawn"

class SnapApplicationExtraMemberPdf
  def initialize(members:, attributes_class:, title:)
    @members = members
    @attributes_class = attributes_class
    @title = title
  end

  def completed_file
    pdf = Prawn::Document.new

    pdf.bounding_box([40, pdf.cursor - 40], width: 500, height: 600) do
      pdf.font("Helvetica", size: 16) do
        pdf.text(title)
      end

      pdf.move_down 10

      members.each do |member|
        attributes = attributes_class.new(member: member)

        pdf.font("Helvetica", size: 14) do
          pdf.text(attributes.title)
        end

        attributes.to_a.each do |attribute|
          pdf.text(attribute)
        end

        pdf.move_down 10
      end
    end

    add_footer(pdf)
    pdf.render_file(temp_file.path)
    temp_file
  end

  private

  attr_reader :members, :attributes_class, :title

  def temp_file
    @_temp_file ||= Tempfile.new(["snap-extra-member", ".pdf"], "tmp/")
  end

  def add_footer(pdf)
    pdf.page_count.times do |i|
      pdf.go_to_page i
      pdf.image(
        footer_filename,
        position: :center,
        vposition: :bottom,
        width: 500,
      )
    end
  end

  def footer_filename
    "#{Rails.root}/public/pdf_footer.jpg"
  end
end
