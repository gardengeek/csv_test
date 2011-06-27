class SourceAnnotationExtractor
  def find_with_custom_directories
    find_without_custom_directories(%w(app lib spec features))
  end
  alias_method_chain :find, :custom_directories
end
