from typing import Iterator

from langchain.document_loaders import Blob
from langchain.schema import Document

from eurelis_kb_framework.base_factory import BaseFactory
from langchain.document_loaders.base import BaseBlobParser

from eurelis_kb_framework.dataset.dataset import Dataset


class DocumentCacheParser(BaseBlobParser):
    """
    Document cache parser
    """

    def lazy_parse(self, blob: Blob) -> Iterator[Document]:
        """
        Override of lazy_parse method
        Args:
            blob: file blob representation

        Returns:
            an iterator over documents
        """
        yield Dataset.load_document_from_cache(blob.path)


class DocumentCacheParserFactory(BaseFactory[BaseBlobParser]):
    """
    Factory for the document cache parser
    """

    def build(self, context) -> BaseBlobParser:
        """
        Construct the document cache parser instance
        Args:
            context: the context object, usually the current langchain wrapper instance

        Returns:
            a document cache parser instance
        """
        return DocumentCacheParser()