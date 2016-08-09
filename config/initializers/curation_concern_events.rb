# These events are triggered by actions within CurationConcerns Actors
CurationConcerns.config.callback.set(:after_create_concern) do |curation_concern, user|
  ContentDepositEventJob.perform_later(curation_concern, user)
end

CurationConcerns.config.callback.set(:after_create_fileset) do |file_set, user|
  FileSetAttachedEventJob.perform_later(file_set, user)
end

CurationConcerns.config.callback.set(:after_revert_content) do |file_set, user, revision|
  ContentRestoredVersionEventJob.perform_later(file_set, user, revision)
end

CurationConcerns.config.callback.set(:after_update_content) do |file_set, user|
  ContentNewVersionEventJob.perform_later(file_set, user)
end

CurationConcerns.config.callback.set(:after_update_metadata) do |curation_concern, user|
  ContentUpdateEventJob.perform_later(curation_concern, user)
end

CurationConcerns.config.callback.set(:after_destroy) do |id, user|
  ContentDeleteEventJob.perform_later(id, user)
end

CurationConcerns.config.callback.set(:after_audit_failure) do |file_set, user, log_date|
  Sufia::AuditFailureService.new(file_set, user, log_date).call
end

CurationConcerns.config.callback.set(:after_batch_create_success) do |user|
  Sufia::BatchCreateSuccessService.new(user).call
end

CurationConcerns.config.callback.set(:after_batch_create_failure) do |user|
  Sufia::BatchCreateFailureService.new(user).call
end

CurationConcerns.config.callback.set(:after_import_url_success) do |file_set, user|
  Sufia::ImportUrlSuccessService.new(file_set, user).call
end

CurationConcerns.config.callback.set(:after_import_url_failure) do |file_set, user|
  Sufia::ImportUrlFailureService.new(file_set, user).call
end

CurationConcerns::Forms::WorkForm.class_eval do
  # The ordered_members which are FileSet types
  # @return [Array] All of the file sets in the ordered_members
  def ordered_fileset_members
    model.ordered_members.to_a.select { |m| m.model_name.singular.to_sym == :file_set }
  end

  # The ordered_members which are not FileSet types
  # @return [Array] All of the non file sets in the ordered_members
  def ordered_work_members
    model.ordered_members.to_a.select { |m| m.model_name.singular.to_sym != :file_set }
  end
end
