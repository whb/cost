module OrganizationsHelper
  def superior_name(organization)
    organization.superior == nil ? "" : organization.superior.name
  end
end
