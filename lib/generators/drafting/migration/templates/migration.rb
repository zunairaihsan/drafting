class DraftingMigration < Drafting::MIGRATION_BASE_CLASS
  def self.up
    create_table :drafts do |t|
      t.string :draftable_type, null: false
      t.string :draftable_id, null: false
      t.references :user
      t.references :parent, polymorphic: true, index: true
      t.binary :data, limit: 16777215, null: false
      serialize :serialized_data, JSON

      t.datetime :updated_at, null: false
    end

    add_index :drafts, [:user_id, :draftable_type]
  end

  def self.down
    drop_table :drafts
  end
end
