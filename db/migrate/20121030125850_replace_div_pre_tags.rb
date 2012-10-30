class ReplaceDivPreTags < ActiveRecord::Migration
  def up
    StatementTranslation.update_all("statement_made = replace(statement_made, '<pre>', '<p>')")
    StatementTranslation.update_all("statement_made = replace(statement_made, '</pre>', '</p>')")
    StatementTranslation.update_all("statement_made = replace(statement_made, '<div>', '<p>')")
    StatementTranslation.update_all("statement_made = replace(statement_made, '</div>', '</p>')")

    PlatformTranslation.update_all("description = replace(description, '<pre>', '<p>')")
    PlatformTranslation.update_all("description = replace(description, '</pre>', '</p>')")
    PlatformTranslation.update_all("description = replace(description, '<div>', '<p>')")
    PlatformTranslation.update_all("description = replace(description, '</div>', '</p>')")

    PolicyBriefTranslation.update_all("analysis = replace(analysis, '<pre>', '<p>')")
    PolicyBriefTranslation.update_all("analysis = replace(analysis, '</pre>', '</p>')")
    PolicyBriefTranslation.update_all("analysis = replace(analysis, '<div>', '<p>')")
    PolicyBriefTranslation.update_all("analysis = replace(analysis, '</div>', '</p>')")
  end

  def down
    # do nothing
  end
end
