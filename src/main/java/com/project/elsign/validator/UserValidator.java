package com.project.elsign.validator;


import com.project.elsign.model.User;
import com.project.elsign.service.ProfileService;
import com.project.elsign.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Validator for {@link com.project.elsign.model.User} class,
 * implements {@link Validator} interface.
 */

@Component
public class UserValidator implements Validator {

    private String emailPattern = "^([a-z0-9_\\.-])+@[a-z0-9-]+\\.([a-z]{2,4}\\.)?[a-z]{2,4}$";

    @Autowired
    private ProfileService profileService;

    @Autowired
    private UserService userService;

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "Required");
        if (user.getUsername().length() < 8 || user.getUsername().length() > 32) {
            errors.rejectValue("username", "Size.userForm.username");
        }

        if (userService.findByUsername(user.getUsername()) != null) {
            errors.rejectValue("username", "Duplicate.userForm.username");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "Required");
        if (user.getPassword().length() < 8 || user.getPassword().length() > 32) {
            errors.rejectValue("password", "Size.userForm.password");
        }

        if (!user.getConfirmPassword().equals(user.getPassword())) {
            errors.rejectValue("confirmPassword", "Different.userForm.password");
        }

        if (user.getSecret().length() < 8 || user.getSecret().length() > 32) {
            errors.rejectValue("secret", "Size.userForm.secret");
        }

        if (!user.getEmail().equals("")) {
            if (!checkField(user.getEmail(), emailPattern)) {
                errors.rejectValue("email", "emailFormat.error");
            } else {
                if (!checkUniquenessEmail(user.getEmail())) {
                    errors.rejectValue("email", "emailUniq.error");
                }
            }
        }
    }

    private boolean checkUniquenessEmail(String email) {
        Long id = profileService.getUserIdByEmail(email);
        return id == null;
    }

    private boolean checkField(String field, String pattern) {
        Pattern p = Pattern.compile(pattern);
        Matcher m = p.matcher(field);
        return m.matches();
    }
}
