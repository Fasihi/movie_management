ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    section do
      section do
        panel "Top Movies" do
          ul do
            Movie.latest_movies.limit(10).map do |movie|
              li link_to(movie.title, admin_movie_path(movie))
            end
          end
        end
      end
    end
  end
end
