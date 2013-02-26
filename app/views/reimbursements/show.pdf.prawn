prawn_document(:page_size => [275, 326], :page_layout => :landscape) do |pdf|
  pdf.text "Hello World"
  pdf.text (expense_sn @reimbursement.expense)
  pdf.text @reimbursement.sn
  pdf.font("/home/whb/simsun.ttc", :size => 16) do
    pdf.text  @reimbursement.staff
  end
end