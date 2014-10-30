class Views::Admin::Roles::Show < Views::Base
  needs :role => nil
  
  def content
    p {
      text "Name: "
      text(role.name)
    }
    p {
      text "Key: "
      text(role.key)
    }
    p {
      link_to 'Edit', edit_admin_role_path(role)
      text " |"

      link_to 'Back', admin_roles_path
    }
  end
end
