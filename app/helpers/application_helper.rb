module ApplicationHelper

  def options_for_lang
    I18n.available_locales.map do |locale|
      [t(locale, scope: :locales), locale]
    end
  end

  def options_for_canton(canton)
    cantons = [
        ["Zürich", "ZH"],
        ["Bern / Berne", "BE"],
        ["Luzern", "LU"],
        ["Uri", "UR"],
        ["Schwyz", "SZ"],
        ["Obwalden", "OW"],
        ["Nidwalden", "NW"],
        ["Glarus", "GL"],
        ["Zug", "ZG"],
        ["Freiburg / Fribourg", "FR"],
        ["Solothurn", "SO"],
        ["Basel Stadt", "BS"],
        ["Basel Land", "BL"],
        ["Schaffhausen", "SH"],
        ["Appenzell Ausserrhoden", "AR"],
        ["Appenzell Innerrhoden", "AI"],
        ["Sankt Gallen", "SG"],
        ["Graubünden", "GR"],
        ["Aargau", "AG"],
        ["Thurgau", "TG"],
        ["Ticino", "TI"],
        ["Vaud", "VD"],
        ["Valais / Wallis", "VS"],
        ["Neuchâtel", "NE"],
        ["Genève", "GE"],
        ["Jura", "JU"],
    ].sort_by(&:first)
    cantons.append [t("canton.abroad"), :abroad]
    cantons.append [t("canton.other"), :other]
    cantons.insert(0, [t("letters.edit.placeholder_canton"),"", disabled: true, selected: canton.blank?])
  end

  VARIANTS = {
      thumbnail: "440x622",
      gallery: "824"
  }.freeze

  def og_image(letter)
    if (letter.reviewed_pdf.present? && letter.reviewed_pdf.previewable?)
      return url_for(letter.reviewed_pdf.preview(resize: VARIANTS[:thumbnail]))
    else
      return image_url("instagram.#{@letter.lang}.png")
    end
  end

  def letter_preview(letter, variant)
    return unless letter.reviewed_pdf.present?
    return unless letter.reviewed_pdf.previewable?
    return image_tag letter.reviewed_pdf.preview(resize: VARIANTS[variant])
  end
end
