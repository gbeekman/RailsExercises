class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :presence => true, :uniqueness => true
  validates :long_url, :presence => true
  validates :submitter_id, :presence => true

  belongs_to(:submitter,
            class_name: 'User',
            primary_key: :id,
            foreign_key: :submitter_id)

  has_many(:visits,
            class_name: 'Visit',
            primary_key: :id,
            foreign_key: :short_url_id)

  has_many(:visitors,
          Proc.new { distinct },
          through: :visits,
          source: :visitor)

  def self.random_code
    code = SecureRandom.base64
    if ShortenedUrl.exists?(:short_url => code)
      ShortenedUrl.random_code
    else
      return code
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
    :short_url => ShortenedUrl.random_code,
    :long_url => long_url,
    :submitter_id => user.id
    )
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.where("created_at > ?", 3.hours.ago).select(:user_id).distinct.count
  end

end
