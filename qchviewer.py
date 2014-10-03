# -*- coding: utf-8 -*-
# Copyright (C) 2013, the IEP development team
# Author: Windel Bouwman
#
# IEP is distributed under the terms of the (new) BSD License.
# The full license can be found in 'license.txt'.

"""
Display the specified qch file in qt help engine.
"""

from pyzolib.qt import QtCore, QtGui, QtHelp
import argparse


class HelpBrowser(QtGui.QTextBrowser):
    """ Override textbrowser to implement load resource """
    def __init__(self, engine):
        super().__init__()
        self._engine = engine

    def loadResource(self, typ, url):
        if url.scheme() == "qthelp":
            return self._engine.fileData(url)
        else:
            return super().loadResource(typ, url)


class QchViewer(QtGui.QWidget):
    """
        Show help contents and browse qt help files.
    """
    def __init__(self, parent=None, collection_filename='qch_viewer_docs.qhc'):
        """
            Initializes an assistance instance.
            When collection_file is none, it is determined from the
            appDataDir.
        """
        super().__init__(parent)
        self.setWindowTitle('QchViewer')
        self._engine = QtHelp.QHelpEngine(collection_filename)

        # The main players:
        self._content = self._engine.contentWidget()
        self._helpBrowser = HelpBrowser(self._engine)

        self.splitter = QtGui.QSplitter(self)
        self.splitter.addWidget(self._content)
        self.splitter.addWidget(self._helpBrowser)

        layout = QtGui.QVBoxLayout(self)
        layout.addWidget(self.splitter)

        # Connect clicks:
        self._content.linkActivated.connect(self._helpBrowser.setSource)

        self.content_model = self._engine.contentModel()
        self.content_model.contentsCreated.connect(self.select_first)

        # Important, call setup data to load the files:
        self._engine.setupData()

    def select_first(self):
        # Select first entry:
        idx = self.content_model.index(0, 0)
        selection_model = self._content.selectionModel()
        selection_model.select(idx, QtGui.QItemSelectionModel.Select)
        self._content.activated.emit(idx)

    def add_doc(self, doc_file):
        self._engine.registerDocumentation(doc_file)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--doc_file')
    args = parser.parse_args()
    app = QtGui.QApplication([])
    view = QchViewer()
    view.show()
    view.resize(1024, 768)
    view.splitter.setSizes([200, 800])
    if args.doc_file:
        view.add_doc(args.doc_file)
    app.exec()
