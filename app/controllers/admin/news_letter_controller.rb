class Admin::NewsLetterController < ApplicationController

  def index
    
  end


  def mail
   @news_letter = NewsLetter.new(params[:news_letter])
   # if @news_letter.save
     @mail = User.find(:all ,:conditions => "nesw_letter_flg = 0",:select => 'name,mail' )
     @notsend = User.find(:all ,:conditions => "nesw_letter_flg = 0",:select => 'name,mail' )
     p @mail
    count = "";
    @mail.each{|m|
     OrderMailer.create_newsletter(@news_letter.subject,m.mail,@news_letter.body)
    count += m.name + "さん<br>";
    }
    flash[:sender] = count;
    flash[:notsender] = @notsend
  # end
  # render(:text => "<PRE>" + newsletter.encoded + "</PRE>")
  end

  def create
   p @news_letter = NewsLetter.new
  end
  
  def history
    @news_letter = NewsLetter.all
  end
end
