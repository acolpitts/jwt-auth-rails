class V2::TodosController < ApplicationController
  def index
    json_response({ message: 'API v2' } )
  end
end
