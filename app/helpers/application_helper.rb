module ApplicationHelper
  NOTICE = {
    create: 'created successfully',
    update: 'updated successfully',
    delete: 'deleted successfully',
    error: 'Something went wrong'
  }.freeze

  def notice_stream(domain:, message:, status:)
    if message == :error
      message = NOTICE[message]
    else
      message = "#{domain.capitalize} #{NOTICE[message]}"
    end

    turbo_stream.replace 'notice', partial: 'notice', locals: { notice: message, status: status }
  end
end
