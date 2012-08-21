class Api::CompanyController < Api::ApiController
  def index
    company = Company.first

    if company
      response = formatted_response(true, company, t('api.message.company.index.success'))
    else
      response = formatted_response(false, nil, t('api.message.company.index.failure'))
    end

    render :json => response
  end

  def create

    company = Company.first
    if company
      response = formatted_response(false, company, t('api.message.company.create.already_exists'))
    else
      company = Company.new(params[:company])

      if company.save
        response = formatted_response(true, company, t('api.message.company.create.success'))
      else
        response = formatted_response(false, company.errors, t('api.message.company.create.failure'))
      end
    end

    render :json => response
  end

  def update
  end

  def destroy
    company = Company.find(params[:id])

    if company.destroy
      response = formatted_response(true, nil, t('api.message.company.destroy.success'))
    else
      response = formatted_response(false, nil, t('api.message.company.destroy.failure'))
    end

    render :json => response
  end
end
