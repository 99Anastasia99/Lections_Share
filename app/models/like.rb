class Like < Socialization::ActiveRecordStores::Like
  belongs_to :user, optional: true
  belongs_to :lection, optional: true
end
