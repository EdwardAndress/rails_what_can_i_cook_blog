class CreateArticlesIngredients < ActiveRecord::Migration
  def change
    create_table :articles_ingredients, id: false do |t|
    	t.references :article
    	t.references :ingredient
    end
  end

  def self.down
  	drop_table :articles_ingredients
  end

end