package vn.hoidanit.laptopshop.controller.client;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Controller
public class CartController {

    private final CartDetailRepository cartDetailRepository;
    private final UserRepository userRepository;
    private final CartRepository cartRepository;

    public CartController(CartDetailRepository cartDetailRepository, UserRepository userRepository, CartRepository cartRepository){
        this.cartDetailRepository = cartDetailRepository;
        this.userRepository = userRepository;
        this.cartRepository = cartRepository;
    }

    @PostMapping("/cart/update")
    @ResponseBody
    public ResponseEntity<?> updateCartDetail(
            @RequestParam("cartDetailId") Long cartDetailId,
            @RequestParam("quantity") Integer quantity,
            HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        String email = (String)session.getAttribute("email");

        User user = userRepository.findByEmail(email);

        Cart cart = new Cart();

        if(user != null){
            Cart newCart = cartRepository.findByUser(user);
            cart = newCart;
        }

        CartDetail cartDetail = cartDetailRepository.findById(cartDetailId).get();
        if (cartDetail == null) {
            return ResponseEntity.badRequest().body("Không tìm thấy sản phẩm trong giỏ");
        }

        // Cập nhật số lượng
        cartDetail.setQuantity(quantity);
        double total = cartDetail.getPrice() * cartDetail.getQuantity();
        cartDetail.setTotal(total);
        cartDetailRepository.save(cartDetail);

        List<CartDetail> cartDetails = cartDetailRepository.findAllByCart(cart);

        double totalPrice = 0;

        for(CartDetail cd : cartDetails){
            totalPrice += cd.getTotal();
        }

        cart.setTotalPrice(totalPrice);
        cartRepository.save(cart);

        // Có thể trả về tổng tiền để update lại UI

        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("newQuantity", quantity);
        res.put("total", total);
        res.put("totalPrice", totalPrice);

        return ResponseEntity.ok(res);
    }

}
