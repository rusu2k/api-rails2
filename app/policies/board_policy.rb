
class BoardPolicy < ApplicationPolicy

    def show?
        #user_admin_or_manager_or_staff
        check_access("show_board")
    end

    def create?
        #user_admin_or_manager_or_staff
        check_access("create_board")
    end

    def update?
        #user_admin_or_manager
        check_access("update_board")
    end

    def destroy?
        #user_admin
        check_access("destroy_board")
    end


    private

    def check_access(action)
        user.role.access_controls.find_by(permission: Permission.find_by(name: action)).present?
    end

    # def user_admin?
    #     user.role.name == "admin"
    # end

    # def user_manager?
    #     user.role.name == "manager"
    # end

    # def user_staff?
    #     user.role.name = "staff"
    # end

    # def user_admin_or_manager?
    #     user_admin? || user_manager?
    # end

    # def user_admin_or_manager_or_staff
    #     user_admin? || user_manager? || user_staff?
    # end



end