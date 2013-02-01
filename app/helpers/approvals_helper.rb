module ApprovalsHelper
  def level_types
    Approval.enumerated_attributes[:level].map { |k, v| [ v, k ] }
  end
end
