module AssetHostCore
  module Api
    class UtilityController < ApplicationController
      before_filter :_authenticate_api_user!
    
      # Take a URL and try to find or create an asset out of it
      def as_asset
        if !params[:url]
          render :text => "Must provide an asset URL", :status => :bad_request
        end
      
        # see if we have a loader for this URL
        if asset = AssetHostCore.as_asset(params[:url])
          if params[:note].present?
            asset.notes += "\n#{params[:note]}"
          end
        
          # set hidden flag if desired
          if params[:hidden].present?
            asset.is_hidden = true
          end
          
          if params[:caption].present?
            asset.caption = params[:caption]
          end
          
          if params[:owner].present?
            asset.owner = params[:owner]
          end
          
          if params[:title].present?
            asset.title = params[:title]
          end
          
          asset.save
                
          render :json => { 
            :id         => asset.id,
            :title      => asset.title,
            :caption    => asset.caption,
            :owner      => asset.owner,
            :tags       => asset.image.tags,
            :size       => [asset.image_width,asset.image_height].join('x')
          }
        else
          render :json => { :error => "Unable to find or load an asset at the URL #{params[:url]}" }, :status => :not_found
        end
      end
    end
  end
end
