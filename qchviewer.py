# -*- coding: utf-8 -*-
# Copyright (C) 2013, the IEP development team
# Author: Windel Bouwman
#
# IEP is distributed under the terms of the (new) BSD License.
# The full license can be found in 'license.txt'.

"""
Display the specified qch file in qt help engine.
"""

from PyQt4 import QtCore, QtGui, QtHelp
import argparse
import glob


class HelpBrowser(QtGui.QTextBrowser):
    """ Override textbrowser to implement load resource """
    def __init__(self, engine):
        QtGui.QTextBrowser.__init__(self)
        self._engine = engine

    def loadResource(self, typ, url):
        if url.scheme() == "qthelp":
            return self._engine.fileData(url)
        else:
            return super().loadResource(typ, url)


class QchViewer(QtGui.QWidget):
    """ Show help contents and browse qt help files. """
    def __init__(self, parent=None, collection_filename='qch_viewer_docs.qhc'):
        QtGui.QWidget.__init__(self, parent)
        self.setWindowTitle('QchViewer')
        self._engine = QtHelp.QHelpEngine(collection_filename)

        # The main players:
        self._content = self._engine.contentWidget()
        self._helpBrowser = HelpBrowser(self._engine)
        self.content_model = self._engine.contentModel()
        self.splitter = QtGui.QSplitter(self)
        self.splitter.addWidget(self._content)
        self.splitter.addWidget(self._helpBrowser)
        layout = QtGui.QVBoxLayout(self)
        layout.addWidget(self.splitter)

        # Connect clicks:
        self._content.linkActivated.connect(self._helpBrowser.setSource)

        # Important, call setup data to load the files:
        self._engine.setupData()

    def add_doc(self, doc_file):
        if not self.content_model.isCreatingContents():
            self._engine.registerDocumentation(doc_file)

    def screenshot_all(self):
        """ Take screenshot of all content and quit """
        for row in range(self.content_model.rowCount()):
            print('Taking shot')
            idx = self.content_model.index(row, 0)
            self._content.activated.emit(idx)
            pm = QtGui.QPixmap(self.size())
            self.render(pm)
            pm.save('screen_{}.png'.format(row))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('qch_file', nargs="*", help="Document file to add to the collection")
    parser.add_argument('-s', action='store_true', help="Take screenshots and quit")
    parser.add_argument('--qhc', help="Use this qhc file as collection file.")
    args = parser.parse_args()
    app = QtGui.QApplication([])

    # Construct viewer:
    if args.qhc:
        view = QchViewer(collection_filename=args.qhc)
    else:
        view = QchViewer()

    view.show()
    view.resize(1024, 768)
    view.splitter.setSizes([200, 800])
    def on_complete():
        view.content_model.contentsCreated.disconnect(on_complete)
        for qch_file in args.qch_file:
            view.add_doc(qch_file)
        if args.s:
            view.screenshot_all()
            view.close()
    view.content_model.contentsCreated.connect(on_complete)
    app.exec_()
