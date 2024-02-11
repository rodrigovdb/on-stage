# frozen_string_literal: true

class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Dirty
  include ActiveModel::Validations::Callbacks

  delegate :transaction, to: ActiveRecord::Base

  class << self
    def values_from_i18n_catalog_for(attr)
      I18n.t("#{model_name.i18n_key}/#{attr}", scope: [i18n_scope, :attributes])
    end
  end

  # Helper method for when we need to store the full string value on the DB
  def attribute_db_value(attr, value)
    self.class.human_attribute_name("#{attr}.#{value}", locale: :en)
  end
end
