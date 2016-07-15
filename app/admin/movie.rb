ActiveAdmin.register Movie do

  permit_params :title, :trailer, :description, :approved, :featured, :duration, :genre, :release_date, posters_attributes: [:id, :image, :_destroy], actor_ids: []

  index do
    column :title
    column :description
    column :approved
    column :actors do |movie|
      movie.display_actors
    end
    column 'Poster' do |m|
      image_tag(m.first_poster) if m.first_poster
    end
    column :featured
    column :duration
    column :genre
    column :release_date
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :poster do
        div do
          movie.posters.each do |poster|
            div do
              image_tag(poster.image.url(:thumb))
            end
          end
        end
      end
      row :title
      row :release_date
      row :genre
      row :duration
      row :description
      row :trailer
      row :featured
      row :approved
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :trailer
      f.input :description
      f.has_many :posters, heading: 'Posters', new_record: 'Add Poster' do |attachment|
        attachment.input :image, hint: attachment.template.image_tag(attachment.object.image.url(:medium)), allow_destroy: true
        attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Poster'
      end
      f.input :approved
      f.input :featured
      f.input :duration
      f.input :actors
      f.input :genre
      f.input :release_date
      f.input :created_at
    end
    f.actions
  end

end
