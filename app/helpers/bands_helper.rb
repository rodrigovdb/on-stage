module BandsHelper
  NOTICE = {
    create: 'Band created successfully',
    update: 'Band updated successfully',
    delete: 'Band deleted successfully',
    error: 'Something went wrong'
  }.freeze

  def notice_stream(message:, status:)
    turbo_stream.replace 'notice', partial: 'notice', locals: { notice: NOTICE[message], status: status }
  end

  def form_band_stream(band:)
    turbo_stream.replace 'form', partial: 'form', locals: { band: band }
  end
end
