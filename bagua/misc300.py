#!/usr/bin/env python
# -*- coding: utf-8 -*-
from PIL import Image
import deal
from numpy import *

__author__ = "Aklis"

class Typing(object):
    def __init__(self, article, width):
        self.save_char = []
        self.article = deal.read_article(article)
        self.sa, self.total_length = deal.strip_article(filter(self.article), width)
        self.width = width
        self.height = self.total_length
        for i in range(0, 26):
            self.save_char.append(Image.open('./symbol/'+chr(65+i)*2+'.png').resize((80, 80)).crop((0, 0, 80, 80)))
        self.dst = self.create()

    def create(self):
        dst = Image.new("RGBA", (80 * self.width + 20, 80 * self.height + 20), (255, 255, 255))
        return dst

    def draw(self, sentense="Helloddog", line=0):
        for n, c in enumerate(sentense):
            #print convert(c)
            if convert(c) == None:
                continue
            current = self.save_char[convert(c)]
            self.dst.paste(current, (80 * n + 10, 80 * line + 10, 80 * (n+1) + 10, 80 * line + 80 + 10), mask=current)
            # self.dst.paste(current, (80 * n, 80 * line, 80 * (n+1), 80 * line + 80))

    def show(self):
        for i, v in enumerate(self.sa[:]):
            try:
                self.draw(v, i)
            except:
                print v, "and ", i
        self.dst.show()

    def showart(self):
        '''
        debug
        :return:
        '''
        for i, v in enumerate(self.sa[:]):
            print i, "and ", v , ' the v is ', type(v)

def convert(c):
    if c == ' ':
        return None
    else:
        return ord(c.upper())-65

def filter(s):
    seq = [',', '.', '!', '?', '-', ';', '\n', '`', '\'', '\"']
    for char in seq:
        s = s.replace(char, '')
    return s

def main():
    article = "./b.txt"
    start = Typing(article, 20)
    start.show()
    start.dst.save('./example.png')

if __name__ == '__main__':
    main()
