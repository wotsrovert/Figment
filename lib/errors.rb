module Errors
    module Permission

        class EditProject < RuntimeError
            def message
                "Your account doesn't have permission to edit this project"
            end
        end
    end
end