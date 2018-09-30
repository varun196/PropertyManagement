class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.string :subject
      t.text :content
      t.references :users, {index: true, foreign_key: true}
      t.references :houses, {index: true, foreign_key: true}

      t.timestamps
    end
  end
end