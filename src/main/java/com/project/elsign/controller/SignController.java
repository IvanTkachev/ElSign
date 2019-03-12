package com.project.elsign.controller;

import com.project.elsign.model.Document;
import com.project.elsign.model.Sign;
import com.project.elsign.model.User;
import com.project.elsign.service.DocumentService;
import com.project.elsign.service.SignService;
import com.project.elsign.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class SignController {

    @Autowired
    private DocumentService documentService;

    @Autowired
    private UserService userService;

    @Autowired
    private SignService signService;

    @RequestMapping(value = "/sign_by_user/{username}/document/{documentid}", method = RequestMethod.GET)
    public String getDocumentById(@PathVariable String username, @PathVariable String documentid, Model model) {

        Document document = documentService.getDocumentById(Long.parseLong(documentid));
        User user = userService.findByUsername(username);
        Sign newSign = new Sign();
        newSign.setDocument(documentid);
        newSign.setSigner(user.getId().toString());
        Date date = new Date();
        SimpleDateFormat formatForDateNow = new SimpleDateFormat("yyyy.MM.dd");
        newSign.setSignDate(formatForDateNow.format(date));
        signService.save(newSign);
        if (document == null) {
            return "/error_page404";
        } else {
            model.addAttribute("documentid", document);
            return "redirect:/sign_documents/" + username;
        }
    }

    @RequestMapping(value = "/check_sign", method = RequestMethod.GET)
    public String getDocumentsByUser(Model model) {
        return "/check_sign";
    }

    @RequestMapping(value = "/sign/check", method = RequestMethod.POST)
    public String addDocument(HttpServletRequest request, Model model) {
        String id_str = request.getParameter("description");
        if(id_str != null) {
            Long id = Long.parseLong(id_str);
            try {
                Document document = documentService.getDocumentById(id);
                if(document == null){
                    return "/check_sign";
                }
                model.addAttribute("documentid", document);
                return "/documentbyid";
            } catch (Exception e){
                return "/documentbyid";
            }

        }


//                String id = GoogleDriveAPI.addFileToDrive(file);
//                Document document = new Document();
//                document.setLink(id);
//                Set user = new HashSet<>();
//                User owner = userService.findByUsername(username);
//                user.add(owner);
//                document.setName(request.getParameter("name"));
//                documentService.save(document);
//                document = documentService.getByNameAndLink(document.getName(), document.getLink());
//                owner.getOwnDocuments().add(document);
//                userService.update(owner);


        return "redirect:/my_documents";
    }

}
