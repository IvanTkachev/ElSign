package com.project.elsign.service;

import com.project.elsign.model.Document;

import java.util.List;

public interface DocumentService {

    List<Document> getDocumentsByOwnerUsername(String username);

    Document getDocumentById(Long id);

    List<Document> getAllDocuments();

    void updateDocument(Document document);

    List<Document> getSignDocumentsByUsername(String username);
}
