package com.project.elsign.controller;

import com.project.elsign.model.Document;
import com.project.elsign.model.Sign;
import com.project.elsign.model.User;
import com.project.elsign.service.*;
import com.project.elsign.utils.RSAKeyPair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.persistence.EntityNotFoundException;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

@Controller
public class SignController {

    @Autowired
    private DocumentService documentService;

    @Autowired
    private UserService userService;

    @Autowired
    private SignService signService;

    @Autowired
    private RsaService rsaService;

    @RequestMapping(value = "/sign_by_user/{username}/document/{documentid}", method = RequestMethod.GET)
    public String getDocumentById(@PathVariable String username, @PathVariable String documentid, Model model) {

        Document document = documentService.getDocumentById(Long.parseLong(documentid));
        if (document == null) {
            return "/error_page404";
        }
        User user = userService.findByUsername(username);

        Sign newSign = new Sign();
        newSign.setDocument(documentid);
        newSign.setSigner(user.getId().toString());

        File file = GoogleDriveAPI.getFileFromDrive(document.getLink());
        String hash = rsaService.getMD5Hash(file);


        KeyPair keys = RSAKeyPair.keyPairRSA();
        byte[] encryptedHash = rsaService.encrypt(hash, keys.getPrivate());

        newSign.setEncHash(encryptedHash);
        newSign.setPublicKey(keys.getPublic().getEncoded());
//        byte[] decrypted = rsaService.decrypt(encrypted, keys.getPublic());

        Date date = new Date();
        SimpleDateFormat formatForDateNow = new SimpleDateFormat("yyyy.MM.dd");
        newSign.setSignDate(formatForDateNow.format(date));
        signService.save(newSign);
        model.addAttribute("documentid", document);
        return "redirect:/sign_documents/" + username;

    }

    @RequestMapping(value = "/check_sign", method = RequestMethod.GET)
    public String getDocumentsByUser(Model model) {
        return "/check_sign";
    }

    @RequestMapping(value = "/sign/check", method = RequestMethod.POST)
    public String checkSign(HttpServletRequest request, Model model) {
        String id_str = request.getParameter("description");
        if(id_str != null) {
            Long id = Long.parseLong(id_str);
            try {

                Sign sign = signService.getSignById(id);
                Document document = documentService.getDocumentById(Long.parseLong(sign.getDocument()));

                byte[] decryptedHash = rsaService.decrypt(sign.getEncHash(), KeyFactory.getInstance("RSA").generatePublic(new X509EncodedKeySpec(sign.getPublicKey())));
                File file = GoogleDriveAPI.getFileFromDrive(document.getLink());
                if(Arrays.equals(decryptedHash, rsaService.getMD5Hash(file).getBytes())){
                    model.addAttribute("userid", userService.getUserById(Long.parseLong(sign.getSigner())));
                }
                else {
                    signService.delete(sign);
                }
                model.addAttribute("documentid", document);
                return "/check_sign";
            } catch (EntityNotFoundException | NoSuchAlgorithmException | InvalidKeySpecException e){
                return "/check_sign";
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
