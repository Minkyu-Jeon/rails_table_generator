require 'schema_docs_generator/excel_helper'

module SchemaDocsGenerator
  class ExcelGenerator
    include ExcelHelper

    attr_reader :header_columns

    def initialize
      @header_columns = ["컬럼명(한글)", "컬럼명", "데이터 타입",  "기본값", "널 허용",  "설명",  "비고"]
    end

    def generate
      p = Axlsx::Package.new
      wb = p.workbook

      style = deep_symbolize_keys(load_excel_style)

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

            column_hash.each do |col|
              ws.add_row [col.name, col.name, col.sql_type, col.default, col.null, is_pk?(col), ""], style: body
            end
          end
        end
      end

      p.serialize("#{Rails.root.join('hello.xlsx')}")
    end
  end
end
