module AppDate
  YYYYMMDD = "%Y/%m/%d"
  HHMMSS = "%H:%M:%S"
  ############################################
  #日付OBJ　→　文字列
  #yyyy/mmdd hh:mm:ssに変換
  ############################################
  def date_format_yyyymmddhhmmss(date_obj)
    date_obj.strftime("#{YYYYMMDD} #{HHMMSS}")
  end
end
class << self

end