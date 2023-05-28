# -*- coding: UTF-8 -*-
"""
@File    ：多线程.py
@Author  ：叶庭云
@CSDN    ：https://yetingyun.blog.csdn.net/
"""
import requests
import logging
from fake_useragent import UserAgent
from lxml import etree
import openpyxl
from concurrent.futures import ThreadPoolExecutor, wait, ALL_COMPLETED
from datetime import datetime

# 日志输出的基本配置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s: %(message)s')
# 随机产生请求头
ua = UserAgent(verify_ssl=False, path='fake_useragent.json')
wb = openpyxl.Workbook()
sheet = wb.active
sheet.append(['品名', '最新报价', '单位', '报价数', '报价时间'])
start = datetime.now()


def get_data(page):
    # 构造URL
    url = f'https://www.zhongnongwang.com/quote/product-htm-page-{page}.html'
    # 伪装请求头
    headers = {
        "Accept-Encoding": "gzip",    # 使用gzip压缩传输数据让访问更快
        "User-Agent": ua.random
    }
    # 发送请求  获取响应
    rep = requests.get(url, headers=headers)
    # print(rep.status_code)
    # Xpath定位提取数据
    html = etree.HTML(rep.text)
    items = html.xpath('/html/body/div[10]/table/tr[@align="center"]')
    logging.info(f'该页有多少条信息：{len(items)}')  # 一页有20条信息
    # 遍历提取出数据
    for item in items:
        name = ''.join(item.xpath('.//td[1]/a/text()'))   # 品名
        price = ''.join(item.xpath('.//td[3]/text()'))    # 最新报价
        unit = ''.join(item.xpath('.//td[4]/text()'))     # 单位
        nums = ''.join(item.xpath('.//td[5]/text()'))     # 报价数
        time_ = ''.join(item.xpath('.//td[6]/text()'))    # 报价时间
        sheet.append([name, price, unit, nums, time_])
        logging.info([name, price, unit, nums, time_])


def run():
    # 爬取1-50页
    with ThreadPoolExecutor(max_workers=6) as executor:
        future_tasks = [executor.submit(get_data, i) for i in range(1, 51)]
        wait(future_tasks, return_when=ALL_COMPLETED)

    wb.save(filename='data2.xlsx')
    delta = (datetime.now() - start).total_seconds()
    print(f'用时：{delta}s')


run()