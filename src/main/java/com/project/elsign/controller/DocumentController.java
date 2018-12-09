package com.project.elsign.controller;

import com.project.elsign.model.Document;
import com.project.elsign.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class DocumentController {

    @Autowired
    DocumentService documentService;

    @RequestMapping(value = "my_documents", method = RequestMethod.GET)
    public String getDocumentsByUser(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName();
        model.addAttribute("documents", documentService.getDocumentsByUsername(name));
        return "/my_documents";
    }

    @RequestMapping(value = "/document/{id}", method = RequestMethod.GET)
    public String getProduct(@PathVariable String id, Model model) {
        Document document = documentService.getDocumentById(Long.parseLong(id));
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName();
//        model.addAttribute("favorite_products", likeService.getFavoriteProductsByUsername(name));
        if (document == null) {
            return "/error_page404";
        } else {
            model.addAttribute("documentid", document);
            return "/documentbyid";
        }
    }
}
