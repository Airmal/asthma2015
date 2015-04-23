class AddIndexInvitate < ActiveRecord::Migration
  add_index :invitates, :invitate_cd, unique: true
end
