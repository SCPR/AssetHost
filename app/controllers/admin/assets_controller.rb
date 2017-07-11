class Admin::AssetsController < Admin::BaseController
  before_action :get_asset, only: [:show, :update, :replace, :destroy]
  before_action :get_uploaded_file, only: [:upload, :replace]
  skip_before_action :verify_authenticity_token, only: [:upload, :replace]

  #----------

  def index
    @assets = Asset.visible.order("updated_at desc").page(params[:page]).per(24)
  end

  #----------

  def search
    @query = params[:q]
    @assets = Asset.es_search(@query, page: params[:page])
    render :index
  end

  #----------

  def upload
    asset = Asset.new({
      file: @file,
      image_file_name: request.headers['HTTP_X_FILE_NAME'],
      image_content_type: request.content_type
    })

    # image_content_type: request.headers['HTTP_CONTENT_TYPE']

    # 👆 use that instead if you aren't using puma as the http server

    if asset.save
      asset.request = request
      render json: asset.as_json
    else
      render plain: 'ERROR'
    end

  end

  #----------

  def metadata
    @assets = Asset.where(id: params[:ids].split(','))
    @assets.map{|a| a.request = request}
  end

  #----------

  def update_metadata
    params[:assets].each do |id, attributes|
      asset = Asset.find(id)
      asset.update_attributes(asset_params(attributes))
    end

    redirect_to assets_path
  end

  #----------

  def show
    # Use "visible" here because we are choosing next/prev based on the
    # index listing. Hard-coding the order here (ID) because the
    # AssetHostBrowserUI uses ID if no ORDER option is passed in, which
    # it currently isn't, so the grid is ordered by ID.
    @assets   = Asset.visible.order('id desc')
    @prev     = @assets.where('id > ?', @asset.id).last
    @next     = @assets.where('id < ?', @asset.id).first
    @prev.try(:request=, request)
    @next.try(:request=, request)
  end

  #----------

  def update
    if @asset.update_attributes(asset_params)
      flash[:notice] = "Successfully updated asset."
      redirect_to asset_path(@asset)
    else
      flash[:notice] = @asset.errors.full_messages.join("<br/>")
      render :action => :edit
    end
  end

  #----------

  def replace
    if !@file
      render :text => 'ERROR' and return
    end

    @asset.file = @file

    if @asset.save
      render json: @asset.as_json
    else
      puts "Error: #{@asset.errors.to_s}"
      render plain: 'ERROR'
    end
  end

  #----------

  def destroy
    if @asset.destroy
      flash[:notice] = "Deleted asset #{@asset.title}."
      redirect_to assets_path
    else
      flash[:error] = "Unable to delete asset."
      redirect_to asset_path(@asset)
    end
  end


  #----------

  protected

  def asset_params asset_param=nil
    (asset_param || params.require(:asset)).permit(:title, :keywords, :caption, :owner, :url, :notes, :creator_id, :image, :image_taken, :native, :image_gravity)
  end

  def get_uploaded_file
    @file = request.env['rack.input']
    if @file
      @file.class.class_eval { attr_accessor :original_filename, :content_type }
      @file.original_filename = request.headers['HTTP_X_FILE_NAME']
      @file.content_type      = request.headers['HTTP_CONTENT_TYPE']
    end
  end

  def get_asset
    @asset = Asset.find(params[:id])
    @asset.request = request
  end
end

