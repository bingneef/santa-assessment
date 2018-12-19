require 'application_responder'

class ApplicationController < ActionController::Base
  include LogragePayload
  include ActiveModelSerializerPagination

  self.responder = ApplicationResponder
  respond_to :html
end
