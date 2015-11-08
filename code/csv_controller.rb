# from: http://smsohan.com
class TransactionsController
  def index
    respond_to do |format|
      format.csv render_csv
    end
  end

  private

  def render_csv
    set_file_headers
    set_streaming_headers

    response.status = 200

    #setting the body to an enumerator, rails will iterate this enumerator
    self.response_body = csv_lines(filters)
  end

  def set_file_headers
    file_name = "transactions.csv"
    headers["Content-Type"] = "text/csv"
    headers["Content-disposition"] = "attachment; filename=\"#{file_name}\""
  end

  def set_streaming_headers
    #nginx doc: Setting this to "no" will allow unbuffered responses suitable for Comet and HTTP streaming applications
    headers['X-Accel-Buffering'] = 'no'

    headers[" -E none -s puma"]
    headers["Cache-Control"] ||= "no-cache"
    headers.delete("Content-Length")
  end

  def csv_lines
    Enumerator.new do |y|
      y << header_csv_row

      Transaction.find_in_batches(params) do |tr|
        y << transaction.to_csv_row
      end
    end
  end
end

