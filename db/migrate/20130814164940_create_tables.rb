class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_hash
      t.text :about

      t.timestamps
    end

    create_table :posts do |t|
      t.references :user
      t.string :title
      t.string :article_url

      t.timestamps
    end

    create_table :comments do |t|
      t.references :user
      t.references :post
      t.text :content

      t.timestamps
    end

  end
end
