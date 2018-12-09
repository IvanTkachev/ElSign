package com.project.elsign.service;

import com.project.elsign.model.Document;

import java.util.List;

public interface DocumentService {

    List<Document> getDocumentsByUsername(String username);

    Document getDocumentById(Long id);

    List<Document> getAllDocuments();
}
