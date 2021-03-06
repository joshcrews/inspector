class Score < ActiveRecord::Base
	belongs_to :item
	belongs_to :inspection
	# scope :videos, -> { where(type: 'Video') }
	# scope :voids, -> { where(type: 'Void') }
	# scope :no_sales, -> { where(type: 'NoSale') }
	# scope :general, -> { where(type: 'General') }
	scope :totals, -> { where(inspection_id: @inspection.id) }
end

  class << self
    def types
      %w(general video no_sale void)
    end
  end
