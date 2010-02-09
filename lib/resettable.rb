module Resettable
    
    def self.included(base)
        base.set_table_name base.name.tableize
        base.extend ClassMethods
    end
    
    module ClassMethods
        def destroy_all_and_reset_auto_increment
            self.connection.execute("delete from #{ self.table_name };")
            self.reset_auto_increment
        end

        def reset_auto_increment
            self.connection.execute("delete from sqlite_sequence where name='#{ self.table_name }';")
        end
    end
end
