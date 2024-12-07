class CreateInnerPlanAttachments < ActiveRecord::Migration[7.1]
  def change
    create_table :inner_plan_attachments do |t|
      t.integer :user_id
      t.text :meta, default: '{}'
      t.string :type, null: false
      t.integer :position, null: false
      t.references :task, null: false, foreign_key: { to_table: :inner_plan_tasks }

      t.timestamps
    end
    add_index :inner_plan_attachments, :user_id
    add_index :inner_plan_attachments, [:task_id, :type, :position], unique: true
  end
end
