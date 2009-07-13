module AppDaate
  ############################################
  #日付OBJ　→　文字列
  #yyyy/mmdd hh:mm:ssに変換
  ############################################
  def self.date_format_yyyymmddhhmmss(date_obj)
    date_obj.strftime("%Y/%m/%d %H:%M:%S")
  end
end
