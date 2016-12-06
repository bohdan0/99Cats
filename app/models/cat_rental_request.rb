class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
    message: "%{value} is not valid" }
  validate :valid_dates, :overlapping_requests

  belongs_to :cat

  def valid_dates
    if start_date > end_date
      errors[:dates] << 'are not valid'
    end
  end

  def overlapping_requests
    requested_cats = CatRentalRequest.where(cat_id: self.cat_id, status: 'APPROVED')
    requested_cats.each do |cat|
      if self.start_date.between?(cat.start_date, cat.end_date) ||
          self.end_date.between?(cat.start_date, cat.end_date)
        errors[:dates] << 'are not valid'
        return
      end
    end

  end



end
