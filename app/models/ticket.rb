class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :state
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  has_many :assets
  accepts_nested_attributes_for :assets
  has_many :comments
  has_and_belongs_to_many :tags
  attr_accessor :tag_names   #needed, because tag_names is no db attribute
  before_create :associate_tags

  def associate_tags
    if tag_names
      tag_names.split(" ").each do |name|
        self.tags << Tag.find_or_create_by(name: name)
      end
    end
  end
end
