require 'rails'
require 'active_record'
require 'axlsx'
require 'yaml'

module SchemaDocsGenerator
  class ExcelGenerator
    attr_reader :header_columns

    def initialize
      @header_columns = ["컬럼명(한글)", "컬럼명", "데이터 타입",  "기본값", "널 허용",  "설명",  "비고"]
    end

    def make_excel
      p = Axlsx::Package.new
      wb = p.workbook
      style = deep_symbolize_keys(YAML::load_file(File.join(__dir__, '../excel_style_config.yml')))

      header = wb.styles.add_style(style[:header])
      body = wb.styles.add_style(style[:body])

      ActiveRecord::Base.connection_pool.with_connection do |con|
        con.tables.each do |table|
          wb.add_worksheet do |ws|
            if table.length >= 31
              ws.name = table[0..30]
            else
              ws.name = table
            end
            ws.add_row header_columns, style: header
            column_hash = con.columns(table)
            column_hash.each do |column|
              ws.add_row [column.name, column.name, column.sql_type, column.default, column.null, "", ""], style: body
            end
          end
        end
      end

      p.serialize("#{Rails.root.join('hello.xlsx')}")
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
        result[new_key] = new_value
        result
      }
    end
  end
end
