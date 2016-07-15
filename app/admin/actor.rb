ActiveAdmin.register Actor do

  permit_params :name, :biography, :gender

  index do
    column :id
    column :name
    column :biography
    column :gender
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :biography
      f.input :gender
    end
  f.actions
  end

end
