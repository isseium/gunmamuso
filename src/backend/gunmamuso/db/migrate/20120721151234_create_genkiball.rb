class TableGenkiball < ActiveRecord::Migration
  def up
    create_table :genkiballs do |t|
      t.string  :fb_id
      t.integer :deleted, :default => 0

      t.timestamps
    end
  end

  def down
    drop_table :genkiballs
  end
end
