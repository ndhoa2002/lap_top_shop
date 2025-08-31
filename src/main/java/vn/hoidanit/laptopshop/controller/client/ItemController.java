package vn.hoidanit.laptopshop.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.service.ProductService;

@Controller
public class ItemController {

    private final ProductService productService;
    private final CartDetailRepository cartDetailRepository;
    private final CartRepository cartRepository;

    public ItemController(ProductService productService, CartDetailRepository cartDetailRepository, CartRepository cartRepository){
        this.productService = productService;
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
    }
    
    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable long id){
        Product pr = this.productService.getProductById(id);
        model.addAttribute("product", pr);
        model.addAttribute("id", id);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request){
        HttpSession session = request.getSession(false);
        long productId = id;
        String email = (String)session.getAttribute("email");
        this.productService.handleAddProductToCart(email, productId, session);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request){
        HttpSession session = request.getSession(false);
        long cartId = (long)session.getAttribute("cartId");
        Cart cart = cartRepository.findById(cartId).get();
        List<CartDetail> cdList = this.productService.getAllCartDetail(cartId);
        model.addAttribute("cartDetails", cdList);
        model.addAttribute("totalPrice", cart.getTotalPrice());
        return "client/cart/show";
    }
}
