# 版权声明：本文为CSDN博主「nongcunqq」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/nongcunqq/article/details/126965065








# python NotImplementedError: formatting_info=True not yet implemented
# mergeCells(a,b,c,d) 单元格合并函数
# a 单元格的起始行
# b 单元格的结束行
# c 从单元格的起始列
# d 单元格的结束列
# 注：单元格的列号和行号都是从0开始
import xlrd

# 检查行是否是并行
def check_row_existed_merged_cell(sheet, row_index):
    # cell_value = None
    for (rlow, rhigh, clow, chigh) in sheet.merged_cells:
        if (row_index >= rlow and row_index < rhigh):
            if (row_index == rlow):
                return (True,rlow)
            return (True,-1)
    return (False,-1)


def convert_to_number(letter, columnA=0):
    """
    字母列号转数字
    columnA: 你希望A列是第几列(0 or 1)? 默认0
    return: int
    """
    ab = '_ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    letter0 = letter.upper()
    w = 0
    for _ in letter0:
        w *= 26
        w += ab.find(_)
    return w - 1 + columnA

# 读取合并单元格中的某一个单元格的值编写成一个方法：
def get_merged_cell_value(sheet, row_index,col_index):
    merged = sheet.merged_cells
    cell_value = None
    for (rlow, rhigh, clow, chigh) in merged:
        if (row_index >= rlow and row_index < rhigh):
            if (col_index >= clow and col_index < chigh):
                # 如果满足条件，就把合并单元格第一个位置的值赋给其它合并单元格
                cell_value = sheet.cell_value(rlow, clow)
                print('合并单元格')
                break # 不符合条件跳出循环，防止覆盖
            else:
                print('普通单元格')
                cell_value = sheet.cell_value(row_index, col_index)
    return cell_value


# https://blog.csdn.net/Dragon_King_Boss/article/details/119991618
# 方法参数为单元格的坐标（x,y），如果给的坐标是合并的单元格，输出此单元格是合并的，否则，输出普通单元格
def get_merged_cell_value(sheet, row_index,col_index):
    merged = sheet.merged_cells
    for (rlow, rhigh, clow, chigh) in merged:
        if (row_index >= rlow and row_index < rhigh and col_index >= clow and col_index < chigh):
            print("此单元格是合并单元格")
        else:
            print("此单元格为普通单元格")


# Cell数据类型
# xlrd.XL_CELL_TEXT 文本类型
# xlrd.XL_CELL_NUMBER 数值类型
# xlrd.XL_CELL_DATE 日期类型
# xlrd.XL_CELL_BOOLEAN 布尔类型
# xlrd.XL_CELL_BLANK 空白类型

def parse_execl(xls_path):
    try:
        data = xlrd.open_workbook(xls_path, formatting_info=True)
    except NotImplementedError as e:
        data = xlrd.open_workbook(xls_path)

    sheet = data.sheet_by_index(1)
    nrows = sheet.nrows
    ncols = sheet.ncols
    print(nrows, ncols)

    # 合并单元格的地方
    merged_cell = sheet.merged_cells
    print (merged_cell)

    for i in range(1, nrows):
        row = []
        for cell in sheet.row(i):
            if cell.ctype == xlrd.XL_CELL_NUMBER:
                if int(cell.value) == cell.value:
                    row.append(str(int(cell.value)))
                else:
                    decimal_places = len(str(cell.value).split('.')[1])
                    format_str = '{:.{}f}' if decimal_places > 0 else '{}'
                    row.append(format_str.format(cell.value, decimal_places))  # 有小数位，保留小数点
            else:
                row.append(str(cell.value))
        if not row[0] and not row[1] and not row[4] and not row[5]:
            continue
        (r_status,r_row_index) = check_row_existed_merged_cell(sheet,i)


if __name__ == "__main__":
    xls_path = r"E:\code\dock_project\excel_image\excel_files\20220916\CABG_20220916.xlsx"
    parse_execl(xls_path)

# 有的execl文件这样可以获取merged_cell，有的不行故这里需要处理





