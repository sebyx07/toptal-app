module ControlService
  class Pagination < OpenStruct
    def pages
      return @pages if @pages.present?
      @pages = []

      before = current_page - 1

      while before > 0 && before > current_page - 6
        @pages << PaginationPage.new(before, false)
        before -= 1
      end
      @pages.reverse!
      @pages << PaginationPage.new(current_page, true)
      after = current_page + 1

      while after < max_pages && after < current_page + 6
        @pages << PaginationPage.new(after, false)
        after += 1
      end
      @pages
    end

    def records
      return @record if @records.present?
      @records = query.limit(_per_page).offset((current_page - 1) * _per_page)
      if search.present?
        @records = search.call(params, @records)
      end
      @records
    end

    def current_page
      @current_page ||= params[:page]&.to_i || 1
    end

    def count
      query.count
    end

    def _per_page
      @_per_page ||= per_page || 10
    end

    def max_pages
      @max_pages ||= (count.to_f / _per_page).ceil + 1
    end

    def has_enough_pages
      pages.size > 1
    end
  end

  class PaginationPage
    attr_reader :number, :active

    def initialize(number, active)
      @number = number
      @active = active
    end
  end
end