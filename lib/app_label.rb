module AppLabel

  LABEL = {
    :mutter_list => "つぶやき一覧",
    :user_name => "ユーザ名",
    :mutter => "つぶやき",
    :mutter_day => "つぶやき日",
    :search => "検索",
    :function => "機能",
    :page_back => "&#171;前",
    :page_next => "次&#187;",
    :destroy => "削除",
  }

  def app_label(symbol)
    begin
      label = LABEL[symbol]
      return label
    rescue Exception => ex
      logger.error(ex)
      return nil
    end
  end
end

class << self

end


