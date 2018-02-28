class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|
      t.belongs_to :user,
        foreign_key: true,
        index: true
        
      t.belongs_to :followed_user,
        foreign_key: { to_table: :users },
        index: true

      t.timestamps
    end
  end
end
