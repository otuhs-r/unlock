ActiveAdmin.register Achievement do
  permit_params :title, :tag_list

  filter :title
  filter :tags

  form do |f|
    f.inputs 'Achievement' do
      f.input :title
      f.input :tag_list, input_html: { maxlength: nil, value: f.object.tag_list.join(',') }
    end
    f.actions
  end

  index do
    column :id
    column :title
    column :tag_list
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :title
      row :tag_list
      row :created_at
    end
  end
end
