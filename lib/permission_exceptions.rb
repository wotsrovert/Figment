module PermissionExceptions
    class Curator < StandardError; end
    class Director < StandardError; end
    class Placement < StandardError; end

end

=begin

- Each user must have one or more roles: Curator, Director, Administrator and Placement

- Administrators can do/edit/view anything, and are the only ones that can create/delete users or edit user roles

- Directors can do/view/edit anything, but cannot create/delete/modify users

- Curators can view any project, but can only edit projects assigned to them.

- Curators CANNOT, even for projects assigned to them:
    Edit Placement Code field
    Edit Placement Location field
    Edit Placement Note field
    Change status to "Preliminary Placement" or "Final Placement"
=end
    
# @project.allow_edits_by?( current_user )
# @project.edited_by( current_user ).update_attributes( params[:project] )
# @user.edited_by( current_user ).update_attributes( params[:user] )