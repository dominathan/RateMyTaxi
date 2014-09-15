class QrCodesController < ApplicationController

  def create_qr_code
    binding.pry
    @taxi = Taxi.find(params[:id])
    qr_code_leave_review_path = root_url + "survey/new?utf8=✓&search=" + params[:id].to_s
    @qr = nil
    binding.pry
    qr_size = 3
    while @qr == nil && qr_size < 10
      begin
        @qr = RQRCode::QRCode.new( qr_code_leave_review_path, size: qr_size)
      rescue
        qr_size += 1
      end
    end
  end

end
