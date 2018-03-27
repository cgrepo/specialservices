require 'active_support'

class RequestPdf < Prawn::Document
    def initialize(request)
        super()
    end
end
