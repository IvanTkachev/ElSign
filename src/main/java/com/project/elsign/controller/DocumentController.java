package com.project.elsign.controller;

import com.project.elsign.model.Document;
import com.project.elsign.model.Sign;
import com.project.elsign.model.User;
import com.project.elsign.service.DocumentService;
import com.project.elsign.service.GoogleDriveAPI;
import com.project.elsign.service.SignService;
import com.project.elsign.service.UserService;
import com.project.elsign.service.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.*;

import java.util.List;

@Controller
public class DocumentController {

    @Autowired
    StorageService storageService;

    @Autowired
    DocumentService documentService;

    @Autowired
    UserService userService;

    @Autowired
    SignService signService;

    @RequestMapping(value = "my_documents", method = RequestMethod.GET)
    public String getDocumentsByUser(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName();
        model.addAttribute("documents", documentService.getDocumentsByOwnerUsername(name));
        model.addAttribute("sign_doc", false);
        return "/my_documents";
    }

    @RequestMapping(value = "my_sign_documents", method = RequestMethod.GET)
    public String getSignDocumentsByUser(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName();
        model.addAttribute("documents", documentService.getSignDocumentsByUsername(name));
        model.addAttribute("sign_doc", true);
        return "/my_documents";
    }

    @RequestMapping(value = "/document/{id}", method = RequestMethod.GET)
    public String getDocumentById(@PathVariable String id, Model model) {
        Document document = documentService.getDocumentById(Long.parseLong(id));
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName();
        Sign sign = signService.getSignBySignerAndDocument(userService.findByUsername(name).getId().toString(),
                document.getId().toString());
        boolean signCheck = sign == null;
        if (document == null) {
            return "/error_page404";
        } else {
            model.addAttribute("documentid", document);

            model.addAttribute("sign", signCheck);
            return "/documentbyid";
        }
    }

    @RequestMapping(value = "/documents/{username}", method = RequestMethod.GET)
    public String getDocumentsByUsername(@PathVariable String username, Model model, HttpServletRequest request) {
        List<Document> documents = documentService.getDocumentsByOwnerUsername(username);
        String result_msg;
        if (RequestContextUtils.getLocale(request).toString().equals("ru")) {
            result_msg = "ТАКОГО ПОЛЬЗОВАТЕЛЯ НЕ СУЩЕСТВУЕТ";
        } else {
            result_msg = "USER NOT FOUND";
        }

        if (userService.findByUsername(username) != null) {
            if (RequestContextUtils.getLocale(request).toString().equals("ru")) {
                result_msg = "Документы пользователя: " + username;
            }
            if (RequestContextUtils.getLocale(request).toString().equals("en")) {
                result_msg = "Documents of user: " + username;
            }
        }
        model.addAttribute("result_message", result_msg);
        model.addAttribute("documents", documents);
        return "/catalog";
    }

    @RequestMapping(value = "/sign_documents/{username}", method = RequestMethod.GET)
    public String getSignDocumentsByUsername(@PathVariable String username, Model model, HttpServletRequest request) {
        List<Document> documents = documentService.getSignDocumentsByUsername(username);
        String result_msg;
        if (RequestContextUtils.getLocale(request).toString().equals("ru")) {
            result_msg = "ТАКОГО ПОЛЬЗОВАТЕЛЯ НЕ СУЩЕСТВУЕТ";
        } else {
            result_msg = "USER NOT FOUND";
        }

        if (userService.findByUsername(username) != null) {
            if (RequestContextUtils.getLocale(request).toString().equals("ru")) {
                result_msg = "Подписанные документы пользователя: " + username;
            }
            if (RequestContextUtils.getLocale(request).toString().equals("en")) {
                result_msg = "Documents of user: " + username;
            }
        }
        model.addAttribute("result_message", result_msg);
        model.addAttribute("documents", documents);
        return "/catalog";
    }

    @RequestMapping(value = "/document/add", method = RequestMethod.POST)
    public String addDocument(@ModelAttribute("new-document") Document document, Model model, HttpServletRequest request,
                              @RequestParam("file") MultipartFile file) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName();
//        if(file!=null){
//            try {
//                String id = GoogleDriveAPI.addPhotoToDrive(file);
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
        return "redirect:/my_documents";
    }

    @RequestMapping(value = "/new_document", method = RequestMethod.GET)
    public String goToNewDocument(Model model, HttpServletRequest request) {

        return "new_document";
    }
}
