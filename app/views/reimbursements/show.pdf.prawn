require "prawn/measurement_extensions"

# reimbursement real :page_size => [105.mm, 190.mm]
# A4 :page_size => [210.mm, 297.mm]

prawn_document(:page_size => [105.mm, 190.mm], :margin => 0, :page_layout => :landscape) do |pdf|
  kai_font = "#{Prawn::BASEDIR}/data/fonts/gkai00mp.ttf"
  hei_font = "#{Prawn::BASEDIR}/data/fonts/simhei.ttf"
  selected_font = FileTest.exists?(hei_font) ? hei_font : kai_font

  fixed_a4_margin = 1.mm * @fixed_a4_margin
  x_margin = -1.mm
  pdf.font("#{selected_font}", :size => 12) do
    pdf.text_box Reimbursement.human_attribute_name(:sn) + " : ", :at => [12.mm + x_margin, 95.mm + fixed_a4_margin]
    pdf.text_box @reimbursement.sn, :at => [25.mm + x_margin, 95.mm + fixed_a4_margin]

    pdf.text_box Reimbursement.human_attribute_name(:expense_id) + " : ", :at => [127.mm + x_margin, 95.mm + fixed_a4_margin]
    pdf.text_box print_expense_sn(@reimbursement.expense), :at => [152.mm + x_margin, 95.mm + fixed_a4_margin]

    pdf.text_box @reimbursement.organization.name, :at => [25.mm + x_margin, 74.mm + fixed_a4_margin]

    pdf.text_box @reimbursement.reimburse_on.year.to_s, :at => [70.mm + x_margin, 74.mm + fixed_a4_margin]
    pdf.text_box @reimbursement.reimburse_on.month.to_s, :at => [88.mm + x_margin, 74.mm + fixed_a4_margin]
    pdf.text_box @reimbursement.reimburse_on.day.to_s, :at => [99.mm + x_margin, 74.mm + fixed_a4_margin]

    pdf.text_box @reimbursement.abstract, :at => [38.mm + x_margin, 62.mm + fixed_a4_margin]

    pdf.text_box @reimbursement.chinese_amount, :at => [38.mm + x_margin, 48.mm + fixed_a4_margin]
    pdf.text_box (number_to_currency @reimbursement.amount), :at => [150.mm + x_margin, 48.mm + fixed_a4_margin]

    # pdf.text_box @reimbursement.staff, :at => [160.mm + x_margin, 36.mm + fixed_a4_margin]
  end
end