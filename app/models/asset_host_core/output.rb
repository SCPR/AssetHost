module AssetHostCore
  class Output < ActiveRecord::Base
    has_many :asset_outputs

    after_save :delete_asset_outputs, if: -> { self.size_changed? || self.extension_changed? }

    #----------

    def self.paperclip_sizes
      @paperclip_sizes ||= begin
        sizes = {}

        Output.all.each do |output|
          sizes.merge! output.paperclip_options
        end

        sizes
      end
    end


    #----------

    def code_sym
      self.code.to_sym
    end

    #----------

    def paperclip_options
      {
        self.code.to_sym => {
          :geometry     => '',
          :size         => self.size,
          :format       => self.extension.to_sym,
          :prerender    => self.prerender,
          :output       => self.id,
          :rich         => self.is_rich
        }
      }
    end

    #----------

    protected

    def delete_asset_outputs
      # destroy each AssetOutput, triggering file and cache deletion
      self.asset_outputs.each { |ao| ao.destroy }
    end
  end
end
