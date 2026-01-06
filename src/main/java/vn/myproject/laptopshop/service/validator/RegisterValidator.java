package vn.myproject.laptopshop.service.validator;

import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.myproject.laptopshop.domain.dto.RegisterDTO;
import vn.myproject.laptopshop.service.UserService;


@Service
public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO>{
    
    private final UserService userService;

    public RegisterValidator(UserService userService){
        this.userService=userService;
    }

    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context){
        boolean valid=true;
        if(!user.getPassword().equals(user.getConfirmPassword())){
            context.buildConstraintViolationWithTemplate("Password nhập không chính xác")
            .addPropertyNode("confirmPassword")
            .addConstraintViolation()
            .disableDefaultConstraintViolation();
            valid = false;
        }

        if(this.userService.checkEmailExist(user.getEmail())){
            context.buildConstraintViolationWithTemplate("Email đã tồn tại")
            .addPropertyNode("email")
            .addConstraintViolation()
            .disableDefaultConstraintViolation();
            valid = false;
        }
        return valid;
    }
}
