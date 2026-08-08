# frozen_string_literal: true
require 'active_model'

class PersonModel
  include ActiveModel::Model
  include GlobalID::Identification

  MISSING_ID = '1000'
  ERROR_ID = '2000'

  attr_accessor :id

  def self.primary_key
    :id
  end

  def self.find(id_or_ids)
    if id_or_ids.is_a? Array
      id_or_ids.filter_map { |id| find(id) }
    else
      case id_or_ids
      when MISSING_ID then nil
      when ERROR_ID then raise 'A random error happened'
      else new id: id_or_ids
      end
    end
  end

  def ==(other)
    id == other.try(:id)
  end
end
