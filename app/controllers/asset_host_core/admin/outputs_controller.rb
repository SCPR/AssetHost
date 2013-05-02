module AssetHostCore
  module Admin
    class OutputsController < ApplicationController
      before_filter :load_output, except: [:index, :new, :create]
    
      def index
        @outputs = Output.all
      end

      #----------
    
      def update
        if @output.update_attributes(params[:output])
          flash[:notice] = "Output updated!"
          redirect_to a_output_path @output
        else
          flash[:error] = "Failed to create output: #{@output.errors}"
          render :action => :edit
        end
      end
    
      #----------
    
      def new
        @output = Output.new
      end
    
      #----------
    
      def create
        @output = Output.new(params[:output])
        
        if @output.save
          flash[:notice] = "Output created!"
          redirect_to a_output_path @output
        else
          flash[:error] = "Failed to create output: #{@output.errors}"
          render :action => :new
        end
      end

      #----------
    
      private

      def load_output
        @output = Output.find(params[:id])
      end
    end
  end
end
