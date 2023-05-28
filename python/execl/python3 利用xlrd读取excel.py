# 1.
# XLRDError: Excel xlsx file; not supported
# 这是因为高版本xlrd不支持xlsx格式导致的，可以安装低版本
#
# Shell/Unix/Bash
# pip3 install xlrd==1.2.0
# 2.
# NotImplementedError: formatting_info=True not yet implemented
# 这是因为使用 rich_text_runlist_map 时，不支持xlsx格式导致的，把xlsx另存为xls格式。
# try:
#     data = xlrd.open_workbook(xls_path, formatting_info=True)
# except NotImplementedError as e:
#     data = xlrd.open_workbook(xls_path)


# 解析单元格
# 解析某一行数据 row
# 获取一行数据，包含数据类型和内容，语法：
#
# sheet.row(index)
#
# 测试：
#
# print(sheetB.row(4)) -> [empty:'', text:'基础术语', text:'财产保险', text:'property insurance', empty:'', text:'以财产及其有关利益为保险标的保险。', text:'财产保险包括财产损失保险、责任保险、信用保险、保证保险等。']
#
# 获取一行数据，只包含数据内容，语法：
#
# sheet.row_values(index)
#
# 测试：
#
# print(sheetB.row_values(4)) -> ['', '基础术语', '财产保险', 'property insurance', '', '以财产及其有关利益为保险标的保险。', '财产保险包括财产损失保险、责任保险、信用保险、保证保险等。']


# 获取一行数据，第start列到第end列(start~end列)[不含第end列]，语法：
#
# sheet.row_values(index, start, end)
#
# 测试，获取第 8 行前 3 列数据：
#
# print(sheetB.row_values(7, 0, 3)) -> ['', '基础术语', '投保人']
#
# 测试，获取第 158 行 第 2~5 列数据：
#
# print(sheetB.row_values(157, 2, 5)) -> ['日常生活能力', 'activities of daily living', 'ADLs']
#
# 可以通过行方法获取单元格数据，获取第5行第3个格子里的数据与类型：
#
# print(sheetB.row_slice(4,3,4)) -> [text:'property insurance']

#
# 解析特定单元格
# 获取单元格里的数据：
#
# sheet.cell_value(1, 2)
# sheet.cell(1, 2).value
# sheet.row(1)[2].value
# sheetB.cell_value(4,3) -> ‘property insurance’
# sheetB.cell(4,3).value -> ‘property insurance’
# sheetB.row(4)[3].value -> ‘property insurance’
#
# 获取单元格里的数据类型：
#
# sheet.cell(1, 2).ctype
# sheet.cell_type(1, 2)
# sheet.row(1)[2].ctype
# sheetB.cell(4,3).ctype -> 1
# sheetB.cell_type(4,3) -> 1
# sheetB.row(4)[3].ctype -> 1
# ————————————————
# 版权声明：本文为CSDN博主「cj96248」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/jiangchao858/article/details/104263006

import xlrd;
import json;
book = xlrd.open_workbook("Insurance_terms.xlsx")
sheet = book.sheets()[0]
list = []
for i in range(3, sheet.nrows):
    row = sheet.row_values(i)
    dic = {"type":row[1], "chinese":row[2],"english":row[3], "shortname":row[4],"description":row[5]}
    list.append(dic);
print(json.dumps(list,ensure_ascii=False));