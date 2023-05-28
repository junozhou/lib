import concurrent.futures


import requests
# from bs4 import BeautifulSoup

urls = []
for i in range(2, 52):
    urls.append('https://www.cnblogs.com/#p{0}'.format(i))


def craw(url):
    r = requests.get(url)
    return r.text


def parse(html):
    print(html)
    # soup = BeautifulSoup(html, 'html.parser')
    # links = soup.find_all('a', class_='post-item-title')
    # return [(link['href'], link.get_text()) for link in links]


with concurrent.futures.ThreadPoolExecutor() as pool:
    htmls = pool.map(craw, urls)
    htmls = list(zip(urls, htmls))
    for url, html in htmls:
        pass
        print(url, len(html))
print('生产者：end')


with concurrent.futures.ThreadPoolExecutor() as pool:
    futures = {}
    for url, html in htmls:
        future = pool.submit(parse, html)
        futures[future] = url
    for future, url in futures.items():
        print(url, future.result())
print('消费者：end')



if __name__ == "__main__":
    pass