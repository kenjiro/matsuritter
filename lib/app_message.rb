module AppMessage
  MESSAGE = {
    :ststem_error => "システムエラーが発生しました。",
    :finished_save => "%sの登録が完了しました。",
    :finished_update => "%sの更新が完了しました。",
    :finished_delete => "%sの削除が完了しました。",
  }

  def app_message(symbol, *str)
    begin
      message = sprintf(MESSAGE[symbol], *str)
      return message
    rescue Exception => ex
      logger.error(ex)
      return nil
    end
  end
end

class << self

end


