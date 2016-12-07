class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
    message: "%{value} is not valid" }
  validate :valid_dates, :any_overlapping_requests

  belongs_to :cat

  def valid_dates
    if start_date > end_date
      errors[:dates] << 'are not valid'
    end
  end

  def overlapping_approved_requests
    return [] unless self.status == "APPROVED"
    requested_cats = CatRentalRequest.where(cat_id: self.cat_id, status: 'APPROVED')
    overlapping_requests = []
    requested_cats.each do |cat|
      next if cat == self
      if self.start_date.between?(cat.start_date, cat.end_date) ||
          self.end_date.between?(cat.start_date, cat.end_date) ||
          (self.start_date < cat.start_date && self.end_date > cat.end_date)
        overlapping_requests << cat
      end
    end
    overlapping_requests
  end

  def any_overlapping_requests
    errors[:dates] << 'are overlapping' unless overlapping_approved_requests.empty?
  end

  def overlapping_pending_requests
    requested_cats = CatRentalRequest.where(cat_id: self.cat_id, status: 'PENDING')
    overlapping_requests = []
    requested_cats.each do |cat|
      if self.start_date.between?(cat.start_date, cat.end_date) ||
          self.end_date.between?(cat.start_date, cat.end_date) ||
          (self.start_date < cat.start_date && self.end_date > cat.end_date)
        overlapping_requests << cat
      end
    end
    overlapping_requests
  end

  def approve!
    self.update_attributes(status: "APPROVED")

    overlapping_pending_requests.each do |request|
      next if request == self
      request.update_attributes(status: "DENIED")
    end
  end



end
