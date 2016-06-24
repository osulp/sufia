module Sufia::Works
  module Metadata
    extend ActiveSupport::Concern

    included do
      property :arkivo_checksum, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#arkivoChecksum'), multiple: false
      property :is_referenced_by, predicate: ::RDF::Vocab::DC.isReferencedBy do |index|
        index.as :stored_searchable
      end
    end
  end
end
