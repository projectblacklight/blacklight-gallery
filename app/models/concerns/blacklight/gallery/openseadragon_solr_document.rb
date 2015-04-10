module Blacklight::Gallery::OpenseadragonSolrDocument
  def to_openseadragon view_config = nil
    if view_config and view_config.tile_source_field
      Array(fetch(view_config.tile_source_field))
    end
  end
end
