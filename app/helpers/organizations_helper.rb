module OrganizationsHelper
  def superior_name(organization)
    organization.superior == nil ? "" : organization.superior.name
  end

  def kind_types
    Organization::KIND_TYPES.map { |k, v| [ v, k ] }
  end

  def display_kind(organization)
    return ' ' if organization.kind
    t "organizations.KIND_TYPES.#{organization.kind}" 
  end
end
