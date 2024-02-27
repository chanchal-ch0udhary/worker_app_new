class ChangeColumnVacancyInPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :vacancies, :vacancy
  end
end
