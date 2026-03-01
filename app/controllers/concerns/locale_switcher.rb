# frozen_string_literal: true

module LocaleSwitcher
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale
  end

  private

  def switch_locale(&)
    locale = locale_from_params || locale_from_session || locale_from_header || I18n.default_locale
    I18n.with_locale(locale, &)
  end

  def locale_from_params
    locale = params[:locale]
    return locale if locale.present? && I18n.available_locales.include?(locale.to_sym)

    nil
  end

  def locale_from_session
    locale = session[:locale]
    return locale if locale.present? && I18n.available_locales.include?(locale.to_sym)

    nil
  end

  def locale_from_header
    return nil unless request.env['HTTP_ACCEPT_LANGUAGE']

    # Parse Accept-Language header and find the first available locale
    accepted_locales = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/[a-z]{2}/)
    accepted_locales.find { |locale| I18n.available_locales.include?(locale.to_sym) }
  end

  def default_url_options
    I18n.locale == I18n.default_locale ? {} : { locale: I18n.locale }
  end
end
