class HomesController < ApplicationController

  def index
    if user_signed_in?
      @micropost = current_user.microposts.build
      @feed_microposts = current_user.feed
    end
  end

  def search
    @search_m = Micropost.ransack(params[:m],search_key: :m)
     #ransackメソッドにて、デフォルトの:qが重複しないように第２引数で指定
    @search_q2 = User.ransack(params[:q2],search_key: :q2)
    if params.dig(:q,:username_or_service_id_cont)
      @search_word = params[:q][:username_or_service_id_cont]
      @search_users = @search.result(distinct: true).order(created_at: "DESC")
        # distinct: trueは検索結果のレコード重複しないようにします。
      @search_type = "user"
    elsif params.dig(:m,:content_cont)
      @search_word = params[:m][:content_cont]
      @search_microposts = @search_m.result(distinct: true).order(created_at: "DESC")
      @search_type = "microposts"
    elsif params.dig(:q2,:username_or_service_id_cont)
      @search_word = params[:q2][:username_or_service_id_cont]
      @search_users = @search_q2.result(distinct: true).order(created_at: "DESC")
      @search_type = "user"
    else
      @search_word = ""
    end
  end

end
