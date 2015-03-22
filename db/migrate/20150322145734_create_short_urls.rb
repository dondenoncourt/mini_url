class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :url
      t.string :mini_url

      t.timestamps
    end
    add_index :short_urls, :url, unique: true
    add_index :short_urls, :mini_url, unique: true
  end
end
