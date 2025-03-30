# frozen_string_literal: true

# == Schema Information
#
# Table name: feature_flags
#
#  id          :bigint           not null, primary key
#  description :text
#  enabled     :boolean
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class FeatureFlag < ApplicationRecord
end
