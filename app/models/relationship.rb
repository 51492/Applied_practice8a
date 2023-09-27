class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  #class_nameで指示したモデル名を参照先として指定できる
  
end
