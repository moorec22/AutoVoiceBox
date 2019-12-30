class SettingController < ApplicationController
  VOICES = [
    'Daniel',
    'Oliver',
    'Peter',
    'Samantha',
    'Victoria',
    'Alex',
    'Fred',
  ].freeze

  def get_voices
    VOICES
  end

  def get_voice
    Setting.voice
  end

  def update_voice
    voice = params[:voice]
    Setting.find_or_create_by(name: 'voice').update(value: voice)
  end
  
  def get_current_category_id
    setting = Setting.where(name: 'current_category').first
    if !setting || !Category.where(id: setting.value).first
      setting = Setting.create!(name: 'current_category', value: (Category.first.try(:id) || 0))
    end
    setting.value.to_i
  end
  
  def get_current_category
    setting = Setting.where(name: 'current_category').first
    if !setting || !Category.where(id: setting.value).first
      setting = Setting.create!(name: 'current_category', value: Category.first.id)
    end
    render partial: "category/base", locals: { category: Category.find(setting.value) }
  end

  def update_current_category
    category = params[:category]
    setting = Setting.find_or_create_by(name: 'current_category')
    setting.update(value: category)
    render partial: "category/base", locals: { category: Category.find(setting.value) }
  end

  def get_fixed_category_id
    setting = Setting.where(name: 'fixed_category').first
    if !setting || !Category.where(id: setting.value).first
      setting = Setting.create!(name: 'current_category', value: (Category.first.try(:id) || 0))
    end
    setting.value.to_i
  end
end

