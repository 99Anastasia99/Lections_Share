class LectionsIndex < Chewy::Index
define_type Lection.includes(:comments, :user, :tags) do
    field :title, :description
    field :body, type: 'text'
    field :speciality, type: 'integer'
    field :comments,  value: ->(lection) { lection.comments.map(&:body)}
    field :user,  value: ->(lection) {lection.user.username}
    field :tags,  value: ->(lection) { lection.tags.map(&:name)}
end
end
