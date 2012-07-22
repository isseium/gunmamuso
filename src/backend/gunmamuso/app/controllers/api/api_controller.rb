# encoding: UTF-8
class Api::ApiController < ApplicationController

  # 認証
  before_filter :auth #, :except => ['user']

  def user
    @user.postFacebook "hello"
    response = {
      :message => params[:id],
      :name    => user.screen_name
    }
    respond_to do |format|
      format.json { render :json => create_json(response), :status => 200 }
    end
  end

  # 元気を開始する
  # @param  integer uid
  # @return integer genkiId
  def generateGenki
    fb_id = params[:fb_id]

    begin
      genkiball = Genkiball.create({
       :fb_id => @user.uid
      })
    rescue => ex
      raise_error 'Generate Genki DB Error'
    end

    # レスポンス生成
    response = {'genki_id' => genkiball.id}

    # 応援URL生成
    # TODO: あとで別だし
    url = 'http://localhost:3000/genki/' + genkiball.id.to_s

    # 敵が現れたことをウォールに表示
    # TODO: 敵の種類を増やす
    @user.postFacebook('群馬が現れました。携帯を振って助けてください。 ' + url)

    respond_to do |format|
      format.json { render :json => create_json(response), :status => 200 }
    end
  end

  # 元気終了
  def finishGenki
    begin
      genkiball = Genkiball.find_by_id params[:genki_id]
    rescue => ex
      raise_error 'DB Error'
    end

    # レスポンス生成
    if genkiball
      response = {'message' => true}
      status = 200
    else
      response = {'message' => false}
      status = 404
    end

    respond_to do |format|
      format.json { render :json => create_json(response), :status => status }
    end
  end

  private

  #
  # Auth
  #
  def auth
    # debug用
    if params[:m_token] == 'hoge'
      @user_id = 1
      return
    end

    user = User.find_by_uid(params[:fb_id])
    if not user
      raise_error 'auth error'
      return
    end

    @user = user
  end

  def raise_error(msg, error_code=400)
    error_response = { :message => msg, :code => error_code }

    respond_to do |format|
      format.json { render :json => create_json(error_response, "false"), :status => 400 }
    end
  end
  def create_json(arr, status = "true")
    # tasks = [tasks] unless tasks.class == Array
    { :response => arr, :status => status }.to_json
  end
end
