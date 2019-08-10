class CreateScrapeResults < ActiveRecord::Migration[5.0]
  def change
    create_table :scrape_results do |t|
      t.text :web_site
      t.jsonb :results, default: {}

      t.timestamps
    end
  end
end
