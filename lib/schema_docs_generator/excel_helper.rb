module SchemaDocsGenerator
  module ExcelHelper
    def is_pk?(key)
      "PK" if key.is_primary?
    end

    def deep_symbolize_keys(hash)
      hash.inject({}){|result, (key, value)|
        new_key = case key
                  when String then key.to_sym
                  else key
                  end
        new_value = case value
                    when Hash then deep_symbolize_keys(value)
                    else value
                    end

        new_value = new_value.to_sym if ["style"].include?(new_key.to_s)

        result[new_key] = new_value
        result
      }
    end

    def load_excel_style
      YAML::load_file(File.join(__dir__, '../excel_style_config.yml'))
    end
  end
end
